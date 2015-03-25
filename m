From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Tue, 24 Mar 2015 18:05:13 -0700
Message-ID: <xmqq8uel51km.fsf@gitster.dls.corp.google.com>
References: <538F69DA.9010201@gmail.com>
	<xmqqmw338khu.fsf@gitster.dls.corp.google.com>
	<xmqqpp7y3ucy.fsf@gitster.dls.corp.google.com>
	<CANQwDwfdUDZfgFar3tr8Er3Ha-1hS0Ypkbsbn0UaSJ7HadsR1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <mail@mwagner.org>, git <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 02:05:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaZl4-0006In-0n
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 02:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbbCYBFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 21:05:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752277AbbCYBFQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 21:05:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81DC143C0C;
	Tue, 24 Mar 2015 21:05:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XYW2RFU5Z3Z+
	9ii3UtFQ+G7eoPo=; b=wru6vEpkm3CYT8+apJYCeBlAIANJrMWS3vzbbNpO3Z84
	T0FiHamo9E3pH14v0gijlnXF7Ve0E5W7hEMuf5pBXyxy6m0gU/qakMumYyCjsAbO
	2tvzpbCi+IGLkdpbFMOsuYMXhDz1niLGySqZwX/5XszZOsgvddtYm234dQCInkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cIVAAp
	zgSninOkEpt7bfKe6/6rkFGgoYzIpI4mMJsYw0fHY2SaAVOX2zb3xuKyBiPHBrvn
	qZsmV4CkMG6pUY5uRslSIMzuIOJyHOOCJhnvgs2VskwN9pcixxy/FWfMMzSqKOvP
	fC4rnnDcOPF+awOOeOntdmaHXFwQpVbtyMe/I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A66943C0B;
	Tue, 24 Mar 2015 21:05:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D56CA43C09;
	Tue, 24 Mar 2015 21:05:14 -0400 (EDT)
In-Reply-To: <CANQwDwfdUDZfgFar3tr8Er3Ha-1hS0Ypkbsbn0UaSJ7HadsR1Q@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 25 Mar 2015
 01:37:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FEB9E1C2-D28A-11E4-9010-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266246>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> On Tue, Mar 24, 2015 at 11:26 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > * jn/gitweb-utf8-in-links (2014-05-27) 1 commit
>> >  - gitweb: Harden UTF-8 handling in generated links
>>
>> This has been lingering in my 'pu' branch without seeing any updates
>> since $gmane/250758; is anybody still interested in resurrecting it
>> and moving it forward?
>
> I can try to pick it up, but I am no longer sure that it is a good id=
ea
> to solve the problem.

After re-reading the discussion thread, I had the same impression.
Let's drop the patch for now.  It can be re-raised as/if needed.

Thanks.

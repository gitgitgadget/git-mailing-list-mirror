From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Bug report
Date: Thu, 06 Oct 2011 09:22:09 -0700
Message-ID: <7vy5wy145q.fsf@alter.siamese.dyndns.org>
References: <1317763443.17036.15.camel@skyplex>
 <20111005072235.GA12600@kolya> <7vlisz8jur.fsf@alter.siamese.dyndns.org>
 <20111006003318.GA9015@goldbirke> <7vobxv3q49.fsf@alter.siamese.dyndns.org>
 <20111006010940.GR2208@goldbirke>
 <CABURp0qCsKG2oOxLw4BfU8UM=9V+pigd69ZK=TZVwetBPqjuiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqiB-0005gj-O8
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067Ab1JFQWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 12:22:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934637Ab1JFQWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 12:22:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72B5852DB;
	Thu,  6 Oct 2011 12:22:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7pAzFdyguEs0
	qAISjxcXQvRr24k=; b=k8GT7ke4xnNmtBNSBNC8hXQKaKIJveCfJW6j1QbLK511
	nMTkTXDPFJSBmJnUxic2icoS1i+cy2mz9F9k5W4pHL5UDm1DnSSyLNP08W7PwJtY
	coJ+fIIazDW/4ElzcA15BwnUAsC8RgWRiFOdT6MeRtvU18N33LOY3oHry4r1kzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MqXw7T
	4xxBhxT3Ssg5wpZrOLxqSkBaomYeLq5axG2Th2Mkh4XHITONhG/T+xiKfd5OeJEV
	lTJ+ganZ4qAYvhp53K0OiaOvxXy8QHmbHi78/ryfNfFi6l0pYnI75agU+AVMJ9CU
	svfVPtS8i+8zm4ndZqDjLJFyxjtdfn+bhP0dU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69E3552DA;
	Thu,  6 Oct 2011 12:22:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C431052C8; Thu,  6 Oct 2011
 12:22:10 -0400 (EDT)
In-Reply-To: <CABURp0qCsKG2oOxLw4BfU8UM=9V+pigd69ZK=TZVwetBPqjuiA@mail.gmail.com> (Phil
 Hord's message of "Thu, 6 Oct 2011 00:04:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57CECE60-F037-11E0-B40C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182968>

Phil Hord <phil.hord@gmail.com> writes:

> On Oct 5, 2011 9:14 PM, "SZEDER G=C3=A1bor" <szeder@ira.uka.de> wrote=
:
>>
>> On Wed, Oct 05, 2011 at 05:44:54PM -0700, Junio C Hamano wrote:
>> > SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>> >
>> > > And what about unreadable .git files?
>> >
>> > Having then inside a working tree is so sick that I do not think i=
t
>> > deserves consideration.
>>
>> I'm not sure why is this any different than having a .git directory
>> that is not a repository inside a working tree.
>
> What should happen here? Ignore it and keep searching? Or fail?
>
> I just added some common gitfile detection code and I noticed that th=
e
> oddball case now is the one that dies on error rather than continuing=
 to
> search for alternate explanations.  I left the oddball behavior assum=
ing it
> is desireable, but now you have me rethinking it.

Yeah, after thinking about it a bit more, whenever we see ".git" during
the upward discovery process, we should always warn if we know it is _n=
ot_
a GIT_DIR before looking for another ".git" at higher levels, as anythi=
ng
in that directory cannot be added. If we cannot tell if it is or is not
a GIT_DIR, we should error out---the reason we cannot tell most likely =
is
because we cannot read it, and such a file, if it is not a GIT_DIR, can=
not
be tracked in the real GIT_DIR at a higher level, and if it is a GIT_DI=
R,
we cannot use it to record updates or inspect existing history.

How's that sound as a guideline?

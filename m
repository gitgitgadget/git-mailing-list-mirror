From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] Documentation: Fix misuses of "nor"
Date: Tue, 01 Apr 2014 12:04:25 -0700
Message-ID: <xmqqfvlw27nq.fsf@gitster.dls.corp.google.com>
References: <1396303907-23291-1-git-send-email-jlebar@google.com>
	<xmqqtxae0xe7.fsf@gitster.dls.corp.google.com>
	<CAMuNMfokH8cVwYmuPX7jY+i6Vp9nPKLS+7rZKUyMvw-8yDOGmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:04:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV3zQ-0007Z9-J3
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbaDATE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:04:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbaDATE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:04:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E893F78394;
	Tue,  1 Apr 2014 15:04:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w2FbCo0Evlw6ovlWg6kB0sl62Jc=; b=bO+OEe
	elkJes7rjDlY0jbh94+HmKADSBAYRq3j0QxbdAe1tVGEpv0ExwjQw8mbdsWaj1nr
	tXlPd0F21ZhzhBt32MwV28xw1EGYI2PIJoJjYXt0MvRoGBfW9vDam14oCZ/MXj1y
	RH0Vmpb6YcVNepfXkeh7qTaW07at10VNYAmkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cni97bCE1XiU4UvI3RSmuvBlJmHjHMJ7
	vk/p01Iep+r0s6bxfa+uwe4v/Ab1b6TdyEatnUKnN5LZT3r/Ec4UmlOs1WzrLZ9d
	pWWiJJY77njatNEngWmdU7tLi3yuGhuoXpB/A7JimquWvfr6pwuiN8JBmerndFjI
	kWcug9sMvZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D53DE78393;
	Tue,  1 Apr 2014 15:04:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2420078392;
	Tue,  1 Apr 2014 15:04:27 -0400 (EDT)
In-Reply-To: <CAMuNMfokH8cVwYmuPX7jY+i6Vp9nPKLS+7rZKUyMvw-8yDOGmQ@mail.gmail.com>
	(Justin Lebar's message of "Tue, 1 Apr 2014 09:48:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7233DEF2-B9D0-11E3-A709-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245620>

Justin Lebar <jlebar@google.com> writes:

[administrivia: please do not top-post]

> On Mon, Mar 31, 2014 at 4:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Four patches queued on 'pu' as-is (but retitled).  I didn't read
>> everything very carefully, though.
>>
>> Thanks.
>
> It's unclear to me: Are we done with this patch queue, or do I need to
> worry about getting these patches into another branch?  If the latter,
> I'll update patch v5 per your comments.

I didn't read everything very carefully, so I cannot vouch for the
correctness of all the rewrites myself, hence I will not be merging
it to 'next' or closer-to-release branches with confidence, at least
not yet.  Once I hear from somebody else who proof-read the changes
(or if I find the time to do so myself), I may be able to do so.  Or
somebody else (or myself) may find problems with the change and send
further review comments to the list, in which case you would want to
incorporate them in a reroll, ande the process continues on that new
version.

I do not remember there were other comments on the latest version of
the series---I suspect not many people had chance to read them yet,
so we may have to wait for "further review comments" for a few days
at least.

Thanks.

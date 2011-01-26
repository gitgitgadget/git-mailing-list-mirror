From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 13:24:17 -0800
Message-ID: <7vei7zjr3y.fsf@alter.siamese.dyndns.org>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
 <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
 <4D3FFB0F.9070700@viscovery.net> <m2hbcvz8me.fsf@gmail.com>
 <AANLkTinKZfkK0uuyNJZf7f1hvfu5-LeSsxaE9fkQ2O5X@mail.gmail.com>
 <m2d3njz839.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 22:24:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCr4-0000HI-If
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab1AZVYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:24:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab1AZVYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:24:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 936183AAD;
	Wed, 26 Jan 2011 16:25:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M9aTU9La/56875iM4TydElVFJGo=; b=X+aipY
	5MDzAX0hjlqsOhxg2cca01tPEcuoOmt4kHgMOAUUJJMaJgeY0kHpQZu83NYiFAyI
	Yt3rI+GSgrKjpiQJKkRBKrFFQycPj1kaGb5WYp1TvAw+ZGYb8KKXma04H/4dKeSK
	SYdmIV010y8q7rzI8K/flupkQ1h3yjoJqzn8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rgeDLXRePl3NcHIp5tN1y5qMFZgb2vLN
	sPOExBcAzOsttXGeb00LC7CfIjMpHOMMyOKIvU1bDJkLU+ZpzzbZpKqBRCxVoc2s
	2qO0VpyJXePNVr/ZGqWubfQlSabH2Px9Nklmol3CqG3P/u29r1O5UUqb+SwtvE9z
	obcX8kbPwTY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 368033AA9;
	Wed, 26 Jan 2011 16:25:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 986733AA7; Wed, 26 Jan 2011
 16:25:08 -0500 (EST)
In-Reply-To: <m2d3njz839.fsf@gmail.com> (Francis Moreau's message of "Wed\,
 26 Jan 2011 22\:08\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4063A80-2992-11E0-9D23-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165549>

Francis Moreau <francis.moro@gmail.com> writes:

>> On Wed, Jan 26, 2011 at 21:56, Francis Moreau <francis.moro@gmail.com> wrote:
>>> Just out of curiosity, I'd like to know why, since it has no annoyance
>>> for those who are replying to my emails.
>>
>> We keep everybody on CC who's interested in the thread here, and
>> usually reply directly to the person whose email we respond to. In
>> this case, I had to manually edit the TO line to be just you, and move
>> everybody else to the CC.
>
> Well, if I decided to set Mail-Followup-To, that do mean that I don't
> want you to do that !

That is _not_ something for _you_ to unilaterally decide.

I am responding to _you_ with this message to tell _you_ something, while
keeping Sverre, J6t and Rene and the list in the loop.

If I followedyour M-F-T on the message I am responding to, I would have
ended up placing these "secondary" (for the purpose of my message) on my
"To:" line.  That would make it impossible for them to prioritize the
messages addressed directly to them (which would have their address on
"To:") over other messages that they are merely in the loop (which would
not have them on "To:"---their address may be on "Cc:" or they may be
getting the message from the list).

So please don't.

Thanks.

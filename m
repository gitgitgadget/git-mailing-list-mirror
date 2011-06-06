From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 12:01:12 -0700
Message-ID: <7vr576943r.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DEC8322.6040200@drmicha.warpmail.net>
 <7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
 <4DECE147.3060808@drmicha.warpmail.net>
 <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
 <BANLkTi=KZN3g4s9jHSgYcPHA4eM+2U3g4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTf3O-0003Xz-3T
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498Ab1FFTB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 15:01:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab1FFTB1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 15:01:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2911D5147;
	Mon,  6 Jun 2011 15:03:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=V2rI8iE/oGlH
	5LxekXBl6nfnVc0=; b=u2r2iglG0I7rqQJKBw1b3NmDklkskPq9rjU2KDnZxzrS
	QTLJBVpQS3YQrzZPtyOiRE/Z3Vuo6kaezY+8A01hz+ZrFcyw+eomMnhL9qMVDJIH
	V326thZ4xtZZ54xMx5p22b7G3sJnY6hwaP7gZiR+zXH5cM0h88Y5gz+J4mCQIuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=W1b0L+
	8HF1/GUKviKYGTeOjmWwAIycpq4l7wTk5a6DK0FEc3VHHvHppENiDNYb5WxJxe1H
	oQgdD+3pDfyDeibczfRO5+/IqhPD1b95Zwz1O472WA2z7rqY7DMjRK5yRb8RORI+
	PMPMilvQiUxg9N85vOUHFUPDmOEZNAjXc9Qb0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBAB45143;
	Mon,  6 Jun 2011 15:03:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E6818513C; Mon,  6 Jun 2011
 15:03:24 -0400 (EDT)
In-Reply-To: <BANLkTi=KZN3g4s9jHSgYcPHA4eM+2U3g4w@mail.gmail.com> (Scott
 Chacon's message of "Mon, 6 Jun 2011 10:42:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABA5BB52-906F-11E0-8BEE-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175149>

Scott Chacon <schacon@gmail.com> writes:

> On Mon, Jun 6, 2011 at 9:14 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> ...
>>>> That is why I asked what the user experience of "git show NEXT" as=
 opposed
>>>> to "git show INDEX" should look like. So what should it look like =
during a
>>>> "pull" that did not finish?
>>>
>>> If NEXT is to mean the result of a commit in the current state, and=
 the
>>> current state would or should not allow a commit, then trying to ac=
cess
>>> that pseudo-commit should error out with a helpful message.
>>
>> What "helpful message"? I asked for the user experience, not handwav=
ing.
>>
>> Do you mean to say that the error message would teach the user that =
the
>> current state is not something you can create a commit? What message=
 would
>> that give the end user? =C2=A0I am hoping the following is not what =
will happen:
>>
>> =C2=A0Q. I tried "git show NEXT" because I wanted to see what the ne=
xt commit
>> =C2=A0 =C2=A0 would look like, but I got an error, saying NEXT is no=
t known as I
>> =C2=A0 =C2=A0 haven't resolved a conflict.
>>
>> =C2=A0A. Yes, the message is correct.
>
> I'm not sure why this wouldn't just list out the index tree,...

You are not entitled to say "I'm not sure" ;-). I asked you to show a
design of the user experience of "git show NEXT", as an advocate for th=
e
NEXT/WTREE notation.

I'd take it that you would "just list out the index tree" as the outlin=
e
of the user experience.

>> =C2=A0A. You would say "git diff HEAD NEXT".
>>
>> =C2=A0Q. Ah, that is the same as I always do before making a commit =
to see what
>> =C2=A0 =C2=A0 I have added so far look sane. Thanks.
>
> Why would this look sane? I would think this would say "* Unmerged
> path <file>" just like 'diff --cached would do.

Either you read it too hastily or I didn't write this clear enough; "sa=
ne"
does not refer to the command. In this story, the novice is saying "Bef=
ore
I make a commit, I check if my changes so far matches what I wanted to
achieve, in other words, I check the sanity of my changes. And 'git dif=
f
HEAD NEXT' is the command I use when I am not in this weird 'conflicted=
'
state. I am happy that I can use the same command".

> But, yes, I assume there would be some difficulty in supporting it
> everywhere.

I don't care too much about "difficulty in uniformly implementing". I a=
m
doubting that you can _design_ uniformly for these new tokens to make
enough sense to help the new people. That is why I've been asking for
concrete examples of user experience design, sample transcripts, that
covers known corner cases.

If NEXT/WTREE advocates cannot come up with one, or if that is just to
punt and say "NEXT is not defined in this case---use the traditional
command" in the error message, I don't see much point in discussing thi=
s
further. It will end up with the same whine-fest as previous rounds.

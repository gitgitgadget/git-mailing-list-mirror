From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 2 May 2011 21:33:48 +0200
Message-ID: <BANLkTikOcZ9U2BJAPAvCwTFpYGcb13pDXg@mail.gmail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
	<7vfwoxoy5c.fsf@alter.siamese.dyndns.org>
	<BANLkTinVvJgE0+gxm8SdDi30-a11P2HnNA@mail.gmail.com>
	<7vy62oly2h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:33:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGysU-0000n0-Hq
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab1EBTdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 15:33:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33267 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab1EBTdt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 15:33:49 -0400
Received: by fxm17 with SMTP id 17so3851336fxm.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m3tVBzHuYqMTteTjdwW8E8YmMvl0I3G97hzMduieMSg=;
        b=LPaH76XSky/TX3PRN+Jfrho9d0ItiU6KXGlPk4gzMj176d3vFf93NV6QQ4pLT20ODn
         +BCzWmIUG0w6sb7OZ3rAvIwiqn/UPXHVK0BQq53mUzoASFo9Tjq6p00yVJfaaKWXhD25
         exveTCtbgPcctCALb8JKJ2Wm9jtjVfA2ii+6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K+0HYaNrsYQOjXjbZQHqxcPVUrLjwTJeTlSZWuQdZm09R1RlWjpI0DwL1HgNaDPzDT
         LFoFZIh4S98rVBWgEozyB5Hvr4b1d6nZyTPGK2qdndL910CJvU3Fm+a0o9yC8GZiVBxh
         u2im70UHDACk4fpRTjmAIk5x5LriPUsqNTfU4=
Received: by 10.223.145.78 with SMTP id c14mr1856628fav.75.1304364828427; Mon,
 02 May 2011 12:33:48 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Mon, 2 May 2011 12:33:48 -0700 (PDT)
In-Reply-To: <7vy62oly2h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172625>

On Mon, May 2, 2011 at 21:08, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>> =C2=A0- Are there existing non-git "grep" implementations that do t=
his?
>>
>> I didn't know of any, until Jakub mentioned the ack tool. And I didn=
't
>> look for one. I will answer you 'yes'-questions only in context of m=
y
>> proposal.
>
> Thanks, but these questions are simple sanity checks done by contrast=
ing
> your design with _existing practices_, if any. =C2=A0It is not useful=
 to answer
> what you did here, only to contrast your design with itself.

I should probably have written 'I *can only* answer...', but I
appreciate your questions anyhow, even if I can't answer them all.

>
> Also we can read them from your implementation ;-).
>
>>> =C2=A0 - perhaps people use something like "sed -n -e 25,30p file" =
and be
>>> =C2=A0 =C2=A0 happy?
>>
>> How would you combine this with git grep HEAD or with multiple files=
?
>
> Now how did you get the compiler error messages from your example fro=
m the
> files in HEAD commit without checking them out?

Haven't you heard of the git-gcc extension yet. Just kidding and point
taken. But I think/hope there are some more use cases than my own for
this feature, else I wouldn't have send the patches out.

Bert

>
> Besides, that question is still part of figuring out prior art done i=
n the
> git-unaware grep, so it is irrelevant that sed or other people's grep
> cannot peek into HEAD.
>

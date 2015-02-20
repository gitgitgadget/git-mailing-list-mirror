From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Fri, 20 Feb 2015 00:13:48 -0800
Message-ID: <CAPc5daWz-Xa7q6f9RzgTP4has8DcCG4QgK7SMGNbH6KGnEyr2Q@mail.gmail.com>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>
 <xmqqa90d4fdp.fsf@gitster.dls.corp.google.com> <CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>
 <54E46635.4060009@drmicha.warpmail.net> <xmqq8ufv408l.fsf@gitster.dls.corp.google.com>
 <CACdBeKnqZuu50knWs=aCm7295no880EN9TYY+hMnfSdVvdZ4AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Julien Cretel <j.cretel@umail.ucc.ie>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:14:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOij0-0007cg-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 09:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbbBTIOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 03:14:10 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33387 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbbBTIOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 03:14:09 -0500
Received: by mail-ob0-f182.google.com with SMTP id nt9so22195992obb.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 00:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NE1/SHQk8LgqCAiN9kylWF/V8jpSTCh5cWcpsW9RmpA=;
        b=Qu8ukKdxUjVBHyeuW3XQnaI2NTTopjxXLZQqlnzifzdyjcNR1Q/2DXJUcEm08LDq4y
         p6VUxZQRFAlr8N3GT1c12YyRV4FVntPtcqZPBESCSnUulYSGaE3iRTDwJz3aAER1974l
         uILUHt5Lk3pI0y3b4/L6BIBzesRZBP9zgpzlQQvSzPu8bljbwYFYjyNsD5CXrFiVQSn4
         JO5/+iHvdxqtdxxkGi+Vbkpgmw8GjwY9Q7pb1VgrtAU5XxRlH0wvAYBC1D8/Aaq0v5ja
         CVy/MYHVNU+I+j2NOPmDmfmuDjXb2wGK77oKHY36Al6ifzFbD+jMg/8QZqHA5uVyknZ3
         +Krw==
X-Received: by 10.182.20.195 with SMTP id p3mr3093891obe.1.1424420048306; Fri,
 20 Feb 2015 00:14:08 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 20 Feb 2015 00:13:48 -0800 (PST)
In-Reply-To: <CACdBeKnqZuu50knWs=aCm7295no880EN9TYY+hMnfSdVvdZ4AA@mail.gmail.com>
X-Google-Sender-Auth: hlsKir0ZTi_YhHNBIvE87eK0nWY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264139>

On Thu, Feb 19, 2015 at 3:13 AM, Julien Cretel <j.cretel@umail.ucc.ie> wrote:
> On Wed, Feb 18, 2015 at 5:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Julien's "HEAD=master, other" vs "HEAD, master, other" may be
>> subdued enough to be undistracting, I would guess.  I do not think
>> the distinction between "HEAD = master" and "HEAD -> master" would
>> be useful, on the other hand.
>
> Just to clarify, I suggested these two notations as alternatives for
> denoting the same state: "HEAD is attached to master". They were not
> meant to denote different states. Accordingly, a detached HEAD could
> be denoted by "HEAD, master, other" (i.e. the same as the current
> output of "git log --decorate").

That makes it even better than my misunderstood version ;-)  A list
that is usually "A, B, C" that sometimes has "A, B=C" is inconspicuous
enough not to be distracting too much, I would say.

Thanks.

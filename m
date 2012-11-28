From: Ivan Kanis <ivan.kanis@googlemail.com>
Subject: Re: git fetch pack freezes
Date: Wed, 28 Nov 2012 18:25:33 +0100
Message-ID: <87obihhc6q.fsf@visionobjects.com>
References: <87624pizoe.fsf@googlemail.com>
	<CAJo=hJvGNUtT+z_E7rSaOr77=7dSo1N+7QiEoHNdEQDV3n7JWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdlPP-000206-NK
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 18:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106Ab2K1RZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 12:25:39 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:41580 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab2K1RZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 12:25:38 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so4587815wer.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:face:x-hashcash:x-hashcash:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=qBffVz7nOOcvXy/jB978Av5yCTd/x0++bvUATALnXKk=;
        b=h0F+9ziQwmE+L9pAkOxun7pUJIDGbZa6UDAuwXyQS/pvFSUkxgJME68dbzfdcCS8n4
         UBqCJLe9XPWuFceOTH6b/1qfrfA1RXEQufOxd59C+j90prFGbetFehTQur9iwhF5dBJQ
         jocsDKs7ZQ445JyrwRUMFBmIANnnp58FC/ZZy3auIkyTDi3u9vrciA1EeBuWoPjDnWnt
         ZWnfiB5ZKbGz3yjStibRaF8ENZEJ2P/w2DniUiVZZx9RW8Kgi9rQggEk4KyjLvgMd371
         viTBdN1oY4Neq1SUcTm3BrIRLuclS9yRPvSWITZt/v1vHTrKxcDpAtvmIBjdpJaMGAW2
         8i+g==
Received: by 10.216.28.8 with SMTP id f8mr5513422wea.162.1354123536811;
        Wed, 28 Nov 2012 09:25:36 -0800 (PST)
Received: from yan ([46.218.71.241])
        by mx.google.com with ESMTPS id g2sm8287303wiy.0.2012.11.28.09.25.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 09:25:35 -0800 (PST)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
X-Hashcash: 1:20:121128:git@vger.kernel.org::clH1G8EBuXrlt1Xm:0000000000000000000000000000000000000000000X/q
X-Hashcash: 1:20:121128:spearce@spearce.org::XtXN2FePlSD+2N3X:000000000000000000000000000000000000000000EqPQ
In-Reply-To: <CAJo=hJvGNUtT+z_E7rSaOr77=7dSo1N+7QiEoHNdEQDV3n7JWw@mail.gmail.com>
	(Shawn Pearce's message of "Wed, 28 Nov 2012 08:41:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210743>

Hi Shawn,

Thanks for the quick reply.

Shawn Pearce <spearce@spearce.org> wrote:

> On Wed, Nov 28, 2012 at 6:12 AM, Ivan Kanis <ivan.kanis@googlemail.com> wrote:
>>
>> On the server we are seeing the following error message:
>
> Upgrade your server.

OK we'll look into it. I have a question: will a 1.8 server still serve
1.7 git client?

> So the stack frames are correct. Its just a problem that the parent
> didn't identify the server crashing and closing its side of the pipe
> on stdin to force it to EOF to prevent the child from getting hung
> here in a read.

It sounds like a bug on the client, doesn't it?
-- 
Ivan Kanis, Release Manager, Vision Objects,
Tel +33 2 28 01 49 50,  Fax +33 2 40 25 89 20
http://www.visionobjects.com

Let a fool hold his tongue and he will pass for a sage.
    -- Publilius Syrus

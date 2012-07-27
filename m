From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] builtin-commit.c: Not add duplicate S-o-b when commit
Date: Fri, 27 Jul 2012 09:07:22 +0800
Message-ID: <CANYiYbFOS6Qw+vrF6_amzKinHwULrqJJKjm9SSy7i3rCtB10aw@mail.gmail.com>
References: <ee08efceaa3f015732a19d49eb96bdeeaaf3d609.1343282283.git.worldhello.net@gmail.com>
	<7vy5m781j5.fsf@alter.siamese.dyndns.org>
	<CANYiYbH0Jfk0LLp8HXVEamD0uRzM2OGJCE8W4h_UoDLh1pMVHA@mail.gmail.com>
	<7vpq7i8oag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 03:07:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuZ1d-00013Q-84
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 03:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab2G0BHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jul 2012 21:07:24 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57177 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab2G0BHX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 21:07:23 -0400
Received: by yenl2 with SMTP id l2so2659785yen.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/bLQuv8KENWiSwGE9kL+n+sWQon6WJQ4qXbayc0vM3g=;
        b=KCA9I864g2brkz6fUhuW8P8qsHV8iQjwcr3PXo1eTH/JybsoRde9/+yTstbuowQXXP
         NW5fqt5mITVx/7G+8qybqMn5pjP+lYONNilgbrkdUBEyYKg+qxiLGPlAEp5aAGl8VFFF
         VtprHV0Uz4odOro9hkOrwUUAHCQStPff2fYSs3zPBgYJcdH47meB4l3Q29I6z5Q27btv
         TIaU7/CQ800pUvVpWsBgVktDG72024ys532Y9wHmU0n7N7aQsK+xpx6JeAnHPbZ7eDWC
         w9qkgE0Ok3ldPtAX9HyyPR70JfNRnnha4nx3iHZ4YT6LJ9uYDHNVu62Y1DEK1YF+Tsgf
         IBIA==
Received: by 10.50.17.170 with SMTP id p10mr508450igd.19.1343351242753; Thu,
 26 Jul 2012 18:07:22 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Thu, 26 Jul 2012 18:07:22 -0700 (PDT)
In-Reply-To: <7vpq7i8oag.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202331>

2012/7/27 Junio C Hamano <gitster@pobox.com>:
>>     Signed-off-by: A
>>     Signed-off-by: B
>>     Reported-by: C
>>
>> So I guess duplicate S-o-b is not intentional.
>
> I think the two commands are doing randomly different things on
> garbage input.  The order in the input (i.e. your "original") does
> not make sense.  C is not the person who handled the patch the last.

I am clear, thanks. Please reword the commit 3c58c1a in branch
"jx/i18n-1.7.11". Change the tags from:

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
    Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
    Reported-by: Vincent van Ravesteijn <vfr@lyx.org>
    Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

to

    Reported-by: Vincent van Ravesteijn <vfr@lyx.org>
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
    Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
    Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


--=20
Jiang Xin

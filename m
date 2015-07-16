From: Juston Li <juston.h.li@gmail.com>
Subject: Re: git send-email Connection Closed
Date: Wed, 15 Jul 2015 19:43:42 -0700
Message-ID: <CAFow2F_MLF_tHNRXcZLuP5i8tu1WFyjhjoALaASO6hMxDMHKgQ@mail.gmail.com>
References: <CAFow2F9ZFNcBdoc7YTCeGT_PA-UvMyfcKWE4K4ufGMyFXJd5Uw@mail.gmail.com>
	<CANoM8SXv22_CGpK+5b7rzSstkpevPt_KmCW9ZHQNS-2wBmEEVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 04:43:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFZ9I-0003Nt-2h
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 04:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbbGPCnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 22:43:43 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37978 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbbGPCnn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 22:43:43 -0400
Received: by iggf3 with SMTP id f3so3808642igg.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 19:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+ZfBJr0WlchddwSKJy1WtXx7bBJ13r7JIso5G8Xbr+A=;
        b=EhsJLll64gC7FKehKcdY4YY3pI4k608kNg0X+rv9pUyFRSI/YX2RtZGko66/HX1FGz
         6DrdbQT39ESAHZEQVizwvgADPAWxh6cy90kQ7OIxtKfz4+fFXw4Pd7G6BLa/tkyfrkOE
         rqpESjI8yg+rWchZrDSejZi5UWLicwcKKzZZPZtHx7JMD4svneC3bX3mo8UURd8fto/j
         5JZoyVq8YVDAEGP+xw+sM8t3FEwE/tgGow3Lt8HQBh19nhwPkq/aVoXSwmE0CmOjmR2T
         runXwE6DRpPDslOD6pz6x3UGI5eRRb2Nv/vwEoKLR/aIpYlbljL4/f+m3QL07Q1FGgPX
         5/xw==
X-Received: by 10.50.143.104 with SMTP id sd8mr423311igb.34.1437014622372;
 Wed, 15 Jul 2015 19:43:42 -0700 (PDT)
Received: by 10.79.19.7 with HTTP; Wed, 15 Jul 2015 19:43:42 -0700 (PDT)
In-Reply-To: <CANoM8SXv22_CGpK+5b7rzSstkpevPt_KmCW9ZHQNS-2wBmEEVg@mail.gmail.com>
X-Google-Sender-Auth: pHQO5CFfeRvXTQ7_iW8LLxKd_wY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274004>

On Wed, Jul 15, 2015 at 3:00 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> I believe that this is due to gmail not allowing the email.  I think
> there are two ways to fix this:
>
> 1.  Temporarily enable less secure apps for your gmail account while
> you send the email [see
> here](https://support.google.com/accounts/answer/6010255?hl=en).
> 2.  Setup multi-factor authentication on your account and create an
> app specific password for git-send-email [see
> here](https://support.google.com/accounts/answer/185833?hl=en)
>
> Obviously the second method is more secure.  I have had success with
> both of these techniques.

Yeah it makes sense it is gmail not allowing it, I've resent the patchset
before so maybe it doesn't like the same/similar email sent thinking that
I am spamming it.

I have 2 factor authentication enabled and use an app specfic password.

Thanks
Juston

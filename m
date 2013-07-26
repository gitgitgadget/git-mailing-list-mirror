From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: redundant message in builtin/rm.c
Date: Fri, 26 Jul 2013 06:03:54 +0200
Message-ID: <CAN0XMOJ+ar+iKwVi_z02x7p3XcZj0SxT69a7ApRxOioet8RwDw@mail.gmail.com>
References: <CANYiYbGQj6mCDraxiBHXEL+qd7OwnFCaMpB3Wb4_Pg=-p+KJAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"'Git List" <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 06:04:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2ZG4-00030h-0T
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 06:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab3GZED4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 00:03:56 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:52186 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3GZEDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 00:03:55 -0400
Received: by mail-wg0-f54.google.com with SMTP id n12so2405536wgh.9
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 21:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IVFbhKUuLC5s31p5DetdmjccCM6G63jV77cDCCKp6eM=;
        b=u7cV6k+aBsqzyBwnSVphKw4onesH2kp6VzWIh12e9bJNNz3hfuSE2XvPg5k0fCcbQi
         LoghRD8XDW2pcV8DE3TpzM3Ik/sD6yVVTX2d59KGfSfhfy/mkxZiJ9Ym8A2DuONrrP9B
         CjU1kaljFafvueahUwhvRdzoaSXZ9ULc4YCJjRoRpGuPPaZokarrBscbGO6o3pG+4r7C
         PsH2BX3oWH8vMqXzc+t9PdaHhLd+XHBoKVcKOop4J1ypg3Gong4fQaPmbeJOvvgNhgXn
         yuYXcoo9cm+2nncjpP3Tj3ArEJGO0c4ED1EFT8ZoddXTqeL/rRIICJdOM5ZscpZd+JqJ
         KUzQ==
X-Received: by 10.194.78.42 with SMTP id y10mr32465189wjw.93.1374811434407;
 Thu, 25 Jul 2013 21:03:54 -0700 (PDT)
Received: by 10.194.20.229 with HTTP; Thu, 25 Jul 2013 21:03:54 -0700 (PDT)
In-Reply-To: <CANYiYbGQj6mCDraxiBHXEL+qd7OwnFCaMpB3Wb4_Pg=-p+KJAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231162>

2013/7/26 Jiang Xin <worldhello.net@gmail.com>:
> Hi,
>
> Commit v1.8.3-1-g914dc02 (rm: better error message on failure for
> multiple files)
> introduced many messages need to be translated. I found two similar messages
> each has a slight typo, and the differences cause redundant works for
> l10n translators.
>
>         # builtin/rm.c, line: 90
>
>                           Q_("the following submodule (or one of its nested "
>                              "submodules)\n uses a .git directory:",
>                              "the following submodules (or one of its nested "
>                              "submodules)\n use a .git directory:",
>
>                          ( no space before "use(s) a .git directory" ?)
>
>         # builtin/rm.c, line: 240
>
>                           Q_("the following submodule (or one of its nested "
>                              "submodule)\nuses a .git directory:",
>                              "the following submodules (or one of its nested "
>                              "submodule)\nuse a .git directory:",
>
>                          ( "nested submodule" should be "nested submodules" ?)
>

It's more readable if "\n" is at the end of a line.

Q_("the following submodule (or one of its nested submodules)\n"
"uses a .git directory:"

> --
> Jiang Xin
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

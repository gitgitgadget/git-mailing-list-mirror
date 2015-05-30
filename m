From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] clean: remove unused variable buf
Date: Sat, 30 May 2015 23:20:52 +0800
Message-ID: <CANYiYbEYLGZ00RadktTvEY1cp97ZckkUz++dxi6X7FzyrSn2bg@mail.gmail.com>
References: <555BB586.8050503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat May 30 17:21:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyiZV-0008Rr-0e
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 17:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbbE3PUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 May 2015 11:20:55 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34164 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbbE3PUx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 May 2015 11:20:53 -0400
Received: by wibut5 with SMTP id ut5so5005288wib.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=50pVVweeSqivdn1sqmNXp02w1gQdkeWlgKN6OZA5O0Y=;
        b=dVvbNicQKfmdidlJl3bKX+mE7qkaHW0KbDUtUk3dLIFCPEFROhOMb9zgaNHnxubD5Y
         gZvyKwgATf7VohcmaR3BdrOBopnPD4PoX00AIgYkhbQh+jYy8vl31wRaVH85jXQ88Lcv
         hH5ccjx7e4bWWqTfYVy2KwPu3/kbEBYc41N5C+RMe4LKu6Psp3onHM2MFyOYmSfil0ed
         rhSd6hLrmn0+Y7YkPNKt+o/qKOGm9mGPWkbo7w3zuFA918pZ3TxFHY8bxnIHZnplVbhG
         leE4T0VYFGh4VX8/59fxJrl0J09PuZJ4jhYxJP0qPZyrwmIBliWG1KO29C2W8Y3kFLF3
         mFsQ==
X-Received: by 10.194.189.80 with SMTP id gg16mr25658139wjc.9.1432999252056;
 Sat, 30 May 2015 08:20:52 -0700 (PDT)
Received: by 10.194.123.7 with HTTP; Sat, 30 May 2015 08:20:52 -0700 (PDT)
In-Reply-To: <555BB586.8050503@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270285>

2015-05-20 6:13 GMT+08:00 Ren=C3=A9 Scharfe <l.s.r@web.de>:
> It had never been used.

Confirmed. The unused "buf" should be removed.

>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/clean.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 98c103f..a9eb772 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -314,7 +314,6 @@ static void print_highlight_menu_stuff(struct men=
u_stuff *stuff, int **chosen)
>  {
>         struct string_list menu_list =3D STRING_LIST_INIT_DUP;
>         struct strbuf menu =3D STRBUF_INIT;
> -       struct strbuf buf =3D STRBUF_INIT;
>         struct menu_item *menu_item;
>         struct string_list_item *string_list_item;
>         int i;
> @@ -363,7 +362,6 @@ static void print_highlight_menu_stuff(struct men=
u_stuff *stuff, int **chosen)
>         pretty_print_menus(&menu_list);
>
>         strbuf_release(&menu);
> -       strbuf_release(&buf);
>         string_list_clear(&menu_list, 0);
>  }
>
> --
> 2.4.1
>



--=20
Jiang Xin

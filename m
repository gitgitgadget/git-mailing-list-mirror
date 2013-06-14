From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/5] stash doc: add a warning about using create
Date: Fri, 14 Jun 2013 08:27:46 -0400
Message-ID: <CABURp0rF2ESFmvf=UQcbKr6ybc0wmGY-_=Nc3yMQJ2jhZGUQJQ@mail.gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com> <1371205924-8982-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 14:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnT7C-0002bP-IP
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 14:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab3FNM2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 08:28:08 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:55624 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab3FNM2H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 08:28:07 -0400
Received: by mail-ve0-f170.google.com with SMTP id 14so413320vea.15
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lnCo5nkGdKOREpokcTv3iCDyzEHFBfRKRiHFD99Ihq8=;
        b=rtKLEKbi8+rwBJVjjmo/vqEvoROkNBuKIZ5zJHkqe8kerP43+qB+Jzta2UB775L051
         7qeR8TFBxlJ+X4v3CMNHS58f4oA7UlK3XpzwVQcUX6ggs6blZ83MHoJIpHuvL7YkJZny
         biCMg2wYtWsCcEJ15DamHnR2a4AUJeTG8NP+vge6Ll6E7cNc6qAKDweg5lw59SoYljT0
         xIqBmGPRiOAzq+MKjPk2lAejC0/Vrgn4BGy9krbg/IhgtowsCQEzSZz6dmVcdiVvcYTo
         HHUmAJOZI6HrR0vd4wCanHcSNKKJghiXJm7jSzx0P/X42FGcqvh4SgMBW0uMC3CxPm14
         68nw==
X-Received: by 10.58.90.5 with SMTP id bs5mr827367veb.60.1371212886916; Fri,
 14 Jun 2013 05:28:06 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Fri, 14 Jun 2013 05:27:46 -0700 (PDT)
In-Reply-To: <1371205924-8982-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227815>

On Fri, Jun 14, 2013 at 6:32 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Add a note saying that the user probably wants "save" in the create
> description.  While at it, document that it can optionally take a
> message in the synopsis.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-stash.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 711ffe1..83bb3db 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -16,7 +16,7 @@ SYNOPSIS
>  'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
>              [-u|--include-untracked] [-a|--all] [<message>]]
>  'git stash' clear
> -'git stash' create
> +'git stash' create [<message>]
>
>  DESCRIPTION
>  -----------
> @@ -151,6 +151,7 @@ create::
>
>         Create a stash (which is a regular commit object) and return its
>         object name, without storing it anywhere in the ref namespace.
> +       This is probably not what you want to use; see "save" above.

Thanks, this is helpful.

Maybe you can also hint why this command exists.

  +       This is intended to be useful for scripts.  It is probably not the
  +       command you want to use; see "save" above.

>
>
>  DISCUSSION
> --
> 1.8.3.1.383.g0d5ad6b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

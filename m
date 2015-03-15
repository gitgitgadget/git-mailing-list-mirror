From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] Documentation/git-add.txt: describe --exclude option
Date: Sun, 15 Mar 2015 14:14:42 -0400
Message-ID: <CAPig+cRP-63zZTBXMMje6QGmkftNThDNQU_P_3Od4SbwdV-JUQ@mail.gmail.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
	<1426427425-23309-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:14:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXD3n-0000Yo-Cs
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 19:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbbCOSOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 14:14:43 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33265 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbbCOSOm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 14:14:42 -0400
Received: by ykek76 with SMTP id k76so10373457yke.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fnHmGmTcx8LG4tAUsrX1KKedAHaVV+ESQ3sbr3GtpOs=;
        b=bZ8huGhLxAkkI6NJHuJWbL0++KW+WBj0uusgzFjZgkaPpboFkGbm4DgzGGOwa4gLrb
         xGM0NIfwNZFU7rR10/GOfFXLlN22DUHDi3HQkd0RLDkOGTavprm6/bWhrMT0/ifG1NwL
         vGL3rGzTZc9GC6js/hHUWXy62/RivGLd8jC5lqhBJSZ5JNya54zce6SwEDdHxs7AiYwN
         ENwWg9uS+GIF0PSjLAN/RJD8CI7r/fngXJlaiS8Vfh1PxqEBfOoxy5JK2yiFFlepbj3R
         SJd+YPgg7VxtXBzBkXXA75Vb87uPvB0hkql4YZ0PrkKuRNpiXPwhOsUl288QseNeLZi6
         2gvg==
X-Received: by 10.236.105.210 with SMTP id k58mr57116873yhg.52.1426443282069;
 Sun, 15 Mar 2015 11:14:42 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 15 Mar 2015 11:14:42 -0700 (PDT)
In-Reply-To: <1426427425-23309-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: MW20GKIz2rp2fMRVG6Y8CC1ObJc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265510>

On Sun, Mar 15, 2015 at 9:50 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index f2eb907..4bc156a 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
> -         [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
> +         [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]] [--exclude=<pattern>]
>           [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
>           [--] [<pathspec>...]
>
> @@ -164,6 +164,10 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>         be ignored, no matter if they are already present in the work
>         tree or not.
>
> +--exclude=<pattern>::
> +       Do not add files to the index in addition which are found in
> +       the .gitignore.

This is difficult to understand. Perhaps something like:

    Also ignore files matching <pattern>, a .gitignore-like
    pattern.

This option can be specified multiple times, can't it? The
documentation should say so.

> +
>  \--::
>         This option can be used to separate command-line options from
>         the list of files, (useful when filenames might be mistaken
> --
> 2.3.3.472.g20ceeac

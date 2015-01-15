From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Documentation/init-db.txt: minor style and synopsys fixes
Date: Thu, 15 Jan 2015 11:50:33 -0500
Message-ID: <CAPig+cTHDf6S-R6DEZ3mV+wNhn9KojsoMy_ogg7wG4aPWnvUpA@mail.gmail.com>
References: <1421317918-11677-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 17:50:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBnd0-00013u-OW
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 17:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbbAOQue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 11:50:34 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:62613 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbAOQue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 11:50:34 -0500
Received: by mail-yk0-f177.google.com with SMTP id 9so7328209ykp.8
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+gALXMUcFOYTYhMYItnaaZGYfcEZunFw+dgeGCDQEXI=;
        b=NhmicYmIR+5vMDkZwnvpaDExkas16z7B1ZLHbWkBgHqPlDFdWFjJXfs9gzN3XtlIWe
         ntApUA2JMKz1L2RLUYVSOxVmWiMKt0/c3oWzOix0KPLi+w5RbfXfyDLQmZ3BjhAItzB9
         JALpr28is68bfaOt26TvZDjzlcI+D/zRi6PGdkHco5FE789wx82xseNgdnCs54IXDtDI
         Y0pkdimGL7HxZ2d0oyhmC36WtQ+xFT+BsJMO92Qa3ma0DUzcQpxHNJp+TzCnlk2ttmyH
         l4Kj1s3Qc2xVXjxbtdXH04oVKlsDVQQc82//0sadqLYaKokoHUex29+/aKzMxzmt0odK
         k6lg==
X-Received: by 10.170.154.195 with SMTP id v186mr7564070ykc.22.1421340633238;
 Thu, 15 Jan 2015 08:50:33 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Thu, 15 Jan 2015 08:50:33 -0800 (PST)
In-Reply-To: <1421317918-11677-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: Ya5dCIpXXDvw6s24Md7-NToIz9I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262486>

On Thu, Jan 15, 2015 at 5:31 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> Subject: Documentation/init-db.txt: minor style and synopsys fixes

Subject is incorrect now that you're modifying git-init-db.txt and git-init.txt.

> This patch constists of two minor changes:
>
> * line-wrap 'git init-db' synopsis
>
> * last possible argument '[<directory>]' was missed
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  Documentation/git-init-db.txt | 5 +++--
>  Documentation/git-init.txt    | 6 +++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
> index 648a6cd..2c77aaa 100644
> --- a/Documentation/git-init-db.txt
> +++ b/Documentation/git-init-db.txt
> @@ -9,8 +9,9 @@ git-init-db - Creates an empty Git repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
> -
> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
> +            [--separate-git-dir <git-dir>]
> +            [--shared[=<permissions>]] [<directory>]
>
>  DESCRIPTION
>  -----------
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 369f889..25412ac 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -10,8 +10,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
> -         [--separate-git-dir <git dir>]
> -         [--shared[=<permissions>]] [directory]
> +         [--separate-git-dir <git-dir>]
> +         [--shared[=<permissions>]] [<directory>]
>
>
>  DESCRIPTION
> @@ -108,7 +108,7 @@ By default, the configuration flag `receive.denyNonFastForwards` is enabled
>  in shared repositories, so that you cannot force a non fast-forwarding push
>  into it.
>
> -If you provide a 'directory', the command is run inside it. If this directory
> +If you provide a <directory>, the command is run inside it. If this directory
>  does not exist, it will be created.
>
>  --
> --
> 2.3.0.rc0.314.g170a664.dirty

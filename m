From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 3/4] cat-file: add documentation for '--literally' option.
Date: Tue, 7 Apr 2015 16:49:30 -0400
Message-ID: <CAPig+cRF7-qTby_s=vQPCTN7JYS9=8q3WO3zkbkGUP4Ax=o=wg@mail.gmail.com>
References: <551F7984.5070902@gmail.com>
	<1428126264-19179-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:49:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfaRE-0002IA-AA
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 22:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbbDGUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 16:49:32 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:33742 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbbDGUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 16:49:31 -0400
Received: by layy10 with SMTP id y10so51578466lay.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=p9yl9n8txpsiZWle0xqR3B1SpwTYaq+4AhQ+PUKNeH4=;
        b=K6xhx7QfI7rR/1ENUx3Sun/qcwYkEDoGyVGZVjahPW4b7lkHn7MHSu0rUYP2131QDa
         AA4A8LdMDZrcgqJMkYDYBF+v2bwnEaqi3hWDPQcoQlzPMBgxr5JyHuK1szdcaJYR19xL
         ofV3tMihSwIpU/BI79CaEqm38+052fbjnPAeslSqDY/qVQEQRqd/93nKwpJHiAGbczTJ
         Z0RyGyJ3oEJup/UZoOcRQIy2Yxy6dFC8HYHzTUiZYr7uulNc/4n9oozw015D9DXrVr1+
         O0QQ7UGDZoJj3tkJfX7qZ7cxG9dOfsY8Xa8/QMLQ9JR9/L/z0EucUP5pP5FrJELDjdAz
         HLIg==
X-Received: by 10.152.26.169 with SMTP id m9mr20050154lag.45.1428439770216;
 Tue, 07 Apr 2015 13:49:30 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 7 Apr 2015 13:49:30 -0700 (PDT)
In-Reply-To: <1428126264-19179-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: jJAZI46PKRbXXibqlq7aisypea0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266941>

On Sat, Apr 4, 2015 at 1:44 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index f6a16f4..8bac7bd 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -9,7 +9,7 @@ git-cat-file - Provide content or type and size information for repository objec
>  SYNOPSIS
>  --------
>  [verse]
> -'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
> +'git cat-file' (-t [--literally]| -s [--literally]| -e | -p | <type> | --textconv ) <object>
>  'git cat-file' (--batch | --batch-check) < <list-of-objects>
>
>  DESCRIPTION
> @@ -69,6 +69,10 @@ OPTIONS
>         not be combined with any other options or arguments.  See the
>         section `BATCH OUTPUT` below for details.
>
> +--literally::
> +       Print information of broken/corrupt objects of unknown type without
> +       throwing an error. To be used combined with '-s' or '-t' option.

The way this is worded, it sounds as if the --literally option itself
is printing some sort of additional information beyond what -s or -t
outputs. In fact, it merely allows -s and -t to work with
broken/corrupt objects. Perhaps rephrase something like this?

    Allow -s or -t to query broken or corrupt objects of
    unknown type.

>  OUTPUT
>  ------
>  If '-t' is specified, one of the <type>.
> --
> 2.4.0.rc1.249.g9f2ee54
>

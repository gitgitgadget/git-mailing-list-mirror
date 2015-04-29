From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 4/5] cat-file: add documentation for
 '--allow-unkown-type' option.
Date: Wed, 29 Apr 2015 17:13:22 -0400
Message-ID: <CAPig+cREOOEmv=JXu7m8-LoVt0ZErQBht+OyTC=BnXX6FZ96iw@mail.gmail.com>
References: <5540D397.8020104@gmail.com>
	<1430312186-23542-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:13:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZIO-0003qH-BK
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbbD2VNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:13:23 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36580 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbD2VNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:13:23 -0400
Received: by iebrs15 with SMTP id rs15so52983821ieb.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EiKtYSN4II89zzGx0ECPAa1qVi6fB7E/kBjhYVI1LVs=;
        b=TMKc3QHud02J1AnZA7ItheB00SbPpgF+F/4X1poaLOPxSdnsd4ruTKt2vA4wEBGqVh
         HBKeRhANQr8dHx03Hx/+yT3TRF3yMrIjLuntWlim7/9/PGY6CRKKwxSkvwJOi8VKXobV
         5jdrCsxmfX6ELct+GQsNbkKUrTbvfKoFR2iKU0Lj033A/aUZelYpUkZACUw33Vkj1beE
         B/Ni4uRtZIbC6WO/+GKceV+ry/5MktsuW+WY/YKDjsIK0rErodESBdvgz/EhlCAGF9pl
         7SxoKKok9BuidlKDSHfDiHUoFoZuDkQF4vvpRNuDaTgBmTaf1TYO1LrFKAfI5BjG6OZ4
         NysA==
X-Received: by 10.50.43.169 with SMTP id x9mr6456732igl.7.1430342002688; Wed,
 29 Apr 2015 14:13:22 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 29 Apr 2015 14:13:22 -0700 (PDT)
In-Reply-To: <1430312186-23542-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: wOsCaFwr1K1qKpvFUL1ASM3i3aY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268003>

On Wed, Apr 29, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> cat-file: add documentation for '--allow-unkown-type' option.

Drop the end-of-line period.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

It's not clear why this change is done separately from patch 3/5
(cat-file: teach cat-file a '--allow-unknown-type' option). Given how
small this patch is and considering how closely related it is to the
actual introduction of the --allow-unknown-type option, it might make
sense to fold it into 3/5.

> ---
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index f6a16f4..f6f6064 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -9,7 +9,7 @@ git-cat-file - Provide content or type and size information for repository objec
>  SYNOPSIS
>  --------
>  [verse]
> -'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
> +'git cat-file' (-t [--allow-unkown-type]| -s [--allow-unkown-type]| -e | -p | <type> | --textconv ) <object>
>  'git cat-file' (--batch | --batch-check) < <list-of-objects>
>
>  DESCRIPTION
> @@ -69,6 +69,9 @@ OPTIONS
>         not be combined with any other options or arguments.  See the
>         section `BATCH OUTPUT` below for details.
>
> +--allow-unkown-type::
> +       Allow -s or -t to query broken/corrupt objects of unknown type.
> +
>  OUTPUT
>  ------
>  If '-t' is specified, one of the <type>.
> --
> 2.4.0.rc1.250.g565e85b

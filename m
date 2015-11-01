From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7] checkout: add --progress option
Date: Sun, 1 Nov 2015 16:15:13 -0500
Message-ID: <CAPig+cQZN_1f1wDwm7esHBhhrnQSx0eMye38Wc2ZxOjWoqjJvA@mail.gmail.com>
References: <1446412364-19377-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 22:15:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZszyB-0007Rr-FK
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 22:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbbKAVPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 16:15:14 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32835 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbbKAVPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 16:15:14 -0500
Received: by vkgy127 with SMTP id y127so75384032vkg.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 13:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1jlW2B1l/GZ8JIEqyaweIYYSaYKCRGZwpOsHQsH0wFM=;
        b=lyiYaxfGfYMnJR4/dx7E4ymB6ALqRkbOpMnK3IpmsUyGYGAoaEvEfkVmuxITvYn/LA
         Lpja0TOb82izoiN8K03RjcUorP8MGIgCAMOy1B9y04Kgd+q8HLc8ycgQlXISKuE+VmK6
         B1EaHoCTPOyW821FqzKqmxtBarl0mBYw8AsKSrRlnOxaaLeToSY8viEa50Qi6Lffak5+
         NshQ79GO61C6fgAlgYcIYd9Q+ZUdyRXIAbdyardWFjv6z2DLhMWzgJJBl6gDoudTOTsi
         YuzgPevGuVn8P806FPSswlSFn46j8vqC99oY2RoRypjzk78MaLSQcfx52Nkq7LzupRcE
         waJg==
X-Received: by 10.31.56.15 with SMTP id f15mr12967344vka.84.1446412513248;
 Sun, 01 Nov 2015 13:15:13 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 13:15:13 -0800 (PST)
In-Reply-To: <1446412364-19377-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: ytSz4LDvosLZGwsA68JEEEhdomY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280672>

On Sun, Nov 1, 2015 at 4:12 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Under normal circumstances, and like other git commands,
> git checkout will write progress info to stderr if
> attached to a terminal. This option allows progress
> to be forced even if not using a terminal. Also,
> progress can be skipped if using option --no-progress.
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> @@ -107,6 +107,12 @@ OPTIONS
>  --quiet::
>         Quiet, suppress feedback messages.
>
> +--[no-]progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal, unless `--quiet`
> +       is specified. This flag enables progress reporting even if not
> +       attached to a terminal, regardless of `--quite`.

s/quite/quiet/

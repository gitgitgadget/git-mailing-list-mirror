From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Documentation/init-db.txt: minor style and synopsys fixes
Date: Wed, 14 Jan 2015 15:47:42 -0500
Message-ID: <CAPig+cSgXQrsmi7D7crxHuRvDgu_1Oq32dtNsvqX+o1+-A7eYA@mail.gmail.com>
References: <1421256839-28660-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:47:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBUqy-0001cV-20
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 21:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbbANUro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 15:47:44 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:52759 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbbANUrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 15:47:43 -0500
Received: by mail-yk0-f170.google.com with SMTP id 200so5183017ykr.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 12:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0AOxsLrKjbPlM3SrdHOTRCs3NEo0OM7P3DlI8xKvogQ=;
        b=YSwluy2eEJM2k3DzzaqQta7wsEzogt33669xuxbRQEtRHpFxe/T5b+UFefWLfUecrU
         qY4S154HhPBMC2gqvfn2338W5h7JDDI5aFo+pCAwXUq62QzAkTtsDnAdJdjYltNjO2CU
         Ppyu46QFccDfJmTujFi8a4Dd3tstqVg/FtJhwo0uapdh1skmmkhkDzOjMbkJXBcOt2kM
         ZuQq00JGX9Yi2ot3gpj4l+VjZuOMioskJo14HjHHKS15RvgcariARtIWDY55kwBPhchp
         asS8brZT8pg4wCI54tH4LCYSBj9GG+H70kBzJRX7DdstGzW0ky66g5d62Bd4S6gtCftU
         MySQ==
X-Received: by 10.170.83.4 with SMTP id z4mr3808385ykz.103.1421268462568; Wed,
 14 Jan 2015 12:47:42 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 14 Jan 2015 12:47:42 -0800 (PST)
In-Reply-To: <1421256839-28660-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: tHe2LDa7D1-4mQOvAyZJgA2VrB8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262422>

On Wed, Jan 14, 2015 at 12:33 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> This patch constists of two minor changes:
>
> * line-wrap 'git init-db' synopsis
>
> * last possible argument '[directory]' was missed
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
> index 648a6cd..1d94fe8 100644
> --- a/Documentation/git-init-db.txt
> +++ b/Documentation/git-init-db.txt
> @@ -9,8 +9,9 @@ git-init-db - Creates an empty Git repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
> -
> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
> +                         [--separate-git-dir <git dir>]
> +                         [--shared[=<permissions>]] [directory]

I realize that you copied/pasted the text from git-init.txt, but this
should really be [<directory>].

While you're at it, you could fix it in git-init.txt, as well, and
adjust the formatting of...

    If you provide a 'directory', ...

to say:

    If you provide <directory>, ...

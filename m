From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4] Documentation/git-update-index: add missing opts to synopsis
Date: Wed, 9 Dec 2015 06:39:04 +0100
Message-ID: <CAP8UFD1cJdoaT=gPqqDshB9g0e_ZUGJqy21UzUTBPmPB6EkmnQ@mail.gmail.com>
References: <1448443802-24507-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 06:39:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6XTQ-0002eB-Lw
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 06:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbbLIFj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 00:39:28 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36574 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbbLIFjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 00:39:06 -0500
Received: by lfs39 with SMTP id 39so26958392lfs.3
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 21:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mEt9ouRQirGMImIX9AykxGo/sArt7IHMv8lG5LY4rtU=;
        b=D7x7q1KmU1xA/v7GJcZS17HCBydftNEOKvoV/HOjdl1jNiTmjh/7+VjSx5qyRsdMOa
         kB7+PYQ7wscjlIjyF3IbNW+k/ybJELDDrO7oYhb/PYzNbaRnDuj5ZSZWwLyJdZNHmV7B
         LeYOQRivCSumo2DJtm8/jZQQYkOyHAiV0oI/A6LSxU93Pk/6S3/mTgzSwdwObKerwUmb
         Zvsta4+UqtECpBorBk8/JLIFgSa8DOu7RmAXKOsAF+BUPfcd6Jhp89Wh8Cr0hQX4QsLd
         rZpvvy1drs7IAa7WoDGtg5KvjkAN8/WoixPzxMVLIMvo6FYYSM6fBaE5cUwDDobJTwdQ
         1jaA==
X-Received: by 10.25.18.93 with SMTP id h90mr1364291lfi.7.1449639544397; Tue,
 08 Dec 2015 21:39:04 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Tue, 8 Dec 2015 21:39:04 -0800 (PST)
In-Reply-To: <1448443802-24507-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282185>

On Wed, Nov 25, 2015 at 10:30 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Split index related options should appear in the 'SYNOPSIS'
> section.
>
> These options are already documented in the 'OPTIONS' section.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> This v4 contains only the split-index options and applies on top
> of the new master that already contains the untracked-cache options.

It looks like this patch has not been applied.
Maybe I should have given it a different title to avoid confusion with
a previous patch that added [--[no-|force-]untracked-cache] in the
SYNOPSIS.

>  Documentation/git-update-index.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 3df9c26..f4e5a85 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>              [--[no-]assume-unchanged]
>              [--[no-]skip-worktree]
>              [--ignore-submodules]
> +            [--[no-]split-index]
>              [--[no-|force-]untracked-cache]
>              [--really-refresh] [--unresolve] [--again | -g]
>              [--info-only] [--index-info]
> --
> 2.6.3.380.g494b52d
>

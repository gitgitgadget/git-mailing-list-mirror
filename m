From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Documentation/git-update-index: add missing opts to synopsys
Date: Wed, 25 Nov 2015 02:53:34 -0500
Message-ID: <CAPig+cSMTx=jA7ag5Qz605hinL55JkuJEPxbTgfEC01qVbWvrA@mail.gmail.com>
References: <1448434392-21983-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 08:53:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1UtW-0002JJ-2I
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 08:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbbKYHxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 02:53:36 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36037 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbbKYHxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 02:53:35 -0500
Received: by vkay187 with SMTP id y187so29341191vka.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 23:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rDgmIeSLp9FHA1czQJzFhoOQve2FjetP7G42v71Ydqg=;
        b=ZxPY/UJQWjwb6xlfJKU0qciEs10fT9uCnp2Lqdfn8XTM7av5BSZbPqB+pEHGRP6IVd
         A8/HHpNDmvaIT3lUJtWRmUjHHr5SUc2kMltWpnNqu1WRWUWDhWupJ0zkGNYMGfM0y6/F
         elbM2CS1XIfW2b/hMslym3pvOYIKdoiKLHwU+llKFaneT6TUODeJVHDZaPqdktpltgzD
         GY4pEhmfWAKrgRyBnlfma4Hu+vUGKeFtu+JVuza6LfwrGzrfMA/vc05bX68Dn+SFo3Dm
         orVGwRKNZwSzdHL1mmA3wyKIH/FxRQmYt05Ylq+YHAlg1A7ZHwQ6OZPgRG90kM/IEkK5
         julQ==
X-Received: by 10.31.169.21 with SMTP id s21mr31526641vke.62.1448438014477;
 Tue, 24 Nov 2015 23:53:34 -0800 (PST)
Received: by 10.31.95.143 with HTTP; Tue, 24 Nov 2015 23:53:34 -0800 (PST)
In-Reply-To: <1448434392-21983-1-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: k9dQBsqEUWO_1pky4xCwD-BxBGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281684>

On Wed, Nov 25, 2015 at 1:53 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Documentation/git-update-index: add missing opts to synopsys

s/synopsys/synopsis/

> Untracked cache and split index related options should appear
> in the 'SYNOPSIS' section.
>
> These options are already documented in the 'OPTIONS' section.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> @@ -17,6 +17,8 @@ SYNOPSIS
>              [--[no-]assume-unchanged]
>              [--[no-]skip-worktree]
>              [--ignore-submodules]
> +            [--[no-]split-index]
> +            [--[no-|force-]untracked-cache]
>              [--really-refresh] [--unresolve] [--again | -g]
>              [--info-only] [--index-info]
>              [-z] [--stdin] [--index-version <n>]
> --
> 2.6.3.380.g494b52d

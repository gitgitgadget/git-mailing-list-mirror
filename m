From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3 v2] Documentation/git-add.txt: describe --exclude option
Date: Sun, 15 Mar 2015 20:36:53 -0400
Message-ID: <CAPig+cT0SS2hJ+9vNk6B0NfsFKSDa4FK-B0hYBYpGSBk1FfFKA@mail.gmail.com>
References: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
	<1426446416-5753-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 01:36:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXJ1f-0002Vn-4e
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 01:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbbCPAgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 20:36:55 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:34241 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbCPAgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 20:36:54 -0400
Received: by yhch68 with SMTP id h68so12391073yhc.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dnKxGqCL+By2Ic+Sqzdlv8uAwfIiawWsOFky4kPhdGA=;
        b=k5Mo5wXr64zAJV/ig34lPMZXEpoFr9AWXDhNnNm1DQr4Dvvvdrzq7XVc6FxDqMF4pp
         CRZ1VYcdPCtsm1tZ5D7CTAmUV1YABawonlLbocQy6h/SbTbSUb0NE20ER9zLCfkhZwZ1
         POgzFuiYRU2ZhPOaystaj3/ReSSvfpoBKDPIgCc0Vf3kbicll7ZSfi5ywLkZ6t2vBB8X
         5zzaZ1ob0wSpNFdF8ljPF+4JuP2sXupVd+ZIWmf+fisQV6Z0Y65VXcIlhGaP53WkgGlS
         DiqtDMMVhX54jwS84+1fDrOAC6/WUeFelmLizLZwkGX0od1DxSp/Dmw9O8SrzptfvJwk
         W4BQ==
X-Received: by 10.170.194.7 with SMTP id l7mr32534874yke.91.1426466213654;
 Sun, 15 Mar 2015 17:36:53 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 15 Mar 2015 17:36:53 -0700 (PDT)
In-Reply-To: <1426446416-5753-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: LKsRaKfZ_RRhLstTlNTGI33A8nc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265538>

On Sun, Mar 15, 2015 at 3:06 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index f2eb907..fee97ed 100644
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
> +       Also ignore files matching <pattern>, a .gitignore-like
> +       pattern. Option can be used multiply times.

s/multiply/multiple/

> +
>  \--::
>         This option can be used to separate command-line options from
>         the list of files, (useful when filenames might be mistaken
> --
> 2.3.3.472.g20ceeac.dirty

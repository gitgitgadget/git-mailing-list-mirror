From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/2] add: add --ignore-submodules[=<when>] parameter
Date: Wed, 23 Apr 2014 16:25:05 -0400
Message-ID: <CAPig+cTyANC34jbeH1EzaWsJMnVemjSGEDB8b2s9VuRqAYwMng@mail.gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
	<5335A78C.60401@web.de>
	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>
	<53374E49.9000702@gmail.com>
	<533874F9.3090802@web.de>
	<5338AC36.6000109@gmail.com>
	<5338B1B0.3050703@gmail.com>
	<5339BAE4.8020306@web.de>
	<CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com>
	<5339F122.60801@gmail.com>
	<5339FBB4.1010101@gmail.com>
	<533B2036.3050506@web.de>
	<533B36AA.3090600@gmail.com>
	<533C5CBD.4050601@web.de>
	<533C6B57.3080901@gmail.com>
	<534180BC.308@web.de>
	<53431CB8.2050600@gmail.com>
	<53432EA5.5060102@gmail.com>
	<53444368.9050607@web.de>
	<5349BC2C.9030509@gmail.com>
	<5349C314.50500@gmail.com>
	<53511617.80506@web.de>
	<535596D1.6070709@gmail.com>
	<5356BF7C.1010200@web.de>
	<5356DB37.8020209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:25:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3jJ-0002X4-E1
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbaDWUZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:25:08 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:40878 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbaDWUZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:25:06 -0400
Received: by mail-yk0-f172.google.com with SMTP id q9so524208ykb.31
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 13:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1jmKODSuuMUYGbzcIdog9tbY3iquVL0WJ6W8/XYnxLo=;
        b=QQ/6nuect33z1xcbyx8EzH7L6wEMuJO3XIsvDpjQdWMO8T8pLSSl6+Q47bhpleDvsH
         PoABMZzAoIjroUgvRoEg4eJy9AsF5zg4WGRoUCvUVePTJ1PzAkbKVev/dw4ilTYxrI4F
         Q+KUmn6XdaIkUkv2wOb2J95oVA4YwY/LB4Mj+xrJy3fENHOhqlhWMyQ4gxCvJDqJsnEO
         jTlLhTDhZF227DZez3lH2ovTxvK52rVDpVGuBn4TAz0P21PBo8eqsxLeUI/+siqceaWj
         qG2ul1JKj/TdhycFIdQFKBMhYjsc9vShrRvJg+7McxWxhC91nzyvdp810v7yUCR/P0hy
         WJNA==
X-Received: by 10.236.167.167 with SMTP id i27mr22863429yhl.95.1398284706041;
 Wed, 23 Apr 2014 13:25:06 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Wed, 23 Apr 2014 13:25:05 -0700 (PDT)
In-Reply-To: <5356DB37.8020209@gmail.com>
X-Google-Sender-Auth: mojKGxG5VNC87LuhzcZ1Hp9Tfcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246888>

On Tue, Apr 22, 2014 at 5:12 PM, Ronald Weiss <weiss.ronald@gmail.com> wrote:
> Allow ignoring submodules (or not) by command line switch, like diff
> and status do.
>
> This commit is also a prerequisite for the next one in series, which
> adds the --ignore-submodules switch to git commit. That's why a new
> argument is added to public function add_files_to_cache(), and it's

s/it's/its/

> call sites are updated to pass NULL.
>
> Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
> ---
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 9631526..b2c936f 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
>           [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
>           [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
> -         [--] [<pathspec>...]
> +         [--ignore-submodules[=<when>]] [--] [<pathspec>...]
>
>  DESCRIPTION
>  -----------
> @@ -164,6 +164,11 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>         be ignored, no matter if they are already present in the work
>         tree or not.
>
> +--ignore-submodules[=<when>]::
> +       Can be used to override any settings of the 'submodule.*.ignore'
> +       option in linkgit:git-config[1] or linkgit:gitmodules[5].
> +       <when> can be either "none" or "all", which is the default.

The "which is the default" clause reads ambiguously. It's not clear
whether you mean "none" is the default or "all" is the default.

>  \--::
>         This option can be used to separate command-line options from
>         the list of files, (useful when filenames might be mistaken
> diff --git a/t/t3704-add-ignore-submodules.sh b/t/t3704-add-ignore-submodules.sh
> new file mode 100755
> index 0000000..db58f0c
> --- /dev/null
> +++ b/t/t3704-add-ignore-submodules.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Ronald Weiss
> +#
> +
> +test_description='Test of git add with ignoring submodules'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'create dirty submodule' '
> +       test_create_repo sm && (

It's conventional for the opening '(' to be placed on a line by itself.

> +               cd sm &&
> +               >foo &&
> +               git add foo &&
> +               git commit -m "Add foo"
> +       ) &&
> +       git submodule add ./sm &&
> +       git commit -m "Add sm" && (
> +               cd sm &&
> +               echo bar >> foo &&

s/>> />>/

> +               git add foo &&
> +               git commit -m "Update foo"
> +       )
> +'
> +
> +test_expect_success 'add --ignore-submodules ignores submodule' '
> +       git reset &&
> +       git add -u --ignore-submodules &&
> +       git diff --cached --exit-code --ignore-submodules=none
> +'
> +
> +test_expect_success 'add --ignore-submodules=all ignores submodule' '
> +       git reset &&
> +       git add -u --ignore-submodules=all &&
> +       git diff --cached --exit-code --ignore-submodules=none
> +'
> +
> +test_expect_success 'add --ignore-submodules=none overrides ignore=all from config' '
> +       git reset &&
> +       git config submodule.sm.ignore all &&
> +       git add -u --ignore-submodules=none &&
> +       test_must_fail git diff --cached --exit-code --ignore-submodules=none
> +'
> +
> +test_done
> --
> 1.9.1.3.g7790cde.dirty

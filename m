From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 71/71] Change 'usually' to 'by default'
Date: Mon, 24 Nov 2014 20:11:32 -0500
Message-ID: <CAPig+cQk-9VPAPxCUD+zz5AzNw=UfpgWGY3s6=32yKWXRMb3JQ@mail.gmail.com>
References: <1416863224-68392-1-git-send-email-richard.littauer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Richard Littauer <richard.littauer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 02:11:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt4fK-0002C7-9W
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 02:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbaKYBLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 20:11:34 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:62045 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaKYBLd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 20:11:33 -0500
Received: by mail-yh0-f41.google.com with SMTP id a41so4896539yho.28
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 17:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0iA7DqoyRH36n7im+o8xpwr1pZONOJ0UVqiWM3lF87E=;
        b=I/sVRpGGGgwgA5XaAnIdg0LOGAPc2i3yJI2tlSb4rMipeaRfHYMHCP4At+TgaRK1ti
         9KRH69lTs+3mM/f3JnMSo7PhwihXnJI+DNWAfblgdyeTRXXFQiazFGgfLD5HOEipRDbx
         LfnunjbUBZ/ybJn+R6n31T9fhS6grGDKHv5dwEVDbKfEnp8MF+kG6WTiQ6MT593iAYli
         KoLrKjKv6UkLHa5OLxBGCg9zYsYX4jjal4EodECC7qEnxZb7xeg9zE6fdoQiKjwVe4m4
         u5TqlC/CoNWQQ4Fv5oHS9FrgObZrrLBh0vBISI3cx2/mnI9NkpzarCzfPY1DY9h2FDyU
         3R0g==
X-Received: by 10.170.134.72 with SMTP id a69mr23592177ykc.103.1416877892519;
 Mon, 24 Nov 2014 17:11:32 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Mon, 24 Nov 2014 17:11:32 -0800 (PST)
In-Reply-To: <1416863224-68392-1-git-send-email-richard.littauer@gmail.com>
X-Google-Sender-Auth: OKEoSr9DkKF3xnuHOtRMPj6iqQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260177>

On Mon, Nov 24, 2014 at 4:07 PM, Richard Littauer
<richard.littauer@gmail.com> wrote:
> I've been confused several times by the docs when running across
> the word 'usually'. It is difficult to know before hand if it
> means 'under normal conditions' or 'by default'. I've gone through
> the Documentation to identify specific cases where I think that 'by
> default' is more explanatory than 'usually'. I know that patches
> that touch too much code is unwelcome - as this is a small fix to
> very specific lines, I think this might be OK.
>
> For the majority of cases, usually works fine. However, especially
> for the docs concerning flags, it is good to know if 'usually' was
> just used by the documenter to mean 'unless your version has been
> exntensively modified' or if it mean "unless you've messed up."
> Hopefully, this isn't too pedantic.
>
> Signed-off-by: Richard Littauer <richard.littauer@gmail.com>
> ---
> diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
> index 154081f..c97e62a 100644
> --- a/Documentation/git-pack-refs.txt
> +++ b/Documentation/git-pack-refs.txt
> @@ -56,7 +56,7 @@ a repository with many branches of historical interests.
>
>  --no-prune::
>
> -The command usually removes loose refs under `$GIT_DIR/refs`
> +The command be default removes loose refs under `$GIT_DIR/refs`

s/be/by/

>  hierarchy after packing them.  This option tells it not to.
>
>
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index ebe7a6c..dc07b64 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -222,7 +222,7 @@ The values of these variables are paths on the filesystem.
>
>  $GIT::
>         Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
> -       in turn is by default set to `$(bindir)/git`.  If you use Git installed
> +       in turn is defaulted to `$(bindir)/git`.  If you use Git installed

This would read better as:

    in turn defaults to ...

>         from a binary package, you should usually set this to "/usr/bin/git".
>         This can just be "git" if your web server has a sensible PATH; from
>         security point of view it is better to use absolute path to git binary.
> @@ -633,10 +633,10 @@ override::
>         overridable, which means that it can be configured
>         (or enabled/disabled) on a per-repository basis.
>  +
> -Usually given "<feature>" is configurable via the `gitweb.<feature>`
> +Usually the given "<feature>" is configurable via the `gitweb.<feature>`
>  config variable in the per-repository Git configuration file.
>  +
> -*Note* that no feature is overridable by default.
> +*Note* that no feature is overridable usually.

This reads strangely and seems more ambiguous than the original text.

>  sub::
>         Internal detail of implementation.  What is important is that
> diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
> index 242a044..8c577ee 100644
> --- a/Documentation/technical/racy-git.txt
> +++ b/Documentation/technical/racy-git.txt
> @@ -38,10 +38,10 @@ files vs symbolic links) and executable bits (only for regular
>  files) from `st_mode` member, `st_mtime` and `st_ctime`
>  timestamps, `st_uid`, `st_gid`, `st_ino`, and `st_size` members.
>  With a `USE_STDEV` compile-time option, `st_dev` is also
> -compared, but this is not enabled by default because this member
> +compared, but this is not enabled usually because this member
>  is not stable on network filesystems.  With `USE_NSEC`
>  compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
> -members are also compared, but this is not enabled by default
> +members are also compared, but this is not enabled usually

These reverse changes from "by default" to "usually" seem to make the
text more ambiguous.

In fact, all the reverse changes from "by default" to "usually"
throughout this patch make the text less clear. Your commit message
does not explain this decision.

>  because in-core timestamps can have finer granularity than
>  on-disk timestamps, resulting in meaningless changes when an
>  inode is evicted from the inode cache.  See commit 8ce13b0> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index 408f285..23636b9 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -140,7 +140,7 @@ You can specify the following configuration variables when building GIT:
>     gitweb.cgi script.  [No default]
>   * GITWEB_HOME_LINK_STR
>     String of the home link on top of all pages, leading to $home_link
> -   (usually main gitweb page, which means projects list).  Used as first
> +   (by default main gitweb page, which means projects list).  Used as first

In an earlier change in this patch, you inserted the word "the" to
improve grammar. Such a change could be applied here:

   (by default, the main ...

>     part of gitweb view "breadcrumb trail": <home> / <project> / <view>.
>     [Default: projects]
>   * GITWEB_SITENAME

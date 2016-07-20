Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6607F2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 16:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbcGTQAR (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 12:00:17 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36294 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbcGTQAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 12:00:14 -0400
Received: by mail-yw0-f193.google.com with SMTP id u134so3594087ywg.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 09:00:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZtPjDbyB6Xs6EcxEOahCM2NWyKhKuFfnDeB6tDzMZwo=;
        b=hYUK/MAPjoY/x51/bLSUfldfJDcVPsOTUiszWvQ2Tuo7v6f27ZJF5dLBOEmQm4dRUX
         9HqozSBn8YQH9zLb9rEAd+XC3dQD5SXR7Qqmjh6Yn31S8jluD4rhHxEYzgZ4hzR6LUYd
         EVnjsHpYYHI54yC3TlEQYhJaNFvySfzF3pDum+qgVz/8LiPEiYU41/tQxoSrpF5NoOsv
         9cZskPlV/jzTFDEQLUpzpibYVymTS+tjDC4ocyme8WkbwQNhL5b4t4cITfPq7Sv8Mmxa
         432L2JcTLVEkQZo0UvSFnCnCrn+mGyhU9eFmar1WLFFBLWGMeRWNIpq0qkGub2TtI5KQ
         W5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZtPjDbyB6Xs6EcxEOahCM2NWyKhKuFfnDeB6tDzMZwo=;
        b=bdOfUJeiRJ15hPlLKpi60+o/JpsEeVQFlBQcqf/BluF3O7mUOSsHwS08AbcdF3pciz
         zms2Nuz/xu6O6WW5KHtugnar/7wyIT740m2dfjZ9TCpJew+y/0VkdJ0uw1e72cWiJf33
         nKFVRUXcn/GShVX2MvyP+zsqk0VFSNFcvzYQmlNM9bL7kHQIjdyyAYK7MFyDzV0Auaux
         G/jtntePDhNdJlFUqr5itVhhXthFwt4nyjEDs+3vifQmk0gzqu4H3uVDbrIlK25qtsmP
         cUb5o24TI0fvlBICw7cRsRUTX7c5PzPdAdqBsKqau3cnZ0M1L+Bae/Wd+okCmNid3Qtu
         z5ng==
X-Gm-Message-State: ALyK8tKl13wPutmO3EM1l2NMg56fcY016CFb30WXvIkHD0MkQMLgCWjpAqymheVuoEFjbOtnKpMYtv1esimD+g==
X-Received: by 10.37.44.204 with SMTP id s195mr21756903ybs.21.1469030413907;
 Wed, 20 Jul 2016 09:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 20 Jul 2016 09:00:13 -0700 (PDT)
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Wed, 20 Jul 2016 21:30:13 +0530
Message-ID: <CAFZEwPMLSW59qUjDXCe6BEz=_e7F79GbPNp0v7nDM2e3q_Kkug@mail.gmail.com>
Subject: Re: [PATCH 0/9] Resend of gitster/pb/bisect
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Pranit Bauva <pranit.bauva@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 4:05 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Hey Junio,
>
> A small mistake got unnoticed by me which Lars recently pointed out.
> The naming convention is "git_path_<name_of_file>" and underscore
> instead of spaces.
>
> Thanks!
>
> The interdiff is:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c2f3cee..88a1df8 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -7,7 +7,7 @@
>  #include "argv-array.h"
>  #include "run-command.h"
>
> -static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
> +static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
>  static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
>  static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
> @@ -100,7 +100,7 @@ static int write_terms(const char *bad, const char *good)
>         if (check_term_format(bad, "bad") || check_term_format(good, "good"))
>                 return -1;
>
> -       fp = fopen(git_path_bisect_write_terms(), "w");
> +       fp = fopen(git_path_bisect_terms(), "w");
>         if (!fp)
>                 return error_errno(_("could not open the file BISECT_TERMS"));
>
> @@ -134,7 +134,7 @@ static int bisect_clean_state(void)
>         remove_path(git_path_bisect_log());
>         remove_path(git_path_bisect_names());
>         remove_path(git_path_bisect_run());
> -       remove_path(git_path_bisect_write_terms());
> +       remove_path(git_path_bisect_terms());
>         /* Cleanup head-name if it got left by an old version of git-bisect */
>         remove_path(git_path_head_name());
>         /*
>
>
> Pranit Bauva (9):
>   bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>   bisect: rewrite `check_term_format` shell function in C
>   bisect--helper: `write_terms` shell function in C
>   bisect--helper: `bisect_clean_state` shell function in C
>   t6030: explicitly test for bisection cleanup
>   wrapper: move is_empty_file() and rename it as
>     is_empty_or_missing_file()
>   bisect--helper: `bisect_reset` shell function in C
>   bisect--helper: `is_expected_rev` & `check_expected_revs` shell
>     function in C
>   bisect--helper: `bisect_write` shell function in C
>
>  builtin/am.c                |  20 +--
>  builtin/bisect--helper.c    | 310 +++++++++++++++++++++++++++++++++++++++++++-
>  cache.h                     |   3 +
>  git-bisect.sh               | 146 +++------------------
>  t/t6030-bisect-porcelain.sh |  17 +++
>  wrapper.c                   |  13 ++
>  6 files changed, 355 insertions(+), 154 deletions(-)

Could someone please look into this series and review so that Junio
can merge this into next which is a vital part of my GSoC project?

Regards,
Pranit Bauva

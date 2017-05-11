Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090E22018D
	for <e@80x24.org>; Thu, 11 May 2017 17:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757594AbdEKRVX (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:21:23 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35334 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbdEKRVV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:21:21 -0400
Received: by mail-pg0-f43.google.com with SMTP id f131so3053803pgc.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C9Ixxj/6ZJFRabPxDDsexbVcxpYANApL9YXZUsFZjxg=;
        b=m4N8EGBu6rRPO2ArTQjyDkYGsRCoMK7aH31hh9/XLBaf2zs5oAOYAal+3o7OaBCeu+
         4SxdsFC3rwFUQLc5ktzmokvbUXHi7R9ALj+Ud8w1iCitZCkpw+9SSPa3Qrj2VqjnpiFx
         hz2yBplS72WGbFLrYkaVQMGLEpAVB4/R0szzNOYySQaa0WZxZMtjwE252+EW5umHeWKA
         TGLDWVZidG2Bfdrdwy118RE4SO7PqcI06NWLLSecoULS9FJzbnUlFIGJadUau2aFTFXK
         j7qQnZ6YgZLZ6kwYwStt2cdeQoLgBxmaI6OT8zHW3T5IWH6Pf2jljH6rShOpEDUHfBCi
         5WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C9Ixxj/6ZJFRabPxDDsexbVcxpYANApL9YXZUsFZjxg=;
        b=LMKNQ9nxcCPI4TDoAhdaOdo8XzUP5yaJxGXT8QLcPRN+iV8LYWNE9zBWOtldzq8otQ
         5W9n0klK9djCdnZ//VD5bfzK6KRGCpi5LhpzhyomIpmq5brc1rlUKtpQywuJDTz0RzVC
         6fsUJ02B7+qB18ssQIbju5Ti+Xz4BrlmxpbV6nfO1arXLUkSqx0LHy3FvhekcYGJvVRa
         qxGgCCp2t7EIU7tBCBe53teLPLi4b+2J8VW4IjaqVoBI70kNrWr7X2bv1cSRp2AvumTV
         eqIh6EDOWNqOOPHfJdp3Sa6iTr3VoaxHKmfc4S6upbopeR2OFhCy81WXtUZB9wNgPINx
         rLww==
X-Gm-Message-State: AODbwcC/iFACGdY19H/DdiqHPijLQAT+YoP05snt57MIVDjjTyT2rYGh
        YH9hhjs9Kk0GrD01fd+GxkVJakOeQcGCfUm0PQ==
X-Received: by 10.84.231.136 with SMTP id g8mr307048plk.12.1494523280998; Thu,
 11 May 2017 10:21:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 11 May 2017 10:21:20 -0700 (PDT)
In-Reply-To: <b26882e61ef466c787b575d3fd60bfeec8a9281a.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <b26882e61ef466c787b575d3fd60bfeec8a9281a.1494509599.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 May 2017 10:21:20 -0700
Message-ID: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] git-parse-remote: fix highly misleading man page
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 6:47 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The man page still talked about the .git/remotes/ directory (which is no
> longer in use, as of 75c384efb52 (Do not create $GIT_DIR/remotes/
> directory anymore., 2006-12-19)).
>
> Let's just revamp it almost completely to reflect the *purpose* of that
> scriptlet, as opposed to its implementation details.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-parse-remote.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
> index a45ea1ece81..7f865f33898 100644
> --- a/Documentation/git-parse-remote.txt
> +++ b/Documentation/git-parse-remote.txt
> @@ -3,7 +3,7 @@ git-parse-remote(1)
>
>  NAME
>  ----
> -git-parse-remote - Routines to help parsing remote repository access parameters
> +git-parse-remote - Routines to help parsing remote repository information

Today I learned about git-parse-remote. Upon further inspection it is
just a lib,
not anything useful for a user. (The man page with or without this patch
is not very helpful to me)

Only git-rebase as well as git-submodule include this lib, the submodules
only need get_default_remote (4 lines of sh), which is also available
in the submodule--helper, we'd just have to expose it and make it accessible.

I wonder if we'd want to retire this script in the long run.

I also wonder if rewriting the man page is good use of (your) time, as the
last contribution specifically to Documentation/git-parse-remote.txt
is 62d955fd43 (parse-remote: remove unused functions, 2009-06-12),
which has been a while since.

The outline in the coverletter promised more than just rewording, but
I am fine with the change as is; it's a good start.

Thanks,
Stefan

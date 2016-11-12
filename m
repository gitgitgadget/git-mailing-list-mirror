Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376E42079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965636AbcKLCCH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:02:07 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:37721 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965572AbcKLCCG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:02:06 -0500
Received: by mail-it0-f52.google.com with SMTP id u205so12524609itc.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f/ern9ztjZoYV6SBp72r40HbHVZ0/ENSTl6OWr8L0TI=;
        b=ravLceFW3Pn1xn2yp/gg8652yvtI5Ozbom0CVRNpjCfbbOp2kQjzcZDyo4Ti52diHV
         V7PFPFjeij6YwSm/pydL/E3Z9rdblmmiYMYQ9KUsxBW89o54URfYTxsy0UoHcKH7n+m7
         ohcFPu5NYVi2eASuFed2JdwCLmP8EtY6+Uj18jKWwNhYQ2fNVFPUDBlmQsqXFGN/3HJm
         5cTPSVNCpCjS/DZKNgZMp8QpaWSgmhWfY769njkUDfRCZbyortJyYleViQVcoeeXwv1n
         vIb3V1FvWDg160aH32DtF+ywOsYN2T1rerDkMiL5CeRN9yAgc2RGNJy5H/ZEKd3pejG9
         DMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f/ern9ztjZoYV6SBp72r40HbHVZ0/ENSTl6OWr8L0TI=;
        b=CK5Fj2WIhyvgwYY9uLelfnLHmRrCbNbq7uNZYNwuVWzv98Afq/8+cT3Z41YBIqZr2E
         zM4HgmEdFCvOY8OC8WQv0sIgQ+CibPLQVCoexj6zk+F7DaRxa9Cu6cEEpWeP9fxy0zaf
         fNIg2yB1A+UJEWRNBeO5eUcs6i9ir+3luMKQZ5Qw3Lk0FQyvM4bSq8E/qzx9GZG6j2yf
         0JzqPpbdU3QRg8iBwFHZgEELTKnH2BILUbWlNROvJQFJHMHwoNccHFsqMSr14cRwlxnh
         GUlyfz/uH0evmwaYncyflBUcqGzSCXdByoorkfXXSbSPrkd5G8JmSMBHGOOHybTCqDpw
         gkWQ==
X-Gm-Message-State: ABUngvf1CUC8MYVPB1WYKNlC4/r4gR41Bfi9XMNnh1a3kfmm+qxD6eOtm41fOyEx1qBSNRU43+z23o/ksoMuOQ==
X-Received: by 10.36.22.212 with SMTP id a203mr535682ita.3.1478916125420; Fri,
 11 Nov 2016 18:02:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Fri, 11 Nov 2016 18:01:34 -0800 (PST)
In-Reply-To: <20161111112332.27727-1-ps@pks.im>
References: <20161111112332.27727-1-ps@pks.im>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 12 Nov 2016 09:01:34 +0700
Message-ID: <CACsJy8DeWR=80H9WEnBAEJhM2YrjgtvjVkop3Q8O2wH2HS9+BQ@mail.gmail.com>
Subject: Re: [PATCH] doc: fix location of 'info/' with $GIT_COMMON_DIR
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 6:23 PM, Patrick Steinhardt <ps@pks.im> wrote:
> With the introduction of the $GIT_COMMON_DIR variable, the
> repository layout manual was changed to reflect the location for
> many files in case the variable is set. While adding the new
> locations, one typo snuck in regarding the location of the
> 'info/' folder, which is falsely claimed to reside at
> "$GIT_COMMON_DIR/index".
>
> Fix the typo to point to "$GIT_COMMON_DIR/info/" instead.

Oops. Ack!

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/gitrepository-layout.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index 577ee84..a5f99cb 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -177,7 +177,7 @@ sharedindex.<SHA-1>::
>  info::
>         Additional information about the repository is recorded
>         in this directory. This directory is ignored if $GIT_COMMON_DIR
> -       is set and "$GIT_COMMON_DIR/index" will be used instead.
> +       is set and "$GIT_COMMON_DIR/info" will be used instead.
>
>  info/refs::
>         This file helps dumb transports discover what refs are
> --
> 2.10.2
>



-- 
Duy

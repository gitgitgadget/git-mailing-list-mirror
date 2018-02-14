Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4D21F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162555AbeBNTBl (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:41 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:46628 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162551AbeBNTBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:39 -0500
Received: by mail-yw0-f179.google.com with SMTP id w142so931925ywg.13
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c917FI8EYC7A97FvyMqozsLYKctA1knyRAcuAP3GtbE=;
        b=Cnq25kWVDNr/moBdwzgbGGqhRKk/lUvnLhxQ4S98SDIsL85D0ccGWxJtpgz5J7ZRVK
         y6CiKpbLUOEkhHTRqFWIi0v2f9xTmA3s68g6WjgTGy+7EZCSZg9rLPeVPcpTqXeM2Pkf
         vHkHtupEijAf1sIRbEr53rthzL3ZcjSmeAnlCH+DDi7PjN9gAKumuGMRXWz7/j0EsAPi
         CU1g40CHctjavMdOLa1cNeAzsSYyI2A6BVIH/fn/CrIvcZvF1mQf47JgrXi+bcLLoJc/
         VfCXCo04HYEDlud2LAvvEc4cCa3fNUNNNqWbdreA6zAYYvmonqSZ4pQPQF4xlP4+pWXJ
         NbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c917FI8EYC7A97FvyMqozsLYKctA1knyRAcuAP3GtbE=;
        b=MTZeY1dSHzOpfUMKpggpzQUwHGrSX3u3Ok6BdxvNZghfnLFhbrPYFDdBDJToLTXDmK
         NrSYRFpTTS+y4/t3WGTcK+xC9ESC5hI31T+fM1R1CDeq7B+yumA1V43vsWbXmmT/E8pd
         9ojJ39Purt0/3j1NvCeLwepOvJkl6suW4oFsC0op0LaAJAy1NJn8h2zW6PMlFvAHU9UY
         jGVK0p9lf1iD9CKj+XYWxJmaqAiqQgXDZfiFFE+ObjKcR9l7naw/0YZFHmBo1gigCToA
         eu1txaBiaCKXht+STknZHQhOiUBf4xkTIsULGdIjMvFyaunZbIBsBXbhHkShHWvLIkTp
         y7eg==
X-Gm-Message-State: APf1xPDbkah+H6KdNdlVn2dTtl+EQzgADLMy+hNk6sU9QJbAwOiIJKsq
        0XqxJ5PNCbKUArzbrxpzrrpwEtWDFyUTACf0E7zIdg==
X-Google-Smtp-Source: AH8x227wziIcdrC8sgZA+9JB/esEGkCtL5pLpmqqQvVjldzsm5KyxilyD0rCiZT6KHBqYmSgN/95mxNye3qbSEC3Q2s=
X-Received: by 10.37.12.130 with SMTP id 124mr194461ybm.39.1518634898395; Wed,
 14 Feb 2018 11:01:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 11:01:37
 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802140404440.25357@localhost.localdomain>
References: <alpine.LFD.2.21.1802140404440.25357@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 11:01:37 -0800
Message-ID: <CAGZ79kav5duDBgfMYSzUsHS0DUzdBFQHN=qgm=aDuOPxER0cuA@mail.gmail.com>
Subject: Re: [PATCH] t/: correct obvious typo "detahced"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 1:08 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

Thanks,
Stefan

>
> ---
>
> diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-detached-work-tree.sh
> index c20717181..fc018e363 100755
> --- a/t/t7409-submodule-detached-work-tree.sh
> +++ b/t/t7409-submodule-detached-work-tree.sh
> @@ -6,7 +6,7 @@
>  test_description='Test submodules on detached working tree
>
>  This test verifies that "git submodule" initialization, update and addition works
> -on detahced working trees
> +on detached working trees
>  '
>
>  TEST_NO_CREATE_REPO=1
>
> --
>
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         http://crashcourse.ca
>
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================

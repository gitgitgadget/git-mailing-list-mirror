Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542361F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeGQAj4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:39:56 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:54637 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbeGQAj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:39:56 -0400
Received: by mail-yw0-f202.google.com with SMTP id c67-v6so37368169ywc.21
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Nr4S/kNOYFpVJNQ8apcSRDvVtCbXq9Ha8c0vlb1b2ig=;
        b=d6HirzswlxOgNE0OqaX7uXN45sJD9qBOqMzoqecGqYAX0xkvkn3ExE3ja1uwbP4bG0
         S62+5uvwH6ohdN29zPZCd3/+UPi3/d7EiNl5JTESFYoyPLlqnBenoESnQiSQXarevgsg
         jUJF9HRwpAxf4ke8lxAaO/kUP1JQGDvii5D7yFASCMfFcQQBDYg4HnaztmUZT3zZJR5a
         9yt9REdtQ9saLo2izCHWYAuTJKk5/gDFsdEgoFUkjY12UnhmwvkmBlVoTJDsKhWypFUa
         zXr7RO0pF4JPn64tOF2rZYMHziRb+Mlx9SrFlZNWAMnLa5Mn8i0E8BYxLgss8nsJWA+Y
         T+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Nr4S/kNOYFpVJNQ8apcSRDvVtCbXq9Ha8c0vlb1b2ig=;
        b=n32cwiOWnq/CtA5/xsxS5+TvVDIcALXN+OMOhpiyjr922bedCfRUcj36hC+RQJGlKC
         hzwV+QU5NmyR/r1Jt6Bg+NF4c6a4UVJ5vOWz9LhFHmQJkdmLKLuTsz/w1HhdRgSnvVWD
         fE2y5F59esj7ZQlV32o9bykvamk+2ZCp1gA3aODegpiKc2fyC2lQxq9UMg5RzFDD4TYM
         YLYCKT3dy5B74rEcLA1rYhisqVDh1h6ov4d3Y697+PlOIhpt3xD0ktDDw3dvzcQEXLKs
         DP8AHzw+RCPCfRlhOCoI/J7Z8ZmDwOhqc8/59eusCZRMNHTB46lcXnHSWPp5Fz+2XpUO
         dFLw==
X-Gm-Message-State: AOUpUlF4UIErkZa1CT9a+ikgQmX9MO40goDrJloUKH1p0WcJbL8h0ihP
        Xt1VTgu01xer7DCAaLKs3Rj5vdNblNtcUIFBNQWp
X-Google-Smtp-Source: AAOMgpfI+Ym+5os36GuNaFNXKUHaCyWoKT5ispmaNQJv2upXXBw80eZXAcMx2IcJ/RgoQcLf6zNKfmuOktl+/s67Uhov
MIME-Version: 1.0
X-Received: by 2002:a81:a345:: with SMTP id a66-v6mr5837080ywh.114.1531786209066;
 Mon, 16 Jul 2018 17:10:09 -0700 (PDT)
Date:   Mon, 16 Jul 2018 17:10:06 -0700
In-Reply-To: <95b11ced4c0355aabf458539a284bb3895d73f6f.1531746012.git.gitgitgadget@gmail.com>
Message-Id: <20180717001006.8283-1-jonathantanmy@google.com>
References: <95b11ced4c0355aabf458539a284bb3895d73f6f.1531746012.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.18.0.13.g5a7731b13
Subject: Re: [PATCH 13/16] test-reach: test can_all_from_reach_with_flags
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subject should be can_all_from_reach_with_flag (without the "s" at
the end). Likewise in the commit message.

> To make this method testable, add a new can_all_from_reach method that
> does the initial setup and final tear-down. Call the method from
> 'test-tool reach'.

This description leads me to believe that can_all_from_reach() is (1)
trivial, and (2) will not be used in production code. But (1) the
function itself is non-trivial and the function signature contains a
"cutoff_by_min_date" parameter not found in
can_all_from_reach_with_flag():

> +int can_all_from_reach(struct commit_list *from, struct commit_list *to,
> +		       int cutoff_by_min_date)

and (2) this function will be used in production code subsequently in
the "commit-reach: use can_all_from_reach" commit. It would be clearer,
maybe, if there were some rearrangement - maybe a commit introducing
this function, especially documenting what cutoff_by_min_date does, and
then a test (which just tests can_all_from_reach), and then the
"commit-reach: use can_all_from_reach" commit.

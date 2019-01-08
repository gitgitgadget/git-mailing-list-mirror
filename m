Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2571F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfAHVUL (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:20:11 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35755 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbfAHVUL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:20:11 -0500
Received: by mail-pl1-f202.google.com with SMTP id a9so2881072pla.2
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6sir5K87oB1jyBYuEnKieGdhXJLCjlO/iSvicOn23AQ=;
        b=o3wDVMiF+cXsy/fg6HEsYeG2kt/21VRDxshDJe2F5sBOf/ZdxGw8Y8s9XQBLCCx7hu
         fmhIgvShWyTqu9zgcSwuGBTIlb8znBJs7jRBBo479idfVYrwqsU/uhYBhqwID05XH4xR
         5uCyBRTGxjmKVPSOIr8oBp+CPp330tnrByyVeTR6IB+/R657IXI7G9u8aXgbNAY+lPVh
         ZDTINFDuGQEsAztkpw+5gS9w7QYRbTThp5q3Phzu3bo/eU5d5eLtILp7XHB6YofVdE9d
         tO241S0SknWcCGhVHBcCb5aiZLaVfJcjNTeRnisI0GDfo5xkWe38/Rw2x3VAn/9Tk2bp
         cxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6sir5K87oB1jyBYuEnKieGdhXJLCjlO/iSvicOn23AQ=;
        b=U+gPfEi/GhIs28ly03mI69dvk5thGUhwxChFdPL4Cc48vYFOskOSwTridCKPhfXajH
         4CBfOUMFXktzYzfdRr35u/ZTMIeg97KeAH/7OC0HcMjuxEr/588zgOZKtv9Ry96WsIMq
         KeeDj/b3wNEGVlGKLde5V363Vu7TVdKcZgKnlJIGjkoHveaFJ+3cqgtC9+vPdvByUEmw
         ehryr8F2a93VpdmSQ2/FxIV9ImFSiR4htpLvzlitBa1YHJxvl+h219S1eFFCyy0iCnl1
         N7mAYBAb1kF0EA2XgiTv80vs8+lhCS1/MoPMWF33X2drZhn/SAkzKKvoGb9eSpX65++F
         dI5Q==
X-Gm-Message-State: AJcUukdiS2JUDBGyP6spqOTPYmuzTlz2RmX5fWSHEU7qnEZSuUiwQnFm
        vrkofz+rMmL7R8nZ1fXx3KwfoThBcF5dT45Uuw8L
X-Google-Smtp-Source: ALg8bN6XfaSMURJTWP77qjvBzhxBlvGs1LUUUkMTBz51hpYhlTmvrW0F8+RRb6ICIQnqOemjqobhlxrrOUfqA7HM/Zq4
X-Received: by 2002:a65:520d:: with SMTP id o13mr1598772pgp.7.1546982410441;
 Tue, 08 Jan 2019 13:20:10 -0800 (PST)
Date:   Tue,  8 Jan 2019 13:20:07 -0800
In-Reply-To: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190108212007.10855-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: sb/more-repo-in-api, was Re: What's cooking in git.git (Jan 2019,
 #01; Mon, 7)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/more-repo-in-api (2018-12-28) 23 commits
>  - t/helper/test-repository: celebrate independence from the_repository
>  - path.h: make REPO_GIT_PATH_FUNC repository agnostic
>  - commit: prepare free_commit_buffer and release_commit_memory for any repo
>  - commit-graph: convert remaining functions to handle any repo
>  - submodule: don't add submodule as odb for push
>  - submodule: use submodule repos for object lookup
>  - pretty: prepare format_commit_message to handle arbitrary repositories
>  - commit: prepare logmsg_reencode to handle arbitrary repositories
>  - commit: prepare repo_unuse_commit_buffer to handle any repo
>  - commit: prepare get_commit_buffer to handle any repo
>  - commit-reach: prepare in_merge_bases[_many] to handle any repo
>  - commit-reach: prepare get_merge_bases to handle any repo
>  - commit-reach.c: allow get_merge_bases_many_0 to handle any repo
>  - commit-reach.c: allow remove_redundant to handle any repo
>  - commit-reach.c: allow merge_bases_many to handle any repo
>  - commit-reach.c: allow paint_down_to_common to handle any repo
>  - commit: allow parse_commit* to handle any repo
>  - object: parse_object to honor its repository argument
>  - object-store: prepare has_{sha1, object}_file to handle any repo
>  - object-store: prepare read_object_file to deal with any repo
>  - object-store: allow read_object_file_extended to read from any repo
>  - packfile: allow has_packed_and_bad to handle arbitrary repositories
>  - sha1_file: allow read_object to read objects in arbitrary repositories
>  (this branch is used by jt/get-reference-with-commit-graph and md/list-objects-filter-by-depth.)
> 
>  The in-core repository instances are passed through more codepaths.

I think this is ready to be considered for merging to next. This series looks
good both to Stolee [1] and to me (I replied to a previous version with
comments on patch 18 [2] which Stefan has addressed, as can be seen in the
inter-diff provided by Junio [3] - I probably should have replied to the latest
version stating this too).

[1] https://public-inbox.org/git/b2ff842d-4d60-0db7-c11d-dcc006dade18@gmail.com/
[2] https://public-inbox.org/git/20181115221254.45373-1-jonathantanmy@google.com/
[3] https://public-inbox.org/git/xmqq36qho1gf.fsf@gitster-ct.c.googlers.com/

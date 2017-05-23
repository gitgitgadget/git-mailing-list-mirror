Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B6720281
	for <e@80x24.org>; Tue, 23 May 2017 12:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935900AbdEWMIC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 08:08:02 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34309 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935851AbdEWMIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 08:08:01 -0400
Received: by mail-vk0-f48.google.com with SMTP id y190so56735589vkc.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QaDUC534vd+c9bd4Jkpy1sNfdT0xatTwgoMtWEWMoYQ=;
        b=B2DCJYQHr25N4Pin1GXz9QBgvZhNNuCbTx0rGFGV0T3TLVUqwsMY0ysqOWgh75Zcxj
         XSGHadOKO7nQx/1gZWLDPP00L7HTU+2tGOn2TtyBT1sZRs6Uk+eDiE5aoSM0Q8dwjPzp
         hp0DcYRzzuTXSaYgAYoZKBsijkBcdIYGdMiaon8LRbKSUoXaogayGoVpAjCU+Ga9kW6w
         cdlv6JhufCUwi83F4dTCih4J5z7inBdTN5APxkyzQb+RjSnViYACR+wGxeWbO8//Vv7K
         Fvb2eOyUfXB1nKKoQmVub3dvffNVjHgz+ESxYwpLgkFIhk49lTnKPnLUFJdao2LY9HMq
         7HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QaDUC534vd+c9bd4Jkpy1sNfdT0xatTwgoMtWEWMoYQ=;
        b=mmDR7k4YfUaxa+IF4TwRfUjBRlmZ6N7zWA1dUBuSEuL6Q7mTG0i3ODmbZMDZ09enE2
         /tZqup4pCyRsB78PmaipT/VW6LIWpube8VM7COgPhMPISb3ewKX30LD9EOPEb1AU88mh
         f8Grcfh8j3oh3M/hxMohnGjNyv3IycH/Wpt/qfAemw1txSKOsrQlTR0bpiftYnjMgVpK
         bGLyLyv4asd4b0fUuj/YeVFj/qcJu9vL/jlj1QCgWjV7eYRFBbiirymLAoIScZ9xauoi
         unOgDh/NPUIL8GHyg6IdQkswfYPjXFDaQuzToigwFGWlCK8AQ8DRpgdR4BYj1v5w8rUF
         rBcg==
X-Gm-Message-State: AODbwcD7Tfz7pki0Ll/9j5yfGLiM/dooR046FQQtvSGZxSLDzuf3Rbf8
        Yb6oVMN1JuHiAdu3FHKCw+Xz9TGaHIT4
X-Received: by 10.31.52.17 with SMTP id b17mr1938179vka.150.1495541280403;
 Tue, 23 May 2017 05:08:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.71.74 with HTTP; Tue, 23 May 2017 05:07:40 -0700 (PDT)
From:   Stefan Monov <logixoul@gmail.com>
Date:   Tue, 23 May 2017 15:07:40 +0300
Message-ID: <CAJtFkWu25RkiKm0O__W2My+Adi9pxZ3YtjZW4eb+2U+wpNS3yA@mail.gmail.com>
Subject: =?UTF-8?Q?How_do_I_see_=E2=80=9Cmerge_events=E2=80=9D_in_history=3F?=
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I use the GitHub web interface and the git cli. Answers for either or
both are appreciated.

Sometimes, when I merge a branch into another branch, I see a commit
with a message like "Merge branch 'master' into other_branch" in the
GitHub history. But not always. So how do I see all "merge events",
inside the history?

Even better if I can get a view with vertical lines showing branches
and merges (like a graph).

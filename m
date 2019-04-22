Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F89C1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 17:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfDVRvN (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 13:51:13 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51143 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVRvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 13:51:13 -0400
Received: by mail-qk1-f202.google.com with SMTP id d8so10964111qkk.17
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=C54tyJ0yLeCTEuallw6Yx2o9o5s/mo0+4SoEOPV2E8Q=;
        b=IVjIwOA8eBGprLzbZOPYW3L19aFbf5EVlc9FUUQvmFJejcoQ6GA/ai94DUmZJNpaT0
         GUyrrkrR/k1J6ABjAf1CNQqpGFKwNftm5lkXd8fur8AB8ZHFSDiC5l46coC4Q2QvaMH2
         fNKo6tpsTNVFCbXIXzpMYQV506Obsmx1m5xY7hT8d58Wk6SvdcjHuZ5ysIgCncq4Jyut
         FS/b1tjIx/ovh8kaxM4uiu1TWLe30hny5AxH+t6d4Lz3g4n3XacELJ5sJpseJykaAHe8
         rX06HcPA6pMRcHtPcHG/dg4gJEv4Et6xApPUEv7ttt9I6FPmEr15xwGVUKDEU6uLvC2m
         BFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=C54tyJ0yLeCTEuallw6Yx2o9o5s/mo0+4SoEOPV2E8Q=;
        b=TG4EGnmcVnSY+CqjMShDhu6ENjQGwikgu/ElHa3QpAQ+vfBXD/DZmYWMYAvMn9Us0Q
         caOKO4o5GPyWBAGWENVRiqxwZE6iWctOMUCKurfv5oSDlm99akFyin+Hm2XCVe6k+Nj8
         QCTlFE1TdLBCICXTU9DVGhTCjVKT50FXnRW3HKHCCSqkyLt+K9vZlfzNUPylTUDrHEp1
         djj4jUdoFdr1l9PfoMS+2nKzAHkiRizMinGOOrnGkerfWx17zbuxywSq83KYCHtTKXFV
         rn/fiNB9WOPFyfquFPdCOtzjpUOPbT6hOua5ET1d5ttI4+fwpRqidOeVE38VKMrKvUzq
         0tEQ==
X-Gm-Message-State: APjAAAVIg73sZOezHbGa2+EIL0jAVhE7ARRVvkRVpDtWe62ylwgL1vTK
        52gDxje916FK9e7xVjGBRO6rprB5knh1R4gXnLe1
X-Google-Smtp-Source: APXvYqwkfr+Yl4Cn8ewSQ+ySrMtbuar9CRT4zC4f+Ivgg6RAjHep3GARFfLmy/5QIYIOVdkI6RqrECSscDWM6fa4BjkT
X-Received: by 2002:a0c:b0ea:: with SMTP id p39mr16898473qvc.242.1555955472062;
 Mon, 22 Apr 2019 10:51:12 -0700 (PDT)
Date:   Mon, 22 Apr 2019 10:51:04 -0700
In-Reply-To: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190422175104.15471-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: jt/fetch-cdn-offload (was What's cooking in git.git (Apr 2019, #04;
 Mon, 22))
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/fetch-cdn-offload (2019-03-12) 9 commits
>  - SQUASH???
>  - upload-pack: send part of packfile response as uri
>  - fetch-pack: support more than one pack lockfile
>  - upload-pack: refactor reading of pack-objects out
>  - Documentation: add Packfile URIs design doc
>  - Documentation: order protocol v2 sections
>  - http-fetch: support fetching packfiles by URL
>  - http: improve documentation of http_pack_request
>  - http: use --stdin when getting dumb HTTP pack
>=20
>  WIP for allowing a response to "git fetch" to instruct the bulk of
>  the pack contents to be instead taken from elsewhere (aka CDN).
>=20
>  Waiting for the final version.

Sorry for getting back to you late on this. The current status is that
v2 (this version) looks good to me, except that not many people seems to
be interested in this - I sent out v2 [1] with a relatively significant
protocol change to v1 (requiring the server to also send the packfile's
hash, meaning that a workflow that =C3=86var has described will no longer
work), but nobody replied to it except for Josh Steadmon (who did give
his Reviewed-By).

In the meantime, I have been working on a server-side JGit
implementation [2], but not all parts are done (and it will take some
time).

If this version is good with everyone, then this is the final version. I
know it has been some time, but if I squash "SQUASH???" onto
"upload-pack: refactor reading of pack-objects out" and then rebase onto
latest master (14c0f8d3ab ("The sixth batch", 2019-04-22)), there's only
one small merge conflict.

[1] https://public-inbox.org/git/cover.1552073690.git.jonathantanmy@google.=
com/
[2] https://git.eclipse.org/r/c/139993/2

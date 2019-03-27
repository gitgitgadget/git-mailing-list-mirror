Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C2020248
	for <e@80x24.org>; Wed, 27 Mar 2019 11:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfC0LaP (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 07:30:15 -0400
Received: from n1nlsmtp02.prod.ams1.secureserver.net ([188.121.43.194]:45372
        "EHLO n1nlsmtp02.shr.prod.ams1.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbfC0LaO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Mar 2019 07:30:14 -0400
Received: from n3plvcpnl110358.prod.ams3.secureserver.net ([160.153.140.31])
        by : HOSTING RELAY : with ESMTP
        id 96k3hSIpb1z7s96k3hq7gH; Wed, 27 Mar 2019 04:29:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m-mooga.com
        ; s=default; h=Content-transfer-encoding:Content-type:Mime-version:
        In-Reply-To:References:Message-ID:CC:To:From:Subject:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nD3Fpr8aB91HjqOoOeDDxyJ5UCGVXTz+oARmEtCacQA=; b=ENX+wFknGyuhVXlitGVFkEcVyz
        Cmk9chKthnHtabMaDnYHk8nWciXUA5THUgWXmoonRJM9RG3LrgwcZ8HVEdDkv5Bd5s5vUYhuiAZic
        2n6zHc5NE0GwVwGc0IwEvpz68na9JRqIgDrWt68c2gBSgNPg5p6q79aMef5QKTfFMl7aIlbHUgfGZ
        HFlzTm5dawL8+vgYpuamBSBfpnv/uYYNQNtoH8gJghE+ksmO0aujJUFs6/46VfvGMXmlUBaemwAZH
        msGO72HcBN5fy4vk3Dsw0lEgu2p49ap8VaV2N3fSN8VjNW/Gvewq1lms0TRVxOsrxwNMyTu5Z2t7N
        oBkG42OQ==;
Received: from [141.22.241.209] (port=56254)
        by n3plvcpnl110358.prod.ams3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <contact@m-mooga.com>)
        id 1h96k3-005MM5-50; Wed, 27 Mar 2019 04:29:11 -0700
User-Agent: Microsoft-MacOutlook/10.17.0.190309
Date:   Wed, 27 Mar 2019 12:28:49 +0100
Subject: Re: [GSoC] microporject test_path_is_*
From:   Mooga <contact@m-mooga.com>
To:     Elijah Newren <newren@gmail.com>
CC:     <git@vger.kernel.org>
Message-ID: <BBF4F6A7-E5CA-4493-B386-AB7A69EA6EFD@m-mooga.com>
Thread-Topic: [GSoC] microporject test_path_is_*
References: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com>
 <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com>
In-Reply-To: <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com>
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - n3plvcpnl110358.prod.ams3.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m-mooga.com
X-Get-Message-Sender-Via: n3plvcpnl110358.prod.ams3.secureserver.net: authenticated_id: contact@m-mooga.com
X-Authenticated-Sender: n3plvcpnl110358.prod.ams3.secureserver.net: contact@m-mooga.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfMaZHEK5A6qGWI2HzpbieH295WuYBHPMpgJmz3xP8L23zAkgrntlFpN+b7Yz/95Vkpzdk8pvVBOw9hOW4NHqC4raP0ET6TXX+7GfAX2eQUFgd81ktpDF
 4FBsO5V5C5UJv3N7SiKH4ECiLfKcK3VabJGZpNiNKS6kBukF7S5CSPbmbaCqXfZHLLSft5HG5IAMFamRIHotqbQT+F4Bca6wUvc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


So for example  that is git diff

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 286bba35d8..fc82965a0f 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -66,7 +66,7 @@ test_expect_success '"add" worktree' '
test_expect_success '"add" worktree with lock' '
        git rev-parse HEAD >expect &&
        git worktree add --detach --lock here-with-lock master &&
-       test -f .git/worktrees/here-with-lock/locked
+       test_path_is_file .git/worktrees/here-with-lock/locked



=EF=BB=BFOn 26.03.19, 23:07, "Elijah Newren" <git-owner@vger.kernel.org on behalf=
 of newren@gmail.com> wrote:

    Hi,
   =20
    On Tue, Mar 26, 2019 at 2:10 PM Mooga <contact@m-mooga.com> wrote:
    >
    > Hi,
    > I am still a bit confused about the task itself
    >
    > it=E2=80=99s just text replacing for example:
    > t1400-update-ref.sh , line 194 -> `test_path_is_missing`  has to be =E2=
=80=98test_path_is_file=E2=80=99
    >
    > Thanks
   =20
    There are several places in the code that use test with -e or -f or -d
    (or -h or...) in order to check for the presence of a
    file/directory/symlink/etc.  For example,
       test -f path1/file1
    This could be made more clear and produce nicer error messages if it
    were instead
       test_path_is_file path1/file1
   =20
    There are likewise several that use one of
       ! test -e path/to/filename
    or
       ! test -f path/to/filename
    or
      test ! -f path/to/filename
    which could be replaced by
      test_path_is_missing path/to/filename
   =20
    This GSoC microproject is just about picking one testfile that has
    some of these constructs, and fixing the cases found within that
    testfile.
   =20



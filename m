Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802AC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF0A619EC
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhCXS5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:57:50 -0400
Received: from w4.tutanota.de ([81.3.6.165]:54290 "EHLO w4.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237532AbhCXS5a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 14:57:30 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w4.tutanota.de (Postfix) with ESMTP id 9F7D41060144
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1616612249;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=eCfU9ay9ki1X2Xr2hksq2shrB3p5gq2vyNyD8r3THUg=;
        b=a0bzHyYnY07K+EIBHetDdSMmS1nmNEmxvgGpJxm9aJch7HX3viFUJQVv5Y3CqEw1
        35lLClhb9uDd+bhIBU9l+7aFrJJStdN528Ioi1NYx0itCfOEGxAqDmevtjq3QMft1SU
        8E9H57tiP42MxVriYCf/YI0ZgVDACzqh3dmYpPxju/MsZztbY+Y9KD4cd+0OZjVDTeW
        3EunP6hEouGSjOavivTPQ7DKdubcugaPuc1IdpW+uEhh9wsqnFoEP1IfEc9al7AT1TP
        TspWrWr/WyZ9wVZLRA/6qRnRr+DZHFbnqhNUV4+xY+svAAwdGUynu7hTjaFY9OWkJnH
        Sntpy8yGmw==
Date:   Wed, 24 Mar 2021 19:57:29 +0100 (CET)
From:   jost.schulte@tutanota.com
To:     Git <git@vger.kernel.org>
Message-ID: <MW_aJot--3-2@tutanota.com>
Subject: Configure default merge message
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I'm using git mainly with BitBucket repositories. When I pull from a remote=
, the default commit message will be "Merge branch 'source-branch-name' of=
=C2=A0https://bitbucket.org/ <https://bitbucket.org/jibbletech/jibble-2.0-c=
lient-web>repository-name into destination-branch-name".

I'd like to configure git to omit the "of=C2=A0https://bitbucket.org/reposi=
tory-name" part. How can I do that?

Regards
Jost

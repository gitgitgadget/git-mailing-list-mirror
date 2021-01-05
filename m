Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EFFC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 03:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E152256F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 03:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbhAEDup (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 22:50:45 -0500
Received: from w1.tutanota.de ([81.3.6.162]:55180 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbhAEDuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 22:50:44 -0500
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2021 22:50:43 EST
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id DDFA0FBF4BA
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 03:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1609817960;
        s=s1; d=tuta.io;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=reh+B/YmjkpR6YORf8t3nS/PpubHaZWBGr9iRYNGqTY=;
        b=azErYxUoJK2iFN9yMtF2vz31y4TvKYaj2+mbQEciH9vkfjbmzG+QCGPXx+5NY2Fw
        3Nx4bZxpmSm8r0+hZtxnthpcGRwEacmj9EzwhzoLCDtVfI2cc/CbQfD5JDHHg78a05P
        xGcrlwXJ5whrZ2fB/ieMWJtGmHMJMWQwXXieZsNcWfvzlG5bg3tuhwRILa65VjL5BC5
        7FRV+wskWmuRMRXAfZpE6IIMyVeYQNZ+cOMu4q7CNlHpv8/7g2BPtvPzCAFp/nsTTMM
        GeR/ybqSkpkvyMhsDJ/c9CwGofbur7n+RB8P+v8dCyPOrkPyeGvMPtFa23eV6pmRjxN
        mXPzVpticg==
Date:   Tue, 5 Jan 2021 04:39:20 +0100 (CET)
From:   stratus@tuta.io
To:     git@vger.kernel.org
Message-ID: <MQFZ9EW--3-2@tuta.io>
Subject: git tag truncates tag list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git,
git tag misses out some tags from this repo here, there seem to be too many=
 to show:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux

It cuts the list short, losing either the latest ones with simply=20
git tag
=C2=A0or the earliest using either=20
git tag=C2=A0 --sort=3D-creatordate
=C2=A0 or=20
git tag --sort=3D-taggerdate

=C2=A0Is there some config option somewhere to show the full list?


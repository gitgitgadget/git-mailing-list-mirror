Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3759BC2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 08:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166CB206ED
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 08:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgBLI45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:56:57 -0500
Received: from vuizook.err.no ([178.255.151.162]:56512 "EHLO vuizook.err.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbgBLI44 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 03:56:56 -0500
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1j1npF-0001tY-IG
        for git@vger.kernel.org; Wed, 12 Feb 2020 08:56:54 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1j1np8-000Un1-Kq
        for git@vger.kernel.org; Wed, 12 Feb 2020 17:56:46 +0900
Date:   Wed, 12 Feb 2020 17:56:46 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: SHA1dc on mac
Message-ID: <20200212085646.hgq3nv2lf4brbb3j@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

If I'm not mistaken in my reading of the various files involved, it
looks like for some reason, building git on mac leads to using Apple
Common Crypto for SHA1, rather than SHA1dc, which seems unfortunate.
Is that really expected? More generally, at this point, should anything
other than SHA1dc be supported as a build option at all?

Mike

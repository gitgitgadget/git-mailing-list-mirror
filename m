Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB62C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC9320848
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgAGRjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:39:46 -0500
Received: from ikke.info ([178.21.113.177]:56460 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgAGRjq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 12:39:46 -0500
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 12:39:46 EST
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 35D9B4400DA; Tue,  7 Jan 2020 18:31:11 +0100 (CET)
Date:   Tue, 7 Jan 2020 18:31:11 +0100
From:   Kevin Daudt <me@ikke.info>
To:     git <git@vger.kernel.org>
Subject: SHA-1 chosen-prefix colission attack
Message-ID: <20200107173111.GB923852@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>, git <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Researchers published new advances in creating collisions in SHA-1
hashes: https://sha-mbles.github.io/

> As a side result, this shows that it now costs less than 100k USD to
> break cryptography with a security level of 64 bits (i.e. to compute
> 264 operations of symmetric cryptography).

Kevin


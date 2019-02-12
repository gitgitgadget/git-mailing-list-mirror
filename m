Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52BE91F453
	for <e@80x24.org>; Tue, 12 Feb 2019 15:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfBLPCJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 10:02:09 -0500
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:59204 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfBLPCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 10:02:09 -0500
X-Greylist: delayed 1103 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2019 10:02:08 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk;
         s=20180806.ppsw; h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:
        To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ldho3TaD/D4dxvSISag97MqZu7RqV5wEx3BdESQwRos=; b=x2b0Ka01vIu6nm5n7/GYN8OOy6
        Ok5CyG/JLbBfWigMFa0WIBYDfNGWYUOrJ65VPEgwsJPmxJtqYxaVLrWzcJsZGcEbOBPmayx9YJiAw
        pv7fU0QfsU8WFW/uFKTwE6gaQ9McbVmxrLGcyg9pMdMSjfszAMt1z/R9HKstYIS2wzmg=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from its-dev-1.cta.phy.private.cam.ac.uk ([172.24.64.61]:47776)
        by ppsw-31.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:587)
        with esmtpsa (LOGIN:tdd20) (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        id 1gtZHk-000TZ5-Kw (Exim 4.91) for git@vger.kernel.org
        (return-path <tdd20@cam.ac.uk>); Tue, 12 Feb 2019 14:43:44 +0000
Message-ID: <408a4b8c4a02df89516c8920ac99b80fde096cce.camel@cam.ac.uk>
Subject: Cloning an empty remote repository using Git GUI fails
From:   Tom Daff <tdd20@cam.ac.uk>
To:     git@vger.kernel.org
Date:   Tue, 12 Feb 2019 14:43:44 +0000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version 2.17.1
git-gui version 0.21.GITGUI

Steps to reproduce:

1) Open `git gui`
2) Select "Clone Existing Repository"
3) Set "Source Location" to an empty remote repository (I am trying
to clone from a gitolite "wild" repo that is created on the fly during
the clone).
4) Clone

Result:

fatal: Couldn't find remote ref HEAD
fatal: The remote end hung up unexpectedly

Expected result:

Successful clone


Previously reported here: https://github.com/msysgit/msysgit/issues/144
 but couldn't find it anywhere in the mailing list.


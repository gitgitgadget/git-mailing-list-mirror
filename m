Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F91A207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 14:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755102AbcJFOCg (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 10:02:36 -0400
Received: from mclniron02-ext.bah.com ([128.229.5.22]:63840 "EHLO
        mclniron02-ext.bah.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754295AbcJFOCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 10:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=bah.com; i=@bah.com; q=dns/txt; s=20160504;
  t=1475762556; x=1507298556;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=O/SY0XY9jCBqs5fDsQGgFBFMBi7jzH8pksDjqbTx/Hw=;
  b=QJQwjdkZgZXn8fdEDsrHUGw+o+2DIMFcu6jq4Vs7Xfl7d6/DCJlI5f/n
   TFPoR/J67YoJeR1PFrLkSXp/Yd86YRWUbJhftRmkeZ7xZI/iTMany7JcQ
   Kxob2boG4UxC8xmVWnX/iGrETpZjaQ1kEBTXYL1/18Q0JKiCsX8/AmgTM
   o=;
x-SBRS: None
X-REMOTE-IP: 10.12.10.220
X-RELAYED: True
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2F2BAALWfZX/9wKDApcHAEBBAEBCgEBgz0BAQEBAYF4umCGIAKCTgECAQEBAQECA3cLhGg6UQEVFRRCDxcBBBvHEI9agy6CLwWZfwGZeoV0kHaFeYcDKoEFgQABAQE
X-IPAS-Result: A2F2BAALWfZX/9wKDApcHAEBBAEBCgEBgz0BAQEBAYF4umCGIAKCTgECAQEBAQECA3cLhGg6UQEVFRRCDxcBBBvHEI9agy6CLwWZfwGZeoV0kHaFeYcDKoEFgQABAQE
X-IronPort-AV: E=Sophos;i="5.31,454,1473134400"; 
   d="scan'208";a="847663358"
Received: from unknown (HELO ASHBCSHB08.resource.ds.bah.com) ([10.12.10.220])
  by mclniron02-int.bah.com with ESMTP; 06 Oct 2016 10:02:11 -0400
Received: from ASHBDAG1M3.resource.ds.bah.com ([fe80::e408:2edf:8022:481d]) by
 ASHBCSHB08.resource.ds.bah.com ([::1]) with mapi id 14.03.0279.002; Thu, 6
 Oct 2016 10:02:10 -0400
From:   "Vacha, Brian [USA]" <vacha_brian@bah.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Fork Errors
Thread-Topic: Fork Errors
Thread-Index: AdIf2jpv4xmwQsngS26RjrVKKVCazQ==
Date:   Thu, 6 Oct 2016 14:02:09 +0000
Message-ID: <2E2ADD8A4AA3FA44A8D8FB00E2B24154B5E9E1C6@ASHBDAG1M3.resource.ds.bah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.4.233]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When starting Git Bash, I receive the following errors:
0 [main] bash 18088 fork: child 14072 - died waiting for dll loading, errno=
 11
bash: fork: retry: No child processes
1190419 [main] bash 18088 fork: child 8744 - died waiting for dll loading, =
errno 11
bash: fork: retry: No child processes
3343518 [main] bash 18088 fork: child 12324 - died waiting for dll loading,=
 errno 11
bash: fork: retry: No child processes
7480858 [main] bash 18088 fork: child 17008 - died waiting for dll loading,=
 errno 11
bash: fork: retry: No child processes
15635036 [main] bash 18088 fork: child 8108 - died waiting for dll loading,=
 errno 11
bash: fork: Resource temporarily unavailable
bash-4.3$

My connection is great at 72 Mbps download and 93 Mbps upload.  I don't rec=
eive other errors so it appears to be a Git Bash issue to me.

Thanks,
Brian

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDFB201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 03:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdBUDAV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 20 Feb 2017 22:00:21 -0500
Received: from vpn.innerrange.com.au ([203.122.143.146]:23295 "EHLO
        remote.innerrange.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750977AbdBUDAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 22:00:21 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Feb 2017 22:00:20 EST
Received: from IR-CENTRAL.corp.innerrange.com ([fe80::216f:2d6c:20cc:241b]) by
 IR-CENTRAL.corp.innerrange.com ([fe80::216f:2d6c:20cc:241b%15]) with mapi;
 Tue, 21 Feb 2017 13:54:34 +1100
From:   Craig McQueen <craig.mcqueen@innerrange.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Tue, 21 Feb 2017 13:54:33 +1100
Subject: git svn find-rev -- search for nearest SVN rev
Thread-Topic: git svn find-rev -- search for nearest SVN rev
Thread-Index: AdKL7TkNrPN82CelTWiTCWtYc7qfRA==
Message-ID: <5500469A22567C4BAF673A6E86AFA3A40295E64BC779@IR-CENTRAL.corp.innerrange.com>
Accept-Language: en-US, en-AU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-AU
x-tm-as-product-ver: SMEX-11.1.0.1278-8.100.1062-22898.004
x-tm-as-result: No--3.232800-5.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using git svn with a project that uses SubWCRev.exe to incorporate the SVN revision into the build number.

I've updated it to use 'git svn find-rev HEAD' in git svn usage, to achieve the same effect.

This works until I have a local commit that hasn't yet been pushed to SVN with 'git svn dcommit'. Then, 'git svn find-rev HEAD' returns nothing.

It would be really great if the '--before' and '--after' switches would work in this case. Then I could use 'git svn find-rev --before HEAD'.

-- 
Craig McQueen


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB3320C11
	for <e@80x24.org>; Wed,  6 Dec 2017 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbdLFVAl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 6 Dec 2017 16:00:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:29879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbdLFVAk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 16:00:40 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2017 13:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.45,369,1508828400"; 
   d="scan'208";a="1252602522"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2017 13:00:39 -0800
Received: from orsmsx105.amr.corp.intel.com ([169.254.2.105]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.89]) with mapi id 14.03.0319.002;
 Wed, 6 Dec 2017 13:00:39 -0800
From:   "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: 'git worktree add' does not fire post-checkout hook
Thread-Topic: 'git worktree add' does not fire post-checkout hook
Thread-Index: AdNu1TPJ9CqmWqaIT1WpKGGVIVC9hw==
Date:   Wed, 6 Dec 2017 21:00:38 +0000
Message-ID: <DA0A42D68346B1469147552440A64503C60832DB@ORSMSX105.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmZlNTY2ZWQtODYxMC00ODc3LWI1MDktZjFmMzJkYmE0OGY1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJcL2lQdlpFNGI3TlNOUXlMU1NSK2lPMVFCK2NtT1VvYVNKNkVROG5mOU41enRxc2x3TnBCSmx0dXFneUVaUkFTVyJ9
x-ctpclassification: CTP_IC
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I've noticed that when I run 'git worktree add /path/to/new/tree', the post-checkout hook does not fire, even though the worktree manpage explicitly states that "worktree add" will, "Create <path> and checkout <branch> into it."

Is this the intended behavior? Seems like maybe a bug, but I'm not sure.

Thanks
Matt



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431861FC46
	for <e@80x24.org>; Sun,  5 Feb 2017 02:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdBECaM (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 21:30:12 -0500
Received: from nschwqsrv01p.mx.bigpond.com ([61.9.189.231]:64505 "EHLO
        nschwqsrv01p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751098AbdBECaM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2017 21:30:12 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Feb 2017 21:30:11 EST
Received: from nschwcmgw05p ([61.9.190.165]) by nschwmtas05p.mx.bigpond.com
          with ESMTP
          id <20170205022157.ZYUZ28550.nschwmtas05p.mx.bigpond.com@nschwcmgw05p>
          for <git@vger.kernel.org>; Sun, 5 Feb 2017 02:21:57 +0000
Received: from x220a02 ([137.147.36.17])
        by nschwcmgw05p with BigPond Outbound
        id gqMw1u00L0NBXbd01qMxX6; Sun, 05 Feb 2017 02:21:57 +0000
X-Authority-Analysis: v=2.1 cv=RY5tcAZv c=1 sm=1 tr=0
 a=VubfyEYjcLZ4M2izvE1rvg==:117 a=VubfyEYjcLZ4M2izvE1rvg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=n2v9WMKugxEA:10 a=B_go1Y5uoeYYXnyh9VAA:9 a=CjuIK1q_8ugA:10
Received: by x220a02 (Postfix, from userid 1000)
        id 904E2260044; Sun,  5 Feb 2017 13:21:56 +1100 (AEDT)
Date:   Sun, 5 Feb 2017 13:21:56 +1100
From:   Zenaan Harkness <zen@freedbms.net>
To:     git <git@vger.kernel.org>
Subject: release notes/ change number discrepancy ? -
 Documentation/RelNotes/2.10.0.txt "merge b738396..."
Message-ID: <20170205022156.GA19612@x220-a02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am I missing something in the following:

looking at Documentation/RelNotes/2.10.0.txt I see the following release
note (~line 35):

 * "upload-pack" allows a custom "git pack-objects" replacement when
   responding to "fetch/clone" via the uploadpack.packObjectsHook.
   (merge b738396 jk/upload-pack-hook later to maint).


but when I run git show b738396 , I get the following:

commit b738396cfdcc276c0cde0c1a6462c5cc74ba7b76
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Thu Jul 14 15:58:59 2016 +0200

    mingw: fix regression in t1308-config-set


which seems to be completely unrelated. What am I missing please?

Thanks
Zenaan

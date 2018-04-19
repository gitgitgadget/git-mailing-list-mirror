Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404CF1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 10:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeDSKmb (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 06:42:31 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:43709 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeDSKm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 06:42:29 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Thu, 19 Apr 2018 12:37:43 +0200
  id 00000000000000EE.000000005AD87177.000032EC
Date:   Thu, 19 Apr 2018 12:37:25 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
Message-ID: <20180419103725.GB19591@ruderich.org>
References: <20180326165520.802-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180326165520.802-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When running make -j$(nproc) with the current pu f9f8c1f765
(Merge branch 'hn/bisect-first-parent' into pu) I see the
following error:

GIT_VERSION = 2.17.0.732.gf9f8c1f765
    * new build flags
    * new prefix flags
    GEN common-cmds.h
    * new link flags
    CC ident.o
    CC hex.o
    CC json-writer.o
./generate-cmdlist.sh: 73: ./generate-cmdlist.sh: Bad substitution

This doesn't occur on a non-parallel build.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

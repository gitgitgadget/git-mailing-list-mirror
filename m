Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E9A209FC
	for <e@80x24.org>; Fri, 26 May 2017 06:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030668AbdEZGns (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 02:43:48 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:52172 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759067AbdEZGnr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 02:43:47 -0400
Received: from tigra (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 2FA35D400BA;
        Fri, 26 May 2017 09:43:45 +0300 (MSK)
Date:   Fri, 26 May 2017 09:43:45 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Yu-Hsuan Chen <davidchen9568@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: Corrupt pack file after committing a large file (>4
 GB?)
Message-ID: <20170526064344.o7kifhz5xjbdo4ob@tigra>
References: <CACX31FFFk1aSn+X9VO6PkCofXPE1fjB6pugLcm+srjXFDJkmyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACX31FFFk1aSn+X9VO6PkCofXPE1fjB6pugLcm+srjXFDJkmyg@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 01:51:34PM +0800, Yu-Hsuan Chen wrote:

> There is a bug where committing a large file corrupts the pack file in
> Windows. Steps to recreate are:
> 
> 1. git init
> 2. stage and commit a file larger than 4 GB (not entirely sure about this size)
> 3. git checkout -f
> 
> The file checked out is much smaller than the original file size.

For a bug report to be at least marginally useful, please state your Git
version (run "git --version") and the version of your Windows
installation (including whether it's 32- or 64-bit install).

Please also make sure you're really using Git for Windows (that is, you
got it from [1] or [2] and not, say, from Cygwin.

The best course of actions is to download the most recent available
version from the locations mentioned above and verify the problem still
manifests itself.

1. https://git-scm.com/download/win
2. https://git-for-windows.github.io/


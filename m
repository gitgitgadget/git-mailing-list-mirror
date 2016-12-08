Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC54C1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbcLHTuK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 14:50:10 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:37175 "EHLO
        smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcLHTuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 14:50:09 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb1-g21.free.fr (Postfix) with ESMTP id 025762E319
        for <git@vger.kernel.org>; Thu,  8 Dec 2016 20:50:02 +0100 (CET)
Received: from ylum.localnet (unknown [IPv6:2a01:e34:edf7:4710:1366:30a:a1d9:15f1])
        (Authenticated sender: domi.dumont)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id CE55B13F89A
        for <git@vger.kernel.org>; Thu,  8 Dec 2016 20:49:59 +0100 (CET)
From:   Dominique Dumont <dod@debian.org>
To:     git@vger.kernel.org
Reply-To: dod@debian.org
Subject: Feature request: read git config from parent directory
Date:   Thu, 08 Dec 2016 20:49:58 +0100
Message-ID: <3881793.6JIRvg1BPW@ylum>
User-Agent: KMail/5.2.3 (Linux/4.8.0-2-amd64; KDE/5.28.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I use the same machine for work and open-source contribution. In both cases, I 
deal with a lot of repositories. Depending on whether I commit for work or 
open-source activities, I must use a different mail address. I used to setup 
work address for each work repo in git local config, but this is no longer 
practical.

Since I use different directories for work and open-source, would it be 
possible for git to read irs config also from parent directories ? I.e. setup 
git to read config from ./.git/config then ../.gitconfig, ../../gitconfig until 
global ~/.gitconfig.

All the best

-- 
 https://github.com/dod38fr/   -o- http://search.cpan.org/~ddumont/
http://ddumont.wordpress.com/  -o-   irc: dod at irc.debian.org

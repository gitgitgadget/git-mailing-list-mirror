Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38D21F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeASRv4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:51:56 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:47140 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932305AbeASRvy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:51:54 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:38834 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ecapV-0004QX-WC
        for git@vger.kernel.org; Fri, 19 Jan 2018 12:51:54 -0500
Date:   Fri, 19 Jan 2018 12:51:52 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: should any build system legitimately change any tracked files?
Message-ID: <alpine.LFD.2.21.1801191247250.10222@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  just finished teaching a couple git courses and, after class, a
student came up and described a rather weird problem -- in short:

  1) before build, "git diff" shows nothing
  2) do the standard build
  3) suddenly, "git diff" shows some changes

that's all the info i was given, but it *seems* clear that the build
process itself was making changes to one or more tracked files.

  technically, i guess one can design a build system to do pretty
much anything, but is it fair to say that this is a really poor design
decision? admittedly, this isn't specifically a git question, but i'm
open to opinions on something that strikes me as a bad idea.

rday

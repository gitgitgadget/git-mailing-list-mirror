Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779CC202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 10:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbdJBKNF (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 06:13:05 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:38747 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdJBKNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 06:13:04 -0400
Received: from [::1] (port=59608 helo=cpanel2.indieserve.net)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dyxih-0004v1-SK
        for git@vger.kernel.org; Mon, 02 Oct 2017 06:13:03 -0400
Received: from 158.116.144.29 ([158.116.144.29]) by crashcourse.ca (Horde
 Framework) with HTTPS; Mon, 02 Oct 2017 06:13:03 -0400
Date:   Mon, 02 Oct 2017 06:13:03 -0400
Message-ID: <20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca>
From:   rpjday@crashcourse.ca
To:     git@vger.kernel.org
Subject: What means "git config bla ~/"?
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday@crashcourse.ca
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

   i'm sure i'm about to embarrass myself but, in "man git-config",  
OPTIONS, one reads:

   --path

   git-config will expand leading ~ to the value of $HOME, and ~user  
to the   home directory for the specified user. This option has no  
effect when setting the value (but you can use git config bla ~/ from  
the command line to let your shell do the expansion).

   what's with that "git config bla ~/"? is this some config keyword  
or something?

rday


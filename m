Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0440E2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 14:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdCROaN (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 10:30:13 -0400
Received: from lang.hm ([66.167.227.134]:54125 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdCRO3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 10:29:52 -0400
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v2IEToax005778
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 06:29:50 -0800
Date:   Sat, 18 Mar 2017 07:29:50 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     git@vger.kernel.org
Subject: Is there a way to have a local version of a header file?
Message-ID: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

for an embedded project built inside the Arduino IDE, (alternate firmware for a 
home automation project) there is a need to set a number of parameters that we 
really don't want in the main repo (wifi network IDs/passwords)

right now, we have these things set as #defines in a header file.

We need to distribute a base version of this file for new people to get started.

Is there any way to have git define a file in such a way that if it doesn't 
exist in the worktree it gets populated, but if it does exist it doesn't get 
overwritten? (as I type this, I'm thinking a trigger may work, but we need it to 
work on Linux, Windows and OSX)

Any thoughts on a sane way to handle this situation?

David Lang

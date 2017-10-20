Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9771FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdJTS1h (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 14:27:37 -0400
Received: from lang.hm ([66.167.227.134]:41575 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752101AbdJTS1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 14:27:36 -0400
X-Greylist: delayed 897 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Oct 2017 14:27:36 EDT
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v9KICYlR004708
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 11:12:34 -0700
Date:   Fri, 20 Oct 2017 11:12:34 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     git@vger.kernel.org
Subject: hot to get file sizes in git log output
Message-ID: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm needing to scan through git history looking for the file sizes (looking for 
when a particular file shrunk drastically)

I'm not seeing an option in git log or git whatchanged that gives me the file 
size, am I overlooking something?

David Lang

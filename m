Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B921F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 18:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGMTHo (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:07:44 -0400
Received: from lang.hm ([66.167.227.134]:37910 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbeGMTHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 15:07:44 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id w6DIpYTW019812;
        Fri, 13 Jul 2018 11:51:34 -0700
Date:   Fri, 13 Jul 2018 11:51:34 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:     git@jeffhostetler.com
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 00/25] RFC: structured logging
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
Message-ID: <alpine.DEB.2.02.1807131150350.20559@nftneq.ynat.uz>
References: <20180713165621.52017-1-git@jeffhostetler.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please make an option for git to write these logs to syslog, not just a local 
file. Every modern syslog daemon has lots of tools to be able to deal with json 
messages well.

David Lang

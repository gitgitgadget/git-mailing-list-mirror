Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2102047F
	for <e@80x24.org>; Mon, 24 Jul 2017 04:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdGXEXV (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 00:23:21 -0400
Received: from lang.hm ([66.167.227.134]:51277 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbdGXEXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 00:23:20 -0400
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v6O4D22W023383;
        Sun, 23 Jul 2017 21:13:02 -0700
Date:   Sun, 23 Jul 2017 21:13:02 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Farshid Zavareh <fhzavareh@gmail.com>
cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Should I store large text files on Git LFS?
In-Reply-To: <FF08CB42-35AC-4B97-BB02-2473BEDE66A1@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1707232109480.20418@qynat-yncgbc>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com> <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com> <FF08CB42-35AC-4B97-BB02-2473BEDE66A1@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 24 Jul 2017, Farshid Zavareh wrote:

> I'll probably test this myself, but would modifying and committing a 4GB text 
> file actually add 4GB to the repository's size? I anticipate that it won't, 
> since Git keeps track of the changes only, instead of storing a copy of the 
> whole file (whereas this is not the case with binary files, hence the need for 
> LFS).

well, it wouldn't be 4G because text compresses well, but if the file changes 
drastically from version to version (say a quarterly report), the diff won't 
help.

David Lang

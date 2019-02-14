Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF331F453
	for <e@80x24.org>; Thu, 14 Feb 2019 16:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405015AbfBNQ2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 11:28:15 -0500
Received: from avasout05.plus.net ([84.93.230.250]:52684 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404987AbfBNQ2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 11:28:14 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id uJrwgOLmOuymiuJrxgfRcz; Thu, 14 Feb 2019 16:28:13 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NZTIKVL4 c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=iaiCVPez2tU2VkP9ETUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] read-cache: add post-indexchanged hook
To:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org
Cc:     benpeart@microsoft.com, kewillf@microsoft.com,
        sandals@crustytoothpaste.net
References: <20190208195115.12156-1-peartben@gmail.com>
 <20190214144241.11240-1-peartben@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2f08ee3b-4511-2838-4c70-640d01fe1658@ramsayjones.plus.com>
Date:   Thu, 14 Feb 2019 16:28:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214144241.11240-1-peartben@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIEOh53fGdtEl1rP+dlW88TLq5RDzhyW0FFnBnf5kvTWqLuctxM+QNu8O+/1Y0MKOSpMnEc0KF+U8v+DhsSCFvNEUtsmVvFyTz43Abt/+GAQ/9rBUx4V
 PqyEG6uATogKDvhsvdif0lidTYdV3o1hz5iNUryZ4pZIZo8QVnLcy0SMNYLDE7+FjgKGtXvhgj4r+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/02/2019 14:42, Ben Peart wrote:
> From: Ben Peart <benpeart@microsoft.com>
> 
> Add a post-indexchanged hook that is invoked after the index is written in

s/post-indexchanged/post-index-changed/

> do_write_locked_index().
> 
> This hook is meant primarily for notification, and cannot affect
> the outcome of git commands that trigger the index write.
> 
> The hook is passed a flag to indicate whether the working directory was
> updated or not and a flag indicating if a skip-worktree bit could have
> changed.  These flags enable the hook to optmize its response to the

s/optmize/optimize/

ATB,
Ramsay Jones

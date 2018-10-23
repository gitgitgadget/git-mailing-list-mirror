Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947591F453
	for <e@80x24.org>; Tue, 23 Oct 2018 01:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeJWJjq (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 05:39:46 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:35718 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbeJWJjp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Oct 2018 05:39:45 -0400
Received: from resomta-po-17v.sys.comcast.net ([96.114.154.241])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id ElJhgK1oUVp6yElLIgdn7s; Tue, 23 Oct 2018 01:18:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1540257525;
        bh=0CsHrbwO3FnBTX6dJDyUWRNUMP2QQCO+gjXQIg7bmpE=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=aVkmoUMTgXbq3dsFgAMbK5Anh4afJQcolC/UleLLjgMSI4eBZMxdY5PaL7gCk6gL+
         glrEq/xhZU+Di8C7q54oJDPRxe8Tpr9P4Ag03CWRSEEJQt/fJ01KfGoVE7yiKVSTsx
         1AlBF5A1klpJqSR+kluJ61lVGNY5MUcIggg4hM6qiEL+Lqfh8ia9Two6PSI65OqILV
         rTUOWtBrrZFRKSyO9f2+jCPEkP4Bw5P8pPedoWOw1DD9n61AlHe5R+qcl7h0hvWm0o
         QmKG1ZsmugrMPIKk2C93uklSX4ZrJFhYad7FtxRNsKrcOdrKQ620e9QBtx5qEVFikn
         ystc6iivIg42g==
Received: from [2620:0:100e:913:4957:471c:6cae:55cb] ([IPv6:2620:0:100e:913:4957:471c:6cae:55cb])
        by resomta-po-17v.sys.comcast.net with ESMTPSA
        id ElKrgwgoHyf2vElL0ghEPa; Tue, 23 Oct 2018 01:18:42 +0000
Date:   Mon, 22 Oct 2018 18:18:16 -0700 (PDT)
From:   Matthew DeVore <matvore@comcast.net>
X-X-Sender: matvore@matvore-linux.svl.corp.google.com
To:     Matthew DeVore <matvore@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        peff@peff.net, jonathantanmy@google.com, jeffhost@microsoft.com
Subject: Re: [RFC 0/2] explicitly support or not support
 --exclude-promisor-objects
In-Reply-To: <cover.1540256910.git.matvore@google.com>
Message-ID: <alpine.DEB.2.21.1810221816480.38032@matvore-linux.svl.corp.google.com>
References: <cover.1540256910.git.matvore@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CMAE-Envelope: MS4wfCWuElOk2GSQRngYkA601dRkGeVEY0/Gn6XEx3UvHzCB1eUKBqEk4Y6BdViFuBGgXzTbI+uRYZMHxY6FTFzTtffOI5r86oNx5XNKVFk44ibYiOPyPOwh
 Duw8gcp5bEEhvC7AcbUL8B91uIgEQc5p3Oo+YV1ws/ie7tpDBie309bIhL3an4/8Q5UnjGMH2Z4UI53zfE9BlA4n5gt6sKg/ttCnmbW5r8lLx1JrouKGIQN6
 GEHtJwNgLW73sZogoYZM51bHMUjzqanSDKep1UTrVL/oD0LP/BVQMrR1NtOG8ElanzCvBM2KYC1CXxzOVNXo88FoxtGu0PLFtkTO+GuFCy2rd3aHe9OuIYKD
 7KXxgBLGFC44q8cqXRFwF3PzbZ+ts3FPyf2B2OGpzXQZro76AJGEdBJXkcqWaKCmozhUAevssC7RCukzrWSBSwz7vEtGzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, 22 Oct 2018, Matthew DeVore wrote:

> This patch set fixes incorrect parsing of the --exclude-promisor-objects
> option that I found while working on:
>

Somehow I sent two copies of every message in the patchset. I'm sorry
for the mess.

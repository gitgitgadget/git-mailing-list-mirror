Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB761F4B6
	for <e@80x24.org>; Sat, 11 May 2019 21:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEKVRu (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 17:17:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33602 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfEKVRu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 17:17:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DF0421F461;
        Sat, 11 May 2019 21:17:49 +0000 (UTC)
Date:   Sat, 11 May 2019 21:17:49 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
Message-ID: <20190511211749.5ghtdcuzgb7bkywo@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190511013455.5886-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Combined with stdio and kernel buffering; the kernel should be
> able to avoid block layer writes and reduce wear.

Along the same lines, I'd like to get repack to stop recreating
identical packs at some point (but that could be months from now...)

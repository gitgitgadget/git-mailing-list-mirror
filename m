Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2010BC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CFF20731
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgD1VE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:04:27 -0400
Received: from aibo.runbox.com ([91.220.196.211]:47916 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgD1VE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 17:04:26 -0400
Received: from [10.9.9.203] (helo=mailfront21.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jTXOx-00011f-I9; Tue, 28 Apr 2020 23:04:23 +0200
Received: by mailfront21.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jTXOn-0007M0-EO; Tue, 28 Apr 2020 23:04:13 +0200
Date:   Tue, 28 Apr 2020 21:04:04 +0000
From:   Emma Brooks <me@pluvano.com>
To:     "Nixon, Francis A" <francis.nixon17@imperial.ac.uk>
Cc:     git@vger.kernel.org
Subject: Re: Git Log ignores --oneline and --pretty=oneline in combination
 with -L.
Message-ID: <20200428210404.GA24743@pluvano.com>
References: <DB8PR06MB6218D1398300AFD016D0B804D5AC0@DB8PR06MB6218.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8PR06MB6218D1398300AFD016D0B804D5AC0@DB8PR06MB6218.eurprd06.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-28 14:28:15+0000, Nixon, Francis A wrote:
>  Running `git log --pretty=oneline -L:get_stack_map_frames:stackmapframes.rs`(filename/function names as an example only, consistent across many files.) results on in correct output but doesn't ouput in a oneline format(still includes the full diffs). 

-L implies --patch, which outputs a full diff. If you don't want that,
add --no-patch to the command.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A811F462
	for <e@80x24.org>; Fri, 14 Jun 2019 07:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfFNHmL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 03:42:11 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45166 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNHmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 03:42:11 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hbgqd-00011A-5Q; Fri, 14 Jun 2019 16:42:07 +0900
Date:   Fri, 14 Jun 2019 16:42:07 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     ungureanupaulsebastian@gmail.com, t.gummerer@gmail.com
Subject: `git stash <command> <n>` stopped working in 2.22.0
Message-ID: <20190614074207.mxidz3h573mtd43x@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

`git stash <command> <n>` where n is a number used to work until 2.21.*.
It doesn't work in 2.22.0.

Bisection points to:

dc7bd382b1063303f4f45d243bff371899285acb is the first bad commit
commit dc7bd382b1063303f4f45d243bff371899285acb
Author: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Date:   Mon Feb 25 23:16:20 2019 +0000

    stash: convert show to builtin

which I guess makes sense :)

Mike

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB731FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 01:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbcLLB6a (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 20:58:30 -0500
Received: from ozlabs.org ([103.22.144.67]:55239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbcLLB62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 20:58:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tcQwg2jFWz9t2G; Mon, 12 Dec 2016 12:58:27 +1100 (AEDT)
Date:   Mon, 12 Dec 2016 11:01:44 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitk: Makefile: create install bin directory
Message-ID: <20161212000144.GB18316@fergus.ozlabs.ibm.com>
References: <1462470392-19991-1-git-send-email-vascomalmeida@sapo.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462470392-19991-1-git-send-email-vascomalmeida@sapo.pt>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 05, 2016 at 05:46:32PM +0000, Vasco Almeida wrote:
> Force creation of destination bin directory. Before this commit, gitk
> would fail to install if this directory didn't already exist.
> 
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>

Thanks, applied (with slight tweak to commit message).

Paul.

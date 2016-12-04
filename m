Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085F11FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 23:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbcLDXYw (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 18:24:52 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34702 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbcLDXYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 18:24:51 -0500
Received: from glandium by zenigata with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cDg9G-0006kq-S1
        for git@vger.kernel.org; Mon, 05 Dec 2016 08:24:46 +0900
Date:   Mon, 5 Dec 2016 08:24:46 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Re: Should reset_revision_walk clear more flags?
Message-ID: <20161204232446.tbu6dhwfrw3n5ueo@glandium.org>
References: <20161204230958.h3ilhueqqptv253u@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161204230958.h3ilhueqqptv253u@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2016 at 08:09:58AM +0900, Mike Hommey wrote:
> Hi,
> 
> While trying to use the revision walking API twice in a row, I noticed
> that the second time for the same setup would not yield the same result.
> In my case, it turns out I was requesting boundaries, and
> reset_revision_walk() is not resetting CHILD_SHOWN and BOUNDARY, both
> required to be reset for the second revision walk to work.

and TREESAME when using different pathspecs.

Mike

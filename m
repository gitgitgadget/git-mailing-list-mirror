Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB68A1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 01:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfHZBzI (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:55:08 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38158 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfHZBzI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 21:55:08 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1i24Dm-00018i-P3; Mon, 26 Aug 2019 10:55:02 +0900
Date:   Mon, 26 Aug 2019 10:55:02 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: Re: [PATCH] notes: avoid leaking duplicate entries
Message-ID: <20190826015502.qbgn557xjylju4o6@glandium.org>
References: <20190825051818.9621-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825051818.9621-1-mh@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 02:18:18PM +0900, Mike Hommey wrote:
> When add_note is called multiple times with the same key/value pair, the
> leaf_node it creates is leaked by notes_tree_insert.

For completeness, since I realized it was missing:
Signed-off-by: Mike Hommey <mh@glandium.org>

Mike

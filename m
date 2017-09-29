Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3842047F
	for <e@80x24.org>; Fri, 29 Sep 2017 06:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbdI2Ge6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 02:34:58 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:60997 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750782AbdI2Ge6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Sep 2017 02:34:58 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dxosw-0001re-Jq; Fri, 29 Sep 2017 07:34:54 +0100
Message-ID: <1506666894.3022.2.camel@hellion.org.uk>
Subject: Re: What's cooking in git.git (Sep 2017, #06; Fri, 29)
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Fri, 29 Sep 2017 07:34:54 +0100
In-Reply-To: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.0-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-09-29 at 13:34 +0900, Junio C Hamano wrote:
> 
> * ic/fix-filter-branch-to-handle-tag-without-tagger (2017-09-22) 4
> commits
>   (merged to 'next' on 2017-09-25 at c7550033df)
>  + filter-branch: use hash-object instead of mktag
>  + filter-branch: stash away ref map in a branch
>  + filter-branch: preserve and restore $GIT_AUTHOR_* and
> $GIT_COMMITTER_*
>  + filter-branch: reset $GIT_* before cleaning up
> 
>  "git filter-branch" cannot reproduce a history with a tag without
>  the tagger field, which only ancient versions of Git allowed to be
>  created.  This has been corrected.

This set of patches also includes the new --state-branch option to
allow you to do incremental conversions.

Ian.

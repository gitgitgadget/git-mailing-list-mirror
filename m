Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BC31F437
	for <e@80x24.org>; Tue, 24 Jan 2017 18:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbdAXS4c (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 13:56:32 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:60960 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750704AbdAXS4c (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Jan 2017 13:56:32 -0500
Received: from app04.ox.hosteurope.de ([92.51.170.11]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:128)
        id 1cW6GZ-0004p6-Fw; Tue, 24 Jan 2017 19:56:27 +0100
Date:   Tue, 24 Jan 2017 19:56:27 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Reply-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <1929244236.1844627.1485284187492.JavaMail.open-xchange@app04.ox.hosteurope.de>
In-Reply-To: <xmqqtw8uy62m.fsf@gitster.mtv.corp.google.com>
References: <xmqqtw8uy62m.fsf@gitster.mtv.corp.google.com>
Subject: Re: What's cooking in git.git (Jan 2017, #03; Thu, 19)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev61
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1485284192;7e91dfe4;
X-HE-SMSGID: 1cW6GZ-0004p6-Fw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> hat am 20. Januar 2017 um 00:37
> geschrieben:

[snip]
  
> * rh/mergetool-regression-fix (2017-01-10) 14 commits
>   (merged to 'next' on 2017-01-10 at e8e00c798b)
>  + mergetool: fix running in subdir when rerere enabled
>  + mergetool: take the "-O" out of $orderfile
>  + t7610: add test case for rerere+mergetool+subdir bug
>  + t7610: spell 'git reset --hard' consistently
>  + t7610: don't assume the checked-out commit
>  + t7610: always work on a test-specific branch
>  + t7610: delete some now-unnecessary 'git reset --hard' lines
>  + t7610: run 'git reset --hard' after each test to clean up
>  + t7610: don't rely on state from previous test
>  + t7610: use test_when_finished for cleanup tasks
>  + t7610: move setup code to the 'setup' test case
>  + t7610: update branch names to match test number
>  + rev-parse doc: pass "--" to rev-parse in the --prefix example
>  + .mailmap: record canonical email for Richard Hansen
> 
>  "git mergetool" without any pathspec on the command line that is
>  run from a subdirectory became no-op in Git v2.11 by mistake, which
>  has been fixed.

Hi Junio, 

Sorry for asking a maybe obvious question.
Will that be merged into maint as well?
It is a regression in 2.11 so I would have expected to see that in maint.

Thanks,
Thomas

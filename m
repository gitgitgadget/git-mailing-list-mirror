Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3195620958
	for <e@80x24.org>; Tue, 21 Mar 2017 02:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755961AbdCUCMZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 22:12:25 -0400
Received: from [195.159.176.226] ([195.159.176.226]:36232 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbdCUCMY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 22:12:24 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1cq9HJ-00017r-Vi
        for git@vger.kernel.org; Tue, 21 Mar 2017 03:12:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: Why "You cannot combine --squash with --no-ff" in git merge?
Date:   Tue, 21 Mar 2017 02:11:50 +0000 (UTC)
Message-ID: <oaq256$u33$1@blaine.gmane.org>
References: <oaq19p$kpo$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.4.1-20161224 ("Daill") (UNIX) (FreeBSD/11.0-RELEASE-p8 (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,


I made a mistake in the previous message. I'm really sorry, I need to go
have some sleep right now.

Anatoly Borodin <anatoly.borodin@gmail.com> wrote:
> `git merge --squash --ff` will happily move the A ref to the B commit.
> 
> But what I want, and expect, is:
> 
>         A---B'
> 
> where B' has the same tree as B.

`git merge --squash --ff` WILL create A---B'.

But it's still unclear to me why `git merge --squash --no-ff` should
fail instead of doing the same as `git merge --squash --ff` does. The
error message and the documentation do not give any good reasons for it.

PS In my case, I set `merge.ff=false` and run just `git merge --squash`.


-- 
Mit freundlichen Grüßen,
Anatoly Borodin


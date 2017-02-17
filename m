Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98C8201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 21:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935139AbdBQVvF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 16:51:05 -0500
Received: from smtp26.services.sfr.fr ([93.17.128.1]:64661 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934415AbdBQVvD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 16:51:03 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Feb 2017 16:51:03 EST
Received: from [192.168.1.57] (220.208.99.84.rev.sfr.net [84.99.208.220])
        by msfrf2612.sfr.fr (SMTP Server) with ESMTP id D54121C000C79;
        Fri, 17 Feb 2017 22:42:44 +0100 (CET)
Received: from [192.168.1.57] (220.208.99.84.rev.sfr.net [84.99.208.220])       (using TLSv1
        with cipher ECDHE-RSA-AES128-SHA (128/128 bits))        (No client certificate requested)
        by msfrf2612.sfr.fr (SMTP Server) with ESMTPS;
        Fri, 17 Feb 2017 22:42:44 +0100 (CET)
Subject: Re: Re: dotfiles in git template dir are not copied
To:     Jeff King <peff@peff.net>
References: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
        <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?iso-8859-1?q?Gr=E9goire?= PARIS <postmaster@greg0ire.fr>
Message-ID: <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
Date:   Fri, 17 Feb 2017 22:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net>
X-sfr-mailing: LEGIT
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 > You could, for example, have your template directory itself be a git 
repository.

I can and I do and indeed, that might be the reason behind this.
I made a PR to document this : https://github.com/git/git/pull/325

--
greg0ire

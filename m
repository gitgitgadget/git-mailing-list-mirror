Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C21201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935145AbdBQWh3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:37:29 -0500
Received: from smtp26.services.sfr.fr ([93.17.128.163]:37187 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935007AbdBQWh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:37:27 -0500
Received: from [192.168.1.57] (220.208.99.84.rev.sfr.net [84.99.208.220])
        by msfrf2603.sfr.fr (SMTP Server) with ESMTP id 4E9D91C000C22;
        Fri, 17 Feb 2017 23:37:25 +0100 (CET)
Received: from [192.168.1.57] (220.208.99.84.rev.sfr.net [84.99.208.220])       (using TLSv1
        with cipher ECDHE-RSA-AES128-SHA (128/128 bits))        (No client certificate requested)
        by msfrf2603.sfr.fr (SMTP Server) with ESMTPS;
        Fri, 17 Feb 2017 23:37:24 +0100 (CET)
Subject: Re: dotfiles in git template dir are not copied
To:     Junio C Hamano <gitster@pobox.com>
References: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
        <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net>
        <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
        <xmqqmvdkqxfd.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
From:   =?iso-8859-1?q?Gr=E9goire?= PARIS <postmaster@greg0ire.fr>
Message-ID: <9894f34a-d362-7741-b5b8-3743fe8f4e0b@greg0ire.fr>
Date:   Fri, 17 Feb 2017 23:37:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvdkqxfd.fsf@gitster.mtv.corp.google.com>
X-sfr-mailing: LEGIT
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 > I do not think we should change the behaviour
 > to copy files whose names begin with a dot.

So bug turned feature it is :)

I amended my commit message accordingly.

In my case, my template dir is not at the root of the repository where 
it is versioned, so it would not be a problem for me, but I think some 
people might use this feature to add tests/docs without having them copied.

my template dir repository : https://github.com/greg0ire/git_template

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9482082F
	for <e@80x24.org>; Sat, 15 Jul 2017 16:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdGOQBg (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 12:01:36 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:51142 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbdGOQBf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 12:01:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3x8vSF1skpz5tlF;
        Sat, 15 Jul 2017 18:01:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B7E28135;
        Sat, 15 Jul 2017 18:01:32 +0200 (CEST)
Subject: Re: [FEATURE] git-commit option to prepend filename to commit message
To:     John J Foerch <jjfoerch@earthlink.net>
References: <18894679.1800.1500128374439@elwamui-karabash.atl.sa.earthlink.net>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ef92480f-3de6-fa82-78bc-2a91566e8864@kdbg.org>
Date:   Sat, 15 Jul 2017 18:01:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <18894679.1800.1500128374439@elwamui-karabash.atl.sa.earthlink.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.07.2017 um 16:19 schrieb John J Foerch:
> The feature would be a command line option for git commit that would
> automatically prepend the "<filename>: " to the commit message.
Write a prepare-commit-msg hook:

https://www.kernel.org/pub/software/scm/git/docs/githooks.html#_prepare_commit_msg

-- Hannes

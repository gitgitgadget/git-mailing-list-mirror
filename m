Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA1D1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeHVS7U (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 14:59:20 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:21457 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbeHVS7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 14:59:19 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41wWmN308Rz5tlV;
        Wed, 22 Aug 2018 17:33:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 95732120;
        Wed, 22 Aug 2018 17:33:55 +0200 (CEST)
Subject: Re: [PATCH] config: fix commit-graph related config docs
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>
References: <20180822131547.56899-1-dstolee@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <51671d59-8654-d79a-3fd9-9353aa4de1d7@kdbg.org>
Date:   Wed, 22 Aug 2018 17:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822131547.56899-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.08.2018 um 15:16 schrieb Derrick Stolee:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1c42364988..f846543414 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -917,7 +917,11 @@ core.notesRef::
>   This setting defaults to "refs/notes/commits", and it can be overridden by
>   the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>   
> -gc.commitGraph::
> +core.commitGraph::
> +	Enable git commit graph feature. Allows reading from the
> +	commit-graph file.

Please do not assume that everybody knows what "the commit-graph file" 
is and that they know that they want it or do not want it. I do not 
know. You should mention here when to set this configuration variable to 
which values and what the default value is.

> +
> +gc.writeCommitGraph::
>   	If true, then gc will rewrite the commit-graph file when
>   	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
>   	'--auto' the commit-graph will be updated if housekeeping is

-- Hannes

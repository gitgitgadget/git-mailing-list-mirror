Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501551F597
	for <e@80x24.org>; Wed, 25 Jul 2018 07:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeGYImk (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 04:42:40 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:36223 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbeGYImk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 04:42:40 -0400
Received: from [192.168.1.181] (unknown [185.39.175.181])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41b6PV0xsPz5tlF;
        Wed, 25 Jul 2018 09:32:13 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/9] vscode: use 8-space tabs, no trailing ws, etc for
 Git's source code
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.2.git.gitgitgadget@gmail.com>
 <2e880b6f1c6d37d0f94598db408511e0e216a51f.1532353966.git.gitgitgadget@gmail.com>
X-Mozilla-News-Host: news://news.public-inbox.org
Message-ID: <88952ba5-9de4-9b32-2129-1cc83999db78@kdbg.org>
Date:   Wed, 25 Jul 2018 09:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2e880b6f1c6d37d0f94598db408511e0e216a51f.1532353966.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.07.2018 um 15:52 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This adds a couple settings for the .c/.h files so that it is easier to
> conform to Git's conventions while editing the source code.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   contrib/vscode/init.sh | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
> index face115e8..29f2a729d 100755
> --- a/contrib/vscode/init.sh
> +++ b/contrib/vscode/init.sh
> @@ -21,6 +21,14 @@ cat >.vscode/settings.json.new <<\EOF ||
>           "editor.wordWrap": "wordWrapColumn",
>           "editor.wordWrapColumn": 72
>       },
> +    "[c]": {
> +        "editor.detectIndentation": false,
> +        "editor.insertSpaces": false,
> +        "editor.tabSize": 8,
> +        "editor.wordWrap": "wordWrapColumn",
> +        "editor.wordWrapColumn": 80,
> +        "files.trimTrailingWhitespace": true
> +    },

I am a VS Code user, but I haven't used these settings before.

With these settings, does the editor break lines while I am typing? Or 
does it just insert a visual cue that tells where I should insert a line 
break? If the former, it would basically make the editor unusable for my 
taste. I want to have total control over the code I write. The 80 column 
limit is just a recommendation, not a hard requirement.

>       "files.associations": {
>           "*.h": "c",
>           "*.c": "c"
> 

-- Hannes

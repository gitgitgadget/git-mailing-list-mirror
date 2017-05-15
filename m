Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDED201A7
	for <e@80x24.org>; Mon, 15 May 2017 14:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934529AbdEOO0r (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 10:26:47 -0400
Received: from smtp154.dfw.emailsrvr.com ([67.192.241.154]:57676 "EHLO
        smtp154.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933430AbdEOO0q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 10:26:46 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 May 2017 10:26:46 EDT
Received: from smtp32.relay.dfw1a.emailsrvr.com (localhost [127.0.0.1])
        by smtp32.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 07A26A02FA;
        Mon, 15 May 2017 10:20:15 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp32.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8A099A0304;
        Mon, 15 May 2017 10:20:14 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 15 May 2017 10:20:15 -0400
Subject: Re: [PATCH] tag: duplicate mention of --contains should mention
 --no-contains
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20170515122331.17348-1-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <28535adf-5f8f-a43d-82e9-2ada398637e2@xiplink.com>
Date:   Mon, 15 May 2017 10:20:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170515122331.17348-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-15 08:23 AM, Ævar Arnfjörð Bjarmason wrote:
> Fix a duplicate mention of --contains in the SYNOPSIS to mention
> --no-contains.
>
> This fixes an error introduced in my commit ac3f5a3468 ("ref-filter:
> add --no-contains option to tag/branch/for-each-ref", 2017-03-24).
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-tag.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index f8a0b787f4..1eb15afa1c 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
> -'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>]
> +'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]

I think

	[--[no-]contains <commit>]

is the usual pattern...

>  	[--points-at <object>] [--column[=<options>] | --no-column]
>  	[--create-reflog] [--sort=<key>] [--format=<format>]
>  	[--[no-]merged [<commit>]] [<pattern>...]

... like with --[no-]merged, there.

		M.


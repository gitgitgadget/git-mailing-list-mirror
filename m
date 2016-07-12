Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B641FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 13:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbcGLN4f (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 09:56:35 -0400
Received: from smtp90.ord1c.emailsrvr.com ([108.166.43.90]:52868 "EHLO
	smtp90.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998AbcGLN4e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 09:56:34 -0400
Received: from smtp4.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
	by smtp4.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 282AAA019D;
	Tue, 12 Jul 2016 09:48:47 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp4.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DCD23A01AE;
	Tue, 12 Jul 2016 09:48:46 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Tue, 12 Jul 2016 09:48:47 -0400
Subject: Re: [PATCH v3 7/8] doc: revisions - define `reachable`
To:	Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
 <20160711202518.532-8-philipoakley@iee.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <5784F53E.9040104@xiplink.com>
Date:	Tue, 12 Jul 2016 09:48:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160711202518.532-8-philipoakley@iee.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-11 04:25 PM, Philip Oakley wrote:
> Do not self-define `reachable`, which can lead to misunderstanding.
> Instead define `reachability` explictly.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>   Documentation/revisions.txt | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 1c59e87..a3cd28b 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -237,10 +237,16 @@ SPECIFYING RANGES
>   -----------------
>
>   History traversing commands such as `git log` operate on a set
> -of commits, not just a single commit.  To these commands,
> -specifying a single revision with the notation described in the
> -previous section means the set of commits reachable from that
> -commit, following the commit ancestry chain.
> +of commits, not just a single commit.
> +
> +For these commands,
> +specifying a single revision, using the notation described in the
> +previous section, means the `reachable` set of commits of the given
> +commit.

Better as "... means the set of commits `reachable` from the given commit."

> +
> +A commit's reachable set is the commit itself and the commits of
> +its ancestry chain.
> +

s/of/in/

		M.


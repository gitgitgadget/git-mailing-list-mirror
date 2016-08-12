Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCA11F859
	for <e@80x24.org>; Fri, 12 Aug 2016 14:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbcHLOkW (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 10:40:22 -0400
Received: from smtp130.dfw.emailsrvr.com ([67.192.241.130]:50203 "EHLO
	smtp130.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbcHLOkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 10:40:03 -0400
Received: from smtp25.relay.dfw1a.emailsrvr.com (localhost [127.0.0.1])
	by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id AFE7DC03FE;
	Fri, 12 Aug 2016 10:39:19 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp25.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5106CC03D1;
	Fri, 12 Aug 2016 10:39:19 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.7.1);
	Fri, 12 Aug 2016 10:39:19 -0400
Subject: Re: [PATCH v5 05/12] doc: revisions: extra clarification of <rev>^!
 notation effects
To:	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
 <20160812070749.2920-6-philipoakley@iee.org>
Cc:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <c3271034-8fc5-3e29-ea1a-1c543abc7c52@xiplink.com>
Date:	Fri, 12 Aug 2016 10:39:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812070749.2920-6-philipoakley@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-12 03:07 AM, Philip Oakley wrote:
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> new
> Cc: Jakub Narębski <jnareb@gmail.com>
> https://public-inbox.org/git/578E4F4A.2020708%40gmail.com/
> ---
>  Documentation/revisions.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 3da0083..0b5044d 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -281,7 +281,8 @@ for naming a set that is formed by a commit and its parent commits.
>
>  The 'r1{caret}@' notation means all parents of 'r1'.
>
> -'r1{caret}!' includes commit 'r1' but excludes all of its parents.
> +'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.

This sentence should start with "The".

> +This is the single commit 'r1', if standalone.

That reads awkwardly to me.  Perhaps

	By itself, this notation denotes the single commit 'r1'.

?

		M.


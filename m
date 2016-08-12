Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6AF11F859
	for <e@80x24.org>; Fri, 12 Aug 2016 14:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbcHLOla (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 10:41:30 -0400
Received: from smtp146.dfw.emailsrvr.com ([67.192.241.146]:56305 "EHLO
	smtp146.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbcHLOlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 10:41:03 -0400
Received: from smtp23.relay.dfw1a.emailsrvr.com (localhost [127.0.0.1])
	by smtp23.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 31D58E014D;
	Fri, 12 Aug 2016 10:41:00 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp23.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D6AA7E0140;
	Fri, 12 Aug 2016 10:40:59 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.7.1);
	Fri, 12 Aug 2016 10:41:00 -0400
Subject: Re: [PATCH v5 06/12] doc: revisions: single vs multi-parent notation
 comparison
To:	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
 <20160812070749.2920-7-philipoakley@iee.org>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <a3acb1fe-a1c2-cc66-315d-0dffb1291e8e@xiplink.com>
Date:	Fri, 12 Aug 2016 10:40:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812070749.2920-7-philipoakley@iee.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-12 03:07 AM, Philip Oakley wrote:
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> new
> Junio's final comment https://public-inbox.org/git/xmqqwpkq6b4d.fsf%40gitster.mtv.corp.google.com/
> ---
>  Documentation/revisions.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 0b5044d..934d071 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -284,6 +284,10 @@ The 'r1{caret}@' notation means all parents of 'r1'.
>  'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
>  This is the single commit 'r1', if standalone.
>
> +While '<rev>{caret}<n>' was about specifying a single commit parent, these
> +two notations consider all its parents. For example you can say
> +'HEAD{caret}2^@', however you cannot say 'HEAD{caret}@{caret}2'.

That ^ should be {caret}, right?

		M.


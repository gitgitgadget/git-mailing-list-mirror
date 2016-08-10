Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF3B203BD
	for <e@80x24.org>; Wed, 10 Aug 2016 18:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934007AbcHJSWy (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:22:54 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:36117 "EHLO bsmtp5.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934316AbcHJSWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:22:53 -0400
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 3s8X5V5zSDz5tml
	for <git@vger.kernel.org>; Wed, 10 Aug 2016 15:27:58 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s8X4J12hyz5tlB;
	Wed, 10 Aug 2016 15:26:55 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 269405137;
	Wed, 10 Aug 2016 15:26:55 +0200 (CEST)
Subject: Re: [PATCH] Spelling fixes
To:	Junio C Hamano <gitster@pobox.com>
References: <1470732818-408-1-git-send-email-ville.skytta@iki.fi>
 <xmqqpophajqa.fsf@gitster.mtv.corp.google.com>
Cc:	=?UTF-8?Q?Ville_Skytt=c3=a4?= <ville.skytta@iki.fi>,
	git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <f4f313a0-749d-4db2-3afc-9e93ea2ba130@kdbg.org>
Date:	Wed, 10 Aug 2016 15:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <xmqqpophajqa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 09.08.2016 um 20:19 schrieb Junio C Hamano:
>     <BAD>                     <CORRECTED>
> 
>     accidently                accidentally
>     commited                  committed
>     dependancy                dependency
>     emtpy                     empty
>     existance                 existence
>     explicitely               explicitly
>     git-upload-achive         git-upload-archive
>     hierachy                  hierarchy
>     intial                    initial
>     mulitple                  multiple
>     non-existant              non-existent
>     precendence.              precedence.
>     priviledged               privileged
>     programatically           programmatically
>     psuedo-binary             pseudo-binary
>     soemwhere                 somewhere
>     successfull               successful
>     unkown                    unknown
>     usefull                   useful
>     writting                  writing

This reminds me of one occurrence of "indegee" in commit-slab.h that
should be "indegree". The word is not in this list above, so I don't
know whether you would like to have it fixed in the same patch or not...

(BTW, is that word "in-degree" or "ingredient"?)

-- Hannes

diff --git a/commit-slab.h b/commit-slab.h
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -8,7 +8,7 @@
  *
  * After including this header file, using:
  *
- * define_commit_slab(indegee, int);
+ * define_commit_slab(indegree, int);
  *
  * will let you call the following functions:
  *


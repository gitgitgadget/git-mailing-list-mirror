Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C52C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 06:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiIHG1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 02:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIHG1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 02:27:17 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B8CCD41
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 23:27:15 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4MNTgL4lYVz5tlD;
        Thu,  8 Sep 2022 08:27:10 +0200 (CEST)
Message-ID: <e6cfc04b-8f53-fb81-ea8b-79e983e46201@kdbg.org>
Date:   Thu, 8 Sep 2022 08:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Ambiguous 'HEAD' issue.
Content-Language: en-US
To:     Caglar Akyuz <caglar.akyuz@sparsetechnology.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <AM0PR08MB4323160241D4341FB1B99CC2FD749@AM0PR08MB4323.eurprd08.prod.outlook.com>
 <xmqqsflfr1y0.fsf@gitster.g>
 <AM0PR08MB432341F2A27E1133C7A31DEBFD769@AM0PR08MB4323.eurprd08.prod.outlook.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <AM0PR08MB432341F2A27E1133C7A31DEBFD769@AM0PR08MB4323.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.08.22 um 08:57 schrieb Caglar Akyuz:
> Both 'grep HEAD .git/packed-refs' and 'git for-each-ref | grep HEAD'
> commands return nothing and still 'git status' is complaining about
> ambiguous HEAD.
Are you on a case-insensitive filesystem? Does `find .git -iname head
-print` report anything that is not named uppercase HEAD?

-- Hannes

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C6C43217
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK0Ssq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 13:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiK0Ssp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 13:48:45 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF7B48E
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 10:48:44 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ozMhm-0004BZ-C5;
        Sun, 27 Nov 2022 18:48:43 +0000
Message-ID: <161a40eb-2439-bb38-6082-4379aa9be848@iee.email>
Date:   Sun, 27 Nov 2022 18:48:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: git ls-remote windows issue.
To:     Kirill Frolov <frolovkirill7@gmail.com>, git@vger.kernel.org
References: <16587f28-bd73-39ba-04da-bd0e2240f48c@gmail.com>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <16587f28-bd73-39ba-04da-bd0e2240f48c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/11/2022 18:25, Kirill Frolov wrote:
> When i run  "git ls-remote `origin` HEAD" on windows machine i get
> "fatal: ''origin'' does not appear to be a git repository"
>

Are those the right quote marks? Were the commands directly copy/pasted?
Note how the report (as received) has back quotes for the command, and
then double quoting of ''origin'' on the error resport.

> When i run the same command on same repository on linux machine i get
> "b7efcb7055a6d45f53c05270a2420aaedaba4d02        HEAD"
>
>
--
Philip

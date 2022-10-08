Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB49C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 15:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJHP2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHP2a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 11:28:30 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194076360
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 08:28:29 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ohBkZ-0004Fc-4O;
        Sat, 08 Oct 2022 16:28:27 +0100
Message-ID: <0d7707ba-5cfb-35a6-441f-06bf80053a72@iee.email>
Date:   Sat, 8 Oct 2022 16:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] symbolic-ref: teach "--[no-]recurse" option
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
 <86355292-cb54-32c8-abf5-542fb4cf9ade@iee.email>
In-Reply-To: <86355292-cb54-32c8-abf5-542fb4cf9ade@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

spelling correction

On 08/10/2022 13:28, Philip Oakley wrote:
> The existence of the `maint-xx` branches, and where they came from, was
> something that eluded me for a long time.
>
> The descriptions give the impression there is just a single main branch,

s/main/`maint`/ 
> with a singular name, and that was the end of it. It was only much later
> when some security patches were pushed down to numerous older `maint-xx`
> branches. The use of the singular `maint` is also used in examples a
> number of places further cementing the singular maintenance view.
>
> A few words clarifying the `maint` vs `maint-x.yy` branches could help
> users past the confusion.


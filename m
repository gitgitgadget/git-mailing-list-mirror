Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D400C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 12:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiCNMDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbiCNMCt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 08:02:49 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF67449264
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 05:00:04 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nTjLw-00016f-50;
        Mon, 14 Mar 2022 11:59:08 +0000
Message-ID: <e7563d48-d0f1-92d0-5f2f-e3d0d2f8d922@iee.email>
Date:   Mon, 14 Mar 2022 11:59:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Dealing with corporate email recycling
Content-Language: en-GB
To:     Sean Allred <allred.sean@gmail.com>
Cc:     git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
References: <878rtebxk0.fsf@gmail.com>
 <27b5bf20-2eb5-7873-4fdd-875aa699862c@iee.email> <874k42ar61.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <874k42ar61.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/2022 13:35, Sean Allred wrote:
> It's worth noting
> that, if we do have to use this generated mapping, a mapping of over 10k
> entries is surely to have the odd mistake every now and then.  So it's
> not *totally* trustworthy (and never could be).
I'd agree there. Adding role based mailboxes will further complicate
such mappings.

Philip

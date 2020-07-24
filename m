Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98284C433DF
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E41206D8
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 17:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=avirtualhome.com header.i=@avirtualhome.com header.b="pj/Gni5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGXRAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXRAX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 13:00:23 -0400
X-Greylist: delayed 1262 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jul 2020 10:00:23 PDT
Received: from mail.avirtualhome.com (zandvoort.avirtualhome.com [IPv6:2600:3c03::f03c:91ff:fe70:8808])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34814C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 10:00:23 -0700 (PDT)
Received: from Peter-MacBook-Pro.local (pool-71-121-249-37.bltmmd.fios.verizon.net [71.121.249.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.avirtualhome.com (Postfix) with ESMTPSA id 695C917589
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 12:39:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.avirtualhome.com 695C917589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avirtualhome.com;
        s=mail; t=1595608759;
        bh=l/VhLqsxADRNp3Jk/ofXa6zCzU3oqrgmlTNRSupEke4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=pj/Gni5rIzi8TooSdrLkUQ45y9dz+nGTnWJ4sNMFJ0jXBSPpFHd9HKoWtlXI49njP
         Gca9TM+bb6BGnwyBeGsXD6GWsuwbW86j5BWsf2Orj7X1hJU4InpmO478RsPJS4yQk5
         ymN8dY5XpaEZNFphxJA5NcuT6PhGnC93U8UUW/jY=
Subject: Re: Trying to update GIT in Ubuntu 18.04
To:     git@vger.kernel.org
References: <CAO-dU=fQZ6YVk1rWw_Tc8YT-i_zH7-hw3GATXmf7hwaqqC3j4Q@mail.gmail.com>
From:   Peter van der Does <peter@avirtualhome.com>
Message-ID: <a34ec07c-650e-5410-dbfa-accdba2944b6@avirtualhome.com>
Date:   Fri, 24 Jul 2020 12:39:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAO-dU=fQZ6YVk1rWw_Tc8YT-i_zH7-hw3GATXmf7hwaqqC3j4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/20 4:12 PM, Matthew Glassman wrote:
> My git version is listed as 2.17.1.  If I try to just do sudo apt
> install git..It will tell me I have the latest version and this is
> after running apt update.  I can not get the PPA to work because there
> is no GPG Key to input and thus Ubuntu will automatically keep it from
> use due to insecurity.  Can you please advise me on how to best update
> GIT to the current stable version please.
>
> Regards,
> Matthew


For the latest version use the PPA, found here:
https://launchpad.net/~git-core/+archive/ubuntu/ppa


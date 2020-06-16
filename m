Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A651C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A1420786
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whinis.com header.i=@whinis.com header.b="gRcKfzbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgFPO3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:29:22 -0400
Received: from whinis.com ([198.205.115.165]:40572 "EHLO whinis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbgFPO3W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:29:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by whinis.com (Postfix) with ESMTP id E269E7C2F17;
        Tue, 16 Jun 2020 10:29:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whinis.com; s=mail;
        t=1592317760; bh=C9Na4PXOTePbcDWN/0x73VSsyNwBz6K0lY4nBSA7qos=;
        h=To:Cc:References:Subject:From:Date:In-Reply-To;
        b=gRcKfzbqXHMf2iFRZmR9wyTb+iY6JJs/VZ53fONuKJRj3pcFjwQ489nRkTBzcqP2k
         iSqG4mAOM8phzUuIJljhP+LKY86vnGHlGAHZcmzGcAibHuj+6aHGeNQSULs+qoq3xN
         nfV3nX64XdjneeH46KQCwSYFdw0icrpxg7aTyHmM=
X-Virus-Scanned: Debian amavisd-new at whinis.com
Received: from whinis.com ([127.0.0.1])
        by localhost (asgard.whinis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lhPoIRp9EZCq; Tue, 16 Jun 2020 10:29:19 -0400 (EDT)
Received: from [192.168.1.117] (c-73-139-109-188.hsd1.fl.comcast.net [73.139.109.188])
        by whinis.com (Postfix) with ESMTPSA id 748AF7C200E;
        Tue, 16 Jun 2020 10:29:19 -0400 (EDT)
To:     msuchanek@suse.de
Cc:     alexsmith@gmail.com, don@goodman-wilson.com, git@vger.kernel.org,
        gitster@pobox.com, konstantin@linuxfoundation.org,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
References: <20200616141441.GH21462@kitsune.suse.cz>
Subject: Re: Rename offensive terminology (master)
From:   Whinis <Whinis@whinis.com>
Message-ID: <db005e71-d74b-ce31-afba-50328445fc3a@whinis.com>
Date:   Tue, 16 Jun 2020 10:29:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616141441.GH21462@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Have you even read what the proposed change is?
>
> It allows changing the name of the branch that is created by git init
> using a configuration variable. Nothing else.
>
> It is also proposed to change the default for this variable in a future
> release of git that is expected to have far more disruptive changes,
> such as different hash used for commit IDs.
One is a rather massive change presumably to prevent collisions and fix 
a potentially catastrophic failure of a repository, the other could 
introduce rather massive breaking and disruptive changes..... because? 
Trying to downplay that its just changing the name is rather 
disingenuous especially with how much it is changing. Its not a simple 
rename and breaks a base assumption which is not something that should 
be done or allowed lightly.

Comparing disruptive changes that are to maintain the actual use and 
function going forward of the software and one that appears to be fueled 
solely by an emotional drive without any articulate technical merit so 
far is an odd choice to make.


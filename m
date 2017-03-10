Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EC161FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 21:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbdCJVN7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 16:13:59 -0500
Received: from forward5m.cmail.yandex.net ([5.255.216.23]:56662 "EHLO
        forward5m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750897AbdCJVN5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Mar 2017 16:13:57 -0500
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::25])
        by forward5m.cmail.yandex.net (Yandex) with ESMTP id 9D945206BE;
        Sat, 11 Mar 2017 00:13:54 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1o.mail.yandex.net (Yandex) with ESMTP id 888D61300F15;
        Sat, 11 Mar 2017 00:13:51 +0300 (MSK)
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id XcyCrfy2xI-DoRGqAlV;
        Sat, 11 Mar 2017 00:13:51 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489180431;
        bh=uEjh2lBXMPeSJROn+gjbTJvo9Muzfex0H5fx7UB0NcY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=cHIMOAqnn16K7wqwp4XO+6pO4jpTBMmaoHnWJIvsYOtNSffl6JooufqYKKslS9Li1
         WuPL2+INlbvgBzlVW+qOTf2jqAo7WjIfCT25Meu/9XU6rxK4MuJb2j1TOXisymlSQ5
         +4x8YlZEwr6BJR4CCDsPTBb3UKTusJwpm6DMcCYE=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com, bmwill@google.com
Subject: Re: [GSoC] Discussion of "Submodule related work" project
Date:   Sat, 11 Mar 2017 00:13:48 +0300
Message-Id: <20170310211348.18887-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <20170310193040.16816-1-me@vtolstov.org>
References: <20170310193040.16816-1-me@vtolstov.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This means I can take only any one of them as starting point for
> my proposal?

If it is true, than i'll try to take sh->C transition for submodule
command, and as addirional part of my whole project also this:
https://public-inbox.org/git/1488913150.8812.0@smtp.yandex.ru/T/

>> Have some questions about "Submodule related work" project
>>
>> First of all, I would like to add this task to the project, if I'll take it:
>> https://public-inbox.org/git/1488913150.8812.0@smtp.yandex.ru/T/
>> What do you think about this task?
>
> That is a nice project, though my gut feeling is that it is too small
> for a GSoC project on itself.

Does it sound good? If does, then I'll begin to work on my proposal.

Thanks,
  Valery Tolstov

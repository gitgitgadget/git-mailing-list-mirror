Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157CF20285
	for <e@80x24.org>; Wed, 30 Aug 2017 14:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdH3OS3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 10:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdH3OS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 10:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73B677E433
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 14:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 73B677E433
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=fweimer@redhat.com
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D0B198151;
        Wed, 30 Aug 2017 14:18:24 +0000 (UTC)
Subject: Re: Produce contents of index with existing directory as cache
To:     David Lloyd <david.lloyd@redhat.com>
Cc:     git@vger.kernel.org
References: <5a9e4efd-8c48-487e-4a9f-9362a944c992@redhat.com>
 <CANghgrS9hZyA4vWU=4PZuYue3iLsLx7ObbT_VgRGSXpACwNkcg@mail.gmail.com>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <df9cb4e8-13f7-54b9-b737-be4e56977867@redhat.com>
Date:   Wed, 30 Aug 2017 16:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CANghgrS9hZyA4vWU=4PZuYue3iLsLx7ObbT_VgRGSXpACwNkcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 30 Aug 2017 14:18:28 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30/2017 04:15 PM, David Lloyd wrote:
> git reset --hard ?

That doesn't remove unstaged files.

Florian

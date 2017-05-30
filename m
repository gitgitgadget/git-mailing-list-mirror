Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B6F2027C
	for <e@80x24.org>; Tue, 30 May 2017 12:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbdE3MdL (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 08:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdE3MdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 08:33:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EEFC61B8F;
        Tue, 30 May 2017 12:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 2EEFC61B8F
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=lersek@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 2EEFC61B8F
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-87.phx2.redhat.com [10.3.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 909F9183E6;
        Tue, 30 May 2017 12:33:09 +0000 (UTC)
Subject: Re: FORMAT_PATCH_NAME_MAX increase
From:   Laszlo Ersek <lersek@redhat.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
 <CACBZZX5U=U1bpiFuuxH2t8ZWnmQQAjWm1ji8XYq_6-SJPGL1sw@mail.gmail.com>
 <c2453701-979b-ebc7-dcc3-483a27d4c157@redhat.com>
Message-ID: <85970ab4-e9c8-c6b6-11d3-faafd3ed0708@redhat.com>
Date:   Tue, 30 May 2017 14:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <c2453701-979b-ebc7-dcc3-483a27d4c157@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 30 May 2017 12:33:10 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(apologies for the self-followup:)

On 05/30/17 14:28, Laszlo Ersek wrote:

> Note that in such an incremental review, I specifically wish to compare
> patches against each other (i.e., I'd like to see diffs of diffs, AKA
> interdiffs), and not the source tree at two, v1<->v2, commits into the
> two series. The latter would only give me the difference between the v1
> and v2 patch application results, and while that is valuable as well,
> I'd really like to diff the actual patches.

... One (but not the only) reason for that is that I'd like to see the
v1->v2 commit message improvements as well. I quite frequently suggest
commit message improvements in review.

Thanks
Laszlo

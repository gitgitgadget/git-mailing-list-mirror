Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8B51F424
	for <e@80x24.org>; Wed,  9 May 2018 12:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934731AbeEIMPU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 08:15:20 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeEIMPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 08:15:19 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0Lk8eg-1eihwZ20lu-00c7Uo; Wed, 09 May 2018 14:15:13 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 3678A64A3C0;
        Wed,  9 May 2018 12:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N_IrG6WKf5WV; Wed,  9 May 2018 14:14:54 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 73B60647B9B;
        Wed,  9 May 2018 14:14:54 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 14:14:54 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 1E6BE804D2; Wed,  9 May 2018 14:14:54 +0200 (CEST)
Date:   Wed, 9 May 2018 14:14:54 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: do not limit tree mode listing in the file list
 panel to current sub-directory
Message-ID: <20180509121454.v4y4av3sk7nh4hnn@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari>
 <20180508122256.nyv6ddcoifygfpk4@pflmari>
 <CAKPyHN3YMU3oZaW-wR2ZMV6aMwoeFGMmiJBQXtvipVvkWPLZVQ@mail.gmail.com>
 <20180508133905.6jhhhp6l7avjkctl@pflmari>
 <CAKPyHN1bGtCBZUh7cDAN-t+5DTutvyL6FLwynALTGZA5ijqwrA@mail.gmail.com>
 <56ccabf699cdc6e15c5dcb73db5692180c79906d.1525863290.git.raa.lkml@gmail.com>
 <CAKPyHN0iQh=UJOX-8u4PO1ON9SW+G1gBCGh25FJ_RyoGk906QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAKPyHN0iQh=UJOX-8u4PO1ON9SW+G1gBCGh25FJ_RyoGk906QQ@mail.gmail.com>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:RIz9rNAesidfUbjLHxaxrxIYcZp9RCKUWQlEQD59Z0Ak/uZ80Mf
 2L5Gm1Xo/vvq/GZGkCPpgcfu1huWd1xVq8skuYT5S5g5bIn/RngR1zxf7Eq+iZSIYrza2BO
 62Izn9DdxW4gTxm+geR7Quvj/2kAvNf/BklplEtk5+Nj93KiF38kmJC/JhPbuWhXOd7PilL
 PjY/lLFM03iMFqjcLOkZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z01XEolLBmQ=:kC4InKdWkS96U6c9A5pO/M
 WTS/n8LeEOpb2SJxG+9reaPOADig3pBSCD3IWw8VKupiGNWvvF+x0bO7tG/hqF6O+SIbA61s0
 sscFcKHZgzrOF4gJXlfHENZDsEZDvbq3zctBI+3X9AH1A80GINvVDIk9RS2YxGC72KqmMAi5y
 hiqhGX+vJPz5Ujg2RisHLb6UDZo4h2x1Ulcx6VdrSYmKuQK4tVdJsPgOv2+1J5TMoes1S5Iix
 WrFKthYlrlDlRtUCsEPUad5yZ53WqahnaiiAg2puUTZiIjRBtvi3+d5HMRpFCylSUeRoWar0u
 BT37XWmOHWbgv8+gvRerI4ozSu3Zs9cOZjOJYU2KW1FkP8xJw5w590/PrY+Bt4UDSKppM5GpA
 CzUmyOBFUJkqPKZRlAGUtOITq+m7ohnxsUSHRQQYb99AmexorgS/LqZQCi9cXM9tp0LpmyM02
 QdUY7fzAVi/CrEfsokmjiOGmTwudh9k42QiqEjaKlX6odul5rPM8v8Dyv1tyD6H4GNO+rbq1E
 59nafAyEoF7FYcmz0q3QP+/FKeEuKj4zuJJpe5CrRCdWZsB1PQ3O9BEf7fUqWRIz0v71MTvtx
 MilKQgQi+QZvPNdMTQxDXvYqtnPRUHKWJ+8vz/Zqxnif86wxlmRzB5R2z/dZr6pD8F6RWDaQy
 1mzh01ZQmsMokjTHGyUtFxSsIlJiENyJyHbFCalo6JYZi2chGt46C9bj5nzoFjdEhx4Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg, Wed, May 09, 2018 14:08:51 +0200:
> >> I noticed that too, while testing your patch and I'm also confused.
> >> But was not able to send a request to Paul yet. ls-tree --full-tree
> >> seems to be one that should be used here, I think.
> >
> > Well, I just tried your suggestion. 'ls-files' doesn't have --full-tree, so
> > for those it is just cd-up.
> >
> > It is on top of the re-sent series.
> 
> I would consider the current behavior as a bug, therefor I would put
> this patch first, and than your other fixes/enhancements.

I might do, just want to hear more opinions on the matter: someone might have
good reasons for the current behaviour and consider a bug the fact that Patch
mode behaves differently, for instance.

And as I completely screwed up the resend of the series, there will definitely
be a re-resend.

Regards,
Alex

---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus


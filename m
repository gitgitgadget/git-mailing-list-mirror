Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577B8C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 10:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382E3611EE
	for <git@archiver.kernel.org>; Sun,  2 May 2021 10:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhEBKNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 06:13:37 -0400
Received: from mout.web.de ([212.227.15.3]:46313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhEBKNg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 06:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619950361;
        bh=LbTeszyhXBw4UlVJdsH39DX90LHxK3d4o+V4csZCNSU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EYD+qdcO7DwqN1/hNChvxSjw6OGncbtBW9lx8Hvs1Avt6UQmxDHO1W+AIMDvD9q6Z
         OmZoFh3QSWSstgr+aZ/V4Bz4zhMjoM1HsQYceJUmvVtoWyJxg1cQ8WkgafisSRUXoC
         XTIfSSs0p8nuqId3ozLqzFbkwGSUespmBcV0iHaA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPpD8-1lgyZW3j62-0052YE; Sun, 02
 May 2021 12:12:40 +0200
Date:   Sun, 2 May 2021 12:12:39 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com, stolee@gmail.com
Subject: Re: [PATCH v2 0/8] Parallel Checkout (part 3)
Message-ID: <20210502101239.dyevkjcp7jzov2rd@tb-raspi4>
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <cover.1619818517.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:5TJjta6Onca8Svyyd4HTbcgRmxRLOb/yHa3Xclf2hJ6uPz+SpY+
 NSXYMSXkELiccJiMZRPtNkj/R0QAXXwzRarL49A/n85/uVTGtnZsrhwytBAS0WQVTyXTI7O
 OK6m6/WzMsdvDI5/9l3utGdqTzc6lzjZgrGxWyOReeEIataMsZ3fRm4509v+tzh84h0THPI
 SAkYStZM8FQ97KqGxueyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5fshnTlCfNM=:lqoX8vyGZGNQzPRvcvn5ME
 cFH+BpPrp6PNXsRHU7L9NqlnWWjuobr0m08FovrJcOwboMwNKVGDf62hmIZKHtEN9WY7rNdFD
 XXDt/DGbV1SOAAOwWseNK5Lb0f52GVlSIAWPfv/BKBfidJ4ItvypGduik6UmESW9K+EtiMdbA
 USE2FiVGCLEUBLSIy32WjBZ7plTp0tZSMfL29CP4eSc9lvYXPg+hP64XTJDiyvCBvg6UYYuzO
 /XbBEwJqQ1pQgcztwM/UT0LrwhkLKTdkeFtxGCHFGc9bxYCW3TNK2/DGwtl233klO9P4tCnE8
 35rShOoOIyUIrnkF6XcFR9sNc8celRQ4KZv/BGsuKfbzGm4nRx2VRCQaxWpExLY784Koz9vwB
 GHj0g6q/Bf2sN1kQ7sNFh8dt/r4R2mp1TdKBGYj4mimj/+8lh4Jzv3zktkH62HBkuwmhZ9L7Q
 iVxeqUNOW9jh5cbHNNQLRjoi1+4H6xvDocBeNWi2gQ9F/Rj17iM5BKXJZ/BpEv9YaDl2P88SN
 vMWx17hIHw7MxVNDT77dGwmTFuo8vi6+nLOZJ3RQVPN3lLmg+NYel8M9ZdSZEjKLQrTgTLd2q
 J0NkjShkc5RjwDAJffRQP+sdXNoPSCKyEsqURqbwjUIuwJWpeKXRdPJsx6lVwSY9c2e2LGa1J
 c5r4Xab/o4Wlu4cv7PiaSKRWVQSbWK1j745nDJEXRHNbUNpM/ylAYQvk3mr1x49I5pYjHIuNR
 liezJhRPgHn7JEcSwVOM9tmd4/Lv/SxnYXITrMm5ItzqZg44c9vBgHh4e1Tc8Odq+ZmlYuzsp
 iEZPrtiugrjKeCKRNUnz2fzguC245MN6fsKYWZNhMWDE5id15H+2vT+IsmtfqETi4Khqn6AUj
 dTus6G6YRsmpbEPZshorx20I4njSdtVtFf5pyYWtwiVIMglTNRSGZV0XEmdjEfnhciYS7YPm6
 MW822OMHe5m1T88BvRNZktICuysw/P9xaEz2Cw0kICX/+f36Fv9R4LQnEXBzy9VO/Jeq6uj8T
 d68Es/Cjo93tAq1WF+paq+6sGFbChlM6ivGHGNyqY7JijHjwwlAo65BFfVsqKCyX/p2ZHyO1z
 hyxEnXx3lqgu+J7FTuLV1xmd52Xrvg+kNprJ0P2PTQnfo7NTXIb8Rssjc3rUY2QMS+sv/cxqU
 YDRXfKJ+5iyPlLp7Mf0ynqZLI9cHSu3vFE1Y5EbNEZfrq9Fv/uc5xN3IAXSgfqJVGZsUc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 06:40:27PM -0300, Matheus Tavares wrote:

[]

Thank's for the work.
I just make a quick test:

"swapping" git.git between

HEAD is now at e870325ee8 The third batch
and
HEAD is now at 7e39198978 The thirteenth batch

On a Desktop running Linux.
Using the git.git repo, mounted as nfs on an oldish NAS
with spinning disks (and WLAN) gave this timing:

git -c checkout.workers=1
2 minutes, some seconds.

git -c checkout.workers=4
1 minute, some seconds.

git -c checkout.workers=16
40..44 seconds

Not a scientific measurement, just a positive feedback from a real-world.

Good work, I'm looking forward to have this feature in git.git



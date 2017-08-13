Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B60A1F667
	for <e@80x24.org>; Sun, 13 Aug 2017 18:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdHMS1d (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 14:27:33 -0400
Received: from vie01a-dmta-pe05-1.mx.upcmail.net ([84.116.36.11]:64502 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751119AbdHMS1d (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Aug 2017 14:27:33 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dgxbn-00025h-Qu
        for git@vger.kernel.org; Sun, 13 Aug 2017 20:27:31 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id wiTP1v0175BuuEg01iTQzh; Sun, 13 Aug 2017 20:27:24 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 75F4845D4512; Sun, 13 Aug 2017 20:27:23 +0200 (CEST)
Date:   Sun, 13 Aug 2017 20:27:23 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
Message-ID: <20170813182723.GB31079@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <20170812095915.GA5768@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170812095915.GA5768@tor.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2017 at 11:59:15AM +0200, Torsten Bögershausen wrote:
> Thanks for working on this - unfortunatly the patch does not apply on
> git.git/master.
> 
> Which baseline did you use ?

next - 98096fd7a85b93626db8757f944f2d8ffdf7e96a
It accumulated to 19 patches.

Regards,
Martin 

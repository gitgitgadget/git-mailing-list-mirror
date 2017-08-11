Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC04F208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 07:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbdHKHMs (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 03:12:48 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:33664 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751691AbdHKHMs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Aug 2017 03:12:48 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dg47i-0006HT-6P
        for git@vger.kernel.org; Fri, 11 Aug 2017 09:12:46 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id vjCk1v01c5BuuEg01jCloE; Fri, 11 Aug 2017 09:12:46 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 88B1145D4512; Fri, 11 Aug 2017 09:12:44 +0200 (CEST)
Date:   Fri, 11 Aug 2017 09:12:44 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH V2 2/2] Convert size datatype to size_t
Message-ID: <20170811071244.GC15128@mail.zuhause>
References: <1502348462-4992-1-git-send-email-martin@mail.zuhause>
 <1502348462-4992-2-git-send-email-martin@mail.zuhause>
 <xmqqwp6b13lo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwp6b13lo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 03:04:51PM -0700, Junio C Hamano wrote:
> Martin Koegler <martin.koegler@chello.at> writes:
> 
> > For next. As this touches core functions, it will likely produce
> > conflicts with other changes. Please provide the commit you want
> > to rebase the patch on and I'll produce a V3.
> 
> No matter what base you pick, by the time the series is merged with
> other topics in flight to form an updated 'pu' branch, any series of
> this invasiveness will cause conflict.  

I don't have time to track all changes floating around on the git mailing list.

If you want the some of my patches based on a specific set of commits, please ask for it.
I'll try to rebase my patche(s) on it.

Regards,
Martin

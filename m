Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0DB320248
	for <e@80x24.org>; Wed, 17 Apr 2019 05:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfDQFmx (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 01:42:53 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:42937 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfDQFmx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 01:42:53 -0400
Received: by mail-pl1-f171.google.com with SMTP id cv12so11490241plb.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 22:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kEaaj9dkKcqKTkWKBmOUTHNLphxK2fNiv2WXsrBvj2Q=;
        b=dGd34Pew+HR+0s/T8Tx9fAChzPIa4Gc0ATwL7H+l4d+4Ll05+Xhc/dp5VnlN1DBT/j
         bHp9iZoG9ndau9xF7cfXtni4oGmE7zaUP2qypMLHZYWMH94x250U0yHYlLtREoiapoJ8
         dl2njHNe8UteVFxx93Nd1y5VXKi3Ku8tulPDh0pDfoUCOt3QL7VunUp/WD+Z0iXlhHXT
         7TraKSiLRrknghqArhFrBG+jjtVDWkSGc1i5ShKqs+TKK0+leqITMFl/PCtSM42YxXn5
         7ySODG9qhaqrdROgctg7K4qGAXR+cryRoFu4Ngr7070tcfUB1BTmvPK1XDevBsKu701q
         5nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kEaaj9dkKcqKTkWKBmOUTHNLphxK2fNiv2WXsrBvj2Q=;
        b=sz+WCFJC2H6H2IbasFKGwMU193b7/s1y4pmubIQdx/RDo1JnlV3jQMjk+7Y6ab5T80
         tHnteeQ1A52EJIR3v/W6Yjtc+LL32PtcYSHFz7yeVr7wO8FtmywgVhfLVElXwTQ4yQ/6
         xSR4q4LnhJwR7dD9ZHp8dtL8CWcmAKXH9Me4V6NWRisNWNjJUpqhl9DIKnxDOJLkuSMK
         QU8iw/hYd4PV9/5M8MIAcNR4PnDcq14y3FZaCjKC9BTnKrl5oDKCNEIj5LwoyXyCxLid
         3X2Q2CUTNUGlZmg59gUx1JcFTNV19u2rnx0B9Q8EuEqy0ovJf/rFTHxDfRacnPoGAgTM
         pplw==
X-Gm-Message-State: APjAAAWrV4jJyShLxMX7g/MnoOLlRBkMi6IWGohqePBo9jTrJBz2Qgj/
        i88MMs8GuD1y8aE0ERxLd2qZXAbwIByJZg==
X-Google-Smtp-Source: APXvYqxBg5z4Lmb7GK1aoYpAD5Xf2OM39m9sQ4aTZ5aUZHRZ8GVX6b6M5bB3eXnIlVSOy7VnpFoBLg==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr44816923plp.157.1555479772541;
        Tue, 16 Apr 2019 22:42:52 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e0dc:83cd:66cb:9fa7])
        by smtp.gmail.com with ESMTPSA id c25sm76865895pfo.69.2019.04.16.22.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 22:42:51 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 16 Apr 2019 22:42:50 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
Message-ID: <20190417054250.GA98165@Taylors-MBP.hsd1.wa.comcast.net>
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
 <20190417023706.GA86159@Taylors-MBP.hsd1.wa.comcast.net>
 <xmqq7ebtkx7p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ebtkx7p.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 17, 2019 at 02:38:34PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Hi Junio,
> >
> > On Tue, Apr 16, 2019 at 10:19:45PM +0900, Junio C Hamano wrote:
> >> * tb/unexpected (2019-04-10) 7 commits
> >> ...
> >>  Code tightening against a "wrong" object appearing where an object
> >>  of a different type is expected, instead of blindly assuming that
> >>  the connection between objects are correctly made.
> >
> > I sent a re-roll of this series in [1], which should be ready for
> > 'next' if you feel comfortable queueing it.
> >
> > [1]: https://public-inbox.org/git/cover.1554861974.git.me@ttaylorr.com/
>
> That's this one
>
>     Date: Tue, 9 Apr 2019 19:13:06 -0700 (1 week, 3 hours, 23 minutes ago)
>     Subject: [PATCH v2 0/7] harden unexpected object types checks
>
> which I think is what has been queued and what is listed in the
> message you are responding to.

Ah, perhaps you could clarify some confusion I have about the "What's
Cooking" emails (or at least point me somewhere I could un-confuse
myself).

This topic is in the "Cooking" section with a "-" (which I recall means
that it's in 'pu'), but there is no "Will merge to ..." line below it
from you.

That makes sense to me, but I'm not sure whether or not that means it's
queued. Do you say that a topic is queued once it's on your pu, or once
you have written "Will merge to..."?

Thanks in advance for your clarification.

> Do you mean you have even newer ones?

No, those are the latest.

> Thanks.
>
Thanks,
Taylor

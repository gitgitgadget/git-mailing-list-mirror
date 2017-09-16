Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE6020A21
	for <e@80x24.org>; Sat, 16 Sep 2017 11:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdIPL7x (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 07:59:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35534 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdIPL7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 07:59:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id j16so2683591pga.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=Jo6WXdAVnyz6e24oLvNXviZ5IvJ5N42FxWD/rvTU0+Y=;
        b=fAy6Mx4pv0oqESwXvg90X/yXdIrFQ0BGwgL3Uz1VjFYXfdvs3u8CvxdzHsYrjlHGOn
         pHpHtz1d+iGVRepRndtP9EgKL3qiaNq2gyslXkQ8CCF2iAj5W0m1QT1YDXBGo4XawQor
         Z05uB3ULs408eNHrEM3D6n91p1Ccn20XZ7zv0RT+mXNW7IYELOuKZdlQUA0Ubm2KgjcH
         +tBjQqcTNxKj4ypH4Brz+M1uC/NwKMWuAJgcEj1nRby+VEykVOuCImqSx4PRE0YfC1vE
         b6H11R1zzG8H/bYV+aKOBCfDIexR6LgFkLeF5XRnTW0IYEST2XI2qqPO8LSbsR+qRAMw
         VDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=Jo6WXdAVnyz6e24oLvNXviZ5IvJ5N42FxWD/rvTU0+Y=;
        b=SPtactEQKaTJmAgcMbVPICxidj0p2sZFhf3rNB8Fa1/NWDPpUtskOMZPlLAttXJAnP
         gM3jJ1Dcxe7uome3pvSo0GGXxVyPQ+7CXJ1+SdWPniHsg3GrfuiU3cEv0A33kptN26ox
         ecbR/6qpIT9xnzi0xsWit4KiDLE+DlLw09fRoMxIAIl6n67FJKYZadqYXs4+UCeWg/Re
         YDqh6khrNSjOhi7YapVpIdN/PvN1y8WH+1B93yomJ5s3AL6iJlO9YA1r2++1q4JCTShR
         jVkes7ZJ+CzXD5HlKOkrWdCdZubcqMSqz+ULzt3oOypxqroqM6TWhYdqleZCqJql8DDZ
         VaiQ==
X-Gm-Message-State: AHPjjUjf5cjaAdO8tkmjPcbSsZuxTtpRUNmugriGgsAMpUI+EnJ0SBkP
        LEBYXwi+blBfJnKaDB4=
X-Google-Smtp-Source: ADKCNb7bgbILy/XHjlCuIa2R/ClmpRr5aQT/2Cp6wvWaxaiBixe3bRmJEvT6WHrejUT6wacmjiqk8Q==
X-Received: by 10.159.207.132 with SMTP id z4mr30393978plo.95.1505563192065;
        Sat, 16 Sep 2017 04:59:52 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id k27sm6425012pfk.20.2017.09.16.04.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 04:59:51 -0700 (PDT)
Message-ID: <1505562455.23153.3.camel@gmail.com>
Subject: Re: Are the 'How to' documents present as man pages?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     git@vger.kernel.org
In-Reply-To: <20170916085402.pc2vnimymien355n@ruderich.org>
References: <1505538043.21890.4.camel@gmail.com>
         <20170916085402.pc2vnimymien355n@ruderich.org>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 16 Sep 2017 17:17:35 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-09-16 at 10:54 +0200, Simon Ruderich wrote:
> On Sat, Sep 16, 2017 at 10:30:43AM +0530, Kaartic Sivaraam wrote:
> > I was reading the 'git revert' documentation and found the following
> > line in it,
> > 
> >     -m parent-number
> >     --mainline parent-number
> > 
> >         ...
> > 
> >         See the revert-a-faulty-merge How-To[1] for more details.
> 
> Square brackets indicate links, you should have a NOTES section
> at the bottom of the man page which contains something like this:
> 

Yes there is, thanks!

> References to other man pages generally use round brackets, for
> example git-merge(1).
> 

I didn't know they had different meanings for different brackets in man
pages. The asciidoc source itself uses square-brackets to refer to man
page sections. May the link to notes should be something like [note 1].
Not sure if it's possible to do that.

---
Kaartic

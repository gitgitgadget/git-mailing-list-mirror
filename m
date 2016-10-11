Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C681F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbcJKUcS (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 16:32:18 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35674 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbcJKUcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 16:32:17 -0400
Received: by mail-wm0-f51.google.com with SMTP id f193so7784824wmg.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GF4FjVHQLuzD2r8S3OoB8rQ7/yqbxPMsA50guITT6Uo=;
        b=cH2nCJ4AwWWaIedDGFy+qDy6keAMzc6pNITFE0doRgZp9Muo18AyJBBmoERs+VwNRx
         RTrYNzJvhHcCeIWv/Ml646p9gGYroHaUZeQcJ4T3AXTMeHZszsdYgPmp58p2UwhmCBWq
         25Jo9w3fCnpc0uApI3jHRHb1adWeJTwrEu1n+TXPqi6f1842DzloKL0+R7km4x7QAmnt
         ymNhf7hXFX2mi2hNnD0ZrYgxfae6QMqXXP3a6d8yC77dSsAZJJymBE/pmN1gQsXdqW2D
         9hCfmucGHNBTzsX4yGmQ+ciqAZh9fFGNFahYrAlOwbXE5vt4hQ8rHk9rJBBVT7ZU2ObV
         H+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GF4FjVHQLuzD2r8S3OoB8rQ7/yqbxPMsA50guITT6Uo=;
        b=TNCSIgCv3rg8mS06R7nnYddgOpRRTjR8IZq03OVPPdi02OFlEapR2d4FIjwHIpmk7u
         od3/jK7JmRKxK47h9h47d8N5ChprKsYR2IDfl+0it1diGq3o+puBqESIyTrIr/2/D/1+
         5qWK3D5SUM0BsOYbILqeVNZuMpFgz+75xdcxqu3Bu4LozlqQOT4mMR/RHaq90N42QsDX
         PtZe3xldeCsDFUkLSHYDS9xBzrsGCWRZYC0Srthz0XPYm6M95VA+ZZ2nX6diAuHoDJoG
         XtQbB0NeutCUWFYyesNvFe/uaHj0tt8G9M9Xsrb9UujA8rr6qSIBx+KJV+G8NlWfdxU0
         Oifg==
X-Gm-Message-State: AA6/9RmzHAjGl1qDAnEbH++AFy/oJ/MTY9DXT+x0/pSa4R8OpX+3xuZCXa0JMqSOhcxV3w==
X-Received: by 10.28.4.13 with SMTP id 13mr419620wme.92.1476217936047;
        Tue, 11 Oct 2016 13:32:16 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id r1sm8811768wjc.43.2016.10.11.13.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Oct 2016 13:32:15 -0700 (PDT)
Message-ID: <1476217934.3876.12.camel@kaarsemaker.net>
Subject: Re: [PATCH] contrib: add credential helper for libsecret
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
Date:   Tue, 11 Oct 2016 22:32:14 +0200
In-Reply-To: <xmqqa8ea8wzy.fsf@gitster.mtv.corp.google.com>
References: <20161009123417.147239-1-grawity@gmail.com>
         <1476198080.3876.8.camel@kaarsemaker.net>
         <xmqqoa2q8ypl.fsf@gitster.mtv.corp.google.com>
         <c87e4dd4-7253-d7c2-010b-6d8c7f587093@gmail.com>
         <1476216585.3876.10.camel@kaarsemaker.net>
         <xmqqa8ea8wzy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-10-11 at 13:13 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > On Tue, 2016-10-11 at 22:48 +0300, Mantas Mikulėnas wrote:
> > > On 2016-10-11 22:36, Junio C Hamano wrote:
> > > > Thanks for a review.  I'll wait until one of (1) a squashable patch
> > > > to address the "we do not want unconditional overwrite" issue, (2) a
> > > > reroll from Mantas to do the same, or (3) a counter-argument from
> > > > somebody to explain why unconditional overwrite is a good idea here
> > > > (but not in the original) appears.
> > > 
> > > 
> > > 
> > > I overlooked that. I can write a patch, but it shouldn't make any
> > > difference in practice – if c->username *was* set, then it would also
> > > get added to the search attribute list, therefore the search couldn't
> > > possibly return any results with a different username anyway.
> > 
> > 
> > Makes sense, so a (3) it is.
> 
> 
> So... does it mean the gnome-keyring one needs a bugfix?

I'd say both behaviours are correct.

When you do a search without a username, both helpers fill in the
username returned by the actual credential storage. When you do a
search with a username, the gnome-keyring helper won't overwrite the
value passed in and the libsecret helper overwrites it with the same
value, as the search can only return matches that have the same value.

D.

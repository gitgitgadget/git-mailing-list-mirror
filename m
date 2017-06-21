Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CC620401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbdFUVTO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:19:14 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34370 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdFUVTM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:19:12 -0400
Received: by mail-pf0-f170.google.com with SMTP id s66so90468071pfs.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tIVowW5NRkLOHz391G/z16u4MV04qtBr5QhcmsXp+0Y=;
        b=me+5INKRZWPwj/+5tbkt1r/i76s0cEI7pmvg+OrKDP91nGK46FK4GE4AyykC0aQPBK
         jHscAwWD+eJ/2JIQmNvaDWZokcHf3RW8v2K3WhSeS7GWe+whfgMB64hMeRnE6euUtGwu
         UI+2+d1rpRDPxMIXZ5uh5qJm1HPzMMFng7DRgdiEaolJLAsoVzJ1XBJAh6ammwN+MFVE
         ZqQRb284r5r3Thq0Ac5mRB7PXK1M4+FrqRr747HpisQH05JCMXHFfxZV2J3MMvVr8++E
         mZ5aKxlMwLNIti1gfJSecqRWH2mMaU0bteSqHBl/rd8MEyDqipPQz2dRRBFeH68MGKp+
         VG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIVowW5NRkLOHz391G/z16u4MV04qtBr5QhcmsXp+0Y=;
        b=hISOb1E9apXzeBXL6QxTVMWjzgfK+O3WahWjpbldWTR6GMquMO0G/dR/h6W/Gis4jA
         UAGzRjMJl2sVx0QnpzLTk89BreK8fj3ABCVCFoyFR6Lg+Hkb7km4SglBcZDayluksBLF
         BAPujb+D4AuXAAk/ARP13EB2pV9JFYwjGco28kFbbiDxnbyI6OFaCyw4ZDNEl7tlxZ1m
         86aiBmLvG7MtFXPgMFnAmmac3QJB7lX2ydzUyjrRJtbrKL50/RzJF+x79cYV2nGOQO5v
         N4WuCLdn1IqFfEsAPzWbmPcgzW6b29khHqviXzGfHvAJ4KAsyLfXzOuKiMsToxuFzYBK
         huyA==
X-Gm-Message-State: AKS2vOzbQlDh3D3YVX0QrfntZSQ2OMoeZ9DjZsqf6xX21+n1DQ6UNPC3
        W9pZa9+LB/60svERjSQ=
X-Received: by 10.99.111.201 with SMTP id k192mr38426836pgc.192.1498079951423;
        Wed, 21 Jun 2017 14:19:11 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:708c:2191:5b14:b1a])
        by smtp.gmail.com with ESMTPSA id q7sm35152191pfk.108.2017.06.21.14.19.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:19:10 -0700 (PDT)
Date:   Wed, 21 Jun 2017 14:19:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Tim Hutt <tdhutt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Monitoring a repository for changes
Message-ID: <20170621211908.GF60603@aiede.mtv.corp.google.com>
References: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Tim Hutt wrote:

> Currently if you want to monitor a repository for changes there are
> three options:
>
> * Polling - run a script to check for updates every 60 seconds.
> * Server side hooks
> * Web hooks (on Github, Bitbucket etc.)
>
> Unfortunately for many (most?) cases server-side hooks and web hooks
> are not suitable. They require you to both have admin access to the
> repo and have a public server available to push updates to. That is a
> huge faff when all I want to do is run some local code when a repo is
> updated (e.g. play a sound).

On the polling side, it is possible to improve things a little:
https://www.kernel.org/mirroring-kernelorg-repositories.html
https://github.com/mricon/grokmirror

A hanging GET or websocket is more client-friendly but more expensive
server-side.  That doesn't rule out making it happen on some servers
if someone does the work.  If I understand correctly then this
architecture tends to lead to centralization --- a small number of
services providing notifications pushed from multiple sources, as with
https://developers.google.com/web/fundamentals/engage-and-retain/push-notifications/how-push-works

If someone wants to try adding something like grokmirror (which
describes the state of multiple repositories, amortizing the
per-request costs) to git, especially if it supports something
etag-like as Jeff King suggested, then I would be interested.

Thanks and hope that helps,
Jonathan

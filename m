Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5420C1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937852AbdLRSR1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:17:27 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:44073 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933403AbdLRSQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:16:57 -0500
Received: by mail-io0-f169.google.com with SMTP id w127so10774380iow.11
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJ1wC3nWSnHFAbnFJLYtsp69hASDdd3nginsyaXmrMQ=;
        b=WqYEtMr+WUCZP068x9wZj+HbYEnR7Tb908Z+k3cbbPgc0XiFWbAGRxnP1wAXSdynY8
         UmuMJilp814qD1hL1JeB2ARAY1G3EIH2bCyYOhkZcWef+/+AX+/tPDvxtxBw9UR/84Ad
         VrrvAjfzcbXsAQogvljnsfE2gYHsulQvBa7Ji/gOBdYDhRi+Bty7DK3Ec5mvPkWRLJTU
         qEVTX5apNT/GziXBjmwT1sthLCSUpJilTDGuikRQ4kHKVG4juY0An2bTplu8KJeqCPok
         YVpmxd77hBMIfnMeDzHRR/VeMze+HwzCjSUupeIKIXZbjziuYZuLOdkus7HynJr0kRDV
         m97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJ1wC3nWSnHFAbnFJLYtsp69hASDdd3nginsyaXmrMQ=;
        b=d1Mg89pwgofZQ+9aP/S8GwDLAbD3+ZMo++ebMTkYUWA5sldyt/UkHjD7677zRVV900
         7vmpeOq3Xwnm6tX0LYrxxGMD5C9viCV0GvJu+MZv8torMJ7bKA+xgpSOKBxwvhvJAp4S
         N0ShBJSFeczFFwnAkGTVQov/Q/QOD0M/7wjIrDpWo+2v8OQ3U4HW3uQdyovoxMSX14t6
         xKlsljdc+4k+TeXO9evnl5TTwCDD0S/OdqQCKefKqu3gaBr3Sr3q4b6T+LwQdI/rFg1E
         l/hlKRtLALmeYUINocLE0cgZNNPrk7X/UC8Ni+mXBuotreU8/eE4xt4npxWWhay5EsI/
         eUXw==
X-Gm-Message-State: AKGB3mLvK93ix0ld2E++W+wVTfr1M3rGdNc3AKzMpZMNdAKqAug1TEbV
        YKyRf1Afj4rSugJ7ax3nz03q8A==
X-Google-Smtp-Source: ACJfBovBcEFMCfQpNWeWVlrtYt+tlxeGg5BaLbFbIIHXqXSb4yl/R2yDsATpzm7VJvblfKPHCZ81Tg==
X-Received: by 10.107.83.19 with SMTP id h19mr792938iob.208.1513621016450;
        Mon, 18 Dec 2017 10:16:56 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:1883:9083:6c1f:dfbe])
        by smtp.gmail.com with ESMTPSA id e82sm6761467iof.34.2017.12.18.10.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Dec 2017 10:16:55 -0800 (PST)
Date:   Mon, 18 Dec 2017 10:16:55 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fetching commit instead of ref
Message-Id: <20171218101655.16105728beb82d38732e48a0@google.com>
In-Reply-To: <1513600223353.28799@arris.com>
References: <1513600223353.28799@arris.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Dec 2017 12:30:23 +0000
"Carlsson, Magnus" <Magnus.Carlsson@arris.com> wrote:

> In a certain situation I would really need to fetch all commits
> related to a specific commit (SHA). I have read the git fetch
> documentation and found nothing regarding this. It only seems to
> support fetching references.

The documentation has been updated in version 2.15.0 to describe this.
But as the commit message of commit 83558a412afa ("fetch doc: src side
of refspec could be full SHA-1", 2017-10-18) says, this functionality
was available earlier.

> I found some traces on stack overflow:
> https://stackoverflow.com/questions/14872486/retrieve-specific-commit-from-a-remote-git-repository
> 
> Following that recommendation it feels like it almost works:
> $ git fetch subrepo 50f730db793e0733b159326c5a3e78fd48cedfec:refs/remote/subrepo/foo-commit
> remote: Counting objects: 2311, done.
> remote: Total 2311 (delta 0), reused 0 (delta 0), pack-reused 2311
> Receiving objects: 100% (2311/2311), 703.64 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (1174/1174), done.
> ----> So far so good, but then an error message appear:
> error: Server does not allow request for unadvertised object 50f730db793e0733b159326c5a3e78fd48cedfec
> ----> And nothing seems to be fetched.
> 
> Is there a way to fetch a commit and any ancestors to that commit based on a SHA?

You'll need to set uploadpack.allowTipSHA1InWant,
uploadpack.allowReachableSHA1InWant, or uploadpack.allowAnySHA1InWant on
the server. (This might need to be better documented - I see this
documented for fetch-pack, but not fetch.)

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AA820A40
	for <e@80x24.org>; Wed, 29 Nov 2017 17:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933660AbdK2RNI (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 12:13:08 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35837 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932384AbdK2RNH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 12:13:07 -0500
Received: by mail-wm0-f52.google.com with SMTP id f9so7452248wmh.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=B+tTLvSWCxelDVEpULRyUdI2IYWQfUJnx5ELONVUx3g=;
        b=G9GApgONI07jP12D/E7CtUKZxn+B6AzhR82389dpPN3glL2yW5w2ARSwk+VVFbS+Zz
         lRiWTPhSb9xKyUhBIpeyiOJBCXZeYBfufL9RM+Z9jzhEbstHOxlBqhBBMUZU4M4VjEBx
         wDSaHlkaX9Hjf4C7gorvmXw1XF5OZv6OPjr6eOjVFb0gg9iHHJFlY76gpTz1xI1+4jnO
         qOxocdBQ5zB7FRxzkHhdAnawB0WFuD245KAoY2oydStF+pzvmomvZfXvFO3nPb8xyEdl
         QUtEoSjgc0BUo5h0xjOEcjm6iX7cnRGI7oOGqA09H2ks722dq/bky3DlZV6TwZCOCRhf
         9QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=B+tTLvSWCxelDVEpULRyUdI2IYWQfUJnx5ELONVUx3g=;
        b=LOOXuvI5CUeOwh0NdEDaXXD0r6f91IsJOYvkeM/MBUYC49auXNXj7pqMR5UI71Ff0x
         GBJY21nLKUKPVx95Ll+zCnsGY5RUefa3V2LI51S9Ld2GFQp/jUVHPDhK4XLUsWNYy4te
         axUuSMJweEscLKZg6mYyRGh5OKQWRSuA5MBSkUW912JHRa7mkRKzP15GQ7FGC2gSYhjP
         z71aTt72POKag4VGXk23apU/RVYhAZqTw00w7V/KXfqlp9PvMFoxmWCja5nj0ioXY18c
         ibeNCf5GdvdWG2GBBkB4Hu1kxIPwZIOcqOr6+aQjApNd/Q48pkEV93X0GXEiGDCCqbUT
         Wo2Q==
X-Gm-Message-State: AJaThX6FZNMW+OTGz71+14h0AEbe9IPlyg1nXy9M9B9gBepqc+Z8xeGf
        Tonvgb6HFaeIvPZ/VUnXnwIGNp22
X-Google-Smtp-Source: AGs4zMYHYbzpQx07a6zkYCchPp6CbnflPBV74TU4Xcu86n/vcpho1Q1IN24O24zkbdNDt/x67fN2jA==
X-Received: by 10.80.145.154 with SMTP id g26mr8888105eda.140.1511975586341;
        Wed, 29 Nov 2017 09:13:06 -0800 (PST)
Received: from localhost ([176.12.211.224])
        by smtp.gmail.com with ESMTPSA id s14sm1778841eds.78.2017.11.29.09.13.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:13:05 -0800 (PST)
Date:   Wed, 29 Nov 2017 19:13:01 +0200
From:   Doron Behar <doron.behar@gmail.com>
To:     git@vger.kernel.org
Subject: imap-send with gmail: curl_easy_perform() failed: URL using
 bad/illegal format or missing URL
Message-ID: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171013
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm trying to send a patch with the command `git imap-send`, I used the
examples in the manual page as the main reference for my configuration:

```
[imap]
	folder = "[Gmail]/Drafts"
	host = imaps://imap.gmail.com
	user = doron.behar@gmail.com
	port = 993
	sslverify = false
```

This is my `cat patch.out | git imap-send` output:

```
Password for 'imaps://doron.behar@gmail.com@imap.gmail.com':
sending 3 messages
curl_easy_perform() failed: URL using bad/illegal format or missing URL
```

The URI doesn't seem OK to me, I tried using `imap.user = doron.behar` and the
URI was `imaps://doron.behar@imap.gmail.com` but that ended up with the same
error as in the previous case.

I would love to get some help here, a Google Search didn't help as well.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D905B1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 20:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbcK1Uey (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 15:34:54 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35346 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbcK1Uex (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 15:34:53 -0500
Received: by mail-io0-f172.google.com with SMTP id a124so251793608ioe.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 12:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Pg9ZezzdQR8fkgj5ffkg48TlPFlVjO5d25F3rI6uwtQ=;
        b=az/WgrDahfonnZ4TtEBlGvX+rwaN5M7fWcUZBc2Pa21zRf7xpxFvm24H/6tG+8jMNI
         KbjIrfjChncnoJQuXiX0rqy3p0gpLb45Gxhcbb9vowv8AwjIFXu9s77BPTgNSp4L1aDZ
         Ve8UyMokM0+6YaAXKJf5tAoJieisjNiuMNKsaugU6cGU7gee6+vn9xtqgTfvUEnrcqPa
         nMb8tTjW3oQNqi5dv9ujIRI68tPSKpqrV+HB6kZL4bFFDOxLgJOHGFtbcqH3Fq0c8vgM
         V+vB0Qe4s4pgQANOtJvAY0k9a+b1/pRAIJK4XPCzS9JVLqC0Bhcy/HuPXoN4oKxwjyQ/
         MB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Pg9ZezzdQR8fkgj5ffkg48TlPFlVjO5d25F3rI6uwtQ=;
        b=Yhgw1Y0FF0uQu2HN5yeq7jS8KM6d0lc7NzclP8g6+6+UPS3uHNi6A2vB2woO+q8uKh
         Cy4p3s7tzatuczHcFx7MpsY0G3pfy6A5o8uLX34zuSYz9KU4FrDJe/T9mT4TIVjorHAP
         3I7U7/2QyNlsKD/zZICz4v9eNKQAIfgJbWDW4Y8E/cMeTaYAyDFzqxOKWb9fo7vYUMLN
         zl4D1myHz1T+xDGuCoNK/sTGAySE+Zutq3H6PscOCcrfnnFiFLa3trA5GjI7oqIc7A4+
         3yuiMFjlVHjwg67jup+NlUGwZfBNFOARyklqakd3COIanmCQJM+xM63xoQ67Tco4RiuT
         JDsQ==
X-Gm-Message-State: AKaTC009Oo1+0fdo+WhAoTLwRf00WOKyB+23OM23OXPn5GWtZSjiZg0Ai/B2Wk27/XQ6dxSnz5Wy3IsAc/s69g==
X-Received: by 10.36.156.132 with SMTP id b126mr19551879ite.91.1480365291885;
 Mon, 28 Nov 2016 12:34:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.10.147 with HTTP; Mon, 28 Nov 2016 12:34:51 -0800 (PST)
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Mon, 28 Nov 2016 22:34:51 +0200
Message-ID: <CAOE4rSzTq6DVR2ch+as9Pbo35NjKP5b1+Ub1XZWEnwJTahqEfg@mail.gmail.com>
Subject: Partial fetch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to fetch a remote repository over https but sadly it
timeouts too soon.

$ git fetch -v upstream
POST git-upload-pack (gzip 1148 to 641 bytes)
POST git-upload-pack (gzip 1148 to 644 bytes)
POST git-upload-pack (gzip 1948 to 1038 bytes)
POST git-upload-pack (gzip 3548 to 1845 bytes)
POST git-upload-pack (gzip 6748 to 3431 bytes)
POST git-upload-pack (gzip 13148 to 6659 bytes)
POST git-upload-pack (gzip 25948 to 13084 bytes)
POST git-upload-pack (gzip 51548 to 25997 bytes)
POST git-upload-pack (gzip 102748 to 51375 bytes)
POST git-upload-pack (gzip 205148 to 101973 bytes)
POST git-upload-pack (gzip 409948 to 203200 bytes)
POST git-upload-pack (gzip 82248 to 41185 bytes)
POST git-upload-pack (gzip 90448 to 45257 bytes)
POST git-upload-pack (gzip 99448 to 49719 bytes)
POST git-upload-pack (gzip 109348 to 54623 bytes)
POST git-upload-pack (gzip 120248 to 59937 bytes)
POST git-upload-pack (gzip 132248 to 65839 bytes)
POST git-upload-pack (gzip 145448 to 72450 bytes)
POST git-upload-pack (gzip 159948 to 79682 bytes)
POST git-upload-pack (gzip 175898 to 87436 bytes)
POST git-upload-pack (gzip 193448 to 96171 bytes)
POST git-upload-pack (gzip 212748 to 105783 bytes)
POST git-upload-pack (gzip 233998 to 116207 bytes)
POST git-upload-pack (gzip 257398 to 127793 bytes)
POST git-upload-pack (gzip 283098 to 140511 bytes)
POST git-upload-pack (gzip 311348 to 154447 bytes)
POST git-upload-pack (gzip 342448 to 169815 bytes)
POST git-upload-pack (gzip 376648 to 186850 bytes)
POST git-upload-pack (gzip 414298 to 205408 bytes)
POST git-upload-pack (gzip 455698 to 225879 bytes)
POST git-upload-pack (gzip 501248 to 248389 bytes)
POST git-upload-pack (gzip 551298 to 273131 bytes)
POST git-upload-pack (gzip 606398 to 300334 bytes)
POST git-upload-pack (gzip 666998 to 330414 bytes)
POST git-upload-pack (gzip 733698 to 363387 bytes)
POST git-upload-pack (gzip 807048 to 399647 bytes)
POST git-upload-pack (gzip 689453 to 341449 bytes)
error: RPC failed; HTTP 504 curl 22 The requested URL returned error:
504 Gateway Time-out
fatal: The remote end hung up unexpectedly

Is there some way to fetch partially by smaller chunks and then repeat
that again till everything is fetched?

Thanks!

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EFD41FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 18:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758851AbcLBSPE (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 13:15:04 -0500
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36316 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758817AbcLBSPD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 13:15:03 -0500
Received: by mail-yw0-f171.google.com with SMTP id a10so221884834ywa.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 10:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=vZxjWH3+irNtiYUz7d0C7Jz7FZOLXekcvFupibOBwIU=;
        b=t661EDDcXyUV6WcBViaK712VejXI0gmjsIKC9xpfoTtXyxFA0kCrPbIAeRLQEtiMdW
         EyqCoIvHt32vRNzV/XnuvMaT0j/49Pn9xH8PDpfHfxpz+8fsNv4RifHFmkh3TCYzfxfR
         JoHzWaShYuSP1gnmCDLhnf2qJfGkNYtWU3bjxIL6S9ydabnzk13ozL5P1CJDWSLYj31X
         HtyS03GkCmQg4A5C4UUysEoYFJ6tkYLiRKYgTx9ujsFbVKeFSZK/EeNE6AxlwVisuS49
         9DcwvcHfj8n0W8htTX7jA91VipOWN8lqtW/xa0hKMkAla6c6NgTIkJefLxNqkYpYnCRM
         KkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vZxjWH3+irNtiYUz7d0C7Jz7FZOLXekcvFupibOBwIU=;
        b=Gd3D4F40AHFEqVGhuZ2ZC0Gfx01BIXNVVap/MXOIPXL1x9dfb02gjzKsne3N02e+Uq
         OFIqjACMa57fF34H5biTHMdg0Vw3Rjr4C5xU7sDUusC+Kjarh19bzkqx5K7QVuInigHP
         K8XgZhVvpvrYb9ZgzHIZTfxkRE8KEiU9kXwqL6yWu2gYVnCottCoMRffi5xnqbo5N+rc
         QUm/P5mTvRhTk/2+pKM8aQ/OVkaOb8TCgbPOPc+11Eq0L72WNR5BaPuqUofcHHB25K8L
         xIdO+5VDLpRaM8uuu9nzSR3V47QVIvBaMrGTbSWhjVbMpWNmMohYfkNHxxI78EDEtw7Y
         PLug==
X-Gm-Message-State: AKaTC03ttFdvexQ1/0Pk3bVLEYMJqLBzUyzhL8L6sAd/iVMm9YV16P/Rbaz+Y1qOAM3vANBBuopmhk7cJTweyg==
X-Received: by 10.129.153.14 with SMTP id q14mr44470147ywg.191.1480702502292;
 Fri, 02 Dec 2016 10:15:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.83.8.14 with HTTP; Fri, 2 Dec 2016 10:15:02 -0800 (PST)
From:   ken edward <kedward777@gmail.com>
Date:   Fri, 2 Dec 2016 13:15:02 -0500
Message-ID: <CAAqgmoNG4vOqLnOqmrUvwTNJpqGBckfN-y=Fc99TrvjPhz7h0w@mail.gmail.com>
Subject: Where is Doc to configure Git + Apache + kerberos for Project level
 access in repo?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Where is Doc to configure Git + Apache + kerberos for Project level
access in repo?

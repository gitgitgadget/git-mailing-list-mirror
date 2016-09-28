Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44973207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 06:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbcI1GtJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 02:49:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33113 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbcI1GtI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 02:49:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id w84so4362122wmg.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wMv5BX4CnjJogrD6SKkWgKOHdToHvMOheGKmbCTXOTQ=;
        b=q6+Xht23tq1pMy9AtAOjvgwWSGpyU9TdODCA8mahAHKTFqLkzAilFfTYtis5YRAZlW
         nXG0xgj4DFYjvrSj7EKA+xMPxLoQOwxXYq2aiVLM81IKRb3/Imni124icYFqaMTGY8yc
         qMmbYKvdVtjU7c7+vDBWTW7RU3Z9GUJfr/0GWUVYMWZwuZC1Ql2nd2qDAe0nux1iMGyl
         qDrGk/DKBH8m8zUzofwKpKlCVewR4MXoXSxKS315VfqrZxgoVV74GH7Rm+z7Ka8fe0We
         h2GXEaSIb5Miwi0PNw6IT/04Qvcfs7zIQ1elV3l9A9sa4xoUBwomlgf5RX/sylHWv9Nr
         w4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMv5BX4CnjJogrD6SKkWgKOHdToHvMOheGKmbCTXOTQ=;
        b=ebUq39SdCcXxrkGMx68cAI0TCkFCsjFQBMPLZfYO54aJK1md99lKvaVRiTP22mLMy6
         w4nVn6L2XxLT0oKf0xx0j+RB0wntby1ZBSDY3AeQvaT7+oe0sqkPgRbReg/vzougUaLB
         KSL70WHO4Wl2Liz8y7rnhNYkYFR2L/aN9v//ib/RQ3o+eaOyTwWcKCGY9cDpfS6HPJIX
         +sQ5mgpU9DjUqKUNjIzTwtCscfscGNLxGnsvEyK5lfxoGU9Gg04Xt+YW3QtgTAKStkrG
         OJN+h0FkZA+0Ae1DUVMMzDn+sqd/iIav2QRgS80eoiEWmxqgOqmuRpNbvlfBqxBwiLOM
         Mvlg==
X-Gm-Message-State: AA6/9Rkke1qBSvFqTRHSJwtOaW5rfco7J9GCxewV/JmXTijoQcnIyc9Kx/39lERdEb5lYw==
X-Received: by 10.194.112.131 with SMTP id iq3mr14181857wjb.123.1475045346453;
        Tue, 27 Sep 2016 23:49:06 -0700 (PDT)
Received: from [10.156.63.164] (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id k2sm20589945wmg.23.2016.09.27.23.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 23:49:05 -0700 (PDT)
Message-ID: <1475045345.7623.26.camel@kaarsemaker.net>
Subject: Re: Repeatable Extraction
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     chris king <kingces95@gmail.com>, git@vger.kernel.org
Date:   Wed, 28 Sep 2016 08:49:05 +0200
In-Reply-To: <CAJQwtsidixAAJKp7-b2PmXgs=mS+PbT5ebOmKLJU1nEn7UJ2og@mail.gmail.com>
References: <CAJQwtsidixAAJKp7-b2PmXgs=mS+PbT5ebOmKLJU1nEn7UJ2og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On di, 2016-09-27 at 20:14 -0700, chris king wrote:
> Hello, first off thanks for such a wonderful tool! I have a general
> question and I hope this is an appropriate spot to ask it.
> 
> Is there a way automate extraction that will repeatably generate the
> same files? Currently, each time I extract git portable many of the
> binaries change slightly. For example, if I extract twice using
> 
>     PortableGit-2.10.0-32-bit.7z.exe -y -gm2
> 
> then Beyond Compare tells me that many of the files in usr\bin have
> changed at offset 0x88 and 0x89. Why is that?

Hi Chris,

That file is specific to the git for windows project, not git itself.
While you may be able to find somebody on the git@vger mailinglist who
knows the answer, git for windows also has a separate mailinglist at
https://groups.google.com/forum/#!forum/git-for-windows and a chat room
at https://gitter.im/git-for-windows/git -- these may be of more
assistance in this case.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net



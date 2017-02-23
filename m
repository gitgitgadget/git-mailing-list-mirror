Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5A6201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 09:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdBWJlQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 04:41:16 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34755 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdBWJlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 04:41:15 -0500
Received: by mail-lf0-f65.google.com with SMTP id h67so2317821lfg.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u/66BWkKiKPOOy9X/Frx8igqgsQ4ggJMWj3L9quze+M=;
        b=LJbKREPRvR3cxqvpZbVC0k8YndsKEzsh7+1Cv+jK9agFTehnDHGxl9ZmlWSDheZIQQ
         pS7kMJpv+x7mx6dFXZaJ1iJoy0wvcELnZ2jZW+y/RyIxQ6h8fmfm2RDW7xCoKuoF7QmA
         TOrPWOk9i9enyshuW78hFquK7F8WQHNS/LTJOCEpD0wZxRFmay6L2bnscRiUZzn9Aj3Z
         HptFcyn5M3uvVAsFW64A4EW/gSX6Un/0/fwWBmFrDbIKMWG4/P/Ogzo8uknQUQK9kl08
         rA8lL487nbmWPG3MQZc3PuJjQ8wArnBscXWWKGBcBnYr6TxxuRHfv0Gjob/EmjfHfF9Q
         mVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u/66BWkKiKPOOy9X/Frx8igqgsQ4ggJMWj3L9quze+M=;
        b=WXNYCPpNeETKNPp8S9TrKqySyr0VNbK8wDG6oAphrVBeJHa9qFDZBXI/qNbk9/M+EF
         6WsKn+wBEmfCxFes3sIpuEpFKah20BWrmvqELtpDmyEaJ5Jt9lHNV9vuEzHEU0JHAfZM
         xCBETN3dMXApdpBijSsuG389ehQED7/DwnBgi6LNMzZRL5gFCLQnquU38nZ3oZp3L5BI
         fo41AkNEtMZptb0zs/kr2OWAkqEVKmd4y60ghD7P4Koi4Ox0t3yj2G7p0VLZTWnlfqh1
         Ns7CTalBusK2gnx6efeic3ZKvB35qkZ3xnNvtj2HVKZkAm8EAdLHyIBvdpZVvTkhdkqL
         zUig==
X-Gm-Message-State: AMke39kgJYYVUWCZMrLfJb7h0uqAo5CAmckU+mx4G3Vs4Op5fNV+AmXcwKk+zX5KcAClJoO/bQBOsdHo28yXwg==
X-Received: by 10.46.21.92 with SMTP id 28mr10177039ljv.81.1487842873300; Thu,
 23 Feb 2017 01:41:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.204 with HTTP; Thu, 23 Feb 2017 01:41:12 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Feb 2017 10:41:12 +0100
Message-ID: <CAP8UFD2O62Ri-ULa09RCwLg=HxYfNnztCCdAX3uSFC2QOp0rgA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 24
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Jacob Vosmaer <jacob@gitlab.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Erik van Zijst <erik.van.zijst@gmail.com>,
        Brendan Forster <brendan@github.com>,
        Stefan Saasen <ssaasen@atlassian.com>,
        David Turner <novalis@novalis.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Shawn O. Pierce" <spearce@spearce.org>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Charles Bailey <charles@hashpling.org>,
        Karen Sandler <karen@sfconservancy.org>,
        Tim Pettersen <tim@atlassian.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Cornelius Schumacher <schumacher@kde.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 24th edition of Git Rev News is now published:

https://git.github.io/rev_news/2017/02/22/edition-24/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.

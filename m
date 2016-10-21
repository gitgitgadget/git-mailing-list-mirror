Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67F820229
	for <e@80x24.org>; Fri, 21 Oct 2016 18:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934966AbcJUSTr (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 14:19:47 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33063 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934946AbcJUSTo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 14:19:44 -0400
Received: by mail-qk0-f175.google.com with SMTP id n189so165190989qke.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+BLWvC4FMug4QTzu5g3N8/ElPbBQTfoY//WFAnq7Hgk=;
        b=FkTrsNcS9uHU6H+EkoWy+R6Y3//usJa+w14C4wzx/zFidyfRZ3hqrrIkk7TnwjGZhX
         m7XswuwufiOH5f98B5f/1jvHwOFO827qsnzgjgi+dZps1adnpxPKti+NJtWQHv20ioRb
         uP1MhW51Yy5DU8dE9v3Y4GKXu2ZH25/SZ2zQKRtp73vsmZo0aDILQ4+dnheKTQrvUq9D
         nen9NyuqpvRAYwt4hmPX0BYReave7Ijm7LUmmQKrsSB5qsSzVCHkIVKSC4Xe2zkxxO2w
         TBtS8qjK9QZONuNKRaTJS0Nj5oqr8RDEwX9fjXG1z6LnpVLs0kfLLpeGT6O0fT7Mdgf9
         MQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+BLWvC4FMug4QTzu5g3N8/ElPbBQTfoY//WFAnq7Hgk=;
        b=emsRF1dtYsarVXA6kFr9dyHhaIZxLgxl7j7hycmYbNETUCul3ZnSFj7kyH50z5TQd7
         /9ZJnGU/d0RPmXtPU2JPlYK1TvZSFr+JcBYmtJOTPz1h3ot4rGhPMds3cRRh7rLKeNbJ
         fKRv6npDGuap3RbBLTgDB4gw48emWkBSL2Xs41yRegKzDSgd0Qb8eL6zsZdIiHoqKjAV
         bHT7FzJu0sFonLu3BXehUxEQLoRozmFmPFVAoHj1OoLOZZ5TQOpj5lqXgqjEh/AExow3
         TUkcW5P5QndzQgFC211FNdfAS2vbGoKHVkur5hOduMpBJpwa38Tg074H10hBJnb8i78E
         zBJA==
X-Gm-Message-State: ABUngvd0zIFmYFRuMBcyiF60+N3kPXwad+VDsHc+0LT1SsiT9P1p5NV0cH6xI1ePhvCArsCd38EDlVei2SsUsOYg
X-Received: by 10.55.129.1 with SMTP id c1mr2467247qkd.53.1477073983187; Fri,
 21 Oct 2016 11:19:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 21 Oct 2016 11:19:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 21 Oct 2016 11:19:42 -0700
Message-ID: <CAGZ79kaPdSfY_DXL6BDQ9pAma8p61r4m1n81VTxPHYi8zQuZfA@mail.gmail.com>
Subject: RFC Failover url for fetches?
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So when pushing it is possible to have multiple urls
(remote.<name>.url) configured.

When fetching only the first configured url is considered.
Would it make sense to allow multiple urls and
try them one by one until one works?

Background:
http://www.businessinsider.com/amazon-spotify-twitter-github-and-etsy-down-in-apparent-dns-attack-2016-10

I wanted to fetch and had to fix a url of a repo
to point to a working mirror.

Thanks,
Stefan

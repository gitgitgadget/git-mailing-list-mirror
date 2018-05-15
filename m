Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76FB51F406
	for <e@80x24.org>; Tue, 15 May 2018 21:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeEOVPN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 17:15:13 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:41169 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbeEOVPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 17:15:09 -0400
Received: by mail-yb0-f179.google.com with SMTP id l9-v6so549119ybm.8
        for <git@vger.kernel.org>; Tue, 15 May 2018 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GtzN9r44xRz1c8F+Su/DoIQYHjVdPCKZ58dyU+1Sy7Q=;
        b=rQQniGf2L2S0ie88vcF/I3x7Eo68H5mhwQ5z59Jnrq59SGgFc1OQKy3jwvSX1g+BVP
         MIXn+Kqzc9Z/OeqjnHSwgDNAziNsF7euTs8lNif73HMM9rxlY0ZEVpP9MLgdxIaawoDO
         z/t7EQz84OguLs0X09Bh12ShHoRtYu97VyfAiTHZhrkLwVZ0z7ybpHYTsUFl+sTmZlI4
         eLR+BtsXBiAJNnita/EBPCskN2fptYWE82Xu23TB4s5eM7ylSbnVX+FvtZwE6lmtfjzm
         dL9O/luJzMXjHFe1unHDlQ0nehR29Ra2kVeSnetnEbrdNjzg8VUkshf1cyR8So4Vcgt5
         809Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GtzN9r44xRz1c8F+Su/DoIQYHjVdPCKZ58dyU+1Sy7Q=;
        b=pVXhpttw4DN4iI8KjMVJyc7hw3oh2l8sgo33SgMtdlFDWR/FQyijE12Icjy2i9+gCz
         4kNo5fK0qvlYFnq6v61OdQi17J1aYQODNRMinh7cK+qIZW4khZlkGPs/4TbKCTiC3QBZ
         1XB8nT1hFT8N0Mefl1yJsqvzqCBGFAOrG+q27c5K8nASJ8u3VcX69B5QuIjWd0mxVb6M
         PRsWSoDH3bkSwsDUowEQD60ox2ffyJMz9nwsHS2N4/sQWBxjihWdv2gRk6BU9SwM7BJh
         ilbNVu8bLRBFnX4ORh0ym6ew8WP1mDasL6BZc9RXsbkCL53iFipl0A/E1RjBw9wfIr34
         TonA==
X-Gm-Message-State: ALKqPwcBDaLblZ+jE0+0XwOEvNnl/1Fvn+eSZQ8KASPPsn14dSJbkBI1
        cUr3ZJeR/lesPbL+V/cuh2k9elQ1Ih9OxK6fG0/tpzOZS5M=
X-Google-Smtp-Source: AB8JxZr8PmfFM6Os4hqM/AE1/aoAmCzS+qgZcDg3Qa35ZbcbcHaOpkTIwEE5MRRTaqCD5V197puXapuCcCttWUtTtnE=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr9719924ybb.334.1526418907845;
 Tue, 15 May 2018 14:15:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Tue, 15 May 2018 14:15:07
 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 May 2018 14:15:07 -0700
Message-ID: <CAGZ79kYvmy9yXY-1N-SbHr5Snc5Zi2q0=9XRMscKkrWhfXkcFw@mail.gmail.com>
Subject: What would travis do?
To:     git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

in a context unrelated to Git, I found https://github.com/grosser/wwtd
("What would travis do?"), which may be interesting for those who
tweak the travis file.

Just for your information,
Stefan

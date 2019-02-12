Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1D3C1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 03:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfBLDwA (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 22:52:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41629 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLDwA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 22:52:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id u188so7895726qkh.8
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 19:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nZinQUlr30DAs62Bcs2iBiqFqUdiYc+gaiUBY9q8XE=;
        b=cMrJfvNtccSL5hgTqNl2xpIUdPpil8EWLvNPS/gV+RD1rnFmQ5i1/4PPPW3iJeENLW
         cZ5i3v8QZ5pvJTY3/ev4P85+0Ss1KVLv6bENUchTDdO77XNjNBMdtoDI9vzxDL1ezxBd
         hL/EfP9R1XbIPB0s31aDuOVIoUEfhuvk9tU6hVfIWbkTfcNnmlMLQz3l1Z/YY8Vg/RQG
         NV0tePje+GSt+0kkRLgsa2kc8F0g7YDm29HI4jtQzs3HCRnE/FTdWBIi+ekhnMQphgXx
         HEF/RXewsLJLsrXEhgSIz1CyWf2kqzR61kKQsiVlkIzRdrH5sZFXCg6Xgzi2IOWS8xyf
         WBwQ==
X-Gm-Message-State: AHQUAubCmoOLAuDMQ6E1hRXVrsF1+v67HUnPzFeBt+pb9A3mhTtaITh4
        6sJ2PkGYQqARiuKcyKJDPycfVBfEY5KcT8SHY2I=
X-Google-Smtp-Source: AHgI3IY4KQ+QAjChnjRVOqHcIY6K6EQMoHhn5EgaVBbzuB1Z2rVmm+7LlCOCQ07v3yrURoP6AfriIXBJgY/ax4MBlmU=
X-Received: by 2002:a37:404f:: with SMTP id n76mr1196304qka.26.1549943519420;
 Mon, 11 Feb 2019 19:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-20-sandals@crustytoothpaste.net>
In-Reply-To: <20190212012256.1005924-20-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Feb 2019 22:51:48 -0500
Message-ID: <CAPig+cQsWrqapzd7XqDEf9Dx+pg3NjnJUG8Sgh21LEu3YWKRcg@mail.gmail.com>
Subject: Re: [PATCH 19/31] http-walker: replace sha1_to_hex
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 8:23 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Since sha1_to_hex is limited to SHA-1, replace the uses of it in this
> file with hasH_to_hex.  Rename several variables accordingly to reflect

s/hasH/hash/

> that they are no longer limited to SHA-1.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

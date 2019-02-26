Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81EE920248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfBZMry convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 26 Feb 2019 07:47:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46424 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfBZMry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:47:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id z25so14572834qti.13
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OplZJdZ5cyL99vmtCEJtK62ZSfgDQx1MIt+oHdCB/C4=;
        b=hrtnnFYRLwg+U7R/2dMcCewxg+r4bv1ZYy0NucUsxrFNV9D5g1G+fNwqfgdFgbTCjl
         AiggnBJqc1l5SXt6yaBL2XofUZkqiPWixyuHhRtWG8/BT5H2yVjuJK4wECNtThDFFgOg
         kzAiMJWVmwstuZrFs0yXhXyZDQaeOSKwLd9ivS9T4KjQlv1HMDnPGSJ9iPzXNvtmkhtm
         zhfwyRPrcuBhW0JGk+JbjzeAlNUK6UqdEZs9sUNqlC7sJgd+2eLXCoKZ/88z/ksJZxYV
         brKDHTd3ogCU0A2yfn2Eplojg5Y4lE+G4upV8w4XvSfEk98Ia4UN8y/9piN4/G/27YS4
         wuEQ==
X-Gm-Message-State: AHQUAuZOF0ExWPTUNkvaOiqcwffCX/i2C05T6DL/hwlxBb76MFm88GDq
        AYDUQVjdXr+nuOoujTw/kPJqUc5m21vtvNFkGlQ=
X-Google-Smtp-Source: AHgI3IYS8UCjdLlxAi3Ugf5pB13yFhQPLfqSu7/+xvCrY7nR55Qu8XFvyfL/BRYaQVf3NbY5m0BUxPFWNmSg16JQkhg=
X-Received: by 2002:ac8:7405:: with SMTP id p5mr18055943qtq.184.1551185273013;
 Tue, 26 Feb 2019 04:47:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551123979.git.martin.agren@gmail.com> <e960fec4b492f3edf7bade35862333af5e8704d7.1551123979.git.martin.agren@gmail.com>
 <CAPig+cS7BdHhLn+XjjyVa+PC040y-E4iPD=kuDtigenzSHcFKQ@mail.gmail.com>
 <CAN0heSrogSpdSOGj0ibx0Dcjw=0o0u0VSivfjgL7r5f-Jiqs3w@mail.gmail.com>
 <CAPig+cRTj_jHFrqyYsn=ivuO9uNcWjB=5okX0SCGoeWU=uR8Gw@mail.gmail.com> <CAN0heSoWv9xTYzFS16-fjnZuY_+6vpHSHcLmwWG8DdJEmNcTuA@mail.gmail.com>
In-Reply-To: <CAN0heSoWv9xTYzFS16-fjnZuY_+6vpHSHcLmwWG8DdJEmNcTuA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Feb 2019 07:47:41 -0500
Message-ID: <CAPig+cQ8d7_=sY5bQ8soeNAnE60o8mdE4utCiJSaJgR7p8UrwA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/Makefile: add missing xsl dependencies
 for manpages
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 12:59 AM Martin Ågren <martin.agren@gmail.com> wrote:
> On Mon, 25 Feb 2019 at 22:01, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I guess I was further confused by the fact that manpage-base-url.xsl
> > is still present even after "make distclean", which is not something I
> > would have expected for a generated file. (Perhaps something to
> > consider "fixing" if you re-roll, or not if it's out of scope.)
>
> Are you sure? `make distclean` in the top directory depends on the
> "clean" target, which calls out to `make -C Documentation/ clean`, which
> removes the file. [...]
> Were you perhaps mislead by one of the similarly-named files?

Yes, I was misled by similar names. Sorry for the noise.

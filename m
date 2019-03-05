Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245F820248
	for <e@80x24.org>; Tue,  5 Mar 2019 22:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfCEWyY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 17:54:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41706 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfCEWyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 17:54:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so11265521wrw.8
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 14:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aj0AvRdqrZjrDWpnRX0bpcSvXqnUd9nJ9Czyj5qmmjs=;
        b=rJtgBwZTTOnlWb33afUBLEQYp5e6ku7bmNU2QDjB7W355+uhDSiEE7USdEvvxV1dgl
         rkXzNWvpCSFXf2ok+L9gGgIpH9HemCbjNNFRumRUpkPQlxYriPW/1JXw7vui6PiNkaRi
         5KGbqXUNBtaxmeDcvaIL5VF0Rk9hPHjr0E+Mj6/UNrT53PABhzMHtd4uiO2qlzMzgTTk
         +OoeQuidFzkLvOV0xHAf6ntsgWqDalynWacQ9ivJ8t7W496PzT3f3rKEuqyxQgnIoB5p
         rSmNYU1Yn72p2OO2fy2TaNseNCiGUfaxZr8BOou2CoM2XH7qsEuf9h38Od8N2SeR/Flg
         OSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aj0AvRdqrZjrDWpnRX0bpcSvXqnUd9nJ9Czyj5qmmjs=;
        b=HOhkWqED4YDJUskmhwum77+X05stgQPburn5/8CDaI2FyuUK2YgsdFVS2hZuBCcwIo
         hfOOix/bzAADujoZmyHRl/ANp2skLki0i9Cc5e+k3JoCducXUP3QxfUwu4/7FjRidjmS
         FviYX/xVYJYGV0dyOa2Hsu3fKiMNtbgtAnmQao8Gn23KDZ67oibnKsVCdmIw7wlALiZn
         9obrwRbMZF5rU2fMN2DdWyEChdl2rK+uY4vL7VKFzU+gNMzm6Mh54bh9yHCH8YotRwUj
         6/SR4o6Mu+Fpgv7ERXxTBAyNiL/BaX00Ra3Qoq7upR30Rp5OrOXULxyGNUpYNJgoOUXW
         NfXg==
X-Gm-Message-State: APjAAAXg4XwKJtjwKokXEwK+vx1b50LeGb1KN/rrBXJZKIrl2CN1DDnH
        JV0R7qnS5zTasS5OHnkjyoQ=
X-Google-Smtp-Source: APXvYqxyjGpYwVtxjRE7RByd6O/V8zVxqaESRy140qMOyl0hu/mRcJd32k2pbRzyNTu7nRfbWpsKrQ==
X-Received: by 2002:a5d:4a05:: with SMTP id m5mr829770wrq.46.1551826461735;
        Tue, 05 Mar 2019 14:54:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d16sm9786190wrx.29.2019.03.05.14.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 14:54:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: [PATCH] Doc: fix misleading asciidoc formating
References: <20190305214423.27820-1-jn.avila@free.fr>
        <20190305223655.GA27535@sigill.intra.peff.net>
Date:   Wed, 06 Mar 2019 07:54:20 +0900
In-Reply-To: <20190305223655.GA27535@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 5 Mar 2019 17:36:55 -0500")
Message-ID: <xmqq4l8hszj7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Did you notice this when building locally, or on the asciidoctor-built
> pages at git-scm.com?

Does git-scm.com even have this file rendered?  I do not think we
glob for technical/*.txt in any of our Makefiles; instead we have a
list of ready-to-be-consumed TECH_DOCS listed explicitly.

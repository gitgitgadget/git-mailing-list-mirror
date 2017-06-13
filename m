Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5230520282
	for <e@80x24.org>; Tue, 13 Jun 2017 07:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbdFMH5G (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 03:57:06 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35101 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdFMH5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 03:57:05 -0400
Received: by mail-wr0-f175.google.com with SMTP id q97so130155929wrb.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0YzyjmdPP9E/Pox+z1eppAyNpUMQnn07Gw9MZvF8Ao4=;
        b=iLMR/HIEA1NwO1fRUNYzKm8h5+qCa+Gd5ZLe2AvlqujvI187o0Fqrdos/ddXNinkxB
         9k15jrT7o5xjmP5WuasBMMImlIJfseYzSBEA/wQoN7heeZQTbl/dwiRAsReUojCUo7iC
         sTiUvKvmMrcNkFHdZWouRnXSQ8CVXbNhCv7oxeYvMdpuopANmffRHL0DvQ17zDYWf7x4
         MibpVAQzSW9o5xVTJ6SlWHT63kGzBV/TXs12Q629mRImFD9CxPbKJdBt3ZjovCy4e3uC
         nWqrr09oJzHmOcMtjX8WUDfdIorWVMpd/H8B0a2R0VUj2f6edVc2ty5bQoEQGm47l6wz
         gFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0YzyjmdPP9E/Pox+z1eppAyNpUMQnn07Gw9MZvF8Ao4=;
        b=DIvdykUj3EhdUVJ7fKmBgM/jUnPEbHwR9dAnNeTpdfOQa+ItgohZGinZzjv0G0wV5N
         EV+0NuH4OKLZkzhq6FQdA9NailCGbM2/vn2+GKXAImdTU4/Z2U2CSZojPKzOFEXoOoHG
         86bhkZgQ6QHD/12bOXrGLRMa1Cmvnc4C9LAwXuC86x7Q1UdGWoOaaI0kEEEJGLP8prt7
         NQcK+7YpwuXQY0IqlfWO9OkamONJ47ifW0WtcLsS/8DIpoY3U2KUm6R70hfFvRkQUMXV
         jgA9fR8Cw5XnRyoEo6PpAev0B2yx+oNl+KQ9ItlAYmSJqpK1CW12ZXmTfbA6R6M320f4
         6cOQ==
X-Gm-Message-State: AKS2vOwHecDNDB0vOxP/KXYRjwSISuKeeuwSa5kFZVxjCA0iJPg4Aq0a
        AEKQziX3m+8jzw==
X-Received: by 10.223.165.1 with SMTP id i1mr1877487wrb.59.1497340623555;
        Tue, 13 Jun 2017 00:57:03 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4C1A.dip0.t-ipconnect.de. [93.219.76.26])
        by smtp.gmail.com with ESMTPSA id t8sm17388318wrc.28.2017.06.13.00.57.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 00:57:02 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqtw3o4nl8.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Jun 2017 09:57:01 +0200
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Content-Transfer-Encoding: 7bit
Message-Id: <C7CB1ED2-D7B0-40D3-A239-893BA444CF63@gmail.com>
References: <20170609142151.94811-1-larsxschneider@gmail.com> <20170609170357.GE21733@aiede.mtv.corp.google.com> <xmqqtw3o4nl8.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Jun 2017, at 03:51, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> Lars Schneider wrote:
>> 
>>> Many open source projects use github.com for their contribution process.
>>> Although we mirror the Git core repository to github.com [1] we do not
>>> use any other github.com service. This is unknown/unexpected to a
>>> number of (potential) contributors and consequently they create Pull
>>> Requests against our mirror with their contributions. These Pull
>>> Requests become stall [2]. This is frustrating to them as they think we
>>> ignore them and it is also unsatisfactory for us as we miss potential
>>> code improvements and/or new contributors.
>> 
>> I think this description could be more focused.  It's also not
>> self-contained --- e.g. the link to stalled pull requests is likely to
>> become stale over time, especially if GitHub gives us a way to disable
>> pull requests for the repository some day.
>> 
>> Could you summarize for me the motivation behind this patch?  Is it to
>> make Git more approachable, to avoid frustrating contributors, etc?
> 
> I wonder if s/stall/stale/ is what Lars meant.

Of course :)

- Lars

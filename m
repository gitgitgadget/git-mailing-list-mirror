Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8641FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 12:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbcIKMey (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 08:34:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35766 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756029AbcIKMew (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 08:34:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id a6so9678670wmc.2
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jwtxUYZYRzJfNBYjsswzOuZq9fnhNCd+XhBPa1ikfDI=;
        b=xBsyp9q6We4Cukseo5ZxKkLb1Y5jdZned/lEBvqZMRRuLN9kRYgmr/fa2l1fEs1sRi
         kf6k8n1CdPdtEOBGZqHvd6Vvh8wtE/nak9OYultJlZSUjDfxzTjpzMqpQjVxk8+huJjx
         jDlSatAlhEyeTS/OvHomU4rkPKzH0ZV569fuf84T5ymtJlIXP+s4BdcDRNtqwbacDVhO
         MO98WXTDKUiI5xBv/aHVLVkV8MXjK4GG80k8KXU/4oeaT05/Bar6V08RfH8ZB7y4Am1Y
         bF6IrQYgdpDvs0HwWqJ2QVnYJ1XeqIHa1mSTNgNL/pg2j2ZVSJtRNlAFwIuJ3VEvj+ya
         ZYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jwtxUYZYRzJfNBYjsswzOuZq9fnhNCd+XhBPa1ikfDI=;
        b=Nx83CQ4Sx/pj6XNxossp+peEerOHpkS4exDs9HG5oZOvApQ3NqavHRWLvyqLZP3C6T
         nyTMKVYdqWpoI/7blo+yA7/SzzJly+umYBdhkXv6LiMue33fkwXTXI7ZVEN794AsAsMB
         aTNFXyHcshyziBVwdEeFe3nUq/pHlynvNRiARMMWny1DIRXatq0JwBslIfyCswCexwQI
         9c5t6QFeTyzHJtamly99+hODOVnwpUADN9uzM0UH7RZph0h6bSBF2YKvSzJ0LAjR2lU7
         ZoGa+rmV/6rcMeiNGsyUYXeWLKLa563jOLkPQWsZJcFpi4O0iMiO0DQCxjCGpQjSw0Mf
         HdBQ==
X-Gm-Message-State: AE9vXwNPKQ1gM3f4Hpo/wOrRF+hnxDws32JBXsvojQUjHl8KIsVTTb4C1pTSaYYi3J9Byg==
X-Received: by 10.194.88.137 with SMTP id bg9mr10640255wjb.155.1473597290760;
        Sun, 11 Sep 2016 05:34:50 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BADCF.dip0.t-ipconnect.de. [80.139.173.207])
        by smtp.gmail.com with ESMTPSA id j1sm12811738wju.9.2016.09.11.05.34.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Sep 2016 05:34:50 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 08/10] convert: modernize tests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kbG3Zza0e_kKhz5sBZcippwjewEBasYCioJF9drEov_Aw@mail.gmail.com>
Date:   Sun, 11 Sep 2016 14:34:49 +0200
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <02449FE2-5997-4BDB-A3F4-2276470F27B9@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-9-larsxschneider@gmail.com> <CAGZ79kbG3Zza0e_kKhz5sBZcippwjewEBasYCioJF9drEov_Aw@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Sep 2016, at 00:05, Stefan Beller <sbeller@google.com> wrote:
> 
> On Thu, Sep 8, 2016 at 11:21 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Use `test_config` to set the config, check that files are empty with
>> `test_must_be_empty`, compare files with `test_cmp`, and remove spaces
>> after ">" and "<".
>> 
>> Please note that the "rot13" filter configured in "setup" keeps using
>> `git config` instead of `test_config` because subsequent tests might
>> depend on it.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
> 
> Makes sense & Reviewed-by "Stefan Beller <sbeller@google.com>"

Thank you,
Lars


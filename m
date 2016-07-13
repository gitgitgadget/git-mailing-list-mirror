Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F8A2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 18:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbcGMSQW (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 14:16:22 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38535 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbcGMSQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 14:16:20 -0400
Received: by mail-wm0-f47.google.com with SMTP id o80so81607206wme.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 11:16:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ylH6C143sKWKfdPKdQJNr84xgGuRJMdCI8PkGmYE/fI=;
        b=M7ebIUayW5Aj/7OiOeHpdCaLwsk2Aa2gm7+B9l8Mfn4bu3EPKteRdYz196qlS00Jut
         7RVtp7UJavNnFE7YRUmdZMdRtw1PQwl0aSuEOyrBB4Ww/F3eFW3xHwj8sE/Old2USopS
         MuNnrhzsoWT76fEHO1cJfESURsQt0Leyzbf4XLyNsr9bnQUVy7UoFe+bJMZWYS1nnc4b
         BGlEqnM/z/OGkMC4qlAGjDhQtcts6A8e6ce/jGNkXcbh11+5x7Q0JyOOTRM1Ho3GfrXS
         SMVbflnVzhL5DDhCE8IhtENZJhsMpx2ZxO1wVg4NdppMdFnW6GyizLmD2cDb+scjhc42
         3pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ylH6C143sKWKfdPKdQJNr84xgGuRJMdCI8PkGmYE/fI=;
        b=eHLPn9Gozvh7AFWxi7AkZ6yjPp/gGE72CpuBE7WVt5w6ZTS3oEJ7vb/QWa5v3UqIWL
         U8/AjdHz4kgo+oeuaMb94E+R/IQkiKt9yzAkSerBzIu24WIGM640yIk4Jp/tTzJbyuTL
         OsnilW4X+O6ZzvFxsfNH3S96uCME95TeBKH5nOsEJCaGRapAGkFZRct4Mf3RPT9ZM1V5
         Gvf4pbeyBK+HgVW5gmX8+rBdRT9g62jBMTVI9by2mAvq7eHPDHT/okXAyoS/4t3wH/P5
         4nQUNtzlCtXDFYDBuAqj5ol+vTsGPIpcgRFy0uszyR6wmK5uMOTY+/JpbPOB8qNfzIiL
         ESDg==
X-Gm-Message-State: ALyK8tJ5DJ/v4rww1TSCag2GTITijXHatmXgnCHdhptnbntUUw8k2fb7AfrqzzFNsHs3GQ==
X-Received: by 10.28.228.132 with SMTP id b126mr19098494wmh.93.1468433763943;
        Wed, 13 Jul 2016 11:16:03 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id sb15sm2073519wjb.3.2016.07.13.11.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2016 11:16:03 -0700 (PDT)
Message-ID: <1468433762.4649.6.camel@kaarsemaker.net>
Subject: Re: Https password present in git output
From:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:	ervion <ervion@cryptolab.net>, git@vger.kernel.org
Date:	Wed, 13 Jul 2016 20:16:02 +0200
In-Reply-To: <2908abd39c722c080ec37a987a79e32f@cryptolab.net>
References: <2908abd39c722c080ec37a987a79e32f@cryptolab.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On wo, 2016-07-13 at 20:26 +0300, ervion wrote:
> One possibility for this in git is to save remote in the 
> https://username:password@domain.com/repo.git format.

This is not recommended. Git has credential helpers to help you store
passwords outside the git configuration.

Which then makes your original problem go away :)

D.

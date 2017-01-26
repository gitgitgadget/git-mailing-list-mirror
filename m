Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3991F437
	for <e@80x24.org>; Thu, 26 Jan 2017 09:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbdAZJOH (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 04:14:07 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33842 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbdAZJOF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 04:14:05 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so48792582wmi.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 01:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=91JPg12SvNlHkfyi+5X2pkiltMGDXuf8wIrgGNEQJ28=;
        b=Aruet1aDNcQ/lJOJeAoKoQVIxABE0A407UKHrDOOJBiTTux+wDJR67qlWYMBDFqdRg
         lDmSXpDTFy89sLKbHb/6alexahIcNSlYnjV5Ewm60hf7hABuws/XbGNsikPI/2ITPoJ8
         HQ0C059BAipTzbO4Cazo9GXbK6KZtviHERFDOKqZHLm14jeQt2W6+5KNy29QvUc1am+U
         iXhibL8yXI5+Yr5R4B7FG7I8Kabfa2dyRL3CmCC9D2jFUGURNuIeB1bs5m/o2Sv52vKP
         xy3iCtVeGSHCoSCrO/SCSRDKqTXOTjRa2jKTHj1K0Ags6xx4fUqytrGvnQjx1J8nVHAe
         vunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=91JPg12SvNlHkfyi+5X2pkiltMGDXuf8wIrgGNEQJ28=;
        b=Frl1l0GVR0vNijSek9EiMYM1Td3FaOjB4lNKMIrozzKxtsNmKjmvgy4DnnFHSJGGzE
         UdS98m3sCxYk91J3JTsIH4FQzb0WGoGEWtJr7mRzGrS5v7LWO8K0Ts8M4MqcdFFtF5+Z
         o6AkKH2b1d2mCrascGB7wE/QbwOd/kKtfI1fZD312mShpS9WuowGD20YWysh2lkX57Xu
         4kmlfCpnfZfXEz7zkpHB4T/qdMi5xQ4xTAO3AEj4YpJ1n+Y2/j7x8dlBeudBnQHmKILu
         GBkNdc3Oj9EZCdkvPvuPsM+hw/zsl9JRapDUAK0CLEax6PZU++o2YZVmM+PVzXlZFQps
         /fLg==
X-Gm-Message-State: AIkVDXJDpr57DVjruD+CKvZHsMNgFqiyzIt+8Rv1EFg2icERiK1hyDjH7Acgq6rxcyK3mw==
X-Received: by 10.28.19.207 with SMTP id 198mr1601105wmt.70.1485422043769;
        Thu, 26 Jan 2017 01:14:03 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5A5D.dip0.t-ipconnect.de. [93.219.90.93])
        by smtp.gmail.com with ESMTPSA id o132sm2616259wmo.17.2017.01.26.01.14.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jan 2017 01:14:03 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq7f5i92jk.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 26 Jan 2017 10:14:01 +0100
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D9F0976B-9F78-44BE-B9DD-CAB6506FA3A9@gmail.com>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com> <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com> <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net> <alpine.DEB.2.20.1701251800120.3469@virtualbox> <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net> <xmqq4m0nc8dz.fsf@gitster.mtv.corp.google.com> <20170125183924.6yclcjl4ggcu42yp@sigill.intra.peff.net> <xmqq7f5i92jk.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Jan 2017, at 23:51, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> I guess the way to dig would be to add a test that looks at the output
>> of "type mv" or something, push it to a Travis-hooked branch, and then
>> wait for the output
> 
> Sounds tempting ;-)

Well, I tried that:

mv is /bin/mv

... and "/bin/mv" is exactly the version that I have on my machine.

The difference between Travis and my machine is that I changed the 
default shell to ZSH with a few plugins [1]. If I run the test with 
plain BASH on my Mac then I can reproduce the test failure. Therefore,
we might want to adjust the commit message if anyone else can reproduce
the problem on a Mac. 

I can even reproduce the failure if I run the test with plain ZSH. 
However, I can't find a plugin that defines an alias for "mv". Puzzled...

- Lars

[1] https://github.com/robbyrussell/oh-my-zsh

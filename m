Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BC2203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 10:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbcGZKaX (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 06:30:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34565 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbcGZKaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 06:30:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so968640wma.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 03:30:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6eo/LbVOaSdk5WBryz1iIhbl8BrUa56+AIGCSDZ3Iyk=;
        b=Ae8FxddnZEyAvP08LdkXladlABBQHdlkg/C+0se8jYitAGr++ZrYw9okTkAPpgtI0Y
         ycG9f+CgbZ0DTksho5AhzVC3pQ+9Ktd/a7E4LqFNONI58UBGPNj8G51EtFwFErNZT5mA
         QivZzYRf9q7eVHx4n0EQCNXsasih01pHUtBaIb+IWzddkRTjwNqVOVTdglVcdt6SjVE0
         6V+H6N0C/d/nLCY5E5G9YZXJphoTfQbbpnGonLEXBr2274JLSBEeOp+Z5Xn6NdzJ1V+w
         EgAnoAYKPAIXN7fZD3911fBWFTp/3pwBtQoalL0s7/IXnQkXT8ITJVAbbfVM9PU70qCo
         Nd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=6eo/LbVOaSdk5WBryz1iIhbl8BrUa56+AIGCSDZ3Iyk=;
        b=Ys+4jtKhskQruuPhY2MOF8iIoErs133XJuTrNDWoIkx7numQnfRvc9BiX+keHJdCrx
         cKvzXkhjoRygIVLNRHZ5BvR0Q0+9HaTw2Mq+8CWUgy5Wlu3qQLdUGokEr3xDYAqUqqjd
         Sx3tFinORYGfDgOGv4oPBy9755Gv/gPOIxzJhloFoPfiSlDc/ZT/dN2nN2ZaB+hbjf8F
         bapKRd7VgOuFIBRMDw3fjlYVzy5CZYD87U7dT13V5SglsjK/rFDDVYsVMt7nOfMpUMY/
         Q7Z8qI0SLNVm6swTjEHb/7v4e/9FSOh+6KXQ3Uf3ycBsjKwVlxiDN+uNP51FZT2LcK8Q
         d+dQ==
X-Gm-Message-State: ALyK8tLjFKctsUkyWUOd0AzBpbRb2hqO3YyVpYtVnwW7lkW5dEoCe/oKPMCpr352GTVHBQ==
X-Received: by 10.28.166.140 with SMTP id p134mr42974889wme.21.1469529019139;
        Tue, 26 Jul 2016 03:30:19 -0700 (PDT)
Received: from [192.168.1.26] (afq129.neoplus.adsl.tpnet.pl. [83.25.146.129])
        by smtp.googlemail.com with ESMTPSA id o4sm203083wjd.15.2016.07.26.03.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 03:30:18 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] push: add shorthand for --force-with-lease branch
 creation
To:	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
References: <cover.1469483499.git.john@keeping.me.uk>
 <4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
Cc:	git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57973BAD.2020607@gmail.com>
Date:	Tue, 26 Jul 2016 12:30:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 23:59, John Keeping pisze:

> +test_expect_success 'new branch covered by force-with-lease (explicit)' '
> +	setup_srcdst_basic &&
> +	(
> +		cd dst &&
> +		git branch branch master &&
> +		git push --force-with-lease=branch: origin branch
> +	) &&
> +	git ls-remote dst refs/heads/branch >expect &&
> +	git ls-remote src refs/heads/branch >actual &&
> +	test_cmp expect actual
> +'

Do we need to test the negative, that is that if branch is not
new it prevents push (e.g. when <branch> is HEAD), or is it
covered by other tests?

-- 
Jakub Narębski


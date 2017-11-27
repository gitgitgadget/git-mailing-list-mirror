Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BD520954
	for <e@80x24.org>; Mon, 27 Nov 2017 10:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdK0KWl (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 05:22:41 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:38645 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdK0KWk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 05:22:40 -0500
Received: by mail-it0-f53.google.com with SMTP id n134so20624601itg.3
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=afz1/kQz7Ot2mRq5fBcN/giIrqrvhCXkc5f6gXw+BHA=;
        b=RV/bP90sUog+joZQjHUoiQdx1YSlfIDVpsYQA9tU/o4aFC2oKnSGTgOcxJK8NUf/pF
         RCQmqOxWON2EA6JAEQMdY5tJmI11THFxYpM1pHUtKZlwl8vtmefNSPG/689uMk1SO6o4
         ipyNKNqTtI+G3HgnO2NfRzA2aECKtnE5ddrfryqMghzuc2GngiA/hY1VFH8x4P1/rqs/
         0SnUZ4Eh7W+KtzSGLuG9Iz02ZEMJjXbq9F74eD1wZkMdFTUr9EVawAeUqNJeVgFR+J67
         BqRYAODtn20d76xgGb6A7o8UuDiOcNeIdRZLGU7k17uYL/pwU2k7ex0S8dhlBgFncUJw
         ySiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afz1/kQz7Ot2mRq5fBcN/giIrqrvhCXkc5f6gXw+BHA=;
        b=kX9sy8BzfC5QnSsL77lQcpJi1N/RV0RJxlILABT87S24AkZB3xi+urNUowMTUoUJwD
         CQ1ZlZTncCQR2Xo/22E67cEqfPa+Q0eyMeQTcw2vuwDpIBN7fCEKg/1d11GrAoXcL+oU
         K6g1XYj80Vss66+rkgwN7rWc+mS5XnvAuvk/ZnVRF8Xvm689MvDoSq8JL+kzl2eXvpgY
         0iv6LgUiMFR6jcmpOXdlRrNdJTC++uRqcOYzDrK6IOHKv5E5s6cnwTb2avnUbRu56sfD
         FLmaaGiuGjVuiOxWSg6+rNl1Q4WjNhrB1yYO9VoV0xLQVKoVF28quywXTxui/SU8cWbO
         ZY/Q==
X-Gm-Message-State: AJaThX4evUfnEwmwn8zFfb8usDtq0RDJtPYS4mbb1Agktl7Tb8rT13B+
        7ddKeiGH6SuezcRzk1xwqVq70db9
X-Google-Smtp-Source: AGs4zMasckgspFEwroBRMdzdqcmSpv5LAUvP+hrDT1tgK+uSqTyTb4d8OLR3sD/JECmlDETapaACcw==
X-Received: by 10.36.239.195 with SMTP id i186mr25017722ith.29.1511778159270;
        Mon, 27 Nov 2017 02:22:39 -0800 (PST)
Received: from [10.4.2.238] ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id i201sm7304949ita.32.2017.11.27.02.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 02:22:38 -0800 (PST)
Subject: Re: [PATCH] git-status.txt: mention --no-optional-locks
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
References: <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
 <20171126192508.GB1501@sigill>
 <alpine.DEB.2.21.1.1711262231250.6482@virtualbox>
 <20171127052443.GB5946@sigill> <20171127060412.GA1247@sigill>
 <xmqqindwcl00.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b63ecdab-2283-9479-0de6-29a604c09670@gmail.com>
Date:   Mon, 27 Nov 2017 15:52:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqindwcl00.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 27 November 2017 11:37 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>> +using `git --no-optional-locks status` (see linkgit:git[1] for details).

It strikes me just now that `--no-side-effects` might have been a better 
name for the option (of course, iff this avoid all kinds of side 
effects. I'm not sure about the side affects other than index refreshing 
of "git status"). And in case we didn't care about the predictability of 
option names even a little, `--do-what-i-say` might have been a catchy 
alternative ;-)


---
Kaartic

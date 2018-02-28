Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53871F576
	for <e@80x24.org>; Wed, 28 Feb 2018 11:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeB1LAZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 06:00:25 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:60528 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeB1LAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 06:00:24 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id qzTBeK2l0AruKqzTBeKYEv; Wed, 28 Feb 2018 11:00:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519815622;
        bh=YOFNrfkN55QKWzbXbt8/IdQr3SX5mfeheteyjGZIFzM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fyCBs7xS4RYjZhPqaYmEoRpKKz+zoB9xkW892lqm8iTj8MRDMKuiecFvwWk2LaCZi
         F7ARfzHlccd9WB3mG0FCswi8LIu2pvUhKVfkeDFh0mWP37lBG0BZhmvqgxKIps2/MF
         I9iO3q4cEmdiyWaKiWyc28UQ0tK7IKeLXv2Qq4Ro=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=br5i+nSi c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=5TGShhhCOkkjIN1DtA0A:9 a=-0dqI8obaBt8hneB:21
 a=6VP2jZ5Itb8Tth0V:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/9] t3701: indent here documents
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
 <20180227110404.16816-3-phillip.wood@talktalk.net>
 <xmqqo9kanjrk.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <12a03e03-640e-90c8-0ac8-14807a1834c9@talktalk.net>
Date:   Wed, 28 Feb 2018 11:00:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9kanjrk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFwknxhfjnFmJhPIdU6fewNbWbE5ccNIfUkdr50XitvePn0fvMNwWQoo5CLJyRZX9Rd9qxvvFH+DtJI+bRHCNvlkttMaqQU3PHCrYcarIs0mR711xYvo
 OFjAdO1ilVdW39na0PtHkTitaj0gYWkUvmzqZosoHudTwCoxQUjUpw5NukkgJQYYJSCWFpnvWWj7LllMGNWnqthrcWUb+MqItcBK0UFDvaP9RvAPZKeJ8lwv
 NcUpfiYtBvSkusIAdHun/qvUUenRfuU2OymD2juRs0kQJARLuxATUzQbL5h5JFGVmGn1DfgbKsrtXLVDt6ePcFcoMitWs1cYMqm9w5CORlY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/02/18 22:35, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Indent here documents in line with the current style for tests.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> This loses the hand-edit-while-queuing done based on Eric's comment
> for the previous round (see what has been queued on 'pu' for quite a
> while), which is not very much appreciated.

Sorry as you had not commented on that patch I didn't realize you had
edited it before queueing it. (There are probably other here documents
in that file that were already indented that would benefit from Eric's
suggestion.)

> Also you lost the title fix done while queuing on 6/9 (see 'pu').
> 
Is there an easy way for contributors to compare the branch they post to
what ends up it pu?

Best Wishes

Phillip

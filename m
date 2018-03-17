Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF9F1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 18:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeCQSNf (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 14:13:35 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:37122 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbeCQSNe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 14:13:34 -0400
Received: by mail-pl0-f51.google.com with SMTP id w12-v6so7764508plp.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=8f2O7TAtdpJ5TzN5arJz3Uc44GIHvZ1ViHBKQ23AK5M=;
        b=dTylyBEeS/zdFtLwEiPSmtjKZXSnKRSx9nW4mkIyjLs7oEiMJLh4/hITDRqeDQemEe
         iys4d4OH58lqIS84YOsCwztIBMZ9teHxcAZDZJ2VQD5S0sOndFBerMz7Mwstx+HrLD+L
         8VudprwjL9/gSz9i/U+Caip1CapM9AyXmjqJy6WVnpDYiihQwhgdVKOAUX2axb/SdlV6
         TdUqNIcYdY5X0c4ZvZoaJpUWTXTszC5rg7dVeBox8elnyV20GDw7MnZ01yd9Cp5sPTbl
         M7867MdnPj3lQMOv6o08jhae2B+xJvAWzmP944vxLGTrit/qCoFQtkjClf7WFE/dDFUt
         bPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=8f2O7TAtdpJ5TzN5arJz3Uc44GIHvZ1ViHBKQ23AK5M=;
        b=NWgSociWgI1B8YOseyw340c+je1Ml+zDMHLaaPagOlQU2Dz7W2RDZ3i8R/Vf5vcxUX
         NkdEiydXtJBc2+Kwd3Z1T64SWGRedTTST58RbsQuYUPWAqP5JOu+9Z5nGIp4/LC1vJct
         +Wpf0e/HEe9c8eqb5EVRLOvQV284ntnp6Y0C51z9+vSl1EfMlh3huJZKWmr1bfcPY7rk
         Bta1Kty/MOblj7DAbmtmayppUU/RU9n8Q5sjZHb5lbCBkILQiKRXhf7yC2kuqpnqcv9m
         GsuGnyvJG3nEaltX+i8bOVApipiAUu3thz9b4U/6YaxZveepMBk8pJe/svEYYDEnyve7
         B75A==
X-Gm-Message-State: AElRT7EU/xbQGz1UfhPNLvAvHNF7H7DfurjKg/g+HCEW3o36IEHoDe1q
        MqGyKjdIvtZHl/AJ8E1xen7cwp8H
X-Google-Smtp-Source: AG47ELveC/wPj410s0bnRq6l/itfwr/1BPaF1ddjbkqqVYVRM9LR7USNhdrghxr3diw7uK/LXAI6wQ==
X-Received: by 2002:a17:902:6547:: with SMTP id d7-v6mr2820879pln.253.1521310413619;
        Sat, 17 Mar 2018 11:13:33 -0700 (PDT)
Received: from [172.22.73.22] ([112.196.62.4])
        by smtp.gmail.com with ESMTPSA id x128sm12275209pgb.31.2018.03.17.11.13.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 11:13:33 -0700 (PDT)
To:     git@vger.kernel.org
From:   Yash Yadav <yashdimpu@gmail.com>
Subject: [GSoC] Scripts to be conversted into builtins
Message-ID: <67e865ac-3303-eda6-e14b-f56607d64908@gmail.com>
Date:   Sat, 17 Mar 2018 18:14:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am a student going through the GSoC process.

In the project ideas listed there is one idea talking of conversion of 
scripts to builtins. This interests me but no pointer forward is given 
and I'd like to dive more into that idea and go through the script(s).

So, where should I look further from here?


Thanks,

Yash Yadav


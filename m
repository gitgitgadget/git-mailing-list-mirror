Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A551FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 20:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755507AbeARUH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 15:07:56 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34616 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753412AbeARUHo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 15:07:44 -0500
Received: by mail-io0-f195.google.com with SMTP id c17so26189492iod.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 12:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wyn95djlarVBCI+xF91ZjQgHdQ8dmZVJKZLnlqFhrz0=;
        b=Fg7DCprp3+6OUlP0mPa/Pl975mkBYavgjUX61j1ir2ZCLPNDT6jk4AsTjtQjshFjMd
         nc65erCXDXWhhnHAHVGzD979lJrx6e27Xt1NA6yJdRXNVHCtr6lwIV/3yqTqPc2+MH7V
         uTuFk9e7MPVLxC4fEW3ryVmN6xlODklCcAKZ+fi2ColFTo7YC0ZuBJjFzVkOGaAEv5Ns
         66pK4WN0njgBrEpyXnu6ZHbtzFkDt6SAmJnTy0B+mklY2xeG8Ahz3DLGC9yUuAcKp5Sv
         284mdMxjNBsbiZe6lOoi/ZrIPFGx9SoS9J9YGPsxb8dyh39uchr6AicwfATItlkB3xM5
         pqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wyn95djlarVBCI+xF91ZjQgHdQ8dmZVJKZLnlqFhrz0=;
        b=RyX/InVB0QP8ZQLv4suc4HjCjXMubEUAoB4v7OhxYf2uDUAn2MWHY1iwCMFkP/donr
         HN8MTdtDVs1thcVgx0AmAfQbqmPL5j1uNS25V3wYK+2ZkI7zdRvinw3oRtuRpr/lLnQv
         1AMugJyB8QDDqcuWwoo+dnncuPLFxxXX4ry/ddbAU5/K2291uQQH1K8q3dHkuYlYGyeX
         pEmyT37WyxBHG0N1+d7Ap9z901e/Hp1yXeNzu3uZ71QVX8p534buNjZHJvXsesvGj5ov
         pA0pNYYRMvioKrpWC5gnJkDPy3Osr/xEB8uupYjwAqalwf5QzHtJGE8wv/DJXvhekvhO
         EFFQ==
X-Gm-Message-State: AKwxytffUdRAemTrcROVuL31XYwAODg3BMTBJc91jWG+1k8UGPEseQa0
        CiNHJo/Na8J0Q17tcLvMTIjdXSMl
X-Google-Smtp-Source: ACJfBoubZuw+wkAglZNswo1HXSOGG6OQG8wph3Ev4sGUZRa6Lfhb2uhNlCInJ/Vriu97zuiva0wlKw==
X-Received: by 10.107.164.134 with SMTP id d6mr5709521ioj.176.1516306063453;
        Thu, 18 Jan 2018 12:07:43 -0800 (PST)
Received: from [10.3.15.151] ([142.75.254.199])
        by smtp.googlemail.com with ESMTPSA id u103sm4197412ioi.3.2018.01.18.12.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 12:07:42 -0800 (PST)
Subject: Re: Git For Aix 6 and 7
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        raikrishna76@gmail.com
Cc:     git-packagers <git-packagers@googlegroups.com>,
        git@vger.kernel.org, Michael Felt <aixtools@gmail.com>,
        Thom May <thom@may.lt>
References: <157d942b-99a9-4a75-92b9-8eb8adb17032@googlegroups.com>
 <87d127i5qs.fsf@evledraar.gmail.com>
From:   Peter Harris <peter@harr.ca>
Message-ID: <d21239cf-804d-7bc8-5af3-0d54fdbc85d6@harr.ca>
Date:   Thu, 18 Jan 2018 15:07:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <87d127i5qs.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-01-18 09:47 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jan 18 2018, raikrishna jotted:
> 
>> Hi Team,
>>
>> I have an urgent requirement to install Git client for Aix 6 and 7, could
>> you please help send me or navigate me to the correct url.
>> My present infrastructure comprise of Aix and Linux servers , I am
>> successfully using Git on Linux however I am struggling to find correct
>> package for AIX platform.
>>
>> Appreciate your quick response.
> 
> Hi raikrishna. The git-packagers list is a rather small list so perhaps
> someone on the general git list (CC'd) knows the answer to this.
> 
> I'm not aware of anyone providing binary git packages for AIX, but I
> don't use it so maybe they exist.

IBM provides git packages for AIX here:
https://www-03.ibm.com/systems/power/software/aix/linux/toolbox/alpha.html

It's git 2.12.0, so it's not the very latest version of git, but it's
not bad for AIX.

Peter Harris

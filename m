Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A85520899
	for <e@80x24.org>; Fri, 18 Aug 2017 02:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbdHRCiz (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 22:38:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36970 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753858AbdHRCiy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 22:38:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id 83so12647675pgb.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 19:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3zkL5oTo4hadPqXuTaWHU3QPZzbgOZ5n+dY/ybbg+5o=;
        b=PCoo1uhjnOoxQEM6F1P+tLqJXvoKeyLtlXo4c5EUngQGRWEmXD3/zNr5M0Yc5T0izg
         T0Y6hDYBGoKh6s2dLgsdOR55u7W2c0xcKJ1wcK3MOtPnty4SyruWfrTp5BzDe4IJIdl5
         LLfxFq21+Bvlvq6RMAD2ogmVDKuHviUwzFV4Mj8+IHa4ATvvJMSTyroL/jLHok+1+ipD
         tExb5HQ1ZcZBkh6VVY6EmayNgbQBT/g2jYsm93Ze74YtQ/diSB8UY7RWSW8mWzAaYYOf
         48TG9qhBfMuRNoIRIzBY2dU/WBL+q7xx/+Dd3YeIMocNI09kKLw1Jprr9Mis3hbwmMPV
         Q/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3zkL5oTo4hadPqXuTaWHU3QPZzbgOZ5n+dY/ybbg+5o=;
        b=YLq3xUQNB+FVyNcLPZyyKuipUzb9LDZjB+c45ncM9Qh8qMH6v0r5hW6M8X+CE1LVCa
         GzSEuxUxVfwcCnlTULbvE1XrQibGqVuxxXzg+mXs/pEittOA8KFMDUt6okm17UIRrGMa
         fFeBwqPBnxULWHdobpt+DbPkmuj44EuncdvK3aFY4psphJM74YKjqlmhnLiJAmmnOVDj
         POzteWBWM0hUld4hFFtHlzBlg0W6MS71GNWHFS6HKuCMw2/C4hSS+VXfOXEbJzFa2rwD
         UK8CyTN5d/Wd6WF85XS47r2B4rnnOl2+OEj6VWizc8CJNApQPMyjMOu19acTSKtvOAn1
         7h8g==
X-Gm-Message-State: AHYfb5jwezTFH2oOANm/MXj1hmsj1o3IJJPfxC6gWxu41e1Pz1qPV3aY
        hDtTNdgYSFCKdCtso0s=
X-Received: by 10.84.131.15 with SMTP id 15mr7988995pld.156.1503023933732;
        Thu, 17 Aug 2017 19:38:53 -0700 (PDT)
Received: from [10.4.2.238] ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id d88sm8531072pfl.158.2017.08.17.19.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 19:38:53 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] builtin/branch: stop supporting the use of
 --set-upstream option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     martin.agren@gmail.com, git@vger.kernel.org
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
 <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
 <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
 <xmqqo9reezjx.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <69172c47-0af4-4c74-a20b-82da537ad9ee@gmail.com>
Date:   Fri, 18 Aug 2017 08:09:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9reezjx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 18 August 2017 01:28 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index 81bd0a7b7..948d9c9ef 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -195,10 +195,10 @@ start-point is either a local or remote-tracking branch.
>>   	branch.autoSetupMerge configuration variable is true.
>>   
>>   --set-upstream::
>> -	If specified branch does not exist yet or if `--force` has been
>> -	given, acts exactly like `--track`. Otherwise sets up configuration
>> -	like `--track` would when creating the branch, except that where
>> -	branch points to is not changed.
>> +	As this option had confusing syntax it's no longer supported. Please use
>> +	--track or --set-upstream-to instead.
>> ++
>> +Note: This could possibly become an alias of --set-upstream-to in the future.
> I'll tweak `--track` and `--set-upstream-to` in the updated text
> and remove the 'Note:' thing that does not give any useful
> information to the end users while queuing (no need to resend).
I thought I explained the reason for adding the note in one of the 
previous mails.
Here's the portion of the mail,

On Monday 14 August 2017 02:20 PM, Kaartic Sivaraam wrote:
 >
 > On Wednesday 09 August 2017 12:03 AM, Martin Ågren wrote:
 >>
 >> Maybe the final note could be removed? Someone who is looking up
 >> --set-upstream because Git just "crashed" on them will only want to know
 >> what they should do instead. Our thoughts about the future are perhaps
 >> not that interesting.
 >
 > I thought it's better to document it to avoid people from getting 
surprised
 > when the options *starts working* again.
 >

I hope that explains the reason.

---
Kaartic

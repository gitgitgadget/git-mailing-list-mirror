Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2652027C
	for <e@80x24.org>; Tue, 30 May 2017 20:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbdE3Ukw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 16:40:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34040 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdE3Ukv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 16:40:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so5296987wrb.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pf1p3V4qrzWG36eNCFzmKKWpmSm27AsCW2jD3vPr7To=;
        b=cCFYFITIaqj3Vi7RzTkQ1ZzOU8D/C/4kJbRFD2F4x9p2QNCN2HW7BQpkkf32kTvbEq
         qZ+Epo2NePS71AcoMjpDjoqlvR6BuknaKygylqeHYJh006Svpy3pwGiumOmtQIWQlW2a
         LLw7xe7bWODdyBnmt1DM9C7/p0/ce4ClGQM5Hx7Vf2dR28ieJYAIy/Pu+xUcTY60A1Cg
         fkAqdVWkrunU/TqxifaNBpn1Dp8IulWLrdj990nb14Sh/pDJEZfoxI3V3Bt4srdgetBW
         WWSaM8Q/N+S5HNWLQdkQMfj0fC/47HMvti6MOn2UIUvwdIHHcSvIDH2Mgu0SGQydQbpJ
         0hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pf1p3V4qrzWG36eNCFzmKKWpmSm27AsCW2jD3vPr7To=;
        b=aKk98n9wjp02wfzI9E6eAP7PXRPTjUs2veZQ2uhat1omPIpyvN1qweHxzYgieKdEPX
         zXBms09Mi/PA1WMzyAiWlrAulDXMq1i31U+8SR7/GiXc4AoQ+8vbdMZucaIUDYRPNmD3
         SOke0eukK1DmMuVSURK3lmjhvMlilIurlsPQZPrU2tScS4+4n2z0xAUSP+LGI/031enp
         H7wngQg8bkBvCcJCWdssoRt59Lwlrt0DyiOXZQTDqPff/Kc2UKXZ/svXWovc196Iq1Aw
         RGJBAFbKUpGIIpgBbb0wREvGFHj3HJfVAHxBJk5H7n8s1/YiO2m+AmnOUoKqLDqHbB+R
         fEFw==
X-Gm-Message-State: AODbwcDSNI69BwcBWajsPADwk+CPq37F+xwS/EHkO2E979f9EEkGrzZk
        3BQHIFZdETVu3Y5W
X-Received: by 10.223.171.212 with SMTP id s78mr6235332wrc.116.1496176849730;
        Tue, 30 May 2017 13:40:49 -0700 (PDT)
Received: from ?IPv6:2001:a61:345b:1800:859b:523d:9d4b:b3ec? ([2001:a61:345b:1800:859b:523d:9d4b:b3ec])
        by smtp.googlemail.com with ESMTPSA id p187sm19650120wmd.20.2017.05.30.13.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 13:40:48 -0700 (PDT)
Subject: Re: [PATCH] doc: Improve description for rev-parse --short
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20170528143322.8580-1-asheiduk@gmail.com>
 <xmqq1sr7dly4.fsf@gitster.mtv.corp.google.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <787ad1fe-9923-d47d-79b0-8b0aebd8eb9b@gmail.com>
Date:   Tue, 30 May 2017 22:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqq1sr7dly4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.05.2017 um 06:10 schrieb Junio C Hamano:
>>  --short=number::
>>  	Instead of outputting the full SHA-1 values of object names try to
>>  	abbreviate them to a shorter unique name. When no length is specified
>> -	7 is used. The minimum length is 4.
>> +	the effective value of the configuration variable `core.abbrev` (see
>> +	linkgit:git-config[1]) is used.  The minimum length is 4.  The length
>> +	may be exceeded to ensure unique object names.	Implies `--verify`.
> 
> "Implies --verify" is less important than the fact that multiple
> object names cannot be given from the end-users' (and readers')
> point of view, no?  The sentence in the pre-context still hints
> (incorrectly) that we might take multiple names---that would want to
> be corrected, no?
> 
> Let me try.
> 
>     --short[=length]::
> 	Take a single object name, and output a prefix of the object
> 	name whose length is at least the specified length and
> 	sufficient to ensure uniqueness of the name.  The minimum
> 	length is 4.  When no length is given, the effective value
> 	of the `core.abbrev` configuration variable is used.
> 
> Thanks.

Your are right about s/names/name/ in the pretext.

But I think that the link to the `--verify` option is still important.
The text there talks about when something is output, exit codes and
about `^{type}` peeling. Also `--quiet` is linked to
`--verify` and hence relevant here.

So I'd like to patch your text to this:

  --short[=length]::
	Same as `--verify` but output only a prefix of the object
	name whose length is at least the specified length and
	sufficient to ensure uniqueness of the name.  The minimum
	length is 4.  When no length is given, the effective value
	of the `core.abbrev` configuration variable is used.

And I'd like to move the section up right to `--verify` and `--quiet`.
The options in this section are not sorted alphabetically anyways and
the relevant parts would be adjacent. Is that OK?

ALso: Did you remove the `linkgit` by intention or just by accident?

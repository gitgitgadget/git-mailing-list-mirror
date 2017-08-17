Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B5620899
	for <e@80x24.org>; Thu, 17 Aug 2017 12:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdHQMDI (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 08:03:08 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36113 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdHQMDG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 08:03:06 -0400
Received: by mail-pg0-f47.google.com with SMTP id i12so41653509pgr.3
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sGSDL6zDABonoGbnb2aFan+DzGEjBehyPoq+CU0uTlk=;
        b=JjJiL5Q3wXAZ2FRX9BSg3hwaw9zMKgn5TVYSqg8FMcyG3XaXzTbiRMZpgTRq2M4NMp
         tpClxA39xrLDPTouuYdgraguJtH8nzxoHQ+XawvLCwO75fDZnF7WotOtSgC5qPd3FuJt
         CONQX0WLJ6etQZ1noxR6GTaAvt2+v5tMsj8eGRGY7mPVmminEthM2xxmwJGNAsIZvFTv
         GQyZQ6/rTJqtHQpPUgJunTr5o5YKXQt9VpxUZiYh5pIVKgy8bmEF/D+97L/HF8NgAesM
         EJ9e21AOYO97FZVu88VQWZ6G04eik/KrmV/tw34HXdjcWLnW89d4RDCpo+ciXeTifN5S
         vPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sGSDL6zDABonoGbnb2aFan+DzGEjBehyPoq+CU0uTlk=;
        b=lttMSiD2a3CAPtyam4MWzD3NrXoDum4haz5fvQdudGYlLKO1/V5gciQLFq0hesc0Jo
         BfAykawzrZXztQjpRQFe72wiFyIn8Oz0bqszG8UrK/9xG2LPdc6NzIaQeYFuDhxwcubm
         lY8iaNENbfIv2KorSJajRR6ml7VHxrJuTwft6SVzL2I7Oatyfb5QlsaTC3uFmYgPsXh6
         4TslfMONUSbsLhdvCykyQbVqNdNP9Mkr/DeUmrCfpw4oHM4YFXmrVXBRXgOhDsia5BkV
         OAU5jDu4rRFDvfkgPM7pkZSYNPjgyVCrTOd0tl0Melvu4x5sJsSe+glnSiD4M2D0ateT
         yr7w==
X-Gm-Message-State: AHYfb5hCod48yWnqxIoP5WfB7epWRCk7YUHRrviigTD5ba7Ui3batd9C
        2HV3UqDXjgn4437t8cA=
X-Received: by 10.98.78.6 with SMTP id c6mr5038755pfb.307.1502971385568;
        Thu, 17 Aug 2017 05:03:05 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id p62sm7341507pfg.66.2017.08.17.05.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 05:03:04 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2017, #03; Mon, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqr2wdso3k.fsf@gitster.mtv.corp.google.com>
 <943ad6c6-a5fb-cbb0-9eca-ac1c3e51fa15@gmail.com>
 <xmqqvalnjori.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <d797f50f-37b0-872e-d2d0-5d61e3cfae51@gmail.com>
Date:   Thu, 17 Aug 2017 17:33:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqvalnjori.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 17 August 2017 12:58 AM, Junio C Hamano wrote:
> Nothing has.  Neither thread seems to have any comment from anybody
> but you, and I took it as an indication that people do not think it
> is a good change.
>
> I do not find the s/branch/parameter/ too bad (although I would have
> said "arguments" instead).
>
> For the other one, I personally think split sentences and lines make
> output look worse, but this is obviously subjective (just like the
> patch itself).
>
Thanks! Will keep this in mind in future. BTW, what about the patch that
did get user attention?

https://public-inbox.org/git/<0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>

---
Kaartic


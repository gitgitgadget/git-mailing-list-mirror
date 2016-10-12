Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEF3207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 15:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbcJLP2H (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 11:28:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33285 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933253AbcJLP2A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 11:28:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id i127so3726576oia.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=46df7ZX/tJnjK3bsP9CrgXgubZp8HB7/0nqTpEEvbNE=;
        b=pnnmEg6yxHxBD1+M23uHy13MlwDb2KAL48px5EMex84b7zNNRruBb+qoRc2xd1d76a
         DxkZ+Oeh1KohkZ2LbV5rxnG/VYro12QBt8fSAFLw2Ugs0rhshleYB12sG4H+pXiNKKRT
         JPu6hWKOZUnVxrdMtFv4yQI67NHNf69Qva1tL9dO3+Igo9fpD/CjcHGZEFtEoUHZ0/cF
         xPa9YbaBT4baSeRdK+QO/zxvD4C0yz1komstDfL0q94tlrpOduHJEQ2zaMrgszh+k48F
         D5myzOnK/YLdtMXkHEiJYT2KJAIdPzjGzLf0fGqSM+tVLMwXUO7rLW73NcTlEiB4V+Mv
         VDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=46df7ZX/tJnjK3bsP9CrgXgubZp8HB7/0nqTpEEvbNE=;
        b=VzccPItxMpTCavK9kbAIAoz0ThKVZ3yeXG2UcYsrEFVb08sOE3ZB5kFrGHTB50Rme+
         FFrZrXv0vYl62jHAMmmMUqje+3s4ccx//f8pDB1ID6eIW9Up/FT13AYysOqEBghZIxl5
         G7ZVfdhcP8eqmmMRvkKS0eNhcfuYjwzqBd7uU86ChuNRcEg+sxlhrulpkdAucwatX4WY
         5UGwcT4DRGAz1CK4057uR+KAf5kis4e5CEyf/l5EGMyQg4seQBXMXTrbNC77fIilF/PW
         7qXQHycXawKjYNKGM6Ek0K+u1ytKv68QiM2zgtL7unQXuTSa8BqO5Ossv9LmOmILKd2U
         l3qg==
X-Gm-Message-State: AA6/9RnauhoM4xeUvIFQrBHkAj5JJPfccD8xcwjqGpZIJRwSfRBojFmIfD1wTVVz876LUQ==
X-Received: by 10.202.56.132 with SMTP id f126mr1125891oia.73.1476286078682;
        Wed, 12 Oct 2016 08:27:58 -0700 (PDT)
Received: from larrylap.suse (cpe-24-31-249-175.kc.res.rr.com. [24.31.249.175])
        by smtp.gmail.com with ESMTPSA id v79sm3064621oif.20.2016.10.12.08.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 08:27:58 -0700 (PDT)
Subject: Re: Formatting problem send_mail in version 2.10.0
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
 <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
 <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
 <vpqfuo3l4fl.fsf@anie.imag.fr>
 <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
 <vpq4m4iamfs.fsf@anie.imag.fr>
 <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
 <vpq60oy589b.fsf@anie.imag.fr>
Cc:     Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <02cfe81b-9f6a-ddbd-3411-2839e8a58b1e@lwfinger.net>
Date:   Wed, 12 Oct 2016 10:27:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <vpq60oy589b.fsf@anie.imag.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2016 02:36 AM, Matthieu Moy wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
>
>> On 10/11/2016 11:18 AM, Matthieu Moy wrote:
>>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>>>
>>>> That added information at the end is intended to be passed on to the
>>>> stable group. In this case, the patch needs to be applied to kernel
>>>> versions 4.8 and later.
>>>
>>> OK, but where do people fetch this information from?
>>
>> This format is used in a patch for the kernel. When the patch is
>> merged into mainline, stable@vger.kernel.org gets sent an E-mail with
>> a copy of the original patch. Maintainers of the indicated systems
>> then merge the patch with their stable version.
>
> Sorry, but this does not answer my question. I'll rephrase: when
> people behind stable@vger.kernel.org get the message, how do they know
> which version of the kernel they should apply it to?
>
>> I do not want it in the body of the message. I just want to pass a
>> hint to the stable maintainer(s).
>
> If it's not in the body of the message, then where is it?

That information is supplied in the "Cc: Stable" line at the end. That is the 
point for the "[4.8+]" notation. That means apply to kernel 4.8 and later. 
Without this information, the patch author has to monitor the mainline kernel 
for the application of the main patch, and then send a separate E-mail to Stable 
indicating the version info. When the info is included, then the process is 
automatic. I hope you understand now.

Larry



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0585820248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfCUWMD (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:12:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46406 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCUWMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:12:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so214821wrs.13
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n/pVG8/WblF9KdySkHnET7nKhUD+dLxdaKCSj7IMZLg=;
        b=IldFZRIsssVJpP7Uk+uhgwYwR9fxYnxpZ/xJXpdbxifJbYb8MMixVa0ErTrvKfcMG8
         dISg/MTHgk6rbX1w3t5KFaaD/HmssIgtau9XmALkLT56Y92M9TVmxjRatLSIXdnzNO0f
         vfo/TQkKnvcv3LAJI5SoMNYvasGymw/aPk54lUnQVbENbQ5Hed1bU1S55n81a9B25wKV
         R+oSDsd9YjXw5Hb2QhoL3WFxy/EetABySnhXgsYmZxWcjFkXyj3S6q2NGyQ41H5sJO8a
         U/hkbuC4RXk/AumBucRZI+cgNY6b1n80IJ9YQJK06yDtHZLkJqF1zHEEyz97T7bJP++7
         69lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/pVG8/WblF9KdySkHnET7nKhUD+dLxdaKCSj7IMZLg=;
        b=Iyr5gn0jeSf2OzUKjX2KqOEjStGUEb252+giKCPEqT0DNN1I1NnayBUdxoPd7/ZRec
         gUz/TqzhOILR7d/WS5i/u3o+QD6cqqalbI8vxAFtUH/Tz4PZ4dgrsonFes9TJGtYDeXY
         skrysIWSm7DpuQaSIG/tDEEa6iHf5LcHF+iQf4teNkxJ6mZpP93hgnn4b2z+2uR9NkdV
         MeBcD8WhvpZHqGTE0c224zoVSqmzD3XDG21Kwx+WWpegJtp2On+dh1TRnu13pR11pKct
         61Pg29rcnt4+TKLK0H3wHoUukQOCQ69WRoa+6/ssv5Dc+GtsoX5t5/e5O+8vUErSjubG
         4Fag==
X-Gm-Message-State: APjAAAXAK2poLnO7elgdTq721oI0HANsQ2SRhmaHhGRrwld+bzNh7Elp
        UNAC66lfiEqoOAJf+6S7eg4=
X-Google-Smtp-Source: APXvYqxiMF+S1hm2V3gsm8I0fZQn7G6ugLOTIagg84hzQqQ5wzPzxcD7KYTZq0/nd1lPX4ogJDFrbg==
X-Received: by 2002:adf:9c8e:: with SMTP id d14mr4023751wre.237.1553206321534;
        Thu, 21 Mar 2019 15:12:01 -0700 (PDT)
Received: from ?IPv6:2001:a62:1401:b801:e94e:b0ec:3a32:7f61? ([2001:a62:1401:b801:e94e:b0ec:3a32:7f61])
        by smtp.googlemail.com with ESMTPSA id 7sm16410070wrc.81.2019.03.21.15.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:12:00 -0700 (PDT)
Subject: Re: [PATCH 2/4] gc docs: include the "gc.*" section from "config" in
 "gc"
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-3-avarab@gmail.com>
 <20190318213139.GF29661@sigill.intra.peff.net>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <4dba2718-9e93-4f07-8f67-f79a8a9fbb0c@gmail.com>
Date:   Thu, 21 Mar 2019 23:11:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318213139.GF29661@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.03.19 at 22:31 Jeff King wrote:
> On Mon, Mar 18, 2019 at 05:15:00PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
>> Rather than duplicating the documentation for the various "gc" options
>> let's include the "gc" docs from git-config. They were mostly better
>> already, and now we don't have the same docs in two places with subtly
>> different wording.
>>
>> In the cases where the git-gc(1) docs were saying something the "gc"
>> docs in git-config(1) didn't cover move the relevant section over to
>> the git-config(1) docs.
> 
> Makes sense.
> 
> I think we lose the actual example for gc.*.reflogExpire:
> 
>> -The above two configuration variables can be given to a pattern.  For
>> -example, this sets non-default expiry values only to remote-tracking
>> -branches:
>> -
>> -------------
>> -[gc "refs/remotes/*"]
>> -	reflogExpire = never
>> -	reflogExpireUnreachable = 3 days
>> -------------
> 
> I don't actually think it's that big a loss. If we wanted to retain it,
> though, it might make sense in the "EXAMPLES" section.

Coincidentally I stumbled over that example a  month ago and immediately
put `never` into my configuraton for a certain - often rebased branch
(something like "pu" here).

> 
> -Peff
> 


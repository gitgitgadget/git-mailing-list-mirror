Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105581F859
	for <e@80x24.org>; Sat, 13 Aug 2016 00:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcHMAa0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 20:30:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33034 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbcHMAa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 20:30:26 -0400
Received: by mail-pf0-f196.google.com with SMTP id i6so118560pfe.0
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 17:30:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=hZKdiYXN5MDCsX5tBTF+mhE5UiQ84Un0R2m/BNk1Rvw=;
        b=uOPSyT15EoD5gidwAmxrnjt2AOWh2JlpJXgdp0SV01DVjV1mPIju6dtftRn8oMOf4Q
         QQqztp3DDJvs23JqJwNLOVfprSipnBE5Pma9JF0Q3RPP3vSoQWd59uxskuZRICGBKxEc
         W7D/C54OJVW26FkveJ9HHj9j/d/KNK3lEjDbP2j505jgcBQCCzRPkSeoeuAGL7WsmRwL
         dMq4wY2MdZQrJf89/Ght9jKY9A9KPq8XuP2FSTH1N3uILCe0Hh5u/03aC5EundgCBGCP
         3fqEWfIKyX3fB9blSWe9YUbDZ8EBb9qbsXraakEeIn+J3jA9svubZX3qDq8O23NGhQGu
         SzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hZKdiYXN5MDCsX5tBTF+mhE5UiQ84Un0R2m/BNk1Rvw=;
        b=Z0n5XI0c2ew2Od4LJpIspj2AzWpluLCm2zBEzczaFanghXoqfOPQ6Ccg7h1KuzY/PS
         RG1gU00hUqwDpgYuMsWTztCv/rD6i2UPc0Vhlga3qJ3xxVfIFiRRX2Od8mRFK33aODiu
         0MW+m7jFShsWHl+z/uBoiXxG98raWYdj5T+cCdQMFRz0C4RrL/GNWSRcBiiweR3YQgVE
         l3XcOTrC3dn/N5knBaorjpYK4l1YzcS4ZszjM5svgBbJrai+UEun+JUI5x+DFXns/4/L
         eIsO1Ay1mStthKN7h4MOCNV0CEaFIS/jygOOBwGrKKm82AoyFRpF1JSMAfoVkO5LKdr/
         ATsA==
X-Gm-Message-State: AEkooutV7t17fBvnjFo0jdDhy8kaFX9j3EdChgKuifJLzNPFsTRQ98rktBf6vRiqbmU1VQ==
X-Received: by 10.98.27.200 with SMTP id b191mr31952770pfb.111.1471048225255;
        Fri, 12 Aug 2016 17:30:25 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.174.142])
        by smtp.googlemail.com with ESMTPSA id w64sm15649508pfb.93.2016.08.12.17.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2016 17:30:24 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
References: <nn1euf$h6q$1@ger.gmane.org>
 <d2ef9717-beb2-2661-d0b0-4e33f82511ae@gmail.com>
 <be1b1fcd-48d7-facd-f45c-0c52e6c12e88@gmail.com>
From:	Sitaram Chamarty <sitaramc@gmail.com>
Message-ID: <0e542a52-16ed-8967-fe1d-bfb5a728518c@gmail.com>
Date:	Sat, 13 Aug 2016 06:00:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <be1b1fcd-48d7-facd-f45c-0c52e6c12e88@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/12/2016 08:07 PM, Jon Forrest wrote:
> 
> 
> On 8/12/16 6:11 AM, Sitaram Chamarty wrote:
> 
>> At present gitolite is -- AFAIK -- the only "pure server side", "no GUI"
>> solution for access control, and has some interesting features that more
>> "GUI" solutions may not.  It is also (again, AFAIK) used by kernel.org,
>> Fedora, Gentoo, and several other open source projects as well as many
>> enterprises.
>>
>> If you're ok with adding that, I'd be happy to supply some text for your
>> consideration.
> 
> I appreciate your offer and I don't disagree with what you're
> suggesting, but my goal, for now at least, is to keep the same coverage as upstream.
> 
> If they add something about Gitolite to their next edition, then
> I will also.

Oh ok; I must have misunderstood what "2nd edition" means, or did not read your
original email carefully enough.


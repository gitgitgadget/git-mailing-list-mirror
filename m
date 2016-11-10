Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE262035F
	for <e@80x24.org>; Thu, 10 Nov 2016 11:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755308AbcKJLHT (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 06:07:19 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32851 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754704AbcKJLHR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 06:07:17 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so2385711wmu.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 03:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DuWQPtLoRKYKm5QCrDIE2+TpxU/OZAbIKQ/i7U1gjW0=;
        b=FyaYveWooHSOM0MXIBNnycZVZXjiFHgGCbaL94lBvHqDKCY8zuwBe/wu88QlnZCAu3
         XjhXYCT8yyW+A1dVpHG0cqZ3upmPpZE1/qjCAhtqRzKWG/+ppKfr/OQ1C3gJbp1Jsfw8
         r1DPGPdK7L0Lj1Sl8Zim4KDHxyrnyQB7+VL8bSLpeaHs+t0URnq6apl4r0TkshVZIoLv
         fN2kd7k/UwHwmLM6ngE7aswcyVgf7AdbsJajVZlzvWsPcDKrtnrAtBwmfmpgBc1OQAZz
         DJ+Zi9/fvq7i9iuJltim7ZP/NY5edjMjhKNWRWCoEO/VObMFQ0HHeX+SUjH45TkA9sIH
         IO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DuWQPtLoRKYKm5QCrDIE2+TpxU/OZAbIKQ/i7U1gjW0=;
        b=L62UehTwCiZ4WO4INIUlzct/lIMscWMO+hViJWQ9Obcu/4RX9piVlnfHF2wrMjZlHB
         ZBAno331mDvFBx6D6SWaNs0Xkh3Z2v9SPcLz0MA2pitS/Jqen12+qqA7FV4+H96XQzV5
         7NVY3qRlDPhPCkYeX+q5diI2fhcPPacV4rE3+d74rX0k+YW9wcW5f9bLysvfEZQUNQ7A
         uxodivyafNKF/mW7dWxhp28/ZlTdskJRFZrqzPZOQu8FpdnzIIeesfgKRgEQxnaZuZGU
         CMvexLwOrKTig90m2mIr2t+hZK5u2p9K8tXZc8wUO5SmrZO5YBLEhhgASVOEBx43ntJN
         QPZg==
X-Gm-Message-State: ABUngvfL0Tpb0l3RX1hUvKkdkRMWGMKN8cp0BRDkfSpq5dbE8T3kuxc5o3TV146XCtOJ/A==
X-Received: by 10.194.120.167 with SMTP id ld7mr3749359wjb.206.1478776036297;
        Thu, 10 Nov 2016 03:07:16 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 129sm12347044wmq.9.2016.11.10.03.07.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 03:07:15 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
Date:   Thu, 10 Nov 2016 12:07:14 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <20161017002550.88782-3-larsxschneider@gmail.com> <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com> <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Nov 2016, at 22:20, Jeff King <peff@peff.net> wrote:
> 
> On Sun, Nov 06, 2016 at 10:42:36PM +0100, Lars Schneider wrote:
> 
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> TravisCI changed their default macOS image from 10.10 to 10.11 [1].
>>> Unfortunately the HTTPD tests do not run out of the box using the
>>> pre-installed Apache web server anymore. Therefore we enable these
>>> tests only for Linux and disable them for macOS.
>> [...]
>> Hi Junio,
>> 
>> the patch above is one of two patches to make TravisCI pass, again.
>> Could you queue it?
> 
> I don't really mind disabling tests if they don't run on a platform. But
> the more interesting question to me is: why don't they run any more? Is
> there some config tweak needed, or is it an insurmountable problem?

I can't really remember what the problem was. I think some apache config
required some module that was not present and I wasn't able to get this
working quickly.


> Using Apache in the tests has been the source of frequent portability
> problems and configuration headaches. I do wonder if we'd be better off
> using some small special-purpose web server (even a short perl script
> written around HTTP::Server::Simple or something).
> 
> On the other hand, testing against Apache approximates a more real-world
> case, which has value. It might be nice if our tests supported multiple
> web servers, but that would mean duplicating the config for each
> manually.

I agree that the real-world Apache test is more valuable and I really want
to keep the Linux Apache test running. However, I don't think many people
use macOS as Git web server and therefore I thought it is not worth the
effort to investigate this problem further.

- Lars

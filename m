Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C841F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935318AbeB1WRe (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:17:34 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36509 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935314AbeB1WRc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:17:32 -0500
Received: by mail-wm0-f52.google.com with SMTP id 188so7952300wme.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XydACjSVRXVQZrXSqKsA4hDhqZStVtHjZOkxZ4H9YZg=;
        b=DGYfF0pw9S0YwfkJeigu7gpYD2S75h3y/jXlVLu37FPXAFswM+K9QaJOwnGrp0OHxh
         NI27cu/h96/kkXm2ZLLQg9R2kZFEUJZvlcfncjdBBUo4ZO8ZMGKFpGc+RSqCRDT1GgMX
         C/3m6jWmBYRZMLYfo5F7wVlIhpGBiZXr2MuvKZPa/R1uYOegKbG6K62bLl/mriRu72R9
         F/jFdh0Cdhr2x4Iwb6sYo0LyDpyh8VTcGq/xsDDQVIOyUTu0TSE0mmyCU+4ff578L6rE
         8kw8h/0uDWESIugHXakhhDAuprepDuzNFE9G2zSwdcsSzOv2dmFmEh058om4U8WzSEy6
         T51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XydACjSVRXVQZrXSqKsA4hDhqZStVtHjZOkxZ4H9YZg=;
        b=tLsxhV8A7xjwvZxBM9aTNnGFHFEFr/LEMi5bb1Em/fmZHknjElRTYBOIeCWDaHMas6
         lVF3z/+DzxzDEdvAsmzS3pwhRNwJVzLHV1bCVFIG/gbS0ZN81BeCGZWhRJpELaCHm72w
         XCrNDaaKk3jdE+iDm4+eppd81F8jsqiGgrXNMrGqn74nBQgtdnpDcPgik0TqU1nNpYeY
         PxYMdFtIjIj9gdk0jCWwYekHgMjwLNHBwOcAFgZ4noRD59fzrX/713LgL4/jD2D8Mbdm
         BRA/c4P4MzGE5Pnr7kLciXW8iohkw964Vic4CSFcOBV7T21CA8jL5LzagLUCiWSOEth3
         bg3A==
X-Gm-Message-State: AElRT7EJIfxoBKQhsnaP4rRPJU+oM+CCv9ULCVxQx4VMTYuuE9yBA7fW
        i7fq50ut/T6CL656ceHSmXs=
X-Google-Smtp-Source: AG47ELu/xRTO5nxACeFlvRDAeEHmIbGZ16P/4LGFX0xPnchvgzet/mNV+BRQ0Fwakpesq7xghF+TNA==
X-Received: by 10.28.150.138 with SMTP id y132mr45932wmd.104.1519856250924;
        Wed, 28 Feb 2018 14:17:30 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 43sm2601816wru.40.2018.02.28.14.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 14:17:29 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
Message-ID: <7c34a060-3013-6404-fe8e-c3ad015803a7@gmail.com>
Date:   Wed, 28 Feb 2018 23:17:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/02/2018 21:25, Igor Djordjevic wrote:
> 
> But U1' and U2' are really to be expected to stay the same in 
> non-interactive rebase case only...

Just to rephrase to "could be expected" here, meaning still not 
necessarily in this case, either - I`ve just witnessed 
non-interactive rebase Johannes previously described[1], merge with 
`-s ours` (dropping B* patches), plus B1 cherry-picked between 
X1..X2, eventually coming up with different U1' and U2', too (which 
would produce a wrong end result, if continued).

But I guess this should go to the "complex history" pile, good thing 
still being that diff safety check between U1' and U2' works as 
expected, thus automatic merge rebase can be aborted and command 
given back to the user for closer inspection.

[1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/

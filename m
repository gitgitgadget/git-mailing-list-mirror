Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA511F859
	for <e@80x24.org>; Tue, 16 Aug 2016 19:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbcHPT42 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 15:56:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36271 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcHPT40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 15:56:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so18101408wmf.3
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 12:56:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QuiE9Dc5tE0x7cN2Uu0g8xX79QsBhVZJ+znAkwZZEEI=;
        b=sN3jUTZD3ZQ6Z/lK76iNPfWWTlCHvSxGN29S+8QwIRlhnJm16Xy0dTSr4/DBt7N3UL
         YlLDGa7gAaclTC8sM6+Lmv+fObEfcnDHIFnBkqilWQuvEnsd7BuA0MD4KgHy7CBMERSs
         jslpc4UyjNaOnBbsLmO3+Vttcq+7BHHooMxQ8wzGEv8wZOMQnGuCOmFfvbL4D5y5njSw
         bBKdX4HWYpjUyhSP6z5KdzUEQwo4fD8iAgIWv8QWoQI5mVjjlt/XmpHzOvA5QJ1mvDUS
         HumDqkpIrjmuBi3fzMaVOsCjRNCQ2VzCViqAjMhaFWxam1JRG9i68YpGluTe0p0wa8+t
         vgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QuiE9Dc5tE0x7cN2Uu0g8xX79QsBhVZJ+znAkwZZEEI=;
        b=Q3R+HqZgimr/6F4e0l28GAMZKmR5kQIhZbDnx6nKRFkZi15aCRtMidzmcInk4Os5sC
         fdvtmN2cKFoAv4qcTi92eD9aOkOVZ1QdY4Y+92r9fBU0gVB0xRxU/oiDgHIOXmFx53bz
         0ddLhvutiBSJaWNINDFk9fvbjhQvPtDyfj6wDbwsUHF9wBtpzZ9jO4X2BYvZNNQeyq7F
         ld3GioUi+vcyzQ4QbIti2l+Xrfkr/IOsF/0oM5itUkBWeJpOffrMxHC/RA4Sei6eJB3B
         mozs6bBaB1aBEqZ7WMAkIJVfcXi3dZAmT1UHtO2y5FM+VdXZpQqxL7Jr55TVZb++Xrz/
         o80w==
X-Gm-Message-State: AEkoouv8lC11uJlhnugN8+RsyuaoCmtwiPWI9KbF/MSLJqOwinKaosVN8pdCPO9Naowisw==
X-Received: by 10.28.153.202 with SMTP id b193mr24326069wme.62.1471377380181;
        Tue, 16 Aug 2016 12:56:20 -0700 (PDT)
Received: from [192.168.1.26] (dcb51.neoplus.adsl.tpnet.pl. [83.23.53.51])
        by smtp.googlemail.com with ESMTPSA id cw7sm28184061wjb.38.2016.08.16.12.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2016 12:56:19 -0700 (PDT)
Subject: Re: Working with zip files
To:	Junio C Hamano <gitster@pobox.com>, David Lang <david@lang.hm>
References: <87y43wwujd.fsf@thinkpad.rath.org>
 <alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz>
 <xmqqeg5oejmn.fsf@gitster.mtv.corp.google.com>
Cc:	Nikolaus Rath <Nikolaus@rath.org>, git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <34d64f4f-3cda-385c-cdce-5f1852d545e3@gmail.com>
Date:	Tue, 16 Aug 2016 21:56:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqeg5oejmn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 16.08.2016 o 18:58, Junio C Hamano pisze:
> David Lang <david@lang.hm> writes:
> 
>> you should be able to use clean/smudge to have git store the files
>> uncompressed, which will help a lot.

You can find rezip clean/smudge filter (originally intended for
OpenDocument Format (ODF), that is OpenOffice.org etc.) that stores
zip or zip-archive (like ODT, jar, etc.) uncompressed.  I think
you can find it on GitWiki, but I might be mistaken.

>> I think there's a way to tell it to do a xml aware diff/patch, but I
>> don't remember how.
> 
> I do not know about "patch" (in the sense of "git apply"), but "git
> diff" (and "git log -p") can take advantage of the clean/smudge
> mechanism.  I used to deal with a file format that is gzipped xml so
> my clean filter was "gzip -dc" while the smudge was "gzip -cn".
> Essentially, this stores the xml before compression in the repository
> so blobs delta well with each other and also the revisions are
> made textually diff-able.
> 
> Nikolaus's case has one extra layer of complexity in that the "file"
> is actually an archive of multiple files.  The clean/smudge pair he
> writes need to be a filter that flattens the archive into a single
> human-readable text byte stream and its reverse.

There is also `textconv` filter that can be used instead; it might
be 'unzip -c' (extract files to stdout, with filenames), or 'unzip -p'
(same, without filenames).

-- 
Jakub Narębski

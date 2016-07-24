Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E1A203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 12:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbcGXMJf (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 08:09:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35911 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbcGXMJe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2016 08:09:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so12621428wma.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 05:09:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B5VY4l3wGrVC1bA1ZQFzwHojk6Jm++bkKeOoJLDravw=;
        b=ioqUCcDGWIlnh1ticexjjnRwB8vPMju65XsTfG+u7CIJYz1Tx7SRQoDy60ftjQDGPg
         o2U5Vn8vV2uszJixZZopstkTtrZoSIn4mDNxeEnGnv6xKLxM7bav4hdC8QT+DB19NdT+
         Z6fU6WEtgmVxb/+dVPJ/gRTePslkHA8W4RbUdulnyvArmNwpig8+bKfwY8Wuqnv2r7tF
         KbQZnw841+BFlSA9aQT6hB7P04kDjTcDglzjHtFT8Gn8DG08GSguFz8Y3m2qzHLGDlsk
         w9i2d2Pm29K56UUTi5YyiHcKYKyx6C/ancKocsCHSrgaZVKDLH8VnIz5YnjXiCFJdFHA
         o0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B5VY4l3wGrVC1bA1ZQFzwHojk6Jm++bkKeOoJLDravw=;
        b=VmFCBIP42RpywKSbk5YCVtRK8x+VhjNEAtg1VUdNPWImdtrVXd9pQqM3+UpDR7Dyam
         qzZhyZRK7IWJNEuivhocNumd/KbmeSRd4Y6IZglAErmy/rtCJKZgzzrB60vRsQ7UmYA/
         hwbD/fhmMAebopy2p4S4wXN8KIoH1VuTY3XQ1Eyf42qdM9459/b0u9n4Mqbjy7Entf3F
         2/+WJKc/zkTlYc3qfqca4iKAFPD87rqGev4yVzB6lD4xpADmqsbvyjUOrN9Lzx41FiDo
         a7NvI158m/w8RFsvGsIA/FwvYtbB5xWv3g66Dey4tqzjWS01sMzfspPufORDbX1I6fcI
         e6Mw==
X-Gm-Message-State: AEkoouvuEumZ9JimLTFRvqBmDqgACSvKaQxJ4VTlrU3b3Xcwtn0ATFz93JK4RklIO/Vk6A==
X-Received: by 10.28.158.142 with SMTP id h136mr15215165wme.10.1469362173125;
        Sun, 24 Jul 2016 05:09:33 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5F1D.dip0.t-ipconnect.de. [93.219.95.29])
        by smtp.gmail.com with ESMTPSA id mc8sm10414633wjb.7.2016.07.24.05.09.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jul 2016 05:09:30 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <32d8feda-0fff-6c8c-1ac3-9cc3d783d0ef@web.de>
Date:	Sun, 24 Jul 2016 14:09:33 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <D4012F2A-9774-408B-A355-B7442A4FBF26@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-4-larsxschneider@gmail.com> <32d8feda-0fff-6c8c-1ac3-9cc3d783d0ef@web.de>
To:	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 23 Jul 2016, at 00:32, Torsten Bögershausen <tboegi@web.de> wrote:

> On 07/22/2016 05:49 PM, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> [...]
>> 
>> 1. Git starts the filter on first usage and expects a welcome message
>> with protocol version number:
>> 	Git <-- Filter: "git-filter-protocol\n"
>> 	Git <-- Filter: "version 1"
> Is there no terminator here ?
> How long should the reading side wait without a '\n', or should it read
> "version 1\n" ?
I agree, I will add the "\n" terminator!


>> [...]
>> 
>> Please note that the protocol filters do not support stream processing
>> with this implemenatation because the filter needs to know the length of
>            ^^^^^^^^^^^^^^^^typo
Thanks!


>> [...]
>> 
>> +
>> +test_expect_success EXPENSIVE 'protocol filter large file' '
>> +	test_config_global filter.protocol.clean \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
>> +	test_config_global filter.protocol.smudge \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
>> +	rm -rf repo &&
>> +	mkdir repo &&
>> +	(
>> +		cd repo &&
>> +		git init &&
>> +
>> +		echo "2GB filter=largefile" >.gitattributes &&
>> +		for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
> Side question:
> Is there a way to "re-use" the 2GB test file through t0021?
> It takes a long time to produce it, especially on my 32 Bit systems ;-)
> But this may be a different patch.
I would like to keep the tests as unentangled as possible and therefore a direct
reuse might not be ideal. However, I could add a new "EXPENSIVE setup test" that 
prepares the file for both tests.


>> [...]
>> +
>> +		printf "" >output.log &&
> Is this the same as
> >output.log
> to produce an empty file ?
Yes, thank you :-)


>> [...]
>> +++ b/t/t0021/rot13.pl
>> @@ -0,0 +1,80 @@
>> +#!/usr/bin/env perl
> Should this be
> "$PERL_PATH" ?
I think we can't use this variable directly in the script. I could create the script file 
for the test and set the shebang to this value. However, no other "Perl file test" does it
and therefore I wonder if it is necessary:
t/t0202/test.pl
t/t9000/test.pl
t/t9700/test.pl
According to the documentation this is useful to avoid trouble on Windows. I will check
this test on Windows.

I also just noticed that all other Perl tests use "#!/usr/bin/perl". Should I change mine
to match those?


> And do we need to protect the TC with
> test_have_prereq PERL or similar ?
Probably not as the documentation states "Even without the PERL prerequisite, tests can 
assume there is a usable perl interpreter". However, all other Perl file tests do the same
and therefore I think it is a good idea.


>> [...]
>> +
>> +print STDOUT "git-filter-protocol\nversion 1";
> Again, I don't like the missing terminator here.
> What if we step up to protocol "version 10" ?
> Could it work to use one and only one line,
> with one terminator, like this ?
> print STDOUT "git-filter-protocol version 1\1";
The missing terminator was a mistake. As mentioned above, 
I will add it!


Thanks for the review,
Lars
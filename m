Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1946F1F935
	for <e@80x24.org>; Sat, 24 Sep 2016 16:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758691AbcIXQWU (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 12:22:20 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37263 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758168AbcIXQWT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 12:22:19 -0400
Received: by mail-wm0-f50.google.com with SMTP id b130so78936159wmc.0
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=s350ZT54HWIUhZ7HE1Vl39N5UkX0jCM7PV/oA3Kc4yY=;
        b=BdEx36Knr49k89nVQyCHgOo3a3cLFCC8JY81VwzGhLLSxd8DqC5OHS98cZQq9dmb53
         odrHtY0LBY5X+QntSdYKqKaZ7xw7MtjUnxG/XCc6XF55UePbH6Y7E3EC3rJL2eRc9gyF
         sTxwAu6o76O2huvwRN8Mnadn+7wwViuGF/dA6mqcGB6GhCPRK4IHLNwO3kPxYjqo4VjR
         UB8y0XBUXSUKDFxUoqvreONyeI6f95LTljx5LxKXtdH2yvkOGL/9Fz6getciEsScBQVx
         DHFrpRrZAJ2HPx9qBer74xhmiaE7Bv70tgG/hOGIZ1kzK7YIH7UYX82p6or8C5rPjQ8p
         ORvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=s350ZT54HWIUhZ7HE1Vl39N5UkX0jCM7PV/oA3Kc4yY=;
        b=EYhkf1jW5c4OXD7yfRXHi7Osuvy7KsgIuz2o8XOri7gRUt7xgURBVCwYOC9ZdCEW42
         kuBii6brivCr4IXlRrm/UBHvw/7lagwrQ2NmnMmDSjkS6JHIQjxBQBBaUlNfhftf19Pu
         vIGkCl3x08n1mkLyqOK230kSQRoaptsWwDmrPY4Msc9jtuGoDhVJOxXfZ9/+tBOqizvu
         LwEXoU5L0XAhn79c1cnjqYQrDOs3OFJ8Uz/333dxh+bwcX8eLq+oBvSZppeTOV56yzYL
         cZLFtF5akhhAJmYnoweuwjj7HLf+MZ5xePPTllywx2xTBG65sZzAO4rnkU24DKVba28d
         sQtw==
X-Gm-Message-State: AA6/9Rm/fcXYs5ccpLawHB/PK/bzsDbIzbIGCYDKFkIsk++9rrRrKawn92x8xTYOnfPxDA==
X-Received: by 10.28.210.74 with SMTP id j71mr8047444wmg.74.1474734138096;
        Sat, 24 Sep 2016 09:22:18 -0700 (PDT)
Received: from [192.168.1.26] (epq151.neoplus.adsl.tpnet.pl. [83.20.58.151])
        by smtp.googlemail.com with ESMTPSA id f8sm12853444wjh.45.2016.09.24.09.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 09:22:16 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] gitweb: use highlight's shebang detection
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
References: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
 <20160923090846.3086-1-ian@iankelling.org>
 <20160923090846.3086-2-ian@iankelling.org>
 <2a4c3efb-2145-b699-c980-3079f165a6e1@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <946807ff-1570-2d81-1026-06529164f8ef@gmail.com>
Date:   Sat, 24 Sep 2016 18:21:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <2a4c3efb-2145-b699-c980-3079f165a6e1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.09.2016 o 00:15, Jakub Narębski pisze:
> W dniu 23.09.2016 o 11:08, Ian Kelling napisał: 

>>        After curling blob view of unhighlighted large and small text
>> files of perl code and license text 100 times each on a local
>> Apache/2.4.23 (Debian) instance, it's logs indicate +-1% difference in
>> request time for all file types.
> 
> Also, "curling" is not the word I would like to see. I would say:
> 
>   Simple benchmark comparing performance of 'blob' view of files without
>   syntax highlighting in gitweb before and after this change indicates
>   ±1% difference in request time for all file types.  Benchmark was
>   performed on local instance on Debian, using Apache/2.4.23 web server
>   and CGI/PSGI/FCGI/mod_perl.
> 
>       ^^^^^^^^^^^^^^^^^^^^^^--- select one
> 
> Or something like that; I'm not sure how detailed this should be.
> But it is nice to have such benchmark in the commit message.

Sidenote: this way of benchmarking of gitweb falls between two ways of
doing a benchmark.

The first method is to simply run gitweb as a standalone script, passing
its parameters in CGI environment variables; just like the test suite
does it.  You would 'time' / 'times' it a few times, drop outliers, and
take average or a median.  With this method you don't even need to set
up a web server.

The second is to use a specialized program to benchmark the server-side
of a web page, for example 'ab' (ApacheBench), httperf, curl-loader
or JMeter.  The first one is usually distributed together with Apache
web server, so you probably have it installed already.  Those tools
provide timing statistics.

[...]
> Note that the performance loss might be quite higher on MS Windows, with
> its higher cost of fork.  But then they probably do not configure
> server-side highligher anyway.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D44AC1FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 07:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbcLEH6E (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 02:58:04 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33517 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbcLEH6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 02:58:02 -0500
Received: by mail-wj0-f194.google.com with SMTP id kp2so37852043wjc.0
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 23:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KLTzmQ5WPDswsVT46n5BgO7RuzB6wzriihunqMkyabU=;
        b=kIYhlXLkTwNoGR4lhItELKQegnh247x0lx25HBhJEb+E9bMXzrDzD/W8Bfi+sxn3lD
         q2tmQI6N/c/GIOcV/daYzS6SpA+UlF+cxYy5puHfpiSKPlIja90mm4QJLg8IN3tSJpQv
         6OmHeOPShnDpt0118iqP961apZivB9G47TlyIYVr2dMyfXmLrq/ThIVLESetnfcWcmOK
         NuC+w81+8JlTD2Zg2kZxcvNNEvPgva2+07w3mKW+e8srvx/nMeXZVyhloC9SUGMTsUPi
         JzSvbc4JVB+vndksYtcZP8W+bENbjtvD9OQT58lsWIqxFltmlII0obWJw8HSpaEI4Aaq
         0nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KLTzmQ5WPDswsVT46n5BgO7RuzB6wzriihunqMkyabU=;
        b=iTAK/sB02P769jEnATUa30H9G8adDF0SoiXslc/tji8koXpHqPyNIQ4F/zT27tGCY4
         q3PrdtLe7nOUg3Fv42Iai9JOZu0axf5KUk5il834YQLMu9ifpwjC4FQ1OF1eiyAHgh8p
         uWuDRrHCSTKGqdam+f8a2R0Q1kWDqusPLII8r56dYldMVknS5YkMoeFXXzCBXD3WXWh/
         QRZ104cfbwHo/pSLCfdpRiFRmumBNPh82yzbZ0MkjHNWxFWZ0cB0OqcDPiLmZyx9TVCv
         Oe17J9TYsE3BTAwdFBg5r3qOnPp3QK1BweNttY2Q4+kjQDaLX2qOO8A75NgvSSFEDHx7
         gI5Q==
X-Gm-Message-State: AKaTC00aPpepcBtCOiWQmkxg+6a+LpANeT/7rlG1qpvo3XXmDKvovq7ioABXzHcU56pcKQ==
X-Received: by 10.194.71.17 with SMTP id q17mr22712398wju.180.1480924679637;
        Sun, 04 Dec 2016 23:57:59 -0800 (PST)
Received: from [192.168.15.248] ([37.153.249.237])
        by smtp.gmail.com with ESMTPSA id w7sm16596111wmd.24.2016.12.04.23.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Dec 2016 23:57:59 -0800 (PST)
Subject: Re: Error after calling git difftool -d with
To:     David Aguilar <davvid@gmail.com>
References: <5f630c90-cf54-3a23-c9a9-af035d4514e0@gmail.com>
 <alpine.DEB.2.20.1612021704170.117539@virtualbox>
 <20161205051510.itftw4hyzkv6nnxn@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
From:   "P. Duijst" <p.duijst@gmail.com>
Message-ID: <c0c8c333-adfa-ad58-f1ec-7239a3a16528@gmail.com>
Date:   Mon, 5 Dec 2016 08:58:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161205051510.itftw4hyzkv6nnxn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/5/2016 06:15, David Aguilar wrote:
> On Fri, Dec 02, 2016 at 05:05:06PM +0100, Johannes Schindelin wrote:
>> Hi Peter,
>>
>> On Fri, 2 Dec 2016, P. Duijst wrote:
>>
>>> Incase filenames are used with a quote ' or a bracket [  (and maybe some more
>>> characters), git "diff" and "difftool -y" works fine, but git *difftool **-d*
>>> gives the next error message:
>>>
>>>     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
>>>     $ git diff
>>>     diff --git a/Test ''inch.txt b/Test ''inch.txt
>>>     index dbff793..41f3257 100644
>>>     --- a/Test ''inch.txt
>>>     +++ b/Test ''inch.txt
>>>     @@ -1 +1,3 @@
>>>     +
>>>     +ddd
>>>       Test error in simple repository
>>>     warning: LF will be replaced by CRLF in Test ''inch.txt.
>>>     The file will have its original line endings in your working directory.
>>>
>>>     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
>>>     *$ git difftool -d*
>>>     *fatal: Cannot open '/d/Dev/test//Test ''inch.txt': No such file or
>>>     directory*
>>>     *hash-object /d/Dev/test//Test ''inch.txt: command returned error: 128*
>>>
>>>     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
>>>     $
>>>
>>>
>>> This issue is inside V2.10.x and V2.11.0.
>>> V2.9.0 is working correctly...
>> You say v2.11.0, but did you also try the new, experimental builtin
>> difftool? You can test without reinstalling:
>>
>> 	git -c difftool.useBuiltin=true difftool -d ...
> FWIW, I verified that this problem does not manifest itself on
> Linux, using the current scripted difftool.
>
> Peter, what actual diff tool are you using?
>
> Since these filenames work fine with "difftool -d" on Linux, it
> suggests that this is either a tool-specific issue, or an issue
> related to unix-to-windows path translation.
Hi all,

@Johannes: "git -c difftool.useBuiltin=true difftool -d" works OK :-), 
beyond compare is launching with the diff's displayed
@David: I am using Beyond Compare V4.1.9

Best regards,

Peter


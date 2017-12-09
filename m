Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72751F407
	for <e@80x24.org>; Sat,  9 Dec 2017 07:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdLIHsl (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 02:48:41 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:32821 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdLIHsk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 02:48:40 -0500
Received: by mail-qk0-f176.google.com with SMTP id 63so1569914qke.0
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 23:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CXQllRDcsunExcPUY8YVd9o6D2Cw6dPyQwIiVLEHe6g=;
        b=PvD2dCrGz+QMCMo1Q9XBNWV4cSrDwfIIA4LL7PiRR0+vdomRdsusa+V/c2e2tPsmS7
         HzYSu/aKUb7oa/AN7hP4kYOpwNqYpWWctOGBxHN58RpaQpLBKt8aeTFLseOCcnwPJKKH
         21jDAtXcC7CyHjyMzSSmAqKKiXYDDEFP58GvNQ6H/esl/kivduOHVjLXNfVGipEvIPE3
         uv0j61vAE5C2AbEy21nZTe93WBz9DzGbB7f1DqcYgOAoSpJAjExwwVdZzcYFp/EDi5Xm
         rWdUn8WZBtF6BheeTJC6305CvfQ38W693iW1lyjIwcom5P3WxXGf4yLQeAokLUpDcE6n
         m+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CXQllRDcsunExcPUY8YVd9o6D2Cw6dPyQwIiVLEHe6g=;
        b=SsrSKPSmQOzpAgxTxgn0/OsPz21wRCEFt83hgvbhL5DKICUoUl/7nHY2NxR9GBayyz
         U+LSMs+4qzrcNSxvfL3uxtFjqcQsMnRXk2PL2YC/708ULCvgFhfG2pTcKY8eqScH18hH
         VaMKO2k7RQjuaJ5SHm5OinVwtG6iPKMcLuGb2kv3wF1XISjkEaw3QPUZwK3b/YbnOBR+
         7DG8s2oj6a1tIKxVtgqRHi9oHLYEKsKh81N5by++bykdtPqkcw3zUDcW0BZDzgiVcYlC
         GmT9BIGTrNDrQ1poNdfLSkY6TMRNIkDCMIuqkEG8JkW3G5jrJza0jcnHd2VUwi2+7mWO
         K/sQ==
X-Gm-Message-State: AKGB3mLxkCANgaSBakFsbi6AALWN0sPpUPQcFjw47MANy1GOhkUw+VJi
        jFaINOsZFfOALx1SXNf8nBrsKCtua/tKHfrtZo4=
X-Google-Smtp-Source: AGs4zMZIGPImyV6DkIdVegtsVAqvgfzMj/sJY4AUrBtiGnKZYe3zy8WZR/qeFFNcC8vGauJkHMSFojAHIwOUh6nLOwo=
X-Received: by 10.55.126.7 with SMTP id z7mr12924868qkc.306.1512805719669;
 Fri, 08 Dec 2017 23:48:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Fri, 8 Dec 2017 23:48:39 -0800 (PST)
In-Reply-To: <xmqqr2s56jn6.fsf@gitster.mtv.corp.google.com>
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
 <xmqqr2s56jn6.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Sat, 9 Dec 2017 10:48:39 +0300
Message-ID: <CAL21BmmPNFAGnjtJy_ULBPjeU9HJAVx3x8B4ZrbqKaq_MU4W0Q@mail.gmail.com>
Subject: Re: [PATCH Outreachy 1/2] format: create pretty.h file
To:     Junio C Hamano <gitster@pobox.com>, sunshine@sunshineco.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I see you've "standardized" to drop "extern" from the declarations
> in the header; I have an impression that our preference however is
> to go in the other direction.

OK, absolutely not a problem, I will return them. Do I need to write
"extern" further in function declarations? And why did everyone choose
writing "extern" every time? It looks obvious for me that declaration
of function is extern, that's why I decided to throw them away.


> The choice of bits that are moved to the new header looks quite
> sensible to me.

I'm very happy and satisfied with it :-)


> s/futher/further/

It was a typo that I missed. Thank you! Will fix it also.


> This has a toll on topics in flight that expect the symbols for
> pretty are available in "commit.h"; they are forced to include
> this new file they did not even know about.
>
> I notice that "commit.h" is included in "builtin.h"; perhaps adding
> a new include for "pretty.h" there would be of lessor impact?  I
> dunno.
>

It's a middle point, as I said. I have plans to create unifying
format.h then (for all formatting issues). I guess that pretty.h and
ref-filter.h will be deleted later. But, I really need to create now
that pretty.h because it is much easier to work with existing
interface. If you have another ideas how to achieve the main goal -
please share them with me, I would appreciate that so much. I am not
sure that my solution is the best, but I can't come up with something
better for now.

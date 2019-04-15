Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4878420248
	for <e@80x24.org>; Mon, 15 Apr 2019 12:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfDOMrw (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 08:47:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:39479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOMrw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 08:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555332466;
        bh=6VYcdYrsheBmVGyiH4nF/s3M+YC53zZaicO4Ht5vjX0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OS+aoaBzNCbomzlS4qh5KUB35el98g34nVgcgLgoNhbFgilS+NHZkkVdm7ivAIEGI
         l1dUnoV0ExFUxTsmhIINO8RPRuEN2dWZWIPGS+x05Zd4wle61j0AFIMwrBtEtjSEeG
         qk7v7KWL6keDvTnpkcA+1k7ua1lCZT2oCMMKO27I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWBpJ-1hMlA32tmD-00XLeA; Mon, 15
 Apr 2019 14:47:46 +0200
Date:   Mon, 15 Apr 2019 14:47:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] output improvements for git range-diff
In-Reply-To: <20190414210933.20875-1-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904151445250.44@tvgsbejvaqbjf.bet>
References: <20190411220532.GG32487@hank.intra.tgummerer.com> <20190414210933.20875-1-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PhSVpw2t4xdn4+VHEKgi89AS7b2wrF2BTqXKfuudn9RCG6HtUx0
 UiDqu3iMQBmfDIoGL4ILVP5jCMDpKhvTXzjwXbV+Z1VBlVNfzbq2gwrt5Z3Jb98k4Pvgi8l
 N6hkKUdjFXX5PAstn6Vu/dT6ehm5u3mc/WSSKo9q9aVvcNHYl3hIbvY9XC2tpI5yRypK3ff
 BBpgqdFPSBrbwxI4F1bBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:po8wEz+CCTs=:h0Fpz5Jc0SMeCLvJPrhD4E
 95ICmmkZtvGHrxjDgMvWGTJZnUGUw5B7kXfsdKYJXJTGRuNlF38EH4oJUNB9/uyFmJLlMtoEf
 ll0Y6ZoypuL6qGax/CAwpPhwnQxc5QO1UbBPJlklc8X1XmqrrvLqqJyKkQbawTbHHgz9dvKjK
 1qkf9xXF9MPBtTtYr78RTFD8C4Gmzr+gcNgqVOLJ1Puh55qaLgTSlopCsLb7Rm0zmtfmRSrPD
 dfcg2GPijFTbFNIKsAP9dmFHrOpDXAYd1CZFGAt20izUCuTyfL5PTbNjbFWcyiaC1mHemmYz4
 QqPyfBBYTU7ct0XXkQFwlmJ5zZSmA+f659PNcSjznx04/vlNjcwsE9xyfd+Jjbm/gjjliQWYk
 w9C4g0JSHsKPko+c4BkXC8Ng6xMdTiYF9uRCLf5C1TBcFCpMr8n5wxUK03i1C0D833Fogr9a3
 AulK+s3XsKmsy6LeeHNaRD29GuFs2WDbymKY/sBnIE+AdD7MUc+QGdpT3fOXIewkF6ppkUGuU
 2csBiFdg/35a7fvDJz2YiWUNBLcdYQB0PW08FAkQicQ6ciBgfw7WOfCOJVIgH/QlzBUCH+h1g
 d+HbIiykAnM7AayUjIFGKXdW4iM/i3KJTni8x0DhDz45i+61ELAVhtaukGx5YLHXyIVsVdzxO
 WHG+CxsBMLVCDDbz1JCgnvaSXSJtk0gJqmQt96AEGfdmZv7ugl2s69B4+IJKyaubEVhpL9kNk
 SWssyI4gldt18DDcNIqLPJo0oPfaxxiRjq3U3FBc7d5WvgFOPs+8bLujrTH+6eJ0EyZlr6U6L
 cgWfhPmazfzTje57OfGpqBP0jySkXWjzUhegUDEyKr1EEMAgjGcotjsElxJH3hqiQ/mUR62Wt
 D2NXYXQotUj+fBQHQ5V2K7/PBm9A7kRzGu/oY1W1R8QvvV6h9+sQEB1ZEG0VPlhRsTSo/LK2S
 X6NYRZ7WD1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 14 Apr 2019, Thomas Gummerer wrote:

>     @@ -99,10 +90,10 @@ modified file Documentation/git-revert.txt

A better example might be a .c file, as the function name is often a
pretty useful piece of information.

Read: I think it should be part of the outer hunk header.

Also, the text "modified file" takes up an awful lot of space. Maybe we do
not really need that information?

While at it, we could strip the line numbers, as this is not intended for
machine consumption, but for human consumption instead.

> [...]
> Note that this patch series doesn't modify or add any tests, and was
> just manually tested locally, thus it is still marked as RFC.

Oh, okay then ;-)

Thanks for working on this,
Dscho

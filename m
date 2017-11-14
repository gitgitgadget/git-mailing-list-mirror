Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45891F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 17:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755884AbdKNRKB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 12:10:01 -0500
Received: from mout.web.de ([212.227.15.3]:50472 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754291AbdKNRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 12:09:59 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ll30X-1eoosq3yB3-00ajUI; Tue, 14
 Nov 2017 18:09:58 +0100
Subject: Re: Changing encoding of a file : What should happen to CRLF in file
 ?
To:     Ashish Negi <ashishnegi33@gmail.com>
Cc:     git@vger.kernel.org
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de>
 <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
 <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f9dc6482-587d-50a9-d649-aed63be18fad@web.de>
Date:   Tue, 14 Nov 2017 18:09:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:aivlozPhPoGzgNjXPuRvQa5VwNFQUM698T/Fo5yNBH0CZYofMGO
 b9Vk9NwvVS66rJqh8KG7B3X1Yr2VBtRnvEhBAu0j55DLJhiJMApLYnUUVDNiRGIt7cdO6vE
 4HFkfRY1GE2rGJ2c/si5Ked/1zzQAGDTmAHwLFy0EJ8sRANTWGNyZobOn9riKB58GfU7DBT
 dVLSZtqZUpxjX4E62mJPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kuesTRJwCeQ=:visXac2FvVHcVYIrf0p+/X
 RFJPwaPAwf/d4mv6TvFygenrUgenSRN+CufGt5k4nlKmjQLmWZ72DZx6DBhQLqIJ/R2n4Fif1
 aw4U/6g9mSymaCSo+lsttUqmhsKbKSTv1XpAIK/J7nJiNPArDKloeSPOz96MN13jd9lAQjn0X
 5CcTN3qmpqlAu/ylpY3NMXGIOVlATmcfGqW2/sZiYrjmtm2oXqJ/krFLFeuUJb5/RHoqlViGF
 OZ9XD+5ibNmfRlIBKhYd/xsk75/A5Pd9m7ZqvpzsSDtouL+OwC6sou9LxFZXpy6zKiWD9qQqf
 ORm4JTdTP56vMJwVzsvOCnwnML32gEcup9gjBu+xNH33s8a16TgMvob6GxPyfWuvhW1nU7nDE
 6XKCDsaSeCLA0CbpqN8pTafOor0eKUpFAG4mnuumioGo4Gw50AX1a4kufm+h7PDYR0CXxq2V6
 tf1qmWqTkZPLU6F18fOIsOknvwpqzV8WaD5DdGfHuZgpZqKA9m9YGeRVQNs3A88k0hslN+LXH
 nJAJ0GYwIcXJr2CkdtfNKjxQ2o9B4JBoXY75tQYh+QBKVKiyjzvYTFtk9LHvu2BKO6F5oRDv5
 c2rl0ICBfrAn+Fhx/NEHEGFtlxTkZ6O0UVb+uI0dq9w3ymLll3juTih0gD2w3s27JiyTbEEkm
 sHPCYCbVZ/8kq4fo09N1JYBhXZtahPGw429QRcUdwKYuedeVBA/YCnCks/IhzND2lJYEH0o9o
 W7TVhdbn9K2fAbJQnmfKIFRMTzFd8O5yMCdvIio2yZKvinQcTYuFx4MWtpPnHVBwjRU/8MAlf
 khFbbEAL+acLAc0yICQtP/JnXzw3KfBqjfNl05Ef6MgMwSItfs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Back to the beginning)

You have a file ApplicationManifest.xml
It is encoded in UTF-16 (and has CRLF)

You convert it into UTF-8
The file has still CRLF (in the worktree)

Now you add it and make a commit.
Under both Linux and Windows you have "text=auto".

I assume that you have efficiently core.eol=lf under Linux
and core.eol=crlf on Windows.

(That is the default, when you don't change anything)

Now, what happens to the CRLF?
If you commit the file, it will be stored with LF in the index,
on both systems.
On checkout, Windows will convert them into CRLF, but Linux will not.

That why you see
>On linux, during committing i get warning : warning: CRLF will be
>replaced by LF in …file_name..

All in all there is nothing wrong, at least as I see it.

The question remains:
Do you need CRLF in Linux ?
Probably not, but if yes, plase add a line

*.xml text eol=crlf

to your
.gitattributes

Otherwise your .gitconfig looks good to  me.







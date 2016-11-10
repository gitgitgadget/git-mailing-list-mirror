Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B95D2035F
	for <e@80x24.org>; Thu, 10 Nov 2016 06:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbcKJGoT (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 01:44:19 -0500
Received: from mout.web.de ([212.227.17.11]:59328 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbcKJGoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 01:44:18 -0500
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LjJL9-1cfzJr2Mwx-00dVkd; Thu, 10 Nov 2016 07:44:04
 +0100
Subject: Re: [PATCH v1 0/2] Fix default macOS build locally and on Travis CI
To:     Junio C Hamano <gitster@pobox.com>, larsxschneider@gmail.com
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <xmqqwpgc6x4t.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <13e1bf7a-d404-3789-5d2a-4d6259959254@web.de>
Date:   Thu, 10 Nov 2016 07:41:59 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqwpgc6x4t.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:DypBOIPn6DmlEkHsPoYHMXJXzYumgoA7BI39l7wPDmLVYbvIBT3
 TfU6HimK8W18hzb/VyMPJFmRBDlx2g8LJ9KWwvUyEPd/GJPtBBeJc+zZHAhEraVAwX46yj9
 YCeXZTRiksjqPRnY8tPV08154e8SlTZvgthrKqla/TmUpDGHAwNJ61vufwdsHugpoS6RVSw
 UYGKcUHASfrxxUAnwiDDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JXJ7yNF+89E=:z4521l01FhIsZlUxXyeQME
 OjyIO3X0Yh/sFVpSnKougJuVMQ63VulC61vqt2HKoURx39XZEANCaaCY+RfOZkvLGQifZqiXz
 wJUJGKAzwuL+NxWhpYSjaVRtA5G85H1niNzBe3JNv1zRjcCQI1lSSpZ88pYzjPNotGFSfK+aU
 ruYx0FwS+LgTiLSzszYj2RV6aSR5LGn2Dtu7Cyl9+9RfGNLg7INF6Or+sIGsfxzDaO3k0rBBU
 5gUJHOket8TjlCDTKW1x50a/m2WQE9BZp0jMy1cvFa4fdZzhrotQ/sbBVnhaUQr5nBxseC4th
 bCbgVntPKth0T7yRFUnePmc//MzGJbj+ieCNoiIqF0ZVUr3idVM4vQJUBmzxl6JGinQKMUmn0
 Ucm4XPtwRdFAR7e9lk4rAbPqkYdMtSfvsT2OsxxU5KPwNnqPYdx12hSGw7HBWKxD7ogS6h/to
 CVocAEjONTGvlLyCFppglUCYIWtSseBYxhzVfwjGAULimp6AYoBGN7pSRAggrlPwGV/rk3tQd
 ym2k/jUHi/L4woDah0l1hxlaq2MtndsDglNoWT5rd0SgacXStWRLKsr8bQcCGny17OxhBa1X8
 WhtOeJ9MnTxC8FmoR4drTzdFQBY0DsundHdL4Y5OEIRAY8hVqYrh7Z+9O+fnvhLread/g+Xat
 M6cbZ2w7CnDn8I3wcGy+XgDBI6PXAF37gE4pqdiRlOQvHhn/wgXJLZlprH8BQwh0eXuZ7cBu6
 9gudMdBlNKe65+vjI4FH0pbTvr+ydqztDTihmaiqlo9oFWq8052RUuKoSfhXHqEujcx5kdSAY
 lOu8G9p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/11/16 00:39, Junio C Hamano wrote:
>
> I've followed what was available at the public-inbox archive, but it
> is unclear what the conclusion was.
>
> For the first one your "how about" non-patch, to which Peff said
> "that's simple and good", looked good to me as well, but is it
> available as a final patch that I can just take and apply (otherwise
> I think I can do the munging myself, but I'd rather be spoon-fed
> when able ;-).

If you can munge the Peff version that may be easiest ?
I couldn't find a branch in your repo, but am happy to review
whatever shows up there and in pu.


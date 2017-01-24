Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E98B2092F
	for <e@80x24.org>; Tue, 24 Jan 2017 11:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbdAXL2v (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 06:28:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:53095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbdAXL2u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 06:28:50 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcSWg-1c42qz3e4c-00jsct; Tue, 24
 Jan 2017 12:28:28 +0100
Date:   Tue, 24 Jan 2017 12:28:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
In-Reply-To: <vpq1svtstud.fsf@anie.imag.fr>
Message-ID: <alpine.DEB.2.20.1701241228020.3469@virtualbox>
References: <vpq1svtstud.fsf@anie.imag.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q+7BGuINubQVWvpPpK56blnDN/oVjjHjO/uS3mMYr9pCnUb7phH
 bFzJFQnHXzsG5DDo8uJ189nYEECIBVFoqL/EbBoyxS3AG01EXczdcojfzjodqX9KLQtDVpf
 sHvLjHsgWvjjNxqMekHvS29HMDrejF+2G1v5A6ApM/5I/W6sqXyJ2Cp0HKAbdkQJbXtzAbW
 KieO/9sULjWIO432JWk9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CZ63L0mJkJo=:ZE21oy3USC5L/bVR4Gau2F
 3ZfGYZpCKK8v8XCrDxudW3BsWopxP1QoEPg91jtE4tKB0/F4+F8inapBwKfQpTsoGjPxs7XOk
 1stT8jcq9NM0O7WXHd80aS+QtlamdZ1dgFaIOhPsPZajvsUbizD0GApvoHk0pi6k8DQ2eTejF
 eAHsO6jC0BVtgpUkstsdX6id0cQ3Uj2MZ4w/AxnlVbbeeT6Aax3qFaU9OTC917SPdC3UylAgR
 kXUnSTXX+VMR+1J1dfiWed4MYILacCvQe2LIurhNZEiPvSWkE9CYbO2WaPr/HUmmhHpWvyGun
 OfdIIUxQ42l819kKdXBH2EnQn8vN8vecmJl1VAQSOEw5/OmJcsgTgy6pPRNdh2Wxk0/UGhDo+
 IRnV+VjipmCjOGVbeJTrT/wmbuyvXL7t5yHQYN/Z+LnIUqnbf2Kzqy89QI97byTio+0bWohgJ
 gPNp+Ay6T28kVyHrEP3IS1FXSXbHiyYIuOs+38v7rGpVcZpJWwsxr8kBp1huti7YLoZhHlYmK
 VCQcaHcz5i84J1Bt8tCguJOO/TCla9FyhVXgTMxpnh0sDGjo8buaI0vH0KtdTNe1Pd1hGthT0
 FcPbY6cEZ9hl3NV0Vca4tUk35cpZSt95NVgUPZjDdAFWij24OrYv61OkKeMDAFr+oO6XoLlpt
 3jZiYNu4bHxppPaZAIH5h9jfe3XUSaU0H0sXpyGyCh4kTCU+b/pkWsn0x9KNk4LeaslS3VJoq
 4/8EH5V9ko2Qv457AcaBFfggp733KwXpfPmhyuPITIDYcyWWlJRK8W8mRCHha+Xz5Zdgz4K0v
 MFV4R049Wii/dQ8vRWcPIth5O4h0df0iLoL4T+gedZVEl54rcb0TVBNUmjWDM8zph0lK89+id
 ua+36Smyu0WUmIxY2cnxVp9d9/TSxBBLultZCHde11KUbcB2C/zcUQdhQmXuAy6KnegR0reaK
 q9KUeI0gA79MBkaoULYAHcyAX+wb4U988OtzSFS76h7I2raZfkkmQD1g5w7TIPfY77EKLE+mK
 gYb7FFcinUu3qiwkkEmKbz6HAfGNr3E+5i6EA6DB2JmhiEXxdR+T7GKntUjaklN9Bw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthieu,

On Mon, 23 Jan 2017, Matthieu Moy wrote:

> * Who's willing to mentor?

As in the years before, I am willing to mentor.

Ciao,
Johannes

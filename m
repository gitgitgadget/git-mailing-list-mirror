Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157B420133
	for <e@80x24.org>; Fri,  3 Mar 2017 16:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdCCQz7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 11:55:59 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52346 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751790AbdCCQzY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 11:55:24 -0500
X-AuditID: 1207440c-aa5ff70000002e8f-a8-58b99fd42df9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.7F.11919.4DF99B85; Fri,  3 Mar 2017 11:54:44 -0500 (EST)
Received: from [192.168.69.190] (p5B105007.dip0.t-ipconnect.de [91.16.80.7])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v23Gsgxp005987
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 3 Mar 2017 11:54:43 -0500
Subject: Re: [PATCH v5 00/24] Remove submodule from files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <22f499da-4ae9-dd93-3862-3287f24c5645@alum.mit.edu>
Date:   Fri, 3 Mar 2017 17:54:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHtl/s4Ig2WbLCy6rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLWZetbbYvLmdxYHdY+esu+weHz7GeSzYVOrR1X6EzePiJWWP/Uu3
        sXl83iQXwB7FZZOSmpNZllqkb5fAlbFw83TmggdMFQdP/mdsYJzG1MXIySEhYCKxZOMFxi5G
        Lg4hgR1MEt//nmaDcE4zSTT/ns0GUiUs4Cyx4sEqMFtEIE1i8eT3zCC2kECSxL/np8AamAVu
        MEpcmvgRbCybgK7Eop5mMJtXwF6i4elTMJtFQEXi4ZLX7CC2qECIxJyFDxghagQlTs58wgJi
        cwqYS7yaDFHPLKAu8WfeJWYIW16ieets5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnF
        qcm6xcmJeXmpRbqGermZJXqpKaWbGCHhzrOD8ds6mUOMAhyMSjy8DJN3RgixJpYVV+YeYpTk
        YFIS5V0wDSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhFd7IlCONyWxsiq1KB8mJc3BoiTOq7pE
        3U9IID2xJDU7NbUgtQgmK8PBoSTBu2MeUKNgUWp6akVaZk4JQpqJgxNkOA/QcI35IMOLCxJz
        izPTIfKnGHU5bhw/8IZJiCUvPy9VSpz3+VygIgGQoozSPLg5sDT1ilEc6C1h3laQdTzAFAc3
        6RXQEiagJX4yYEtKEhFSUg2MmjPiDU6ELpg9bVG20OegO+s0lhf+vKi8U8pgU3/4pWnHxD8q
        HP63tuW4htgPU26Jvl8lSWvdU4R8Avj4Veov3//Uk8wan3bkD7d+yONl26zPXjZ33/o1iKdi
        tUHl12k/LTo0t8txVTyapbYpKljy5tkrH2aeulP55STfd5kn85e7pOmsWMpfqsRSnJFoqMVc
        VJwIAOUYIaIuAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> v5 goes a bit longer than v4, basically:

I've reviewed all of the patches and left a bunch of comments, mostly
superficial. I'm very happy about the way it's going, and especially
want to say how much I appreciate that you've done so much legwork and
added so many tests.

Michael


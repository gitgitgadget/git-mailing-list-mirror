Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43431F42D
	for <e@80x24.org>; Sun, 27 May 2018 05:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755158AbeE0Etn (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 00:49:43 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:62432 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755118AbeE0Etm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 May 2018 00:49:42 -0400
X-AuditID: 12074411-a87ff70000001186-d7-5b0a38e52eec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 52.E5.04486.5E83A0B5; Sun, 27 May 2018 00:49:41 -0400 (EDT)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w4R4ndVY020376
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 27 May 2018 00:49:40 -0400
Received: by mail-wm0-f46.google.com with SMTP id a8-v6so23755816wmg.5
        for <git@vger.kernel.org>; Sat, 26 May 2018 21:49:40 -0700 (PDT)
X-Gm-Message-State: ALKqPwdg9cs2vh14mz7fOHGVaubaXtBe5MTTXB+CcXfXg1BOw3mEVmlT
        Kb08qU7zDeVi6JcFrcdANO/mp7AX6x0BPzO8n6g=
X-Google-Smtp-Source: AB8JxZoKsuFBqWUWBuavNqnWoposJuysh+giIHr+eDw4vykiNnHX5EW5idqgISq69eYVjKPPXSts2noSbKm1a/5SOdw=
X-Received: by 2002:a2e:3806:: with SMTP id f6-v6mr5406858lja.25.1527396579574;
 Sat, 26 May 2018 21:49:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 2002:a2e:9ec3:0:0:0:0:0 with HTTP; Sat, 26 May 2018 21:49:38
 -0700 (PDT)
In-Reply-To: <20180526064745.20199-1-chriscool@tuxfamily.org>
References: <20180526064745.20199-1-chriscool@tuxfamily.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Sun, 27 May 2018 06:49:38 +0200
X-Gmail-Original-Message-ID: <CAMy9T_H7OVJoDQGFNnM-GrCE9jhSqNDALFL1TM45TMcwPx5nnQ@mail.gmail.com>
Message-ID: <CAMy9T_H7OVJoDQGFNnM-GrCE9jhSqNDALFL1TM45TMcwPx5nnQ@mail.gmail.com>
Subject: Re: [PATCH] t990X: use '.git/objects' as 'deep inside .git' path
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqPvUgivaYMZveYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGXcntXAWPCepaJnxmnWBsafzF2MnBwSAiYSD3dOZOti5OIQEtjB
        JDHv/EwWCOchk8S21sWsEM4ERokT/yazQ7SUS2yY/pgJwi6SOHNnI5DNARaf81QNJMwrIChx
        cuYTFhBbSEBO4tWGG4wQdrjE16edYK2cArYSHR/7mSDiNhLzX/wFq2cT0JVY1NMMFmcRUJVY
        c3IpO8T4RIkHP3MgxgdIfPw/nREkLCzgKdG+IBckLCJgKDHn9xJ2kIuZBQ6ySjRebwIbySyg
        KdG6/Tf7BEaRWUium4UktYCRaRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZG
        SGgL7mCccVLuEKMAB6MSD++H2ZzRQqyJZcWVuYcYJTmYlER5LSZyRAvxJeWnVGYkFmfEF5Xm
        pBYfYpTgYFYS4eXS5YoW4k1JrKxKLcqHSUlzsCiJ8zKb7I0SEkhPLEnNTk0tSC2CycpwcChJ
        8L40B2oULEpNT61Iy8wpQUgzcXCCDOcBGq5qATK8uCAxtzgzHSJ/ilGXY96WST3MQix5+Xmp
        UuK8iiCDBECKMkrz4ObAUtIrRnGgt4R5P4NU8QDTGdykV0BLmICWrFvNDrKkJBEhJdXAaCCt
        6iccO2WNzqkpSiZfpa2WPs/lvXpUlF15p6Lptl7f97s1r1Wrv/VY/0FN8cSWlnfHyzJSLP8/
        DX/xr9jp+ZtlfrEC+jKijpPum2bG7Vn+XUfxXDRfX5v+6jOXAi7Iq0tzP5AMVlh/6mGHpK3G
        WhXm/Pu39nhcOdK1pm761YwHh/7nPVqzS4mlOCPRUIu5qDgRAOTbKX8kAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 26, 2018 at 8:47 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Tests t9902-completion.sh and t9903-bash-prompt.sh each have tests
> that check what happens when we are "in the '.git' directory" and
> when we are "deep inside the '.git' directory".
>
> To test the case when we are "deep inside the '.git' directory" the
> test scripts used to perform a `cd .git/refs/heads`.
>
> As there are plans to implement other ref storage systems, let's
> use '.git/objects' instead of '.git/refs/heads' as the "deep inside
> the '.git' directory" path.

Seems reasonable to me. +1.

Michael

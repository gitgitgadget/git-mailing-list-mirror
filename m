Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDE21F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfJXXYT (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:24:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:40923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfJXXYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571959453;
        bh=VLJ+LAssJzMh1FCJ7vVYQbK0zGWyJTO1RBm/U9pkaYw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TiJ36pO8Pmjt5loqyOj3TyGkqpNsbkytksufCJmDzHvW3W+TfUfA0f+u/tZZ7fdo+
         SMEVn9m6dooDi7y1C82ZaPWSBHfJBz7x24b1SGhWV/Xb5jlj94k1UeMkVE8bJSYlBy
         IHD/2WNIyJTajap9DfMK5gGEc3V9FTAx2dmlMNrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1hd7qR1dsI-00pPLZ; Fri, 25
 Oct 2019 01:24:13 +0200
Date:   Fri, 25 Oct 2019 01:23:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix the speed of the CI (Visual Studio) tests
In-Reply-To: <xmqqlftcjjvi.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910250122000.46@tvgsbejvaqbjf.bet>
References: <pull.410.git.1571603970.gitgitgadget@gmail.com> <pull.410.v2.git.1571687999.gitgitgadget@gmail.com> <xmqqlftcjjvi.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j8lXvtjIGmSXgOoe2iei8nFjLf9ZZz9KQB7qDRh69wWl4eiBvZi
 LROG5d5RzjgiMEF0294Tl6r1RnjA6m5kSdBOg2YoCV+dvAKbk9vZf0m7FwApfWFvCLaXxIK
 5XUHn4Hlnlt1LCFsfDpiwOw5wlyK4WT2+MeIN0APhM9XROIWwCZtu8KaUWjE+dPwVlylCmj
 AXxPzAZ0nPQeAuIuumzKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8I7U2njcpJo=:30HYY6mm+s25DXbfrAfxgm
 /4GfMwVmdv+gwZTe1shcBLjtpFZZdf6/Mlcca6a0ZMp9noWkkFMP9i45/2JDZFmScZ1qqaZej
 QPYBb6pua8BTvQnLcxYwVowgwTnpBoxYCM9QJg4gzI1M6hecdrZmTiZAipXWjBG6sLHpIzdpP
 w+CvuAlhEjFLZVM8euJZMqCRjeCfi8ESmUuAq+ZFH6tFz3QtfcTCrp45iKAip1yhk3NHC6A5Y
 XC3dTqQhIk9Vxqmtwzyasjp5jULa6qZECZEDAKY9nKYNgacty9qE/rhV29GluS5ifwx1S4mzR
 yaOi9zED8fppovTXcRDcxwSxnCxCNrAOs590Tgb5Xme5vYJuCi4ql8nDTbYdR5qyswVM+XQio
 kD2bFmi6x3NIJVEacLLzxbWsPblWAlnMW0DxH5nvvoYHa1M1y0a2XoVwmZ+Vfod6fETprHG3Q
 iKbR8elwMY1Fj6lTZIK7Svr1UKG96kCT6GlUbwKkCeeP/IekWGWHv1cHTfEBUvLgBXOFafRVG
 bPkuJP1bqgkSuiC0nliKkE0A4Vlt4rCgg9NwfqvOvzGWezCLWXVKRLgq55oIa/jG/5DPvrCxk
 0GWhBdpQpb4oOFN1Z8yFcSRIJeykr8kjeipj5avC+ykiXfpx3Ytcw+FHP2WNs4W73EApvTH3+
 h9EcTi5hpeDH3fSistBvfY96lzkMW7AQ/tLhK3GCBzSHAYeRzvFSWWto5ZOrJWsra8r3+DUPG
 5Edkc0AhaQ5vHDDTD2Eh1KyukRwuG7SXWpFbkPsrzWZj2W6Z7iUGpiLu9DQVipVKmaW1dtrdP
 fUGBZx2zyYgbAD1VWsoDbS15wXNnBjO1NU4OYwFy/+lVR0AbDXOmPCwQ6BNcsdDWX/uJx5r4J
 BhqYZ/ui3kWfmzKbRKlW4MsEADyi4NLyAEoTyompfDRaD3EBQ2RXdEVmQELnsFSkSbVPV2gix
 0UwGAW2uMvE4A44q/tJi1YmgXpvqEkahZVWQV+LYQzLr5gTIKs0t4rOg3sb8t2XuNTDikaGDR
 e2mPlMXkqAVZvbJwLrmCVRj4v2pb6uP0h1ymRmHzirBXUyVvBzo9Xckc5uZFZEGpCAqZmt1n2
 nQUcCHjMvUhwgGjab2tXfp2IhMviZdGyK3j0w8d7bbDSYdAW+I6JACtFdOOuRBeGIvh78hEAj
 zocz2vFReTAebMNVksml6x3JyabWJkZne13uAqZTsgyT/C4siCPha4PA3psKps7LDf13cDO+W
 0U8jEkbly9S7JNIeRAx4sPmgNoRt6n/xkDFTOylDjs6jafP+4drJTxsZ4znI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Changes since v1:
> >
> >  * Fixed typo "nore" -> "nor" in the commit message.
> >
> > Johannes Schindelin (2):
> >   ci(visual-studio): use strict compile flags, and optimization
> >   ci(visual-studio): actually run the tests in parallel
> >
> >  azure-pipelines.yml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks.
>
> I will take the change to 'master' directly, as cooking in 'next'
> won't give it any extra exposure when the topic touches only this
> file and the patch comes from those who do exercise azure CI build
> before sending it out to the list ;-)

Thank you very much! It is indeed a lot faster now.

Ciao,
Dscho

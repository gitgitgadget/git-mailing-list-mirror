Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126BF1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 20:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfHLUcc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 16:32:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:41157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfHLUcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 16:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565641950;
        bh=6xs1rtWqJmGezj4K5OLLoSac+iGTetd93bxtwiqSgTQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject;
        b=FcnFHqCZqAzVPc9iwdkWelkeqedqkivjiYAPogiN9ObYGFfx6ut1FYJRyjbxyDsPJ
         inrJ91lpTwVUSNP31ox1Bl3jsyWVWCIztfrNA4npTjKowbWtLZRue1ZPz/4Y/s/BOM
         eI8OrPeUxjlk8Gjone50v3+aC4j0d/6prcXLhkLg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.63] ([77.165.132.136]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSMKx-1hquOL045b-00TRr6; Mon, 12
 Aug 2019 22:32:30 +0200
Date:   Mon, 12 Aug 2019 22:32:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com
cc:     git@vger.kernel.org
Subject: No Git for Windows v2.22.1
Message-ID: <nycvar.QRO.7.76.6.1908122229020.656@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vBRRipzTBkbIWPhiWtol1nAxVkkJJZpZ3ihrGlux98d1Sgj0Jkn
 R2IgJvIfgrnc1pT7t1YkOOzbtH0JpgqlaakWLByhBZ8XXR8DS5VTtk+kzW2pPpMNmzN0HkD
 CDJXGvQViXIbqw7tps6No0VOlk0PQV4jNGSZtc3ZOJHABwtuN1qc7tRwp3FS5KNgveJGLUY
 ob+zPBXBD+sr/p8FBNNDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ct+4d/A6hZ4=:dQh0SkSJD4PU5uRuGFqluY
 Sk3I4W914VH2XAC8zQGkKPb+yqSrQa8XKl3JQ4Dzj6NUilUe/p5apBamg2HUiSG0/FJkrvJ3E
 KgtDLrFpy25HGACWNTfdGfLR3//Lj/8LViDZIziFS3FirQzoOqsgB0efKk3Q2iNK1h+KBpd30
 UYOIoZgn7SiGZKyFngENo6ixQACvBE0O6leg/GYv2Jay1ik6LOHZaT4/GA4R6iMTlqM2Q0PDR
 AkGSHPO27LReDG1je8nh1CKBs3DgQavYGIaDvGqGn/iZkXE4ZWEYZNrE7Y22y1NlBaeC36UYN
 ZijGZLR0mMXPxQEKEpLYhV4S/v2ci+LWQ/WuRLELU8/GftENATUBXMg463rYxF3acaSbOzJlr
 qW/6kukD6g6pBjHJq7qDvNhSleRFUzSIqDv+B6Tyo5ILC4OY8kFKAhKEQNJ99I8W75YzFpAgJ
 R/qs5Qjz1gv8dRwe+RcwgR1NtuqDQMmOyLUOvqcHvaFlW83JZGCFWCRJLQkn3C1sqCk8HmwsQ
 SvDgV+H9qMJuphZi1RKTQdCLbkSFXZRlw2EUliLj8YqQimBbgQDl3Xr9LyPGNIqEFf2o7/9cm
 NVtJWki/pYf2RPQhyOSRwsE3I4BsyH2KLSHolb3eAldKS9Wc/SBJOEhYIRfKXKO+1IlEqg+aJ
 A8/1NQm1L2U1q8LS5KEOLNR0cvH6/vyxz9AoosngeWU8dWCf/QXW4+JRejT9w/1paLgGYLiZg
 w2/ciQLgML96gaa7yIYXQ4KlABA5Ws+QWw6S7svMQBqjhZBzE5iaHYrudccg1jFybXWe2+GKW
 CRYxbO9G2KwGW+KFCAKLLpOk5eQX7kYQOIalu9jvvdLeo8IeHY7Sbpv0g5ePnMwn4HFaokgPm
 HFFzGWbh4g9fE0U0hqi4iRPn3ukuvq+ouVWTQezT6d8DtrFNzbXfnF1hx6bs3K00BMuZDgI1J
 OMw/Hqga0dogI6W0Fn/dXrj99HhDQUkGTYi6jIYtPLJTpib6VYdRXGttr1DVdOluYIxXkHBdl
 8DoKR/wT8M8/QEtXS8KfRIFJWfHkJlkECSJVDEOvF0cZFj2ghSeIUM8A+xmjvKJ/wRlAMV6fn
 mbfIzAk8M2w9D9gm4NYevmvyRPmSOfSZ9faoOREx+SXbYiNYkqm9Sb40BvaDA+NVckkfWvxn3
 fMUy8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

seeing as v2.23.0 is just around the corner, I decided on skipping a
full Git for Windows release for v2.22.1: while the list of patches
between v2.22.0 and v2.22.1 is extensive, nothing sticks out to me that
says that we need a new Git for Windows only to release another one in
six days anyway.

Ciao,
Johannes

P.S.: Please expect delayed responses from my side; I am with limited
internet access right now.

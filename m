Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FA51F404
	for <e@80x24.org>; Sat, 24 Mar 2018 22:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbeCXWQm (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 18:16:42 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:20451 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeCXWQl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 18:16:41 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Mar 2018 18:16:41 EDT
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id zrKwezIxgwheazrKwesIql; Sat, 24 Mar 2018 22:08:32 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=hZl4FlbxAAAA:8 a=_j03d67v3mU7a8DzvfkA:9 a=QEXdDO2ut3YA:10
 a=zNGlSMxTWkni11D5GzKz:22
Message-ID: <88A1405D65254C7BA987ED4745FEFA43@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christian Couder" <christian.couder@gmail.com>,
        "git" <git@vger.kernel.org>
Cc:     <lwn@lwn.net>, "Junio C Hamano" <gitster@pobox.com>,
        "Jakub Narebski" <jnareb@gmail.com>,
        "Markus Jansen" <mja@jansen-preisler.de>,
        "Gabriel Alcaras" <gabriel.alcaras@telecom-paristech.fr>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Jeff King" <peff@peff.net>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Hilco Wijbenga" <hilco.wijbenga@gmail.com>,
        "Phillip Wood" <phillip.wood@talktalk.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "William Chia" <wchia@gitlab.com>,
        "Alex Vandiver" <alexmv@dropbox.com>,
        "Michael Haggerty" <mhagger@alum.mit.edu>,
        "Brett Smith" <brett@sfconservancy.org>,
        "Patrick Steinhardt" <ps@pks.im>
References: <CAP8UFD23Xku__TDkT10SRFF7oW8fozWo=WwtZ4aMdjS7WDBwRQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 37
Date:   Sat, 24 Mar 2018 22:08:31 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180323-4, 23/03/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfC5m/CD3fV1w8StVBT1hLjVy6tNhXmlOAZaDj0jMuJbQ3W+9s8TblhkStUmoISVLlfp0EhcZeVoppHkhxEX26/BgInjqa3s1Gl/cZw3xrPqahzAcWMrx
 zb6YX/v/HcgBx4Q/87oN58p7fymms2QV8bNu2jta4XkZLEsraZzJo9wKJOt/4PUmjyfxT1Ax5VDvenjoVYWRPysrs2j+Dz0WnSm/wAuRDwozkVuR79KRGoCn
 k2lpMIYboimODOpdqEXmVsMw++K4zzlS+/zt6DVNWytTfpHNeCaXq0Sgu1qIvuxXdUMpLZcpLpjtz6MTlb+2Jmanye9JEYqTFAYyjPt5jEyi8QqJnlN3Hxlb
 kypIYWMNwbmpwcpXnKlQs+m7oXPSBwBqBmGM8pkT8HaBSaGhCar1nK3UjH/wDfNNgDt9Xf7NeVpm99yKvBQYMU5pVVtLiyqVxig8Hr1ngQq1IibPQEH7EcFZ
 FoUM/7cBj+Rn/IVss1YBv8lcbukkxJ+uD/nop/e9PFqiSU5iHdTLk6cbBjMKqG9djutNwcW/HSAzFNRxi05o7ZFNG2tnN/uWk3/a2gLJBj3D+/hwMwueALaC
 XTI4yF+JCFEA2lWDq+VjgWMJaZIay6xiB8fBgzOotKYB7o6JHHSfhTmEpxbQBtx88/cHhtzOwwQp8BW6RRRN8jXlC1lG2ENIgTNTNqzUkeh+ioC6g2GCfsXI
 zZ7xYrQl7/I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christian Couder" <christian.couder@gmail.com>
> Hi everyone,
>
> The 37th edition of Git Rev News is now published:
>
>  https://git.github.io/rev_news/2018/03/21/edition-37/
>
> Thanks a lot to all the contributors!
>
> Enjoy,
> Christian, Jakub, Markus and Gabriel.
>

Thank you for the Git Rev News. I've been off-line for 5 weeks, so seeing 
the newsletter is great.

Next is to peruse Junio's "What's Cooking" lists.

Thanks to all.

Philip 


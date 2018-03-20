Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBABC1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 15:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeCTPzG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 20 Mar 2018 11:55:06 -0400
Received: from mx0a-001d5301.pphosted.com ([67.231.148.98]:38310 "EHLO
        mx0b-001d5301.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751269AbeCTPzE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Mar 2018 11:55:04 -0400
X-Greylist: delayed 2193 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Mar 2018 11:55:04 EDT
Received: from pps.filterd (m0084119.ppops.net [127.0.0.1])
        by mx0a-001d5301.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2KFHaaD003445;
        Tue, 20 Mar 2018 11:18:27 -0400
Received: from dc2-mx8.bnh.com (edge-2.bhphoto.net [74.113.190.228] (may be forged))
        by mx0a-001d5301.pphosted.com with ESMTP id 2grusc0mvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Mar 2018 11:18:27 -0400
Received: from DC2-DLPMTA1 (lb-fmg-svc.bhphoto.net [10.50.8.10])
        by dc2-mx8.bnh.com (8.15.1+Sun/8.14.9) with ESMTP id w2KFIPZV027535;
        Tue, 20 Mar 2018 11:18:25 -0400 (EDT)
Received: from [10.150.2.237] (helo=GTB)
        by DC2-DLPMTA1 with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.88)
        (envelope-from <josephst@bhphoto.com>)
        id 1eyJ1t-0004b8-Jk; Tue, 20 Mar 2018 11:18:25 -0400
Received: from EXMBX02B.bhphotovideo.local (10.150.2.237) by
 EXMBX02B.bhphotovideo.local (10.150.2.237) with Microsoft SMTP Server (TLS)
 id 15.0.1347.2; Tue, 20 Mar 2018 11:18:25 -0400
Received: from EXMBX02B.bhphotovideo.local ([fe80::e062:366f:3c94:9917]) by
 EXMBX02B.bhphotovideo.local ([fe80::e062:366f:3c94:9917%17]) with mapi id
 15.00.1347.000; Tue, 20 Mar 2018 11:18:25 -0400
From:   Joseph Strauss <josephst@bhphoto.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug With git rebase -p
Thread-Topic: Bug With git rebase -p
Thread-Index: AdO/wC9oROpH+fLZQPeiJyRnBL5/FgABDkB+AC4NpgAAB3zcMA==
Date:   Tue, 20 Mar 2018 15:18:24 +0000
Message-ID: <44d0049acaf24e409849f929d7ae4888@EXMBX02B.bhphotovideo.local>
References: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local>
 <xmqqlgenu6qj.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803201551480.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
In-Reply-To: <nycvar.QRO.7.76.6.1803201551480.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.50.0.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MTA-device-Scanned: Yes (on DC2-DLPMTA1) 1353 bytes in 0 secs
X-UOID: 18C5AB48-98F6-47CE-B68F-B154A109AA67
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_06:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perfect. Thank you.

-----Original Message-----
From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
Sent: Tuesday, March 20, 2018 10:53 AM
To: Junio C Hamano <gitster@pobox.com>
Cc: Joseph Strauss <josephst@bhphoto.com>; git@vger.kernel.org
Subject: Re: Bug With git rebase -p

Hi,

On Mon, 19 Mar 2018, Junio C Hamano wrote:

> Joseph Strauss <josephst@bhphoto.com> writes:
> 
> > I found the following erroneous behavior with "git rebase -p".
> >
> > My current version is git version 2.16.2.windows.1
> >
> > I made an example at GitHub, https://github.com/jkstrauss/git-bug/
> >
> > There seem to be two problems when rebasing merge commits with git rebase -p :
> >   1. All lines of merge commits' messages get collapse into a single line.
> >   2. When an asterisk is present in the middle of the line it gets replaced with the file names of the current directory.
> 
> I suspect that this has already been independently discovered
> (twice) and corrected with
> 
> https://public-inbox.org/git/20180208204241.19324-1-gregory.herrero@or
> acle.com/
> 
> and is included in v2.17-rc0 (and later ;-).

As it is included in v2.17.0-rc0, Joseph, could you verify that the version at

https://github.com/git-for-windows/git/releases/tag/v2.17.0-rc0.windows.1

fixes this issue for you?

Thanks,
Johannes

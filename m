Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD6A1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeCVQwk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 22 Mar 2018 12:52:40 -0400
Received: from mx0a-001d5301.pphosted.com ([67.231.148.98]:38938 "EHLO
        mx0b-001d5301.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751628AbeCVQwj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Mar 2018 12:52:39 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Mar 2018 12:52:39 EDT
Received: from pps.filterd (m0084119.ppops.net [127.0.0.1])
        by mx0a-001d5301.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2MGhNW5015396;
        Thu, 22 Mar 2018 12:47:35 -0400
Received: from dc2-mx8.bnh.com (edge-2.bhphoto.net [74.113.190.228] (may be forged))
        by mx0a-001d5301.pphosted.com with ESMTP id 2gumjsms30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Mar 2018 12:47:35 -0400
Received: from DC2-DLPMTA1 (lb-fmg-svc.bhphoto.net [10.50.8.10])
        by dc2-mx8.bnh.com (8.15.1+Sun/8.14.9) with ESMTP id w2MGlYfh018754;
        Thu, 22 Mar 2018 12:47:34 -0400 (EDT)
Received: from [10.150.2.236] (helo=GTB)
        by DC2-DLPMTA1 with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.88)
        (envelope-from <josephst@bhphoto.com>)
        id 1ez3NF-000DFQ-VD; Thu, 22 Mar 2018 12:47:34 -0400
Received: from EXMBX02B.bhphotovideo.local (10.150.2.237) by
 EXMBX01B.bhphotovideo.local (10.150.2.236) with Microsoft SMTP Server (TLS)
 id 15.0.1347.2; Thu, 22 Mar 2018 12:47:33 -0400
Received: from EXMBX02B.bhphotovideo.local ([fe80::e062:366f:3c94:9917]) by
 EXMBX02B.bhphotovideo.local ([fe80::e062:366f:3c94:9917%17]) with mapi id
 15.00.1347.000; Thu, 22 Mar 2018 12:47:33 -0400
From:   Joseph Strauss <josephst@bhphoto.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug With git rebase -p
Thread-Topic: Bug With git rebase -p
Thread-Index: AQHTwfw1ROpH+fLZQPeiJyRnBL5/FqPcdJyw
Date:   Thu, 22 Mar 2018 16:47:32 +0000
Message-ID: <e1f49e12af544f4c9ece2794f7be4d9a@EXMBX02B.bhphotovideo.local>
References: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local>
        <xmqqlgenu6qj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803201551480.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <44d0049acaf24e409849f929d7ae4888@EXMBX02B.bhphotovideo.local>
        <nycvar.QRO.7.76.6.1803212332320.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqqd0zwm5fd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0zwm5fd.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.50.0.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MTA-device-Scanned: Yes (on DC2-DLPMTA1) 1042 bytes in 1 secs
X-UOID: 9D432090-76D4-4370-9B96-3666A9C0E953
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_08:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I meant to say that I installed 2.17.0-rc0, and it worked perfectly. Sorry for the ambiguity.

-----Original Message-----
From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C Hamano
Sent: Thursday, March 22, 2018 12:39 PM
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Joseph Strauss <josephst@bhphoto.com>; git@vger.kernel.org
Subject: Re: Bug With git rebase -p

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 20 Mar 2018, Joseph Strauss wrote:
>
>> Perfect. Thank you.
>
> You are welcome.
>
> I am puzzled, though... does your message mean that you tested the Git 
> for Windows v2.17.0-rc0 installer and it did fix your problem? Or do 
> you simply assume that it does fix your problem because Junio & I 
> expect it to fix your problem?

Thanks for asking, as I was curious about the same thing after interpreting what Joseph said as "oh, perfect that there is a packaged thing I can readily test" (implying "I'll get back to you after seeing if it helps").

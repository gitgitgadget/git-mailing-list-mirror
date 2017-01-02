Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5481FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 06:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbdABGqf (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 01:46:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752641AbdABGqY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 01:46:24 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v026i1Gp053914
        for <git@vger.kernel.org>; Mon, 2 Jan 2017 01:46:24 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27q6qbrwm3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 01:46:23 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Sun, 1 Jan 2017 23:46:22 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sun, 1 Jan 2017 23:46:20 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 766821FF001E;
        Sun,  1 Jan 2017 23:45:59 -0700 (MST)
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v026kKJr5308832;
        Sun, 1 Jan 2017 23:46:20 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 508BBBE03A;
        Sun,  1 Jan 2017 23:46:20 -0700 (MST)
Received: from skywalker.in.ibm.com (unknown [9.124.35.86])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with SMTP id C94F1BE039;
        Sun,  1 Jan 2017 23:46:18 -0700 (MST)
Received: (nullmailer pid 3918 invoked by uid 1000);
        Mon, 02 Jan 2017 06:46:17 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jvoss@altsci.com,
        "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] contrib: remove gitview
In-Reply-To: <20161229015918.jyiqd42z4htjibul@sigill.intra.peff.net>
References: <20161228064255.f4akjdsq24r2hqn7@sigill.intra.peff.net> <20161228172837.24395-1-sbeller@google.com> <20161229015918.jyiqd42z4htjibul@sigill.intra.peff.net>
Date:   Mon, 02 Jan 2017 12:16:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 17010206-0012-0000-0000-000012DB1719
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00006358; HX=3.00000240; KW=3.00000007;
 PH=3.00000004; SC=3.00000199; SDB=6.00802319; UDB=6.00390193; IPR=6.00580170;
 BA=6.00005023; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00013785; XFM=3.00000011;
 UTC=2017-01-02 06:46:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17010206-0013-0000-0000-000049C80AE7
Message-Id: <8760lyc62u.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-01-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=1
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1612050000
 definitions=main-1701020115
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Dec 28, 2016 at 09:28:37AM -0800, Stefan Beller wrote:
>
>> gitview did not have meaningful contributions since 2007, which gives the
>> impression it is either a mature or dead project.
>> 
>> In both cases we should not carry it in git.git as the README for contrib
>> states we only want to carry experimental things to give early exposure.
>> 
>> Recently a security vulnerability was reported by Javantea, so the decision
>> to either fix the issue or remove the code in question becomes a bit
>> more urgent.
>> 
>> Reported-by: Javantea <jvoss@altsci.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  contrib/gitview/gitview     | 1305 -------------------------------------------
>>  contrib/gitview/gitview.txt |   57 --
>>  2 files changed, 1362 deletions(-)
>>  delete mode 100755 contrib/gitview/gitview
>>  delete mode 100644 contrib/gitview/gitview.txt
>
> Thanks for assembling the patch. This seems reasonable to me, though I'd
> like to get an Ack from Aneesh if we can.

Acked-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

-aneesh


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7511C1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 19:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdHCTBX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 3 Aug 2017 15:01:23 -0400
Received: from mx0b-00105401.pphosted.com ([67.231.152.184]:52117 "EHLO
        mx0b-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751739AbdHCTBX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2017 15:01:23 -0400
X-Greylist: delayed 5037 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Aug 2017 15:01:22 EDT
Received: from pps.filterd (m0074333.ppops.net [127.0.0.1])
        by m0074333.ppops.net (8.16.0.20/8.16.0.20) with SMTP id v73HYRwS046763
        for <git@vger.kernel.org>; Thu, 3 Aug 2017 13:37:22 -0400
Received: from xnwpv31.utc.com ([167.17.239.11])
        by m0074333.ppops.net with ESMTP id 2c46rq5swf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 13:37:22 -0400
Received: from pps.filterd (xnwpv31.utc.com [127.0.0.1])
        by xnwpv31.utc.com (8.15.0.59/8.15.0.59) with SMTP id v73HKgGE022078
        for <git@vger.kernel.org>; Thu, 3 Aug 2017 13:37:21 -0400
Received: from uusmna1q.utc.com (uusmna1q.utc.com [159.82.219.65])
        by xnwpv31.utc.com with ESMTP id 2c4859r73s-1
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 13:37:21 -0400
Received: from UUSALE0P.utcmail.com (UUSALE0P.utcmail.com [10.220.35.34])
        by uusmna1q.utc.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v73HbKwa014435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 3 Aug 2017 13:37:21 -0400
Received: from UUSALE0M.utcmail.com (10.220.35.32) by UUSALE0P.utcmail.com
 (10.220.35.34) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Thu, 3 Aug
 2017 13:37:20 -0400
Received: from UUSALE0M.utcmail.com ([10.220.35.32]) by UUSALE0M.utcmail.com
 ([10.220.35.32]) with mapi id 15.00.1263.000; Thu, 3 Aug 2017 13:37:20 -0400
From:   "Burkhardt, Glenn B        UTAS" <Glenn.Burkhardt@utas.utc.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: gitk -m ?
Thread-Topic: gitk -m ?
Thread-Index: AdMMfuPtWkaB7cx3TfmXS1g/Ao0Bcw==
Date:   Thu, 3 Aug 2017 17:37:19 +0000
Message-ID: <6ef11677ca184e78a545452ffffe55a1@UUSALE0M.utcmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.220.3.242]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1706020000
 definitions=main-1708030270
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been looking in 'gitk' for an option that does what 'git log -m' does.  Did I miss something?  In particular, I'd like to get information about a file that's currently available with "git log -m --all --follow", but presented in 'gitk'.  If it's not there, please consider this a feature request.

Thanks.

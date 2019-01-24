Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EEC1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 15:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfAXPJw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 24 Jan 2019 10:09:52 -0500
Received: from mx0b-0000bf01.pphosted.com ([67.231.152.145]:57862 "EHLO
        mx0a-0000bf01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727943AbfAXPJw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jan 2019 10:09:52 -0500
X-Greylist: delayed 839 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 10:09:51 EST
Received: from pps.filterd (m0042303.ppops.net [127.0.0.1])
        by mx0b-0000bf01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OEmpqb020755
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 08:55:52 -0600
Received: from np1exhc101.corp.halliburton.com ([134.132.53.10])
        by mx0b-0000bf01.pphosted.com with ESMTP id 2q7dnqs0ad-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 08:55:49 -0600
Received: from NP1EXMB203.corp.halliburton.com ([169.254.6.8]) by
 NP1EXHC101.corp.halliburton.com ([10.192.132.205]) with mapi id
 14.03.0415.000; Thu, 24 Jan 2019 08:51:51 -0600
From:   Naum Derzhi <Naum.Derzhi@halliburton.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Removing data from repository
Thread-Topic: Removing data from repository
Thread-Index: AdSz7s7aSPVattG+TsebHRS3nLc11AABTpqw
Date:   Thu, 24 Jan 2019 14:51:50 +0000
Message-ID: <7A854577E980BE4FB29FDD041B9B75E701798CEE@NP1EXMB203.corp.halliburton.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.192.128.17]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=794 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901240104
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

I have this problem: years ago one of our developers committed a large (Gigabytes) piece of binary data into our project repository. This should not have been done, but it happened. (Honest, it was not me). We never needed this data in the repository.

Using git rm removes these files from the working tree, but they are still somewhere in the repository, so when we clone, we transfer gigabytes of unneeded data. 

Is it possible to fix this problem?

Thank you
 
 
Naum Derzhi
Chief Scientific Adviser, Physics
 
3000 N Sam Houston Pkwy E, Technology Center, Office T1241H
Houston, TX 77032

Office: +1 (281) 871 3278

________________________________________
This e-mail, including any attached files, may contain confidential and privileged information for the sole use of the intended recipient. Any review, use, distribution, or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive information for the intended recipient), please contact the sender by reply e-mail and delete all copies of this message.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3D6211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbeLZUc0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 26 Dec 2018 15:32:26 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:42432 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbeLZUc0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 15:32:26 -0500
X-Greylist: delayed 34963 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Dec 2018 15:32:24 EST
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBQAk6r3031805
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 10:49:41 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2pkvd7u2pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 10:49:40 +0000
Received: from G4W9121.americas.hpqcorp.net (g4w9121.houston.hp.com [16.210.21.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 46E5665
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 10:49:40 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 26 Dec 2018 10:49:39 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 26 Dec 2018 10:49:39 +0000
Received: from AT5PR8401MB0353.NAMPRD84.PROD.OUTLOOK.COM (10.169.2.143) by
 AT5PR8401MB0482.NAMPRD84.PROD.OUTLOOK.COM (10.169.3.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 26 Dec 2018 10:49:38 +0000
Received: from AT5PR8401MB0353.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::15af:f683:a7fc:6f47]) by AT5PR8401MB0353.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::15af:f683:a7fc:6f47%6]) with mapi id 15.20.1446.027; Wed, 26 Dec 2018
 10:49:38 +0000
From:   "Kodavati, Anilchowdari" <anilchowdari.kodavati@hpe.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Reg SVN to Git Migration
Thread-Topic: Reg SVN to Git Migration
Thread-Index: AdSdCEXnsi1igLacRLSLFR70ulOEog==
Date:   Wed, 26 Dec 2018 10:49:38 +0000
Message-ID: <AT5PR8401MB0353D6F00F021E74E40D0A12EAB50@AT5PR8401MB0353.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.48.114.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0482;6:eXWI0ibJWLRAbOPiUpnk6fws1cmKdbRV1D+ANWX/qu+YfIaWwouQ3bqBJytrxMu2qVbdQ8H31aW2iFhb7AAzDAz6lhYdTxbaTduXXHPm1zkBY/8McZtpTKdVlgXS0oO/0tCtwfaf8fUs06N+JkrvJpa4N4xBcvQa2iThwhRG+rZSg8ovSo/ngG1h3+KDS+BiZV1a5s0UAnr1nZpfFIzcd+W36vDR3SfeVs7mVBQBIg2xm0gbNj650VAaPD20LzTzKGAWihaz5JwBXIdwQY+cXzP7S9gYclNJdPmZvAO/Alopgk8aspygfiyLjPCBpxj9N8dL6w2mp8Hb9o8orb3T8G0vXfM13y5oO81wFayh4DWQmj/Jnk7u/X+pZZcbhBrsbJKo/MPeOTOPUfzIezJhov7hB7Kroyx0+ToEACg4fAEMGdBihY6LuUBU1mXi1xDnQRbN2ox2b5nC9mKdF+t7Gw==;5:nVbrMpXgTM9nxzmsPJCfDSYm5bEyYOOW2dsWyzMY0hA75AqsjiBvm9A5v1IYbaRObtBkCpaaUz7efa0rzrmTkhbbQt1oYxvLLLDXa89vvNR7jOoV8PszI7fO6pRyBUs9STgXN8dLump21uCm2slijPo/inl4qzE0krtjRXBuDOs=;7:hcF42eFurM5zw+YcsUt3Vb6mstcGGp/1QsdDwpQnm+LVF6tOZan8iMwfgznAxcSr1sGEsedSI4wmDbmXmQnCAIINh/I5mNy9Uyz5LN6fyG+quJCXRummZMhSaI1Rvws4XDAMV3/ThfVfHT6RPojPZQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 930c16a8-fc64-4e2b-4ad3-08d66b1fd509
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0482;
x-ms-traffictypediagnostic: AT5PR8401MB0482:
x-microsoft-antispam-prvs: <AT5PR8401MB0482E6DA32A2EAC09C9D62F3EAB50@AT5PR8401MB0482.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB0482;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0482;
x-forefront-prvs: 0898A6E028
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(8936002)(81156014)(5660300001)(2501003)(6436002)(81166006)(71190400001)(71200400001)(14454004)(74316002)(1730700003)(9686003)(86362001)(55016002)(106356001)(478600001)(68736007)(8676002)(99286004)(25786009)(6916009)(105586002)(186003)(476003)(316002)(97736004)(305945005)(256004)(7696005)(7736002)(53936002)(26005)(5640700003)(19627235002)(6116002)(3846002)(2351001)(102836004)(486006)(33656002)(2906002)(66066001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0482;H:AT5PR8401MB0353.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cIgsWU7GOBcyURFdavadMYFPEHiXrpMfpVeUak4xAj/go2DBtr0IiJeTD+LSUw9yJiPyHRFj9zFJ6hNuS3CdCukZksab8aBzi8V5ZpWzv5dA/Wyz1Manmz7edVy2HHuY79MiSlzrFI/FUgceG+fQVloJpavGimvg2XRzEFF/+tqK5q6w6HGC2CBm17yOiU3QsvQz2AHQAUfGc/AR3gFopbWu+RQ2OunP3ntTNodi77xRef3bc0Tj/wEkfTQaQUSXs51PmOT+NVZh/NoqaCsPsMlSVmc4UDht77XXiuk6JTLmC/yGMVf6gnqg0bAKqso3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 930c16a8-fc64-4e2b-4ad3-08d66b1fd509
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2018 10:49:38.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0482
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=2
 clxscore=1015 lowpriorityscore=0 mlxscore=2 impostorscore=0
 mlxlogscore=168 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812260100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am getting below error while doing migration from svn to git. Is there a solution available to over this issue. Can you please help here to solve this issue.

Error details:-
Software caused connection abort: Error running context: Software caused connection abort at C:/Program Files/Git/mingw64/share/perl5/Git/SVN/Ra.pm line 312.


Regards,
Anilchowdari.k



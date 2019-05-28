Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B531B1F462
	for <e@80x24.org>; Tue, 28 May 2019 09:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfE1JKR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 28 May 2019 05:10:17 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:41988 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726853AbfE1JKQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 05:10:16 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4S962OR016860
        for <git@vger.kernel.org>; Tue, 28 May 2019 09:10:15 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 2ss1rpg5m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 28 May 2019 09:10:15 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id C3B9756
        for <git@vger.kernel.org>; Tue, 28 May 2019 09:10:14 +0000 (UTC)
Received: from G4W9328.americas.hpqcorp.net (16.208.32.98) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 09:10:14 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G4W9328.americas.hpqcorp.net (2002:10d0:2062::10d0:2062) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 28 May 2019 09:10:13 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 09:10:13 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.13) by
 TU4PR8401MB0782.NAMPRD84.PROD.OUTLOOK.COM (10.169.44.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 09:10:12 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38%4]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 09:10:12 +0000
From:   "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: GIT issue while cloning (fatal: pack is corrupted (SHA1 mismatch))
 !!!
Thread-Topic: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Index: AdUVNK2vOdBL1LuLQeCX2A7XwcsEXwAAGetA
Date:   Tue, 28 May 2019 09:10:12 +0000
Message-ID: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.242.235.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1538edb6-0272-4ab9-6783-08d6e34c4a4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB0782;
x-ms-traffictypediagnostic: TU4PR8401MB0782:
x-microsoft-antispam-prvs: <TU4PR8401MB07821D5B397336413793A06AE11E0@TU4PR8401MB0782.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(86362001)(256004)(66066001)(76116006)(2351001)(1730700003)(6116002)(7736002)(305945005)(5660300002)(316002)(3846002)(6436002)(102836004)(81156014)(81166006)(14454004)(8676002)(478600001)(68736007)(6916009)(74316002)(33656002)(8936002)(2906002)(52536014)(55016002)(486006)(99286004)(2501003)(25786009)(66946007)(66476007)(66556008)(66446008)(64756008)(73956011)(6506007)(7696005)(53936002)(5640700003)(71200400001)(71190400001)(186003)(9686003)(476003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0782;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6c16s/ub5PDuQzMbeyBwpzsfnVVYOZAb9Dv4sNPViZxDWPpU9LBXbyfqDBAeAQzAs5dwJ1TRVQKgN/dElfO8HEesnrPFItZtaKVlJYbF5zGSDhFccQ8Ma9QJxGAwIV5naCJJ6TM7GEVMQ5xpysuAmEcpQ/jZhE+pNPKGBQ4npj8vm+kAgH/QAHVUc8v4gdIuClv+pJD68i+EYrU5X5k2uApaZBav45lSpege3hve4x+XlBctKQ94lA6NKRBNJvqmS2OiqeIP9AkdeQOovJUcdLajhM9A1PdDuvtAJoUlMaw6prZiOUgj26P8xyXGL0UqV+xIumJE7+CGq+L/9yiYghvudmyQh+h+a/zzQW1fVAxTcv3BgM61/tpxjz5loXimoK0/ThDtwHu2X6IjMnxGPprnVamnGGNEGq0+FX4BnkY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1538edb6-0272-4ab9-6783-08d6e34c4a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 09:10:12.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibrahim.vanak@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0782
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=840 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

We are seeing issue with GIT 2.14 version. When we try to clone the repos, it is taking HUGE amount of time on HPUX, whereas on the linux machine with same network configuration, it's getting cloned in less than mins. So we want to know has anyone reported this issue? What is the fix for this? Has the fix been released for this? Whom should we contact for this? 

Thanks & Regards,
Ibrahim Vanak

Below is the HPUX system where we are seeing issue, it is taking 1 hr 45 mins and later it failed:

root@sstl002.in.rdlabs.hpecorp.net# uname -a
HP-UX sstl002 B.11.31 U ia64 0158936019 unlimited-user license
root@sstl002.in.rdlabs.hpecorp.net# time git clone git@github.hpe.com:HPUX/SysFaultMgmt.git
Cloning into 'SysFaultMgmt'...
remote: Enumerating objects: 63627, done.
remote: Total 63627 (delta 0), reused 0 (delta 0), pack-reused 63627
Receiving objects: 100% (63627/63627), 681.90 MiB | 111.00 KiB/s, done.
fatal: pack is corrupted (SHA1 mismatch)
fatal: index-pack failed

real    104m3.373s
user    0m36.220s
sys     0m6.090s
You have mail in /var/mail/root
root@sstl002.in.rdlabs.hpecorp.net#

Below is the system where it has passed in less than 3 mins:

[root@chandana ~]# uname -a
Linux chandana.in.rdlabs.hpecorp.net 3.10.0-327.el7.x86_64 #1 SMP Thu Nov 19 22:10:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux 
[root@chandana ~]# time git clone git@github.hpe.com:HPUX/SysFaultMgmt.git
Cloning into 'SysFaultMgmt'...
remote: Enumerating objects: 63627, done.
remote: Total 63627 (delta 0), reused 0 (delta 0), pack-reused 63627
Receiving objects: 100% (63627/63627), 681.90 MiB | 5.59 MiB/s, done.
Resolving deltas: 100% (35495/35495), done.
Checking connectivity... done.
Checking out files: 100% (10634/10634), done.

real    2m46.517s
user    0m36.601s
sys     0m10.503s


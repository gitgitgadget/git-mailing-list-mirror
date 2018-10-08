Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PYZOR_CHECK,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DC01F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 14:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJHVNk (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 17:13:40 -0400
Received: from kecgate02.infosys.com ([122.98.14.32]:50757 "EHLO
        KECGATE02.infosys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeJHVNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 17:13:39 -0400
X-Greylist: delayed 1605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2018 17:13:38 EDT
Received: from KECGATE02.infosys.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4732A403B
        for <git@vger.kernel.org>; Mon,  8 Oct 2018 19:04:39 +0530 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=infosys.com;
        s=default; t=1539005679;
        bh=pj4Dh7fFeJyJbRCVKuTnSxcqlII8eH2HSGI0wweskV0=;
        h=From:To:Subject:Date:References:In-Reply-To;
        b=KQlilDjZK2jm1ifvyZn/JWC29HApLvxMKr/Ot4IfQ3eg64d/jpAZT4NwqDr7TwdFj
         0ShT5AUhn6twZpxrj1ssdB8Lb+xbsYHR823DPLtepRoFppph/vLMAyl6k9EwV6uvDg
         6EoxdlIQpo6oM5z0v2zy77NSMFczYyiiIT6lJEH0=
Received: from BLRKECHUB15.ad.infosys.com (unknown [10.66.236.43])
        by KECGATE02.infosys.com (Postfix) with ESMTP id 2BBC0A4066
        for <git@vger.kernel.org>; Mon,  8 Oct 2018 19:04:39 +0530 (IST)
Received: from BLREXOHYB04.ad.infosys.com (10.68.8.105) by
 BLRKECHUB15.ad.infosys.com (10.66.236.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 8 Oct 2018 19:04:58 +0530
Received: from BLREXOHYB01.ad.infosys.com (10.68.8.68) by
 BLREXOHYB04.ad.infosys.com (10.68.8.105) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Oct 2018 19:04:57 +0530
Received: from BLREDGE03.ad.infosys.com (122.98.14.118) by
 BLREXOHYB01.ad.infosys.com (10.68.8.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 8 Oct 2018 19:04:57 +0530
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (213.199.154.115)
 by edge.infosys.com (122.98.14.118) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 8 Oct 2018 19:03:34 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=infosystechnologies.onmicrosoft.com; s=selector1-infosys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj4Dh7fFeJyJbRCVKuTnSxcqlII8eH2HSGI0wweskV0=;
 b=Zfhq4N+EC28pBvayO/jud0DZBCuaNS72EXT9ckhIbuOWhySLuPn1Csq4gBQffHNf6iE3wAofkOGNI82xYgZm52Zg7nKv7aaBg61myfpyMotyVGwRWAm+Oy1GoCDQckmUIza9QjrJNzQPvX+QH11igJv2EENRp1RnZvWNf+ysl/M=
Received: from DB6P190MB0264.EURP190.PROD.OUTLOOK.COM (10.165.186.155) by
 DB6P190MB0231.EURP190.PROD.OUTLOOK.COM (10.172.230.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 13:34:55 +0000
Received: from DB6P190MB0264.EURP190.PROD.OUTLOOK.COM
 ([fe80::fd00:a20a:3a85:ac4c]) by DB6P190MB0264.EURP190.PROD.OUTLOOK.COM
 ([fe80::fd00:a20a:3a85:ac4c%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 13:34:55 +0000
From:   Inderpreet Saini <Inderpreet_Saini@infosys.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: 
Thread-Index: AQHUXwuWhkHuhV+bj0yj/1C97oPqkaUVWTyg
Date:   Mon, 8 Oct 2018 13:34:55 +0000
Message-ID: <DB6P190MB0264D57E910036A91599A09FE3E60@DB6P190MB0264.EURP190.PROD.OUTLOOK.COM>
References: <CA+cYV6v9RVkcheB+9gZot_tP07RzJuLP6b=gstxhCnzN=PKGPA@mail.gmail.com>
In-Reply-To: <CA+cYV6v9RVkcheB+9gZot_tP07RzJuLP6b=gstxhCnzN=PKGPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Inderpreet_Saini@infosys.com; 
x-originating-ip: [62.189.90.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6P190MB0231;6:tzGtsrUAtTgmGQLIGKutj3O6eJjl+OQo2yKxAr8kMwAnEAKCMn3YH+GPalxdXA55tKTdXklHs8afVswRjGqwjXhDQMCPXRQWs6RruDiQtMRXcP5IvXnwicgOpXtjLy0vHFKPcV4Yy0k9chg2msXRVx94DToKbchfFSzyDm5aApL6fxXG681cxWbSqARfjjDCMhU0T7l/B1LR89+75s6lj08QPsVrxxqIzFshhL/m08BemSXA25cDZMquxhVrxuwj2ArfkIBy+vIEXpwIRELQg6tNWvH0da9MUz3QY8ofTc667d9EAbsGQI3rcAxMUfVPKFwm/PFOnR+uqZLL/PrZPTK4Z4H90ve3YGHDvId1KsBDJ2tnwSphCnkIcB8KwkYXihQS1E7gzD1RIfJAyeAtdb/T0V1wOGVOjawJTfhgHed9pk/jQKF4DUNJNPnzvtJUVEDMs056iboRYzrjxCwcNA==;5:vmgOndFaLrFXWga/RVYY9lY5bgv4akHZVzpdxzz3FwMaY8Ptl2a8nmyJ+8CnEPon1r3jaBqraY22D+e0KtaLmeQkp4sxMM5iQFNFAPBCMmI0KdX/v4YjQs50lOcf3g2bComrl/CnR9agVGMPke6ni82QNQDJULHOeMeJ22qlwGk=;7:ITeqXvhyInpFcXWTP9NE4dl8/rX94mo7Uf7b/wD0vZ6zwvzQtqV1lw/WVMCNsWH7GFpzMmVmczUlvbip2balLr5HVJx6kPJ/dJ26NDOY5pCFBO5d0LrlDkigfR8kaisocO2I1OsLzNWnSBuO6w/VndlYvn/VKC0JWEWdJ1wxoyY2m0J5qX2796HzA2V4kqK/gPzYDbgwVUDGC6+DCiFtPp2Cyu9rng+hMgb+8YSO3UjPavpWqDQgXlL6/PkcPhfK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8ec7aa3e-4f4b-434c-e17f-08d62d22d582
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6P190MB0231;
x-ms-traffictypediagnostic: DB6P190MB0231:
x-microsoft-antispam-prvs: <DB6P190MB023175E286A851776EC8FC06E3E60@DB6P190MB0231.EURP190.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:DB6P190MB0231;BCL:0;PCL:0;RULEID:;SRVR:DB6P190MB0231;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(39850400004)(396003)(199004)(189003)(6916009)(7116003)(2906002)(68736007)(486006)(26005)(221173001)(66066001)(33656002)(256004)(5660300001)(2900100001)(19618925003)(8936002)(6116002)(476003)(14454004)(86362001)(6506007)(72206003)(11346002)(3480700004)(71190400001)(6436002)(3846002)(229853002)(4743002)(71200400001)(4270600006)(5640700003)(8676002)(81156014)(80792005)(2501003)(478600001)(7736002)(102836004)(305945005)(446003)(1730700003)(81166006)(55016002)(76176011)(588024002)(53936002)(9686003)(105586002)(106356001)(25786009)(74316002)(2351001)(558084003)(186003)(5250100002)(555874004)(316002)(97736004)(99286004)(7696005)(4000700002)(6246003)(231573002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6P190MB0231;H:DB6P190MB0264.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infosys.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LBLQJRt4Z+QIz05SqaO6RQ9Xwb4AYkdikIkhxaqtAmp3jvAQscB7FqqhWtIm3Sopl1hhudCfSO3uIL9ZBrQ3DOOfqvvYlg3t4YTLMZrabbxRb+B0f6Bnti+Save6rhHAHdAfmBGSZXJa6s+nWRmBREsd6R9olKd8fQnYzQHdzZix+r/8FSGdXjnjlV2OeXaM1Ez6sIgY74fl/bP7LGFb4BVpQYDvtjeYia88ItczbrANEFNvGqJ4BKSwWj5ITH9Nsop5jmQNirU2dyEpf7FyN9irTaIuI8syZv5V2YfPsddwVLCarm8HIWxzBX4crF0kV15gyzS/ACoBTJBCo7vGP5LePSD1nkUgDKeA2A5dFyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec7aa3e-4f4b-434c-e17f-08d62d22d582
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 13:34:55.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63ce7d59-2f3e-42cd-a8cc-be764cff5eb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0231
X-OriginatorOrg: infosys.com
X-TM-AS-GCONF: 00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dW5zdWJzY3JpYmUgZ2l0DQo=

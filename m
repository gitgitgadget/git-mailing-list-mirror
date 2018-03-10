Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0076B1F404
	for <e@80x24.org>; Sat, 10 Mar 2018 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCJP2q convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 10 Mar 2018 10:28:46 -0500
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:35328
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932162AbeCJP2p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 10:28:45 -0500
Received: from CY1PR02MB1399.namprd02.prod.outlook.com (10.161.171.148) by
 CY1PR02MB1962.namprd02.prod.outlook.com (10.166.189.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.548.13; Sat, 10 Mar 2018 15:28:43 +0000
Received: from CY1PR02MB1399.namprd02.prod.outlook.com
 ([fe80::9a0:1fb3:e4bd:df81]) by CY1PR02MB1399.namprd02.prod.outlook.com
 ([fe80::9a0:1fb3:e4bd:df81%14]) with mapi id 15.20.0548.019; Sat, 10 Mar 2018
 15:28:43 +0000
From:   "NELSON, JOSHUA Y" <jynelson@email.sc.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Feature request] Add config option to gpgsign IFF key is present
Thread-Topic: [Feature request] Add config option to gpgsign IFF key is
 present
Thread-Index: AQHTuIRYskh+adEmCUSB+LOceSAbpA==
Date:   Sat, 10 Mar 2018 15:28:43 +0000
Message-ID: <CY1PR02MB13991271133B3A6BD334328DF4DD0@CY1PR02MB1399.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jynelson@email.sc.edu; 
x-originating-ip: [70.42.157.62]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1962;7:/Csa5FnMqDvMyHTJeToUQunOsdGecJTbMNy54Z+V/82Qjb4ZQwhQOYqjsrPFmfsBpQwy9qNrv2JDA3UWO7Pduvuctd7CpjwMBvvt5M67bSkXPrI0TEuMfuFopA5HC/LDPixlUeX5qNkebXeFqOtbRm3ERPff21IhZnWHahBNpH4RQCd3ttcO/k0WG4T78/+56IDwDhuh2V2GJODaVxQ+zfCvyBq4g9z5McBC0S3G7priiUp/mvIWo9RCINsd1EAT
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 9b1358c5-5e16-4ca4-f343-08d5869b9bfb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7167020)(7153060)(7193020);SRVR:CY1PR02MB1962;
x-ms-traffictypediagnostic: CY1PR02MB1962:
x-microsoft-antispam-prvs: <CY1PR02MB1962A3E179B1F3719739601DF4DD0@CY1PR02MB1962.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR02MB1962;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1962;
x-forefront-prvs: 06070568C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39860400002)(39380400002)(189003)(199004)(51744003)(186003)(6506007)(102836004)(55236004)(7696005)(26005)(99286004)(345774005)(66066001)(478600001)(8676002)(1730700003)(81166006)(81156014)(105586002)(68736007)(3660700001)(8936002)(14454004)(316002)(786003)(6916009)(2906002)(74316002)(75432002)(2900100001)(6436002)(3280700002)(106356001)(5250100002)(3846002)(33656002)(97736004)(2501003)(5640700003)(6116002)(55016002)(5660300001)(9686003)(88552002)(7736002)(305945005)(2351001)(53346004)(86362001)(53936002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1962;H:CY1PR02MB1399.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
received-spf: None (protection.outlook.com: email.sc.edu does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NwQ+X8Xe4XhDw5pM5+UavINul7SfKct5iso1GSGHAC+QyUI55MTMkUHLFdHaq/lxWXt+KDpuYGJOadbGvkrDBCXkyC6ygrjfpRgQtvN06CREx8DS+V6QvhKFjyxgXFvpmji5pGjzoJjx52rmKS0E4JlvchHstlGqx7Sf0JTLw7fPTPIIokecsZnquz3ZwHL580xjFFMGwMO7tcWwRSTAN+PUQquNV3ED+BaHxAy8Jx2qSrnfQObr8Ef/uT9z9oAkXk+ZjX/dCkjWrmsa9aCWgaIxd62kvgrf3gtUvRZvLiCfOs38c8nEkvhc3NzD7l1/uJY9J31JjrMaGlBGv4zPbw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: email.sc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1358c5-5e16-4ca4-f343-08d5869b9bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2018 15:28:43.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b2a4b19-d135-420e-8bb2-b1cd238998cc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `commit.gpgsign` allows you to give either 'true' or 'false' as a value. If the key is not present, commits will fail:

```sh
$ git commit -m "example"
error: gpg failed to sign the data
fatal: failed to write commit object
```

I like to reuse my config file across several machines, some of which do not have my GPG key. Would it be possible to add an option to sign the commit only if the private key for `user.signingkey` is present? It could be named something like `commit.gpgsign=default-yes`.

Thank you for your time,
Joshua Nelson

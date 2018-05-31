Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696951F42D
	for <e@80x24.org>; Thu, 31 May 2018 15:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbeEaP5b (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 11:57:31 -0400
Received: from mail-by2nam01on0070.outbound.protection.outlook.com ([104.47.34.70]:44843
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755537AbeEaP5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zillowgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBh47ZTWMixcdi9Lsjycr36sqxK6H/bBH96iBQeJoC4=;
 b=NonXgvN+5ZnlIS23fMp0W1oYKxCCGuGHUddXL9gOd7/SfDI1xRqeHg5XMxtZYhB9CCq1aovYy4LLovlpHkmU25U6JaRv9eJOdVRl5TF8w+zOrufPElpAn0tl21sla9nwHXWL3EFP214RjztiPVsEObx/b7XD7OrcxyU0p+VACLI=
Received: from CY1PR0601MB1990.namprd06.prod.outlook.com (10.164.221.24) by
 CY1PR0601MB1469.namprd06.prod.outlook.com (10.163.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.797.11; Thu, 31 May 2018 15:57:28 +0000
Received: from CY1PR0601MB1990.namprd06.prod.outlook.com
 ([fe80::e142:f997:293c:917]) by CY1PR0601MB1990.namprd06.prod.outlook.com
 ([fe80::e142:f997:293c:917%4]) with mapi id 15.20.0820.010; Thu, 31 May 2018
 15:57:28 +0000
From:   Erika Voss <erikav@zillowgroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git Vulnerability Announced?
Thread-Topic: Git Vulnerability Announced?
Thread-Index: AQHT+PgTcVOcVy9ioEefRG9+4BJCcQ==
Date:   Thu, 31 May 2018 15:57:28 +0000
Message-ID: <D47B86A7-2E5A-4401-99B2-E59FD859C7E6@zillowgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erikav@zillowgroup.com; 
x-originating-ip: [64.125.67.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0601MB1469;7:ffdcu3dlhyD6rwRaRGg+x6vTPQ7j5mz/Me65kckcMSPsAbu9sJdqcSqjocVDsA5Ps39j2ui54n6eJefFuTAsM10RrAfHRVU3hYCThps4vyDnIEfhloPOQf3F1U+wodCDpU5ywHNcj8slpXplvlMo7kUf+hGhqhaaexS80+bznb0eNs0hA0D7VDwalZZ/sZpDmfmlNfhnKqtMx5PJk6qRydpgsa5W1wksFlWY1l2cQKrVFKw6XrmD2kDljHWEFGog
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CY1PR0601MB1469;
x-ms-traffictypediagnostic: CY1PR0601MB1469:
x-microsoft-antispam-prvs: <CY1PR0601MB1469D9A58FCA956FA226249AC3630@CY1PR0601MB1469.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR0601MB1469;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0601MB1469;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(39380400002)(189003)(199004)(6512007)(478600001)(68736007)(2501003)(6506007)(305945005)(7736002)(36756003)(102836004)(53936002)(186003)(5250100002)(5640700003)(6916009)(83716003)(2900100001)(6116002)(8676002)(3846002)(3660700001)(81156014)(1730700003)(81166006)(106356001)(3280700002)(3480700004)(26005)(97736004)(66066001)(33656002)(105586002)(7116003)(5660300001)(8936002)(6486002)(2351001)(2906002)(486006)(25786009)(99286004)(558084003)(82746002)(316002)(2616005)(14454004)(86362001)(476003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0601MB1469;H:CY1PR0601MB1990.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: zillowgroup.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7aJUziuX6bZKDuYJcIWDlBqFih/R+6Hw4y+giOJcH2zzRnGKK01iyoyufDKq0EJema//629NaG41kKoOLdUn5pFF6i6zh6z2pcMGSV6A/TlZvVA1r6xJ4cDT9vgwZKxYZLDhBw6iNdxG8H7JqMO03q8EZWFyXQPdSbbkh3zvLc59zKq7k/pXiOO/uCZgSiu5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <48A9C6B4451F9741B6A08B1875418845@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8d07f7d6-c44f-4e61-012a-08d5c70f35c2
X-OriginatorOrg: zillowgroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d07f7d6-c44f-4e61-012a-08d5c70f35c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 15:57:28.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03346483-0d18-40e7-a588-3784ac50e16f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0601MB1469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R29vZCBtb3JuaW5nLA0KDQpUaGVyZSB3YXMgYW4gYXJ0aWNsZSBJIGNhbWUgYWNyb3NzIHllc3Rl
cmRheSBpZGVudGlmeWluZyBhIHZ1bG5lcmFiaWxpdHkgdG8gcGF0Y2ggb3VyIEdpdCBlbnZpcm9u
bWVudHMuICBJIGRvbuKAmXQgc2VlIG9uZSB0aGF0IGlzIGF2YWlsYWJsZSBmb3Igb3VyIE1hYyBD
bGllbnRzIC0gaXMgdGhlcmUgYSBtb3JlIHJlY2VudCBvbmUgdGhhdCBJIGNhbiBkb3dubG9hZCB0
aGF0IGlzIGF2YWlsYWJsZSB0byBwYXRjaCB0aGUgMi4xNy4wIHZlcnNpb24/DQoNClRoYW5rIHlv
dSwNCkVyaWthDQoNCg==

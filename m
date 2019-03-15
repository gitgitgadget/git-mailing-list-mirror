Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6A0220248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfCOQ1Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:27:24 -0400
Received: from mail-oln040092068053.outbound.protection.outlook.com ([40.92.68.53]:52197
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729130AbfCOQ1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7VJZ8VSzdDNrPh5rNG/Zy5djT7LVd6wZTTwkXVTN7s=;
 b=GXPToFXsgBVXSrHDDRA1E24nwv9w/fv+O5upOMMWvC9MozkA84XG6gnkADw3uOmqkby9Zcg7GiiUXJPKqkvCY2N51I0Bnbohk/L1mAVZZ/fi1CcsufpgmNvVkZMI3Q5M2BH3eZuHt5lEFGGtg/TlkVSRh4FpiGSxIE8rjx1vdEOv41tRERL5VkDSpbKF1aiH3tahhyBmGQ+fV5bYELwRkC1+GVr3R5CDMsdvgyTBKId+u4WwryeeGnyMcKJaC6GGJHllsFmSJ3MGWxisD8x+sQTtxMS2s5YhNvGb2IkZeg0OUpwoSXhVg8NVoxfi6MsmDNgwACf5BOLIFNCllKhwfg==
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (10.152.8.59) by AM5EUR02HT128.eop-EUR02.prod.protection.outlook.com
 (10.152.9.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13; Fri, 15 Mar
 2019 16:27:21 +0000
Received: from AM4PR08MB1233.eurprd08.prod.outlook.com (10.152.8.51) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13 via Frontend Transport; Fri, 15 Mar 2019 16:27:21 +0000
Received: from AM4PR08MB1233.eurprd08.prod.outlook.com
 ([fe80::e1b0:7479:e90:4736]) by AM4PR08MB1233.eurprd08.prod.outlook.com
 ([fe80::e1b0:7479:e90:4736%8]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 16:27:21 +0000
From:   Maxim some <sailormax@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: .gitignore negates by mask problem
Thread-Topic: .gitignore negates by mask problem
Thread-Index: AQHU20vBP3q9sagqRUiV34ZeCPjxIg==
Date:   Fri, 15 Mar 2019 16:27:21 +0000
Message-ID: <AM4PR08MB12333C0A3AC2E20BE74BD273DD440@AM4PR08MB1233.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:76ABCEA6747104363CEAC32865325F81A1E35C66303361BE672EC67AE8A08E29;UpperCasedChecksum:3E1A0332B4405F8F7F8336433D395A197FA391A049B411ADECDC48A16A13F627;SizeAsReceived:6580;Count:41
x-tmn:  [SF6FPNk3iJZHl4CqG1tqXKmYX4eUfKdM]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031324274)(2017031323274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT128;
x-ms-traffictypediagnostic: AM5EUR02HT128:
x-microsoft-antispam-message-info: 9K8RwnBXb8ivRskSxSKuf8XSfQDRu33KKB6HMK+UEI7XyVLyzKzgRncMLERNQueJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9edf7f-f27c-4149-4614-08d6a9631958
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 16:27:21.0945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT128
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Problem:=0A=
Not possible to setup exclusion with /**/ mask and names with "dot"=0A=
=0A=
Directory structure:=0A=
conf/=0A=
conf/server.conf=0A=
conf/server.conf.default=0A=
conf/etc/=0A=
conf/etc/php.ini=0A=
conf/etc/php.ini.default=0A=
conf/etc/init.d/=0A=
conf/etc/init.d/fail2ban=0A=
conf/etc/init.d/fail2ban.default=0A=
controls/=0A=
controls/on_server_start=0A=
=0A=
Require:=0A=
1. track all files in all directories except conf/=0A=
2. inside conf/ directory require track only *.default files=0A=
=0A=
=0A=
My tries of .gitignore:=0A=
1.=0A=
/conf/**/*=0A=
!/conf/**/*.default=0A=
=0A=
result: =0A=
git check-ignore -v --no-index conf/etc/init.d/fail2ban.default=0A=
.gitignore:1:/conf/**/* conf/etc/init.d/fail2ban.default=0A=
=0A=
=0A=
2.=0A=
/conf/**/*.=0A=
!/conf/**/*.default=0A=
=0A=
result: =0A=
git check-ignore -v --no-index conf/etc/init.d/fail2ban.default=0A=
.gitignore:2:!/conf/**/*.default        conf/etc/init.d/fail2ban.default=0A=
=0A=
but=0A=
git check-ignore -v --no-index conf/server.conf=0A=
(empty)=0A=
=0A=
=0A=
Tested on Git v2.18.0(linux) and v2.20.1(windows)=0A=
--=0A=
Maxim=

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52719202DD
	for <e@80x24.org>; Tue, 24 Oct 2017 10:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdJXKit (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 06:38:49 -0400
Received: from esa3.hc19988.iphmx.com ([68.232.145.37]:44575 "EHLO
        esa3.hc19988.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdJXKis (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 06:38:48 -0400
X-Persistent_Disclaimer: true
X-Accelerite_Disclaimer: true
X-IronPort-AV: E=Sophos;i="5.43,427,1503340200"; 
   d="scan'208";a="4411467"
Received: from mail-bo1ind01lp0177.outbound.protection.outlook.com (HELO IND01-BO1-obe.outbound.protection.outlook.com) ([23.103.140.177])
  by ob1.hc19988.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Oct 2017 16:08:39 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=persistentsystems.onmicrosoft.com; s=selector1-Persistent-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nxrCjIygsI3zjxwtW4xobUGGPDWs+dZIwkdP/s1mMps=;
 b=ngSKpKehzO1mxssXD5X2H7p6ZNmHJinLeGOH9LFyc9L2salt40m/2rQEAdZZIXYUV3IrhuB98SCjSrc/LgmL1NJO3w3vXpoy1hbNQNpl2zF8UR/kfgM/VVMZ6QkWKGXHI3T7VU0L+qmk1BENayRB4uud9Ex7qs+s1UOrw/yP9do=
Received: from MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM (52.134.130.15) by
 MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM (52.134.130.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4; Tue, 24 Oct 2017 10:38:35 +0000
Received: from MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::610f:911e:c344:638d]) by MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::610f:911e:c344:638d%17]) with mapi id 15.20.0156.007; Tue, 24 Oct
 2017 10:38:35 +0000
From:   Vaibhav Sood <vaibhav_sood@persistent.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Docker image for git
Thread-Topic: Docker image for git
Thread-Index: AdNMtDtYO2Z80NhRRfWNjjr+U6WBIQ==
Date:   Tue, 24 Oct 2017 10:38:35 +0000
Message-ID: <MAXPR0101MB146810B98D591DDDCA498EEA9B470@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [121.244.211.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MAXPR0101MB1468;6:h6B/O6nH5aTnwVyhxgmjBQY3veuBYI8wrA4RzHMqbkREvxmFEuq/zoZzUghu4COOxn7WwixwTiNo5RIRSsK+3ZkpQQS53g+T3dVhYKUmvWZvlFDn6rlptLtZK7lrkzD6VpTkCxYEBqcPwi5oc1CXVw4kUssTqB1u30Dd8yWSFao1lqrN9hdGS7oIzE+6RYUeoh4OmPY+XRydv881ILke1gEQHVzBYfyg9/y0ryG8mk1lh9d30qtYpf+ViD3R/RIvQdnSUUJuQSlQnhYcWZPhPzhmKCwq2WLRaPhX20VhnbQNUnQMhkblUk4aEMatTdSZzT73pvcuenJmsnlIT8bqQg==;5:3ddDO+VA9024P/sjPw1yBjIVmRfUwFewuWT9LkxrVki/eOMvBLW74OMiRo9xKCz1hXDX1WTpK/kLLuEcRpSpkwaYV88M831xTKXx4BYsHNUyjM+zUOJgVe1nfMoaSezG+14oKQq7tUfBMLl2a6VyNq8MqvTfHEi7EqMKf2HstqY=;24:cQ+eY5IZq9XlAIJ5I83fh9fNI/AiWOmzSrOJYtsH2c7dS1U+HqzN2S77Rp3EdRcXMLTpdbmYZZ6CDv7miOtdpXBERtbLaoQ9dbef9FifjXs=;7:LdUZVLoSUOE6IF3PTHXSf985h71gbndE8HTe6absjXUAAJC/H+N1YquLRlA4AhPFnz/kt3mVcC69ktcgfpc1c5rGbQbwmadBKyDu1+n3Ic9Mjohn55HL/Cs16wgsaEOUuNSGIMT0OE2S4z1nvUU9/BUHQGsJlEhGJquO1x8V6GCjsBdcckXaktTtxIxR7mrh1eSz4vI6UNKUXZPdDJfEgxQwfRogWHOmhGHWz1oRJ/s=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 2e232506-f9b7-4322-d93d-08d51acb6126
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627075)(201703031133081)(201702281549075)(2017052603229);SRVR:MAXPR0101MB1468;
x-ms-traffictypediagnostic: MAXPR0101MB1468:|MAXPR0101MB1468:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vaibhav_sood@persistent.com; 
x-ld-processed: 1f4beacd-b7aa-49b2-aaa1-b8525cb257e0,ExtAddr
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <MAXPR0101MB14685638FB9C80E158847C759B470@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231020)(100000703101)(100105400095)(93006095)(93001095)(6055026)(6041248)(20161123562025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MAXPR0101MB1468;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MAXPR0101MB1468;
x-forefront-prvs: 047001DADA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(39860400002)(199003)(189002)(6916009)(2501003)(14454004)(316002)(106356001)(5660300001)(189998001)(7696004)(305945005)(105586002)(2351001)(3660700001)(74316002)(3280700002)(81166006)(8676002)(81156014)(7736002)(97736004)(3480700004)(2906002)(2900100001)(50986999)(5640700003)(6436002)(6506006)(66066001)(68736007)(1730700003)(8936002)(54356999)(101416001)(478600001)(9686003)(33656002)(6116002)(102836003)(6306002)(966005)(86362001)(3846002)(55016002)(53936002)(25786009)(5250100002)(140573001);DIR:OUT;SFP:1101;SCL:1;SRVR:MAXPR0101MB1468;H:MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: Persistent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e232506-f9b7-4322-d93d-08d51acb6126
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2017 10:38:35.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f4beacd-b7aa-49b2-aaa1-b8525cb257e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR0101MB1468
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Want to check if there is a docker image/Dockerfile for git which is offici=
ally supported? I could not find one under dockerhub official images=A0http=
s://hub.docker.com/explore/

If not, want to check if there is any plan to add an official git image to =
dockerhub?=A0https://docs.docker.com/docker-hub/official_repos/#how-do-i-cr=
eate-a-new-official-repository

DISCLAIMER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This e-mail may contain privileged and confidential information which is th=
e property of Persistent Systems Ltd. It is intended only for the use of th=
e individual or entity to which it is addressed. If you are not the intende=
d recipient, you are not authorized to read, retain, copy, print, distribut=
e or use this message. If you have received this communication in error, pl=
ease notify the sender and delete all copies of this message. Persistent Sy=
stems Ltd. does not accept any liability for virus infected mails.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E2F1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeCPTDw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:03:52 -0400
Received: from mail-by2nam01on0066.outbound.protection.outlook.com ([104.47.34.66]:57623
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750826AbeCPTDv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aei.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yE4YNgg6EGQMQI4Qyqd5xLTjQX323ZdPayBhRQl1/vU=;
 b=Oit9EeGGFEfDv+kRjge8+rfv0y4LaxlW0Lz/WOQ60RxAm5rj11BYcXZTztVc0mgtYXXwxceNHIorBwykfVNRcy33rCUGJM1IzbZf6fVMp65n3Wp23hYhcoWNyysOUNrPwUbjFo1P3gCetGrwfPOapn3ptl6KvKEQa8ABJrdvXaA=
Received: from CY4PR02MB2262.namprd02.prod.outlook.com (10.169.181.15) by
 CY4PR02MB2247.namprd02.prod.outlook.com (10.169.181.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.567.14; Fri, 16 Mar 2018 19:03:50 +0000
Received: from CY4PR02MB2262.namprd02.prod.outlook.com
 ([fe80::68ff:36cb:be97:49ee]) by CY4PR02MB2262.namprd02.prod.outlook.com
 ([fe80::68ff:36cb:be97:49ee%17]) with mapi id 15.20.0567.019; Fri, 16 Mar
 2018 19:03:50 +0000
From:   "Briggs, John" <JOHN.BRIGGS@aei.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: getting fatal error trying to open git gui
Thread-Topic: getting fatal error trying to open git gui
Thread-Index: AdO9WOQXVglR2Ht0QsiCtxNKgnqGlA==
Date:   Fri, 16 Mar 2018 19:03:49 +0000
Message-ID: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamJyaWdnc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWMwZjAwZGFkLTI5NGMtMTFlOC1hOTA3LWQ0ODFkN2E2MmViNlxhbWUtdGVzdFxjMGYwMGRhZi0yOTRjLTExZTgtYTkwNy1kNDgxZDdhNjJlYjZib2R5LnR4dCIgc3o9IjM1MiIgdD0iMTMxNjU3MDA2Mjc2MDkxMjM3IiBoPSJiK25meDk5VnpCTmV2bGdvZ1VwZDhMNkNueEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOHN.BRIGGS@aei.com; 
x-originating-ip: [8.39.233.75]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR02MB2247;20:QuyI4MUov0vErsnl0ltpu8dF0rBMwGb05MCsGZbFVIP/vDTOMLRInVNKfHKywyikbC4bT3uAHgfOfkymYucM32jhMU24FgJytnF3GkplkgRsvCZaJXaIR7l4E1l1ODgS98D7c/7S5SR0F5TPjBsgdwjW6NeTWWcHz4LxwAAQ0RE=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 746aa694-9314-4129-3de1-08d58b70a72e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CY4PR02MB2247;
x-ms-traffictypediagnostic: CY4PR02MB2247:
x-ms-exchange-orgnaization-bypassclutter: true
x-microsoft-antispam-prvs: <CY4PR02MB2247227B533B4400DFDF293CFFD70@CY4PR02MB2247.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR02MB2247;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2247;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(39830400003)(366004)(376002)(189003)(199004)(6916009)(25786009)(316002)(72206003)(558084003)(8936002)(3660700001)(99286004)(186003)(102836004)(26005)(3280700002)(86362001)(6506007)(2906002)(97736004)(305945005)(74316002)(3846002)(7736002)(6116002)(9686003)(55016002)(53936002)(2501003)(5250100002)(2900100001)(106356001)(8676002)(81156014)(1730700003)(33656002)(6436002)(81166006)(5640700003)(2351001)(14454004)(478600001)(68736007)(5660300001)(105586002)(66066001)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2247;H:CY4PR02MB2262.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: aei.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sd0xAuKAPGk4v6+UoiobXIQ1eR6NcaxDkGbrc1Bt3fz90PID3RDRSrsMe7xZTwy7MB1bEcBS2OL/gVdZyd2ikI05B1BsbNPTs71NVAigGZFKGDmJGWz98tvnAjp9ELKCHMwpE/+2YqjOAzE+4NF4tWPjPG3RA+mIbxlb7bDVSnInc8tpOAm26/z1yR64LCg/ej/fCTrTRDNfiJGutfjqmIqqea/ZIxmaKKzkULa25rpQRN83fgXoe6n3O+E88XZvkczYTJwBMFmtJwEA6c6R6ObXnhb5tGWOiPIknt2OW8zDvEBt0UsiVGg7LCauiPilL//4ozrGWDbrCw/V8HeRNA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aei.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746aa694-9314-4129-3de1-08d58b70a72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 19:03:49.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cfa7d515-0462-4766-8d7f-867b7825994a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2247
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just installed git for windows 10 and am getting "git-gui: fatal error" "=
Cannot parse Git version string.

When I execute "git version" in the command prompt I get
Git version 2.16.2.windows.1

Everything else seems to be working. How can I get the gui to work?

John


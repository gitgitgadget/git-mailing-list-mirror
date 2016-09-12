Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61400207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 18:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbcILSLg (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 14:11:36 -0400
Received: from sesbmg23.ericsson.net ([193.180.251.37]:51639 "EHLO
        sesbmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcILSLf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 14:11:35 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Sep 2016 14:11:34 EDT
X-AuditID: c1b4fb25-5405a9800000793b-36-57d6ec4f5b57
Received: from ESESSHC005.ericsson.se (Unknown_Domain [153.88.183.33])
        by  (Symantec Mail Security) with SMTP id C8.BB.31035.F4CE6D75; Mon, 12 Sep 2016 19:56:31 +0200 (CEST)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (153.88.183.145)
 by oa.msg.ericsson.com (153.88.183.33) with Microsoft SMTP Server (TLS) id
 14.3.301.0; Mon, 12 Sep 2016 19:53:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ericsson.onmicrosoft.com; s=selector1-ericsson-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=euKBbBClqao9r4J/+ccHWvpOBhwzb/sthmmwTIuRGgI=;
 b=O4qgmPA4bYxsPNxGsXIJq+yq4WTi2m0P45Fz6bD2MdXguVRiahyi5AYmUPyO2MfbY+kBjsBxtvw5of7f5b7A9maYjz9JW1q0WqI8gjgXStBkwh3yz17LrSCkijA0C5XE8Xz1pQB/gt6J+X7mQ3GvwtsXZKP9JbVitk1XBhYen+g=
Received: from DB5PR07MB1448.eurprd07.prod.outlook.com (10.166.4.22) by
 DB5PR07MB1445.eurprd07.prod.outlook.com (10.166.4.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.619.10; Mon, 12 Sep 2016 17:53:33 +0000
Received: from DB5PR07MB1448.eurprd07.prod.outlook.com ([10.166.4.22]) by
 DB5PR07MB1448.eurprd07.prod.outlook.com ([10.166.4.22]) with mapi id
 15.01.0619.011; Mon, 12 Sep 2016 17:53:33 +0000
From:   David Bainbridge <david.bainbridge@ericsson.com>
To:     Jon Loeliger <jdl@jdl.com>, Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Miniconference at Plumbers
Thread-Topic: Git Miniconference at Plumbers
Thread-Index: AQHSDI6V6h6pkqrOtUixVB2miusEwKB12x6AgABH3SA=
Date:   Mon, 12 Sep 2016 17:53:33 +0000
Message-ID: <DB5PR07MB1448B5EDFE2E2D84C42A8AFCE2FF0@DB5PR07MB1448.eurprd07.prod.outlook.com>
References: <E1bhKNo-0005m2-5z@mylo.jdl.com>
 <20160912004233.qh6uf35v5ylrboz6@sigill.intra.peff.net>
 <E1bjRLd-0005k0-Vb@mylo.jdl.com>
In-Reply-To: <E1bjRLd-0005k0-Vb@mylo.jdl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: jdl.com; dkim=none (message not signed)
 header.d=none;jdl.com; dmarc=none action=none header.from=ericsson.com;
x-originating-ip: [192.75.88.130]
x-ms-office365-filtering-correlation-id: 2d6b2114-dbe4-497b-28f6-08d3db35b6f5
x-microsoft-exchange-diagnostics: 1;DB5PR07MB1445;6:Ry6ZZF7LMk7cWjUeWF/0VY6SlXGJQ4zz7+NnlSiGPhH+us5PrOKCW8tq4v+zdhmzBFr+RvtxvUJxGPib+DyUvEIvb4pTbuqiQmdqEE4vdVIls4Smeo+Aq8s8SVut0t8rCQlMgPpIcVOAYe+QFJay7ZCcOP9IHMfJGUTb+MHaXQnDz/HLq7nIoWdFr5pH/PiCdlJ5qicUdZdQb68+PNmzxtwOJ4Trq+Il+p1KisHmNprVwtbY6Wr4he5kH8XXJPTUXabTFPolw2zmgMjaRD8bPeh083XordrbRk8uB/9uXc8=;5:85lKYeNow4HzKybW+tThYFGQXDvVnIOB1yH8sn2dOTRLjdtTY6VK/jPa/V2IuQPsLVAPi5yhQb+uPNzI3ZibTLEnfxN8MY2FTUcgwbDL03OBfr4OfKVBugMLtqx+coBMVXteYu12QPQRvo+7n7vvKA==;24:Ry38qNYYMKTFDO3pJXtclhVJl0TPSR4NlFX+gmt7aAxEDrc712DS6Ks5UtKqZ1+92+EsMai2tUoS5FnapPkQK5zp2HbJSuFSytzkPPkHCWY=;7:QjUE1E9vCdfo2W9NVNKR8Vmgk6Bn0tOswZbR7INIiaUALp/TQcmQcHfuPfsvhOr348bnkLFx1RNowX6nAwofNetxQRwH+hjbpa7aEopw2nVzKlvvdNYNo/hMh7eOHn7N5peIMQE/ZKquksNxt2CF8xIc/5/2jV2XExeZuXAZywt6v9W/445S8F8rr+C8CtUgYhcAF8Jqklv929vz3c8Yg8BVaTDktULF2HglfcSjsOra9CINpQWTAZCf5SCvd/3U
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1445;
x-microsoft-antispam-prvs: <DB5PR07MB14455E74D8656E7F6FB402C6E2FF0@DB5PR07MB1445.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(9452136761055)(202460600054446);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:DB5PR07MB1445;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1445;
x-forefront-prvs: 006339698F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(30513003)(24454002)(13464003)(54356999)(7696004)(50986999)(76176999)(106116001)(11100500001)(10400500002)(92566002)(87936001)(5660300001)(5004840100003)(9686002)(33656002)(2950100001)(2900100001)(3480700004)(76576001)(5002640100001)(3660700001)(66066001)(74316002)(4001520100001)(5001770100001)(3280700002)(7736002)(6116002)(7846002)(305945005)(86362001)(87386001)(19580395003)(81166006)(8676002)(189998001)(19580405001)(3846002)(8936002)(102836003)(15974865002)(586003)(2906002)(122556002)(4326007)(77096005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR07MB1445;H:DB5PR07MB1448.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2016 17:53:33.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1445
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42KZGbFdUdf/zbVwg29NShZdV7qZLF5PWshm
        8aOlh9mB2ePz2YPsHs969zB6fN4kF8AcxWWTkpqTWZZapG+XwJVx9eFCloIlXBU7zvcwNzBO
        5ehi5OCQEDCR+LVTvIuRk0NIYD2jxLFvIV2MXED2CUaJrQsb2UAcFoFeZol1j14wQWT6mSQW
        N66Fcg4xSqw/d58dpJ9NwEzizYTvLCC2iIClxNYze8BsZgF9iU9/DjCB2MIC2hKnbx9mBVkt
        IqAjsWSKKUS5lcS+ptmsIDaLgKpE18kOsJG8AjESD79+ZYbY1ckocWPiAzaQBKeArsT8YxfA
        ZjIKiEl8P7WGCWKXuMStJ/PBbAkBAYkle84zQ9iiEi8f/2MFGcQIMuhf/2EWiISixMEdG1gh
        bF+J429PMULY79gkLm21g7DdJJa3bYcalC3RM/U4IyTsoiSmzRcDmSkhsINRomfleqgaGYmj
        B/sZIRLrWSVmz9vABvG9lMTdK52MELaMxIs7e1knMGrOQnI4hK0jsWD3JzYIW1ti2cLXzLPA
        oSEocXLmE5YFjCyrGEWLU4uTctONjPVSizKTi4vz8/TyUks2MQITycEtv1V3MF5+43iIUYCD
        UYmH98GWa+FCrIllxZW5wPjiYFYS4b3/CijEm5JYWZValB9fVJqTWnyIUZqDRUmcd9l5oJRA
        emJJanZqakFqEUyWiYNTqoHROeSX6Lo7k3hOTfUpUk1x1F0tL73l0RGTxdu/r7KZ2FxmpLvg
        m9dx7fyD31tZU/KvzBH9uJ3zhODaySfv85jMK9S7Z93J1+slnPb87/9/awxdJp8R32DKcDRK
        Km3CgctyLmaveb6rHcrt0pFx1ZxzNuuigsv7TReylsRJKF5rC5Mo28DxcvNCJZbijERDLeai
        4kQA5ysejCADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The subject matter of the conference looks really interesting but I am unli=
kely to be able to attend, unfortunately.

The subjects being covered like the current State of Git and the Future of =
Git, for example, deserve much wider exposure, and I would certainly apprec=
iate hearing the thoughts of Junio and others.

Does anyone know whether the sessions will be recorded in any way?

Thanks

David

DAVID BAINBRIDGE
Product Manager SW Development

Ericsson
8500 Decarie
Montreal, H4P 2N2, Canada
david.bainbridge@ericsson.com
www.ericsson.com

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behal=
f Of Jon Loeliger
Sent: Monday, September 12, 2016 09:33
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Git Miniconference at Plumbers

So, like, Jeff King said:
> On Tue, Sep 06, 2016 at 12:42:04PM -0500, Jon Loeliger wrote:
>=20
> > I have recently been enlisted by folks at the Linux Foundation to=20
> > help run a Miniconference on Git at the Plumbers Conference [*] this=20
> > fall.
>=20
> I see the conference runs for 4 days; I assume the Git portion will=20
> just be one day.

Yes, and yes.  Likely even "a half day".

> Do you know yet which day?

No.  Sorry.

> -Peff

jdl

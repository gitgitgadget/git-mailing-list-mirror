Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215FB20193
	for <e@80x24.org>; Tue,  1 Nov 2016 10:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168544AbcKAK3B (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 06:29:01 -0400
Received: from lvs-ipout-02-data1.paypalcorp.com ([173.224.161.144]:20935 "EHLO
        lvs-ipout-02-data1.paypalcorp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1168512AbcKAK3B (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2016 06:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=paypal.com; i=@paypal.com; q=dns/txt; s=pp-dkim1;
  t=1477996140; x=1509532140;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ajgioDvQPy+wrDmEiiG4O2yIZLSZDz2VQ5dQ50JTQUk=;
  b=ibqCJk8cW1w0uW3c3UoccdugOKAIQn5dNtJvWeIyCP/f3YpL1ktbdQJD
   SoTpVUSjQnACxyq2Md5mDjrQMTUg0E4M+/qMD9NZddhs2Y7jESNQ1uLhj
   QuEW3aEKj4c6BK72DKrTxsk4l1r9h5HOOhIZVueV7XYyR4kijMTy4F7TO
   HvYLGcgz5n+bXpDp8SdynO4yofnAnTdGaOrouyRxzG179D/PJ9Rr/gK7w
   fJNQQG07gHAdXqL9U0eNjYApFb5sorWuXVjDOpTHMChv6LrbRcycAwdgz
   IaCT2ns0mFg1xjw7+5EpeUq4iR0L1dQFsOuSLnpbUibwnBSrljkwYIcdu
   g==;
X-IronPort-AV: E=Sophos;i="5.31,579,1473145200"; 
   d="scan'208";a="27061677"
Received: from unknown (HELO lvs-ipcld-02-data1.paypalcorp.com) ([10.185.246.164])
  by lvs-ipout-02-data1.paypalcorp.com with ESMTP; 01 Nov 2016 03:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,579,1473145200"; 
   d="scan'208";a="14557150"
X-CloudService: Office365
Received: from mail-bl2nam02lp0083.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.83])
  by lvs-ipcld-02-data1.paypalcorp.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2016 03:28:26 -0700
Received: from BY2PR0601MB1640.namprd06.prod.outlook.com (10.163.107.18) by
 BY2PR0601MB1638.namprd06.prod.outlook.com (10.163.107.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.693.12; Tue, 1 Nov 2016 10:28:57 +0000
Received: from BY2PR0601MB1640.namprd06.prod.outlook.com ([10.163.107.18]) by
 BY2PR0601MB1640.namprd06.prod.outlook.com ([10.163.107.18]) with mapi id
 15.01.0693.009; Tue, 1 Nov 2016 10:28:58 +0000
From:   "Halde, Faiz" <fhalde@paypal.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git issue
Thread-Topic: Git issue
Thread-Index: AdI0J3CwZczyXmwJT22+mDl/pM7wXwAA0HUQ
Date:   Tue, 1 Nov 2016 10:28:57 +0000
Message-ID: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fhalde@paypal.com; 
x-originating-ip: [43.230.180.5]
x-ms-office365-filtering-correlation-id: 8ac5450d-9a91-4768-a799-08d40241e393
x-microsoft-exchange-diagnostics: 1;BY2PR0601MB1638;7:5dpqr8H+VfyIajYzWtDjDFsZ20bSMLY9/ZKJyn66vrrEY/pzrpGypYSNhFEvHkwdMvmzSQFdTXq0PoGffyCJCTjkDojpzSPNhojvUGzrMCwRZnX+OKh1JFHFIbmAXtygFfWdiFj4OOVdDsKrkV7KIwoX99L6KlL8cOGVRoqJAXUrUvuwUeETUnSWjqILFkqbGZldfHLBf/mVbkFTsJX//N0aYUa2EzpBBro9ZhTPH1GYsgUa0mXT7jcbUb8jnHZe7dMJl0cdYJPoO2hBnyC2HZzhLeXiliVQmuAb4PnTjuKQIDXwt2xnHZ1c7GMk3XwmotGYmcFDNeXIj1x4/fEIJ7wW3QjM015vlvwlGR2/ilI=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0601MB1638;
x-microsoft-antispam-prvs: <BY2PR0601MB163824937829CC3A6DAF84E9A2A10@BY2PR0601MB1638.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026);SRVR:BY2PR0601MB1638;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0601MB1638;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(199003)(189002)(221733001)(33656002)(81156014)(97736004)(81166006)(77072002)(8676002)(1730700003)(10290500002)(82432001)(76576001)(68736007)(10300500001)(106356001)(10400500002)(50986999)(54356999)(101416001)(92566002)(2351001)(229853001)(5002640100001)(450100001)(10130500003)(586003)(99286002)(10770500004)(6116002)(102836003)(3846002)(105586002)(4500500003)(3480700004)(5660300001)(107886002)(77096005)(7116003)(3660700001)(122556002)(8936002)(73692002)(2501003)(3280700002)(7696004)(2900100001)(110136003)(86362001)(9686002)(6916009)(87936001)(2906002)(7846002)(74316002)(305945005)(7736002)(189998001)(66066001)(10630500005)(56826009);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR0601MB1638;H:BY2PR0601MB1640.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: paypal.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: paypal.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2016 10:28:57.8925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb007914-6020-4374-977e-21bac5f3f4c8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0601MB1638
X-CFilter: Scanned lvs1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git

Not sure if this is a feature or a bug, but here it is.

I frequently use the following command to ignore changes done in a file

git update-index --assume-unchanged somefile

Now when I do a pull from my remote branch and say the file 'somefile' was =
changed locally and in remote, git will abort the merge saying I need to co=
mmit my changes of 'somefile'.

But isn't the whole point of the above command to ignore the changes within=
 the file?

Thanks
Faiz Halde=20

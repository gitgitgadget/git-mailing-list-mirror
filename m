Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEFB1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933128AbeFUOsy (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:48:54 -0400
Received: from mail-eopbgr700058.outbound.protection.outlook.com ([40.107.70.58]:61600
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932944AbeFUOsp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jwsite.onmicrosoft.com; s=selector1-bethel-jw-org;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PMuT7D9+x82VOC/6DR1uvFjVf1ugnDHNSrZTCmwE6w=;
 b=m2Pq86uqjM+u4JbsZF3sVuHMe/IW6/8S+zzHqS0yEp25h5eyBd2xBKgHGyCxKom1NKrJVUVFFyfd0CZXNgXzXOaLPkPrA+EVwRp94dPbmprBsBkYKXA05vmlw9IhrBAti8GZW7GCZvNio3N4QdpavwMqA9oHAGyu3sH7p65SIWc=
Received: from BLUPR0201CA0010.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::20) by BY2PR0201MB1848.namprd02.prod.outlook.com
 (2a01:111:e400:58b5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 21 Jun
 2018 14:48:41 +0000
Received: from BN3NAM01FT054.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e41::206) by BLUPR0201CA0010.outlook.office365.com
 (2a01:111:e400:52e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.19 via Frontend
 Transport; Thu, 21 Jun 2018 14:48:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of jw.org designates
 208.74.140.212 as permitted sender) receiver=protection.outlook.com;
 client-ip=208.74.140.212; helo=bethel.jw.org;
Received: from bethel.jw.org (208.74.140.212) by
 BN3NAM01FT054.mail.protection.outlook.com (10.152.67.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.884.17 via Frontend Transport; Thu, 21 Jun 2018 14:48:41 +0000
Received: from USMAIL050.bethel.jw.org (10.116.21.93) by
 USMAIL040.bethel.jw.org (10.116.25.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1034.26; Thu, 21 Jun 2018 10:48:29 -0400
Received: from USMAIL052.bethel.jw.org (10.189.21.2) by
 USMAIL050.bethel.jw.org (10.116.21.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1034.26; Thu, 21 Jun 2018 10:48:39 -0400
Received: from USMAIL052.bethel.jw.org (10.189.21.2) by
 USMAIL052.bethel.jw.org (10.189.21.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1034.26; Thu, 21 Jun 2018 10:48:39 -0400
Received: from USMAIL052.bethel.jw.org ([10.189.21.2]) by
 USMAIL052.bethel.jw.org ([10.189.21.2]) with mapi id 15.01.1034.026; Thu, 21
 Jun 2018 10:48:39 -0400
From:   <MJANES@jw.org>
To:     <git@vger.kernel.org>
Subject: gitk selection color not persistent
Thread-Topic: gitk selection color not persistent
Thread-Index: AdQJbgG0sO1OxO7KRQ+38XsHOM1hkQ==
Date:   Thu, 21 Jun 2018 14:48:39 +0000
Message-ID: <e58708d7d22049c9b525c5523dffab91@bethel.jw.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:208.74.140.212;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(39380400002)(376002)(2980300002)(438002)(189003)(199004)(478600001)(8746002)(8676002)(356003)(81156014)(46406003)(81166006)(305945005)(476003)(47776003)(106466001)(105606002)(126002)(86152003)(53936002)(2900100001)(426003)(14454004)(486006)(50466002)(413944005)(72206003)(5660300001)(336012)(8936002)(23726003)(345774005)(102836004)(6346003)(77096007)(786003)(68736007)(97736004)(2876002)(2351001)(26005)(186003)(7696005)(24736004)(97756001)(316002)(59450400001)(6916009)(108616005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1848;H:bethel.jw.org;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN3NAM01FT054;1:C08fARLOZJgmGkxqp0wlGcdmF0/TR7egEub+PE521KKxvusqXn3nfrJxTfn73nqh0CaxMia2I+AK1ozTSO/MyBUpj6iME2YdjllIvuIVwT7ccXAMGnK3xQNY0MwNwdeS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae7d64d5-4a15-40f1-bcdf-08d5d78614c5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BY2PR0201MB1848;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1848;3:1igdYNLzaQt8vkZiGyMeBupTtQiMOev4GcVSr/D58ztoWCXL/oUoVvtucUBghu76G3IRf6euv6eFgryJmHGh/nzWx6Yj8Udn1s+HBAZBAQl7Tk04/g+7FWHpU6KmvmnWhOY0oxYzC/uY0q/WABAkqZXhtPBbZ/Q8k9BsHEZwMk9ptqT5NfzfTrL7hIl130cxIYL1uczxnvb6skF6qoeoko7hZ3se+E+eaK5Uvf9tGsef5d6uvrxMxoD61+wQS0b9Ui9trG/qypx4YjvVTAZCmqLBfzBwWX+3YD1enmzvUauYmYNT4qPuJ+uv/IlVVgcKTKcQwAopR+5nP+C6gJYUKkpfMi+dF+wMCDuOeYGGH5g=;25:PDyCgB2y1xTz69SmjrdUo+RShw3OVfxyz7+8qFw0CoSZteoUvOx8zZI5TvZriDxGu5afroKEQeMrLeySyaQBOz7JHc1wCCnXfWVulzDiTgemPQKDKMYM+rm9qWO5tuaFgybKj5U8lMHk8ig3z+EZyn7QzQ5nZfXiTppaCmmbZaLnsIwgAN9Z3bGVeEPgxC8TW0rkkKkM8WrKGDcCF7gEO+hoEljMtA9a6JLB5rKeBcSJktpDRcLLh/EiXrifkYiQkDNxbnABOl+Lq6gtmPUmtNjTuIsrAt+P9kEZMukNi8a8gNGKNrBN36cGToqB6kuztvCRVO0A+XmE9/Ljtthicw==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1848:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1848;31:vaF8obtktIq4ykMS0UHdAgUdhTMm2KVMsFuYxOTvudDD/f9sXjVNvd2OmNdhxvxeTRC0XDoZDq6SsEPATlfRgB/AshiUALNPc/vFfez62pfgNUKdLrnlAVCQLq93WJ1DcVFY6Y1KvT2jmnyIrAhK7N+Oe93ydy1IC1YKwffwdboMThBEmFpDJkTDUSdy9uj/oiiEIbK2/dGnnlvlO8EFBpHbsUWtufzRrKed9tnh2XA=;20:0v3+QDPd5O7jLXG+ow656hCOYJYO0Th/md8a5xM6uj036yNfeLRNrh+UE3S0idvXWxQ1mDKng951T0DL5aSpkZmELEOHZBzu5bQVMlpeW3FwmlSZjLgZuAZ4/h74NtSjb00WTnondajiHHAEcoEcuy/b+w30vMobL/vE0CQeVCMid+xudKEmdhZ8mSlGgpC+vvecDs+YVzj2iZj572xn2PE8YXUL10jFb43uAdpE1OoME7NcFCWuLCOREFk3DjMLsS+CQlGrvGzYD+oGTfQO695QrOFKV0QAGVSVMOBUSXJvGmCRIExWodfIjGZCVbPfpGrbXauR1mSuhPBfiUIYNXldUhzhh7aFGADIWxyYNJGe7QK0qb47TYG1i2DtjZDMNL1csA+sFB6sxxc1FbvA9imsNSWKLVwGHJZO+dwKdy/CMRGKDAfdbVmjpfbX4/NPqBe4xyRRtlYBko7nIzo7blzfiyxdLE1bUWw2vq005k2A9QYFuK8AZdbBfTt8oUpg
X-Microsoft-Antispam-PRVS: <BY2PR0201MB184861DD55AB4A3C9545A39991760@BY2PR0201MB1848.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR0201MB1848;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1848;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1848;4:RieHSTAou94iWld4S83U0wva7yfg/N4dh0MJDFyDFnA698bXRNUhLXXc7cQyS+jD5NtJ1B22YQNE3P9GXSDdhc0IJJ3I58TGGSiT3bTLswRhWBF78bDYD+zjkzV2GgxwTrX6NTWDNtzKacYbgFxq5PYmHOTotrqumXyZQGuCdlcbkqLEl6TP+baT5yYpMXw5bqEJVxo5s0vC6K5+OWG2drpR9RTCUa0iyb+DtzIwDDZIV42n5UJKqqUXeZvGjekZsqzSU7lpTxle5s/qB1JNtg==
X-Forefront-PRVS: 07106EF9B9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1848;23:L0mzT8taxDpBpmDbMCu0VqWSat7mZHXHQJmgp8p?=
 =?us-ascii?Q?O3UGQ10ebGNwL5MKP5BmibD05DZR+wNFalNcMA1MSr0zJrCnwg7OBkw0sQUe?=
 =?us-ascii?Q?A9y6itQ1MLkuBDUDQWQvzP4YzLaozMAfklMFBxBjCWzEJ/YMlohffXSE8hmB?=
 =?us-ascii?Q?QMP1XNFGleQwRMVE9XWsQGzaDsj5Mkm1LMSNoppeoEQ/pPITIkJJ/FfcZwAg?=
 =?us-ascii?Q?ENGY3wTdSwBawStcjx4Lw4XsSJP7Fp+PmcIZgnTnYU7m6QBTvI2QlaGJLvFZ?=
 =?us-ascii?Q?h3A9KpHJlnw7DlfcPTXYO3cCgxeYa90v0vpe+Du0UfGt1fokoB1UPJwz8zZr?=
 =?us-ascii?Q?UTR+X7RVGSEIWlNp5mN7jXd0UD0q/pCuif8CQihVH5yoPzJlL6Xc2G/R/25L?=
 =?us-ascii?Q?iLUNrlb4mv8yJ8/rf+uzuhiFUZ2ZJPC7SKLjOMvWI3e8NJwIV2WLCwwkTREk?=
 =?us-ascii?Q?1PzNI5FGsIzE5/JzsXKCLe7iy746zeAe5oBPjGgAcA64yP72+5LjLUrYdS8d?=
 =?us-ascii?Q?mSe34vRcgUSfosfBRLvhmGeHXk5db4hNpFtfvdcQZYNoOY/H1S/TKT8gv2mM?=
 =?us-ascii?Q?f+N5lA7M9Tcaqm3v1qYj2Du9BnsAHRueTCKNBCILpKrGcTRsZSkGU7SJHRcX?=
 =?us-ascii?Q?l7ZRXtiAshi2clKmXNQ9aXDch0tjEH3L+l+QP/2hkQB6qmOLEynKAq7PMC+p?=
 =?us-ascii?Q?SIUp5OHa2/ZT0zoFp9joJGIo1vvXx97XZHinW75psuonUU6kPOp01rw7lv8W?=
 =?us-ascii?Q?HRVDqtLZI872Px6ccgAgOxUzQZY5JceT7m8XcwBPejJ7tcbApE2KG7QwT2pu?=
 =?us-ascii?Q?w8b2bquml+jgJguNG/UshnhLSr2I0UI9t/2bvh/+ykQmYEOzEI1b1fv8OScM?=
 =?us-ascii?Q?6NYiQkpHOWhwwFdI31Ucx7WcLg3HbgQTbW2rL4EyO0+TweyMhOmoWpkmKh7f?=
 =?us-ascii?Q?CDBDfM+fRiX9Dk5j3Uu0dLBjnk6lf6lzq+LUHitP3KfC8WJVQ121ayQ6rbx+?=
 =?us-ascii?Q?rb5gDwu7WZkPVeAV0jxcqTkhgKcHY4mSaEcu4xOfZuiRfLLl85edegSLDOPC?=
 =?us-ascii?Q?fyE+SGFLSaGRQb6QjR3Gjq8vi7Ok5tnC05yVnmUeaDvLPoN+Fs+gLAANbyVn?=
 =?us-ascii?Q?XKAjLppIvTDL1j9svvNInei02eJVtkXLWssBdqQVx6UzZeM9flS6BXpInkNW?=
 =?us-ascii?Q?10MQkCOU6MgupLnlCFMu4dcwlpv52WP9/eVuLAWnEERqf7QLy1EU7bCCPNQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: dDdV1/egZ9E4P8u22PwKwlKUmPZzFXKQW3sGHrj7AsE0tD4RzczfOjytq6UYG6hmx7FjAmsDYncHlPV4ZGSq/7ifmJfXV6IYGAwJu+fnhB6rBGZ3AUzGkrRZ/G0TkV6EJpEnS39mvY3XQ3dzP+XrhUyt83oGEdKS7V3/iq/qC70znOYeadaI68L0yYNaR1EvxEsnp8eIz2/JqI/7COK6wA3ydXNCOFy6kCAMx8rLW9s6hMKxPjr2sDMcwkQth9RGzq12RYq3Xv3lHDFkWx1yMUrWPKied1NIsC+GMMCPmH6zF+qLGT9QqRZzBaC0z74CJR5Sq6N5B0ds4B7Vb2GWRA==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1848;6:6VHrScsHg8LK2X2fRcicO6CjNuEY2TF5bHAW9D2/noSMi7UXhfZqIZ+XDQ+fhKv8vxWBC8yEKtLlZyzBpAxqb9Hlfaruv1qHTVCLjoPNwYT35i4qFiOw4Q51/P4YahJiBLrQg0aF2lsYKEMX1cuo5NqCLtgbWcjVUKc2d7+0JYn0f4Qp1fi3JzERPE2/QLt7X/lRe9fPpGsirM/SbfLY0Rhj/XKcMoPbnJh1/SJwO2eNfKToDYFjMVtiVU1M68t1d5prD2UqZd4UxAd81RGxw/oqum9pzbrqguxBr2p0oFY4bAV4tVvRv0UKIC8amNm79g9gL73f7pUGjGT0p0r9DKiMsnpuqvGqJ/3uUTjiArLUvCPtvLtivppSN5AxIUONtozYh9L+uEoW6NZI9lu1yOxZFc6JCCjT/rcQjQKzP/T8XtjRz8WUyfaovG3VedI1HwfnQ8dogK+Akqc2UL70cg==;5:f2hpTeY8z4If6nW5r8qIjFrkTG3FBfs4KG6fmohaV4i/x8ziwBitzioUErfWnTwjkh4NhjoaH3izf/TB3ZsSpXEydF6x05hmdJ0TZD8FuhSDtQu5iQTABQr2njjZWrZosaEWtiD1zOZ935ODWatr/k6NFXFqxIXsJTseuuYwTqM=;24:XHGG2FWya/zCG0kj8weWka4ubpwgTzyQAgTmS7czFBg+6TF87NjD7qbco+OmB+JtamsDowk0aYTVbTRuOLxFnXgWxT96x5fErUZoVIni7EA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1848;7:rsRXx5oJ2zTdRyc4k5pfPw8S7igS1adTKklwZCNeevRlvC7hR0iKdJn/T9r6/GDOj6/bHqhP33z4pbErW/fGuzdnD6YrOW1WuzMhAkO2VnaiSz1IPD+2DxwJqnEaGIBn+zJVLRfhY5xKcTsZL30T/oFlazfy8idnypZSl9MgbofYyZ6GikmIBO/WuWoUMJD91oygu6uZvU3mI6Jg/1WiMNa3AZ97z1PfQS8C7qTw6KUnymNgkA7amLeyiot2IcW+
X-OriginatorOrg: jw.org
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 14:48:41.5948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7d64d5-4a15-40f1-bcdf-08d5d78614c5
X-MS-Exchange-CrossTenant-Id: e9b2b7ba-b238-42a9-b271-2adfc82da650
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e9b2b7ba-b238-42a9-b271-2adfc82da650;Ip=[208.74.140.212];Helo=[bethel.jw.org]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1848
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git community,
Is it possible please for the gitk selection color setting to be persistent=
?  Since 2015 the below approach has been working for me.
Thank you for considering!
Mychael

--- a/gitk
+++ b/gitk
@@ -2409,6 +2409,7 @@ proc makewindow {} {
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -undo 0 -font textfont \
 	-yscrollcommand scrolltext -wrap none \
+	-selectbackground $selectbgcolor -selectforeground $fgcolor \
 	-xscrollcommand ".bleft.bottom.sbhorizontal set"
     if {$have_tk85} {
 	$ctext conf -tabstyle wordprocessor


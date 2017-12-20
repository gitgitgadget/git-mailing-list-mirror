Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA481F424
	for <e@80x24.org>; Wed, 20 Dec 2017 07:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbdLTHst (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 02:48:49 -0500
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:31472
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754561AbdLTHsj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 02:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arris.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MgXd9HEUZMPs2djZio986g/iLxuvedqm0D8HW8RonY0=;
 b=NveITIMfmRM8QR4BZJZ2OzdFp8EMF+x4ZPRO3J2JaMzGenHWBAnXmM6/5eyMR9FS1iTMvyVrLZ/iWIS6Rt/3KT5sYRPOnLbxE69Jb1PWwBLHOsCtawgF7dNuL7mtUtpIixxTh42lMXvhXfy1RrH1CGk0DFD8Li7HUBrE4OJ9hB8=
Received: from BN6PR0101CA0029.prod.exchangelabs.com (10.174.85.42) by
 DM5PR01MB2684.prod.exchangelabs.com (10.172.185.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.323.15; Wed, 20 Dec 2017 07:48:37 +0000
Received: from SN1NAM01FT009.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e40::207) by BN6PR0101CA0029.outlook.office365.com
 (2603:10b6:405:2a::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.323.15 via Frontend
 Transport; Wed, 20 Dec 2017 07:48:37 +0000
Authentication-Results: spf=pass (sender IP is 216.234.144.41)
 smtp.mailfrom=arris.com; pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=bestguesspass action=none
 header.from=arris.com;
Received-SPF: Pass (protection.outlook.com: domain of arris.com designates
 216.234.144.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.234.144.41; helo=webmail.arris.com;
Received: from webmail.arris.com (216.234.144.41) by
 SN1NAM01FT009.mail.protection.outlook.com (10.152.65.54) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.302.6 via Frontend Transport; Wed, 20 Dec 2017 07:48:36 +0000
Received: from ATLEXCH2.ARRS.ARRISI.COM (10.2.195.16) by
 ATLOWA1.ARRS.ARRISI.com (10.2.131.252) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 20 Dec 2017 02:48:35 -0500
Received: from ATLEXCH5.ARRS.ARRISI.com (10.2.131.23) by
 ATLEXCH2.ARRS.ARRISI.com (10.2.195.16) with Microsoft SMTP Server (TLS) id
 15.0.1178.4; Wed, 20 Dec 2017 02:48:34 -0500
Received: from ATLEXCH5.ARRS.ARRISI.com ([fe80::304f:2ad9:b296:d722]) by
 ATLEXCH5.ARRS.ARRISI.com ([fe80::304f:2ad9:b296:d722%24]) with mapi id
 15.00.1178.000; Wed, 20 Dec 2017 02:48:34 -0500
From:   "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fetching commit instead of ref
Thread-Topic: Fetching commit instead of ref
Thread-Index: AQHTeONnP2PiK0t7E0q8cmWqHBiCcqNL2xm/
Date:   Wed, 20 Dec 2017 07:48:34 +0000
Message-ID: <1513756114533.56362@arris.com>
References: <1513600223353.28799@arris.com>
        <xmqqh8snyiz0.fsf@gitster.mtv.corp.google.com>
        <1513672915856.50628@arris.com>,<xmqqtvwmwvkp.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtvwmwvkp.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.2.159.2]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:216.234.144.41;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(2980300002)(438002)(374574003)(505004003)(199004)(189003)(5660300001)(8656006)(76176011)(8676002)(2900100001)(6916009)(478600001)(5890100001)(2950100002)(15974865002)(7736002)(8746002)(356003)(305945005)(59450400001)(53546011)(97876018)(117636001)(36756003)(72206003)(93886005)(86362001)(14454004)(106002)(551944002)(5250100002)(81156014)(50466002)(68736007)(8936002)(2906002)(47776003)(6116002)(97736004)(3846002)(316002)(229853002)(81166006)(102836003)(4326008)(69596002)(6246003)(106466001)(53936002)(23756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB2684;H:webmail.arris.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM01FT009;1:AzseprggKFOLglYkvEKjguEJlpvcVoJDIfOFvWSWObFtjufGjrT3zJfyPdMWPpzx9QUSlp79tPNMTHaRgQCLkhClW5SKrYVahuXGNBMlyNR1LI3lqtie2Uyxz4D3hULq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 647fff9c-6a85-4783-cf1f-08d5477e13df
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM5PR01MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2684;3:mfuZSUNuKKZyxQ/gkOA1kl6/EG5GczmQd5/fEEIrnlBD93EOBDy4oeDXhhV/12xoL1UaC8aaTVJz2ulX5kJeuCfkfLYv9MI1isnHW+JkbmAVaRx6g5BOTMHncSTWUqDfPXvFi3vK6SprS2t3CWge60Y0864iW7BWV6YOZRhekl4gELztoFKpQUuaT5mSP/gfE3nwtj69f+TkUPPxANVXzItc1sDcqHmkghoDhWeXcSlxN29+vFyrCOWG4t2pzZSjDQ6o5m0/RYLO+wfhEwXUOI5VtzOI0F1BBsFFA1dxAeUCUxurNrU9ZUX7wP4K4zuBuzJSRqGD0Dc7BCvaMp4uzLy556s6uk0S+/SilnU+N6s=;25:vmKgIe7tYVpqUhHOdxfAmVMKJKJqHlxDRwkAG0ow3N2BDNvbyQ5ZdQjb8NuBesiwaK4kVDKE3zx3HJbatTazXYYEJYbnUwTHwhUQcVhB1Fq1Y0+zTISUJ+3rrXgl1/n5yIl4THEhLE1UTsFxcRRRQ+F+yDei4n6wiGDqy9cpzrI774pfKOZaplxKrP1KaAshf08PenaLYOTHku2cB1n50NK0Aq5YALkSJ1iP1HUeziHzDjC/c9J0yVTZe5mcJkZt4RA6jftZbRBWUywK5HezZzi3CXa4/TChD9wK8YG3uDL2bxPHYnVLL0hwaf04V8xJI4nuxYSHbM0HknPfL3ncHQ==
X-MS-TrafficTypeDiagnostic: DM5PR01MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2684;31:FuExJt30A17nD+dMAXa2+Fjx3lNvhONnxhC3Ad3iM41naAlix4pRodP1VL+HCRF2x1x5CWQ9gzCCpDv13gtUOhU2JeyMVjZdBx0yjHtMGvrCmIu3m7EYo6XGgWp68SlzjcDsIIew8YEr5Jb7FiGoeOJnRiCCm3xb6tOutgt2p/tW5PQ1cPPCly0Zj//J4Qae6FMIv6507QRMM3RXIhSPmzYIjw8/cYOxuhEPuqGMWS8=;20:sg1sRUDe3xM6ckjJUkTPtv/mxXZOGSznoO0mW5TZ5BL9mha8XPT0bmnFRo5EKQ4XUvi3Vce0/v/0GW2rbEsFVpwQWMZ0ghnDMYb3IwV85yH2/KUZISqoQt8VDFGvKAm+jIZpxMZk0HjFN2erMhwBPKA53PCyad27Vi0ONWq/hSAMeRAfTf5/td18bz5kggAung8LiLnqS/E3t5W7y0BLTcWH5MgueO3kZ3z80/MphqtkXgjj97w3Z5JKYyz1GxQhXilIrzcXhx162fR4jHsXoAI5pjbGTsG2FKIvUcS+YoGE8UIp6wYvsl3etBuUEJhh6EhwgKRs78Z9hrnz6QTbv2n2UyYmIVienTBvZQ4icoUCKpIQIdpdxlLAVzBP11AkivUbezWfIR+YV25mdaJLgjrdURw6OFqyQWXtQz5tA7C1iMxsxGd6FZw0EC9g5B45D0WNg0jfwlbdHUOxKGcf9cD9xxfPTJ9+nvD8DTyWmm84pjL7VPCmL/mM15pzj3kx
X-Microsoft-Antispam-PRVS: <DM5PR01MB2684EFAB086D4DD8CC205C54FE0C0@DM5PR01MB2684.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(104657075078662)(192374486261705)(9452136761055)(100324003535756);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(3002001)(10201501046)(93006095)(93004095)(6055026)(6041268)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR01MB2684;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR01MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2684;4:5NOKGcHSveG/2D3l4jUIxmddEpzcl9aDjxVGJDEJuUBKYqMkOQU5Gb9iAauRsBcU+3VWDYMkXNMFTYgjq9WNljCSeHMGjJ9J58CPaehIqMoLvGHFPkV+pWL155L60eAoHFXpjn/OL0xgX3/anjZiBj21yEIiq+BknbybaMXBrwE582Es+KeEbUH2X2IEEKHndOPnwEmqj82xKGaNCVjCgSXG7DrKs6PtO7yop4A/ur5EebUslXk+8eVU+eRPSsaVtg52FZPVnuz1gKF9WBim95QHkmFPv7Fb4BTdIi3iGWtYEax0Nt0rwXTTkfCNPxzoSLjFhHClgYrM0KyfONHA0eBsZYoj9LOhPD5LhgwBhEubzPQHWngEeZXcv9SQNan9KtKXWhhIggLe9fvrlLqwzW/QZxKrxl6CBgrYUYepTOnazAyMl26jNnSV/HdeM142
X-Forefront-PRVS: 0527DFA348
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DM5PR01MB2684;23:vBT1p+OUCFZom1CsRPIopfu2cTXh7Q7XKau5682?=
 =?iso-8859-1?Q?9KJaM9Prc+dm04NFSbmoguIn697DevbavPXcPxLXJOBWie3jkli3vNEBUd?=
 =?iso-8859-1?Q?cFoBF3PlKJ9Y35t7Ecx03V16aYbU0wSWUdo2vX0EhLIbuV+tr9YVY28cKn?=
 =?iso-8859-1?Q?fhaeRks1MsYRMMXwnKBeYIMg2rx8HCJMEV0gG8wWzG+hhv9dR6eam0HrAp?=
 =?iso-8859-1?Q?BZ3ijl27+sT19y+RuXw9bU02ibIMZVllXdJTexkX9d+UV5oLRGr3C+V1pw?=
 =?iso-8859-1?Q?k74SyRdPnVkpSJ5yVva3y3Q+9baxJ0piYY4/yYT0jkqqKdzbLI+1wbVPrz?=
 =?iso-8859-1?Q?mYAlr5nJhNQ33OptH1zxLOtIvj/F5wK927B5P2W7hwL+sLzagyIc5fVDAJ?=
 =?iso-8859-1?Q?g4dey0Xl1TESqV6TJynxFY4PoIVhnQx5O7N1l4zprJpKi2EOUf39sFa+P3?=
 =?iso-8859-1?Q?naMuc6Z1cE0ZN8z51We7yxorEy/1QzJSVXadmhy+RfDDqelvFtp0OlpdZF?=
 =?iso-8859-1?Q?yZ50T4Okb9pMU6ojR1m4f3hCOvJzfK94Jz7GboHEhb7Niy4ViQNRkYuyln?=
 =?iso-8859-1?Q?mH7azUWAcuUKTgyIYRxtR4tY0E1rjilY861fPj9ERPU5HPxZvo66jlZUt3?=
 =?iso-8859-1?Q?pdPZH/+/R3k8V45KHxr3o8DLvXL4ZzjH7H+dl9K4MwBPHujm+Uld98H2oD?=
 =?iso-8859-1?Q?A+31s3vCoh8Dz2CEYZ8w2vxZcxV8OpiZeoJCibetixSwgMA/x3vBdNhx0a?=
 =?iso-8859-1?Q?kjN2+7tUvKHp6K5N4JL1K2KM1tDsK7LejUJM80sqG7ZnezZ3pI/xhDBk8l?=
 =?iso-8859-1?Q?7T4VpjYeo7wmGZ42eQVVtT3up2VTn6atnnHMNNlE7beWL4NPa52xeqhPSV?=
 =?iso-8859-1?Q?bIAnzXySjjRTBOzfEG3pn7gSKa9Mw/mGAeZ/dJTE5pk/cdfTA8ubSl3AW9?=
 =?iso-8859-1?Q?dWz+aTkwPd6LckRnIcS8wBuhiXKQVucPGu9ZCJbQAUxK/fxOKp8+s2PkVy?=
 =?iso-8859-1?Q?AwJeS3JNK4F4/X1/FnLzu5BGruI+pm7o3GMn7SFux/3t2NfFEBu2ar3Yh/?=
 =?iso-8859-1?Q?lfq+JYepGzeIt0woh0p9eLz8CFjhiOZDx+XMv2dI0vPC4wnA8MFuh1/EGF?=
 =?iso-8859-1?Q?GWuHlksMZ5xhDoCizoluHOSAH0U/LyvYoigob6PfSBn/TZ+14kE3pVtjci?=
 =?iso-8859-1?Q?NcpQ3fO2B+8/BziQ9bB14iraQnYZjnwV9pYz9aiyP9RlXgTGBQp/FDf6Gv?=
 =?iso-8859-1?Q?FHmg6kIhLEgozRtVr4IIb72lvONsrYli+SSZV+7JUfMQUgCGMg1cHV/UGJ?=
 =?iso-8859-1?Q?Ja+zDTn1hZQK7//R/1F532PwJp0YKfF33F2Enobw3D4/IKEt54T2T9+QJi?=
 =?iso-8859-1?Q?/pwyxh1s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2684;6:MdghSHi1ehcGEv5G4PCDepEHaFtx5pKak2bQV9r6goQCITawllYr5CSjp2wl2LXvUcW7hgroSRJ1z6JBCEHdSLl2tuY4NW1wRq4ODPVzj5+4h0OQagPnlCsu8lzjECu81sejAtGtcSO4FwLguO2t9HSVGfGkNhuimzFlW6+vuG3QtC09LhOd5pDzkKVhww0IPwYtIF0qaemUorSitn4KLuAvEzFTl4jVnB7+rvxZXiYjCcLMrs/ieJKHBys7liqHf+Q27RYT4AdBREB/4pnv8QrNx1gwLxy42WPswDhdvuw5ccebWIV4YLkidZVJMU83Ti/4w6VSz/Gkuc57pqmHqaicCrOJU+Zip+c03RoNPOI=;5:Ggd9g3r+HQR4UOphvHHBt40kBDdmzIkyyDIaJ7O5lmoNrlSGZRQRQyuPkPEGTLmL3wCnS/rbaQm28tA725vYaoogZzw2uYVpRlYiNyvTxbtAW0bqd6LZGYWWn8SOlai2bVmjNON0edk3ggjKt18n7qOiwhkyUvEhmTAuR6kt0gM=;24:cGvKTNdUwdEjM3h5tRmdXyD0WGeDO6Fz2vwmo+yffvqx0jQZU1nKr1q84+wibJLJVmuy3QuXfAm2j4lexRrvIpRk+whKadWZww0RVdLNmHY=;7:CK2hjGh96MhRbQIqGEuInSeUl6AI9QA4XF4MajYiXvafj/yaSKk6tZvcfT2LrmYSkUixWfTnFRR9humzqeJkTwyPxwtM3zVwmFCQCaGi77878wWr9vH2EU3DXNKQyt9kbGLvGU6MFSXVc00g+G/EzG5bhWSVoSR6uCrpUGcjcOY8NZ4U/6n29DdsaDOxDIKJyRM4mZSvo0a9REmz4KudymjMYTKHGOJY0UpeoP33b6jZHUcxTc7CdcN7ke1yQ4OD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arris.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2017 07:48:36.5022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647fff9c-6a85-4783-cf1f-08d5477e13df
X-MS-Exchange-CrossTenant-Id: f27929ad-e554-4d55-837a-c561519c3091
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f27929ad-e554-4d55-837a-c561519c3091;Ip=[216.234.144.41];Helo=[webmail.arris.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2684
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for your answer!=0A=
=0A=
From my simple tests it seems that github doesn't have this on by default s=
o that seems a little dull.=0A=
=0A=
Do you know if there is a way to actually find a ref that contains the SHA =
from a remote?=0A=
=0A=
Finally, you say that its a security feature, but from the log it feels lik=
e you are actually downloading things first and then you determine if you a=
re allowed to fetch it or?=0A=
=0A=
$ git fetch subrepo 50f730db793e0733b159326c5a3e78fd48cedfec:refs/remote/su=
brepo/foo-commit=0A=
remote: Counting objects: 2311, done.=0A=
remote: Total 2311 (delta 0), reused 0 (delta 0), pack-reused 2311=0A=
-- >>> Receiving objects: 100% (2311/2311), 703.64 KiB | 0 bytes/s, done.=
=0A=
Resolving deltas: 100% (1174/1174), done.=0A=
error: Server does not allow request for unadvertised object 50f730db793e07=
33b159326c5a3e78fd48cedfec=0A=
=0A=
-- Magnus=0A=
=0A=
=0A=
MAGNUS CARLSSON=0A=
Staff Software Engineer=0A=
ARRIS=0A=
=0A=
o: +46 13 36 75 92=0A=
e: magnus.carlsson@arris.com=0A=
w: www.arris.com=0A=
=0A=
ARRIS:  Legal entity: Arris Sweden AB - Registered Office: Teknikringen 2, =
583 30 Linkoping, Sweden - Reg No:556518-5831 - VAT No:SE 556518-583=0A=
=0A=
This electronic transmission (and any attached document) is for the sole us=
e of the individual or entity to whom it is addressed.  It is confidential =
and may be attorney-client privileged.  In any event the Sender reserves, t=
o the fullest extent, any "legal advice privilege".  Any further distributi=
on or copying of this message is strictly prohibited.  If you received this=
 message in error, please notify the Sender immediately and destroy the att=
ached message (and all attached documents).=0A=
=0A=
________________________________________=0A=
From: Junio C Hamano <gitster@pobox.com>=0A=
Sent: Tuesday, December 19, 2017 17:07=0A=
To: Carlsson, Magnus=0A=
Cc: git@vger.kernel.org=0A=
Subject: Re: Fetching commit instead of ref=0A=
=0A=
"Carlsson, Magnus" <Magnus.Carlsson@arris.com> writes:=0A=
=0A=
> I understand that you don't want to allow people fetching single=0A=
> commits all the time, but is there a reason that you don't allow=0A=
> SHA instead of references when you fetch an entire tree?=0A=
=0A=
I do not think we don't want to allow "single commit" fetch.  We do=0A=
not allow fetching histories from an arbitrary point in the graph,=0A=
unless we can prove that what gets fetched is what the serving end=0A=
intended to expose to the fetcher---you should view it as a security=0A=
issue.=0A=
=0A=
The default way to determine that a fetch request is getting only=0A=
the things the serving end wanted to publish is to see the requested=0A=
tips of the histories to be fetched are all pointed by refs.  Which=0A=
means that a client of a hosting site can rewind and repoint a ref=0A=
after pushing a wrong branch that contained undesirable matter by=0A=
accident.  Moving the ref to make the undesirable object unreachable=0A=
is all that is needed to "hide" it from the public view, even when=0A=
the client does not have a way to trigger "gc" immediately on the=0A=
hosting site.=0A=
=0A=
There are variants of this security measure.  If the hosting site is=0A=
willing to spend extra cycles, we could loosen the "is the request=0A=
fetching only what is published?" check to see if the requested tips=0A=
are reachable from the tips of refs, instead of exactly at refs.  It=0A=
preserves "a mistake can be hidden with a forced push" property the=0A=
same way as above, but it is costly and is prone to abuse.=0A=
=0A=
If you are confident about your pushes all the time, you can take=0A=
a stance "anything in the repository is meant to be read".  That is=0A=
what the "allowAnySHA1InWant" does.  Not everybody however wants to=0A=
do this for obvious reasons, so it is not a default.=0A=
=0A=
=0A=

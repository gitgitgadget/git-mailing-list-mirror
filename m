Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9361F404
	for <e@80x24.org>; Thu, 25 Jan 2018 19:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeAYTBw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 14:01:52 -0500
Received: from mail1.bemta8.messagelabs.com ([216.82.243.208]:17501 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750994AbeAYTBu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Jan 2018 14:01:50 -0500
Received: from [216.82.242.131] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-16.bemta-8.messagelabs.com id 86/71-03139-E992A6A5; Thu, 25 Jan 2018 19:01:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjH9+6cnY7m4nVmPg4TWXdvZDeGYfW
  hckFBRAStxI51cqtd5JwV60sZkdm8pJVdtUwqlxmZZYpZLSsolUxRkqCrSmqKkcnShrWzV62+
  /Z7n/+e58bCU6gajZnm7jRcsnEnD+NMdEfeCYooW7NEv/PwoWjtclEtrHW1Zcu2T2gpmFaV7k
  X+D1g1Vhuuqi+M2UnqF0ZJite9QGPpvuZm09kC7s8VNp6Of0xzIn6VxPgWfhstpKVDhPDk4uz
  yIBC4EZ+qOKhzIj2VwHJT9fogkno43w/urrxiJKbwO0l/2+/JBeCn0HbvLEM8y6HG6KAdivRw
  PH05vl9I0ngNNjnM+ixJvh65nT3yswnYobDzpYz+8CgbfVsslRngGuBvK5aRVCLztuuxjwBiu
  1jVThIOht3NMQfxJcLMoR0HyETA08pQmPBNaL2chwh1TYNS9l3AsVOUPIGlMwLPgXk8SSW+A+
  oE6300Av0Hg6XaN14mG/Evucd4LY90fGGIqRPCss2W88TUKmhqSCYdB53DPFGJyMHCk5RciGx
  vAM9Qtz0PRF/5ZjnA0FD/4zhCOgutXvlIXfAcLhJfnu+hiRJeh+SIv7OeFmMWLYlMEY6rBZua
  Mppi4hdpYMy+KXCpv4lLE2J1WcyXyPswhmQzVoJHr2+pRKCvXBCuLTxj0qmkp1l0HDJxoSBb2
  mXixHoWxrAaUtfP36FWBAp/K23cbTd6vm5CBDdBMV76TZKWYxplFYyqRGtBitu3slwyK7ej5m
  kGpaIvVwqtDlD8kK5ashn2WyUITH9yKZqqDlEgmk6kC0njBbLT9r/ehEBZpgpR3pCoBRottsl
  +fdxS5d5QVdqM0io37K6nTUUJBRHbi7ir9hqyoqNkrny4rjV9b8GlLaMWMj2GCs3FJ+eC7Rpd
  HV3O/O1O9NbzGWdEsLx96nzvq9/zmml3HP3u04cmtbbrbTO9c/1MXf4S2b+pMdKWpqiKtj/mk
  0tfuygT8scKVM3teaOPh5ZFaU2nZrS8lJZrsb1zT1JHVfesPZmpo0cDFRVKCyP0Bhu59b7wDA
  AA=
X-Env-Sender: Edwin.Dyer@alliancedata.com
X-Msg-Ref: server-16.tower-76.messagelabs.com!1516906908!117523198!1
X-Originating-IP: [216.32.180.19]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=alliancedata.com,-,-
X-VirusChecked: Checked
Received: (qmail 3328 invoked from network); 25 Jan 2018 19:01:49 -0000
Received: from mail-sn1nam02lp0019.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (216.32.180.19)
  by server-16.tower-76.messagelabs.com with AES256-SHA256 encrypted SMTP; 25 Jan 2018 19:01:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=AllianceData.onmicrosoft.com; s=selector1-alliancedata-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RYuT+QrT1LT1Bnc9nDT+JRzgXX5GKToVshjJRnodwpM=;
 b=Y5Y+aDJGQ3WtFk/1XMt7pBEFL6JLBsp0FN4E9E/jOmNzVifdmwC8LX5gzPBNdAeMdmBlVAJ2KkSUqUlU0xe9URXQAxot1zJhFpyMOoWGIdY3fzE9JVl3+uKl+XitIXdFQGGe9JVQnwbx0nGrMwLARpMmh1q+Omxdx6OnHLkPWVw=
Received: from BN6PR0101MB2930.prod.exchangelabs.com (10.174.87.139) by
 BN6PR0101MB2932.prod.exchangelabs.com (10.174.87.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.428.17; Thu, 25 Jan 2018 19:01:47 +0000
Received: from BN6PR0101MB2930.prod.exchangelabs.com ([10.174.87.139]) by
 BN6PR0101MB2930.prod.exchangelabs.com ([10.174.87.139]) with mapi id
 15.20.0428.024; Thu, 25 Jan 2018 19:01:47 +0000
From:   "Dyer, Edwin" <Edwin.Dyer@alliancedata.com>
To:     Santiago Torres <santiago@nyu.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "christian.del.vecchio@zurich.com" <christian.del.vecchio@zurich.com>
Subject: RE: GIT 2.3.1 - Code Execution Vulnerability
Thread-Topic: GIT 2.3.1 - Code Execution Vulnerability
Thread-Index: AQHTlf5mrWE6xWrZ+0KKFEQL7E80f6OE1b0AgAAbRMA=
Date:   Thu, 25 Jan 2018 19:01:47 +0000
Message-ID: <BN6PR0101MB293001FE100A016227C04F9EF1E10@BN6PR0101MB2930.prod.exchangelabs.com>
References: <201801251702.w0PH2YFI000707@b0d0p4a1.rz.ch.zurich.com>
 <20180125172057.ie3pvhxx5egpil35@LykOS.localdomain>
In-Reply-To: <20180125172057.ie3pvhxx5egpil35@LykOS.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [205.144.62.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR0101MB2932;6:U5E8GyTYhrTlJn8zlh0K1bruo9mmgb32s8DplksvZNjrLAS1mGUarPFYr8rmwatkildA2dbnzIBfIHbpOb/iMCVoYa3J+5/mnYnxoepoxGiIFxPCu/Zl8Vm7W0HZ8H3Bd/aADtMO7SHTxfwV9O9fOIa7Kf8ccgp5+fJ69W+hc2Dhzi5YFyVEJakvuUVeW+EigM9X1vlqU0XodvNoCP+GW5ciMQuwcopoa2rQHaLkxvLiPE56N3/aDaFn+VmXbmlbpHn2uDPHVUSlHj9mTB3XpaCPLwr5pLB0JHB5uGqtNjM/iL5wN0EuzJrWCkdTN4vOqYwCkH9KLRIqSuXDWizGitQInhMnw5QznhuBRzY+QtFv+lffI1cYsqt6FwnMZC6W;5:qCGZqvf64oNic6WeXpCX+eEoH6hG7+QCaI4DuY2HzccMu7Y+kZ6Qtk8AUnczHvWWaQX2pB3EHnnKzskFNyI4Aj8+rln6GtGUvotbiGNJjajBeekt36+eCJNILLY5A/nklVBdpDQXMS/xw6fK4HttR2JvEPanAfZpH5DVOiIb+Ag=;24:jR0yJwBXN8TqDfskKBRCf8YxucyDJilMI4rSKPME+J85QtlekWBLWlz+F56CF+F/UszohAurPgqpvwnlu9l7Vlgw/GGTvOO58rzIVWrvyhs=;7:nobGk2aguGvqKmvzevyzQFv1oOaVLoYv/78xy9hYsPu41+NA/eBZ4UKXzC0x7eP0sjiPE/MTBIchDOnXqHdaXlOzEs4T6tUUI3DhMxWqH98VQeUMMwjSs22AeZh0OpV8ggTtN1D3Db3OTMeJufoWD4/mkMEP4FTiiXeKAiUZsPpCrw6aLodarMsEIvwahO03JMm+5gJcp1/4JQ/h6JqW1JnsdXCeG2MsStkiGKBWYyjhgGqhXX/iPzdnYhvIxsmF
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2df20f3d-3288-4249-ffd4-08d5642615b8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BN6PR0101MB2932;
x-ms-traffictypediagnostic: BN6PR0101MB2932:
x-microsoft-antispam-prvs: <BN6PR0101MB2932C5A6C71E1AEAA4A2B619F1E10@BN6PR0101MB2932.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(65766998875637)(192374486261705)(9452136761055)(21532816269658)(262068824476603)(54671270437207);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231023)(2400081)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR0101MB2932;BCL:0;PCL:0;RULEID:;SRVR:BN6PR0101MB2932;
x-forefront-prvs: 0563F2E8B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(376002)(346002)(199004)(189003)(13464003)(5660300001)(72206003)(966005)(68736007)(14454004)(4326008)(2906002)(3660700001)(3846002)(6116002)(6246003)(229853002)(2900100001)(478600001)(3280700002)(105586002)(6436002)(53936002)(2171002)(9686003)(6306002)(55016002)(66066001)(106356001)(99286004)(25786009)(76176011)(74316002)(8656006)(7736002)(59450400001)(6506007)(2950100002)(53546011)(8676002)(7696005)(305945005)(316002)(8936002)(102836004)(33656002)(110136005)(81156014)(2501003)(81166006)(97736004)(77096007)(186003)(26005)(86362001)(18886065003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR0101MB2932;H:BN6PR0101MB2930.prod.exchangelabs.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: alliancedata.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: bCwe5jDTGN3EuKDEKIsz3TovSmNYdk9rbZb1kflU71HAsHPdYyFSekKdTg/Nn97KLnq+gwLkTt5RQ/i929PB3Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alliancedata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df20f3d-3288-4249-ffd4-08d5642615b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2018 19:01:47.7367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7a24eae8-33b9-449a-83f5-361634c821ce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR0101MB2932
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current Solaris 10/11 version of Git is 2.4.0:

https://www.opencsw.org/package/git/


Ed Dyer
Associate DevOps Engineer

Alliance Data Retail Services
3075 Loyalty Circle, Columbus OH 43219
Office: 614-944-3923| Mobile: 614-432-3862



-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Beha=
lf Of Santiago Torres
Sent: Thursday, January 25, 2018 12:21 PM
To: christian.del.vecchio@zurich.com
Cc: git@vger.kernel.org
Subject: Re: GIT 2.3.1 - Code Execution Vulnerability

Hi, Christian.

They are probably talking about one of these[1][2]. I don't have access to=
 a solaris machine right now, so I don't know which is the latest version =
they ship, but they probably backported patches.=20

Here we can't do much more about it, given that the packagers for your sol=
aris version are the ones (possibly) packaging 2.3.1. I'd email or open a =
ticket with Oracle after making sure they 1) haven't backported patches to=
 fix these, or 2) don't have a newer version in their repositories.

Cheers!
-Santiago.


[1] https://security.archlinux.org/CVE-2017-1000117
[2] https://nvd.nist.gov/vuln/detail/CVE-2016-2324

On Thu, Jan 25, 2018 at 06:02:34PM +0100, christian.del.vecchio@zurich.com=
 wrote:
> dear Team
>=20
> I am Christian Del Vecchio,and i work in the infrastructure of Middlewar=
e on Zurich.
> we have installed in our system Sun your product in order to connect to =
our bitbucket repository.
>=20
> we have followed the instruction provided on your Web Page:
>=20
> https://git-scm.com/download/linux
> pkgutil -i git
>=20
> the version installed is the 2.3.1, and actually it works.
>=20
> but last week our security team informed that this software didn't=20
> pass the check control due: Git Server and Client Remote Code=20
> Execution Vulnerability
>=20
>=20
> please, is it available a newer version that fix this problem?
>=20
> our system is: Sun Solaris v10 sparc
>=20
> best regards
> __________________________________________
>=20
> Christian Del Vecchio
> Middleware SME
>=20
> Zurich Insurance Group Ltd.=20
> bac de=20Roda 58,
> Building C, 4th floor
> 08019 Barcelona, Spain
>=20
> 64402 (internal)
> +34 93 4465402 (direct)
> christian.del.vecchio@zurich.com
> http://www.zurich.com

______________________________________________________________________
The information contained in this e-mail message and any attachments may b=
e privileged and confidential. If the reader of this message is not the in=
tended recipient or an agent responsible for delivering it to the intended=
 recipient, you are hereby notified that any review, dissemination, distri=
bution or copying of this communication is strictly prohibited. If you hav=
e received this communication in error, please notify the sender immediate=
ly by replying to this e-mail and delete the message and any attachments f=
rom your computer.
______________________________________________________________________

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD061F453
	for <e@80x24.org>; Mon, 28 Jan 2019 15:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfA1PRs (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 10:17:48 -0500
Received: from esa3.hc595-16.c3s2.iphmx.com ([216.71.158.20]:50744 "EHLO
        esa3.hc595-16.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbfA1PRr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 10:17:47 -0500
X-Greylist: delayed 2128 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2019 10:17:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=alstomgroup.com; i=@alstomgroup.com; q=dns/txt;
  s=alstomgroup; t=1548688667; x=1580224667;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+ESiG836UxjYyNWjENVmq7ibB4NyBV5UMXdyPhV52LY=;
  b=S5kZtMN/bJ4VpcuOo/Ht4E585EqgElWWhDb3khD9bpaH2FEUbGgcCzcv
   jAJY2B8rLJHuMzPAmWePwUuFNtQeI823uAX2TE6Hlcwpe/vbJb0KpewVl
   7FuFX3OJWdyBG9BtL3JnjWICmr1B+ejN/qt3zHzZ28U2zMI1lOUBAQ2wu
   k=;
Received: from mail-db5eur03lp2056.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) ([104.47.10.56])
  by ob1.hc595-16.c3s2.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2019 15:24:36 +0100
Received: from HE1PR01MB3722.eurprd01.prod.exchangelabs.com (20.176.161.147)
 by HE1PR01MB3771.eurprd01.prod.exchangelabs.com (20.176.161.160) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Mon, 28 Jan
 2019 14:24:34 +0000
Received: from HE1PR01MB3722.eurprd01.prod.exchangelabs.com
 ([fe80::255a:24d2:7814:ba6f]) by HE1PR01MB3722.eurprd01.prod.exchangelabs.com
 ([fe80::255a:24d2:7814:ba6f%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 14:24:33 +0000
From:   COLLOMB Joris -EXT <joris.collomb-ext@alstomgroup.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git checkout multiple options issue
Thread-Topic: Git checkout multiple options issue
Thread-Index: AdS3DOSUeSahnLF1Sp2hV0Z9qGG2agABpYKAAAAwhIA=
Date:   Mon, 28 Jan 2019 14:24:33 +0000
Message-ID: <HE1PR01MB3722D90668E75E4BCDBA71F2A9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
References: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
 <000201d4b713$7edcd3d0$7c967b70$@nexbridge.com>
In-Reply-To: <000201d4b713$7edcd3d0$7c967b70$@nexbridge.com>
Accept-Language: en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joris.collomb-ext@alstomgroup.com; 
x-originating-ip: [165.225.77.64]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR01MB3771;6:PMblYZVX1MRa0yiclrAI1lV+Efg5fGsEl11R0C61Uy3ghJrnQ9RpLOKuuL0QRny7dj4PUI0ovzN/dG3UlOs2/1tHbdiAy4q4uEu2cLpbpl9wMH03XDI4cPvj3lKCumMxz6l4eS2J/OaUsghAFQpCf2hicwgIGf7Ftab3Q7NYyPV6AfYpQ1+ar3daIq5nUuBsR8CwnlKGnv7gpw1uDoXXSzGJiQ3nS8J2vSqMkZ3EDc2FYhapdt0ejrLaUlwkJDd1pjKxd3yD7ZYUWgs4OkRqk9u5zTCaPm09WQO8eegylw/EblPmp/R95yb+1TJDN8GpzX3OaT2tPnowLlkJw1swHgJVWi+YVnlNYikc3Am5k+F9BbHm+W3zDbKUWKh/zk05plSY9FUJHRShIXI+82Azd4FD/iBydfM+Oebd+cmf+9RkCz6hBLu0Cz4ZKvOc5VrCftAmqKzugnfTd4odxAT9CA==;5:SwSxWu2ZTNXXCbZ4jtQya6RNCMEj7N5YWv7myuRSRd4gRgu1sCGDE1OCyME9xb/Ji4xwfS/CasdB6SQnXA41eQVbRwDpz91GutHMCWuBgXrgT1RduVNY7iSAbrJNcsWSn/Hnwhz5MsLgn+IlSixMamTb7FbFREN9z44fE0zDIo6R+54j3797rLqWHxRDHSLcAgiC5C+vigZWFLvHNaZGPw==;7:fw4RxqTFC5PwmTwtA+FWD62ypAvfiYjGOxxmIQcGrqDnwOryeMNhoCdqO2dDsciZO7ex9VONBTQXhPL3ic6MJlYnItz6VMCbFLlIgPn2R7uXtlYp4ktjzVMob6xozrZ6jyyPKmk9LSrRnboFJx+CKw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5e6895ce-e33d-4565-94eb-08d6852c5320
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:HE1PR01MB3771;
x-ms-traffictypediagnostic: HE1PR01MB3771:
x-microsoft-antispam-prvs: <HE1PR01MB3771A6498FE11DB0E98C1C55A9960@HE1PR01MB3771.eurprd01.prod.exchangelabs.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(376002)(39860400002)(40434004)(55784004)(189003)(199004)(86362001)(6246003)(55016002)(5024004)(97736004)(68736007)(6436002)(229853002)(71190400001)(71200400001)(53936002)(66066001)(106356001)(105586002)(14444005)(256004)(9686003)(478600001)(2501003)(6506007)(14454004)(446003)(11346002)(2906002)(33656002)(8936002)(99286004)(76176011)(6116002)(8676002)(3846002)(316002)(81156014)(74316002)(81166006)(102836004)(110136005)(476003)(486006)(26005)(305945005)(186003)(7736002)(7696005)(25786009)(55236004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR01MB3771;H:HE1PR01MB3722.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6bhUCNAai6QObNQMoMu4QyliaORD7fmtMcnC11h+7FUSXKZJE1N++hifOm4fAYnfkHzLtcmOEA+GKI5rAEhxtbsrtVqwRA+59xr+2mCwvLqG4yK5ScAmSKLQrEKDLZ6iNV4fOPTNiAEzI+pJoHtDEdmEPbad59GFvA/K94W5A05HVuVUe6k+MkJnBB5BIVXnmKP81vpEuzSv8csgLw+XZlzDrM6n1H+M84Q8faPcXpdMyL8PbJHHJmlyJIaLzhzkXv5Eab5tV7W8MmzcG3WSRHxczz6kr3+XUaYk0P1GDEDnxH9AdzbGWnTPYhyvU6Napgn+p6Qs4Aks3pjQxK9buuFAxRdUNQc0kHWjcOA+SSLwZ9SeHvFiQ4BlqtAxGPvRn8qbpq2o3gvkgTmprsyOFvzj9zj/6JsT6cIsRnX3S8E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alstomgroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6895ce-e33d-4565-94eb-08d6852c5320
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 14:24:33.7612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d993ad3-fa73-421a-b129-1fe5590103f3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR01MB3771
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for answer,

git checkout -f -b "branch_name"
gives me " Fatal: A branch named 'branch_name' already exists."

I understand that here the checkout is force, but not the branch creation.
The opposite option order doesn't work:

git checkout -b -f "branch_name"
gives me "Fatal:  '-f' is not a valid branch name."

Once again sorry if this is expected behavior.

[For clarity, I'm trying to move a branch and checkout it with one command.=
]

Regards,
Joris


-----Message d'origine-----
De : Randall S. Becker <rsbecker@nexbridge.com>
Envoy=E9 : lundi 28 janvier 2019 15:12
=C0 : COLLOMB Joris -EXT <joris.collomb-ext@alstomgroup.com>; git@vger.kern=
el.org
Objet : RE: Git checkout multiple options issue

On January 28, 2019 8:25, COLLOMB Joris wrote:
> git checkout -fb "branch_name"
> (force branch creation and checkout it)
>
> doesn't work (even if option a separated).
>
> I don't know if this is consider as an issue, but here it is.

I think you might mean (which works on every platform I have):

git checkout -f -b "branch_name"

There is no provision for aggregating options into one. -fb (invalid) is no=
t the same as -f -b (valid).

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000  UNIX developer s=
ince approximately 421664400
-- In my real life, I talk too much.





________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

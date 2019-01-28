Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC42F1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfA1RWK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 12:22:10 -0500
Received: from esa1.hc595-16.c3s2.iphmx.com ([216.71.156.173]:26035 "EHLO
        esa1.hc595-16.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730758AbfA1QDb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 11:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=alstomgroup.com; i=@alstomgroup.com; q=dns/txt;
  s=alstomgroup; t=1548691411; x=1580227411;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dnUttcn6IzmgI2pIgzmA8sHR3JFt2YTf11xuGcK5cI0=;
  b=W5nB8toZxf3vnYDEa92BMhKLbQBGHlt5Njzd5ZkJwMmyy2mmt2K6pc3C
   iRyXp2ApYABIsRFuJPqznhzIdi/+hNmZaeQ46NI80UtBM0x9vpTDRun8c
   u+vU2xXV7tYM3MexmXgjCcABwOks7AFKjkeJVLz0pL0ZDIR5dNpfQXmrU
   8=;
Received: from mail-db3eur04lp2050.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) ([104.47.12.50])
  by ob1.hc595-16.c3s2.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2019 17:02:41 +0100
Received: from HE1PR01MB3722.eurprd01.prod.exchangelabs.com (20.176.161.147)
 by HE1PR01MB3020.eurprd01.prod.exchangelabs.com (10.170.254.149) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Mon, 28 Jan
 2019 16:02:40 +0000
Received: from HE1PR01MB3722.eurprd01.prod.exchangelabs.com
 ([fe80::255a:24d2:7814:ba6f]) by HE1PR01MB3722.eurprd01.prod.exchangelabs.com
 ([fe80::255a:24d2:7814:ba6f%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 16:02:40 +0000
From:   COLLOMB Joris -EXT <joris.collomb-ext@alstomgroup.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git checkout multiple options issue
Thread-Topic: Git checkout multiple options issue
Thread-Index: AdS3DOSUeSahnLF1Sp2hV0Z9qGG2agABpYKAAAAwhIAAAizrAAAAtUKg
Date:   Mon, 28 Jan 2019 16:02:40 +0000
Message-ID: <HE1PR01MB3722F2B99E14165C952055BCA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
References: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
 <000201d4b713$7edcd3d0$7c967b70$@nexbridge.com>
 <HE1PR01MB3722D90668E75E4BCDBA71F2A9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
 <000701d4b71c$f3ba57f0$db2f07d0$@nexbridge.com>
In-Reply-To: <000701d4b71c$f3ba57f0$db2f07d0$@nexbridge.com>
Accept-Language: en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joris.collomb-ext@alstomgroup.com; 
x-originating-ip: [165.225.77.64]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR01MB3020;6:mE0fMoWXSVHX/ConWEpr6jUSB/P5iUKY6wwMBykA3uUBj9mUUkC64RzvIKQed3dDT2ZMX66Lm33yoZHMOehq+CQj16+Z+HekZGw0nnqL2YWYx8f+8BxR4AoXow9Pv3SrpqxDUPC4rws51ta8I5VGskr67Ioipz9E3PvGTDf27QPEUL4BJMirYsMbG7CrqhkhZFbwzt8DDxWlJpVpTgUTyQIUaePMfRLS91Sebjq3X/9Q7Qesh0iRIZ8fFZ0JvGPDbasbF5Fmo63jSMsrsE118Vtuz3yafoKg8EHS1I841lpVtMM9EwRDqv2IYSMiWOD8yvbtL6YQ78QCw6HVCNCDuFyTa6lvmd/FVG6g84FmI44HwTfunrNxBePiMYq/sbZ9C5ahMlk4naJ5qxZe1vqMr1cfeK4GlaMu7iBVU+8FmfgGjhQQX7A38nl59HRxlEnLrBCbWBmu/VmKIX2QoTeUCw==;5:frND9wbn4QATDl1NUajNA7eh7pQ75Chnw+oWrlmeZB6/QKxg6cM96DOVLYPvwpBynMmzBDsHcSeHxRoqgGgiSWDmZQ+jHYjsk0rbT8xIpu9l0+szdI77hOZNNs4BV7wJoPB8hEFpHCuYtge8wIEmhCIr5tG75TR8bjZ6DTkgl1JhiqP3HqU0To0oO3dGOMvOWPAwqGB2d08sSnLQQEnQ3w==;7:Ps/B51PKTfcmJji9tLNytlVOoQ/7p3Jb35TJ1N9Okn00+X519CnHn6rrs5FHiwOba+p4PyGzK4PuuiWxuVYnaPSitHSnOsHMtW2AE8kUHH4ACP1hojb70UtwUsLkNMQc8Qvera+tbl/L4wgWRPZU5Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 057affcd-5def-4681-610f-08d6853a07bc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:HE1PR01MB3020;
x-ms-traffictypediagnostic: HE1PR01MB3020:
x-microsoft-antispam-prvs: <HE1PR01MB3020B1A721F7A1D2ECD0F6C0A9960@HE1PR01MB3020.eurprd01.prod.exchangelabs.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(40434004)(189003)(199004)(55784004)(26005)(105586002)(106356001)(305945005)(110136005)(316002)(7696005)(97736004)(3846002)(6116002)(55236004)(102836004)(66066001)(6506007)(81156014)(81166006)(7736002)(186003)(74316002)(8936002)(99286004)(2501003)(8676002)(71190400001)(71200400001)(68736007)(86362001)(25786009)(6436002)(229853002)(33656002)(14454004)(478600001)(93886005)(11346002)(2906002)(446003)(476003)(6306002)(14444005)(966005)(5024004)(486006)(256004)(53936002)(6246003)(76176011)(55016002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR01MB3020;H:HE1PR01MB3722.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7lsE+p9MANDrweMXjYAXeYLaCZbPXTe2JhPLAnd/OyA6tdr0iV7ORLNa8imyzRaXsdOtf9U8Rl7HRScC1tRhPxlk14CObICRnXQPcPvZtezcLyVssFsdieC7suqukPwiRcIfOwVbaWXYw4jYHLonyt26zIBShTL5gK8W/B8tJxBgN+Tm3YLkMLmPr+So9DNE5uWcY04E2QBR7avzwW6fREkbzRFWzj7/y/yhJkhbFWuyFQrV6iZ1DqNU/h40JMUAtdz4URJMMSlRzw0qEb5k6C5huS++c59HjGORZ0IyRmGgkLaI/grfv4Mw1OBsUD33N0pGQ68Ih/x1u/zMh2aKTJ0miGR+z5bw2HXgzX1Lvsp2OQLRcezuHRySHIC+VnzeidHlKz+VvPFq8Bf9BZCytANYyKCMlpDswqFGXUaYsDk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alstomgroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057affcd-5def-4681-610f-08d6853a07bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 16:02:40.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d993ad3-fa73-421a-b129-1fe5590103f3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR01MB3020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Once the branch is created, you can't force its creation, because it is a=
lready created.

Sorry to not be agree, in the man page of git branch:

       -f, --force
           Reset <branchname> to <startpoint> if <branchname> exists alread=
y. Without -f git branch refuses to change an existing branch. In combinati=
on with -d (or --delete), allow
           deleting the branch irrespective of its merged status. In combin=
ation with -m (or --move), allow renaming the branch even if the new branch=
 name already exists.

The behavior I was expecting with
git checkout -b -f "branch_name"
is a checkout on a forced branch creation at <startpoint>.

So the only solution for me is :
git branch -f "branch_name" && git checkout "branch_name"

So to resume:
- This is not an issue, just a divergence between my logic and git implemen=
tation.
- The message "Fatal:  '-f' is not a valid branch name." is maybe not optim=
al, and it may better be " Fatal:  you trying to force the creation of a br=
anch. Please do "git branch -f" if you know what you're doing"

I still don't know if you understand me,
But I really appreciate that you take some time to answer me.

Regards,
Joris

-----Message d'origine-----
De : Randall S. Becker <rsbecker@nexbridge.com>
Envoy=E9 : lundi 28 janvier 2019 16:20
=C0 : COLLOMB Joris -EXT <joris.collomb-ext@alstomgroup.com>; git@vger.kern=
el.org
Objet : RE: Git checkout multiple options issue

On January 28, 2019 9:25, COLLOMB Joris wrote:
> -----Message d'origine-----
>> De : Randall S. Becker <rsbecker@nexbridge.com> Envoy=E9 : lundi 28
>> janvier
>> 2019 15:12 =C0 : COLLOMB Joris -EXT
>> <joris.collomb-ext@alstomgroup.com>;
>> git@vger.kernel.org Objet : RE: Git checkout multiple options issue
>>
>> On January 28, 2019 8:25, COLLOMB Joris wrote:
>> > git checkout -fb "branch_name"
>> > (force branch creation and checkout it)
>> >
>> > doesn't work (even if option a separated).
>> >
>> > I don't know if this is consider as an issue, but here it is.
>>
>> I think you might mean (which works on every platform I have):
>>
>> git checkout -f -b "branch_name"
>>
>> There is no provision for aggregating options into one. -fb (invalid)
>> is
not the
>> same as -f -b (valid).

> git checkout -f -b "branch_name"
> gives me " Fatal: A branch named 'branch_name' already exists."

Once the branch is created, you can't force its creation, because it is alr=
eady created. Just

git checkout "branch_name"

is sufficient at this point. git is correct to complain that you are trying=
 to create a branch that already exists.

git log --decorate --oneline --graph --all

will show you where your branch points in history at any given moment in ti=
me in a convenient form.

> I understand that here the checkout is force, but not the branch creation=
.
> The opposite option order doesn't work:
>
> git checkout -b -f "branch_name"
> gives me "Fatal:  '-f' is not a valid branch name."

In this case, you are asking git to create a branch named -f (the -b branch=
 option). Then "branch_name" becomes the reference that would be used to fi=
nd the commit that -f would have pointed to. However, -f is not a valid nam=
e because it is an option and git is correct to reject it.

git checkout options are described here:
https://git-scm.com/docs/git-checkout

Regards,
Randall


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

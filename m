Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642951F462
	for <e@80x24.org>; Fri, 31 May 2019 14:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEaOpI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 10:45:08 -0400
Received: from mail-eopbgr750109.outbound.protection.outlook.com ([40.107.75.109]:45893
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbfEaOpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 10:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=oc4+n1xAe64DDZCORCRWPWVzw7VdRH4upNP6oY6D9wsZvtER9TeBiBrHE8br9xXAz5U/0HJQC95aGaOhWSIMGUnLBMDjjTMXYikhT6roLts6I0/rwVkp/31Wt+N8cnFc8n6o6S4Qy/XIVN15SKiWhKJEE5TFUnF3etl28vWdz2c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zbo9zCiGEcaDcIjrKKr3YSvEByb0Dfg0FbO9CqWi60=;
 b=gJB+SYthrgokgwtdqthmD9L6BCTg5fHL3UlH9HdFbAYhgLRHqqxPJo3hm6W0E+kfcl+7t8RaTX6vq/eLOVxklef7RpcXmoM98rhnJWYTIPCwFG6QSLRM05tXEKxJgtHut61yljGtTeaZVjcbx4MQAMG1Vw7AC/3iM3bTWqipwUU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zbo9zCiGEcaDcIjrKKr3YSvEByb0Dfg0FbO9CqWi60=;
 b=fMpoUZnI1Mvl3z0QvN3kWREg7KY+7dLb7JvKZ3Xqvan8B6VFsDKJH+06V8hCec/K/KoWQWWJgeWbRNBznY4oYUksEM61auLXt+BBb2lzFTrXbuaZM3Fgh6P0TOoTCvLTbcEyvvAyYiAAIpIjXiyE4l/e5Oj7/79JQVjybSjvN+4=
Received: from BN8PR21MB1156.namprd21.prod.outlook.com (2603:10b6:408:73::11)
 by BN8PR21MB1204.namprd21.prod.outlook.com (2603:10b6:408:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.4; Fri, 31 May
 2019 14:45:05 +0000
Received: from BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::2147:f6c0:c7f:30e1]) by BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::2147:f6c0:c7f:30e1%7]) with mapi id 15.20.1965.003; Fri, 31 May 2019
 14:45:05 +0000
From:   Cliff Schomburg <clisc@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Thread-Topic: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Thread-Index: AdUXME7sW+dzzd+8STqmdbLpESwchwABfZYAAAAnfwAAIhlQgA==
Date:   Fri, 31 May 2019 14:45:05 +0000
Message-ID: <BN8PR21MB1156F7F3E7EFF9C8A60F33D0B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
References: <BN8PR21MB1156ED141AE2662BC5328A22B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F593DAEBD7194DA7041EB7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156DA1893F64814F1BE8709B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
In-Reply-To: <BN8PR21MB1156DA1893F64814F1BE8709B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clisc@microsoft.com; 
x-originating-ip: [24.182.67.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7499d802-49f6-41eb-03e5-08d6e5d6922f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR21MB1204;
x-ms-traffictypediagnostic: BN8PR21MB1204:
x-microsoft-antispam-prvs: <BN8PR21MB120499094C32FB319AD91027B7190@BN8PR21MB1204.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(53754006)(71190400001)(71200400001)(8990500004)(10290500003)(22452003)(76176011)(6916009)(66946007)(33656002)(66556008)(76116006)(66446008)(4744005)(14454004)(73956011)(316002)(64756008)(68736007)(7696005)(102836004)(66476007)(6246003)(478600001)(53546011)(2501003)(2351001)(6506007)(52396003)(10090500001)(186003)(99286004)(26005)(476003)(305945005)(8936002)(11346002)(446003)(3846002)(229853002)(25786009)(66066001)(256004)(486006)(86362001)(81166006)(5660300002)(5640700003)(53936002)(52536014)(8676002)(1730700003)(81156014)(6436002)(2906002)(74316002)(7736002)(9686003)(55016002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1204;H:BN8PR21MB1156.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b065y1e1OB11xfDUR61LIiH2VZRu1jKwfb+0AH2E1aAuum1sIE/SqDS1gKJwMc1GqWtkc47bwLzZAO1XqNmFI3f0bO2SDXA5dHien7dZ1ZJvCYiWsahQ4KfkW+P1igTtXQoWs13Q7swPFXR0+Maxq+Slxvd9wZyevB+pkE0xrO31snA+awH2yV0WOLfdaxOlzTehgYxzrFjDaLApxvPm8nGbi6GnbcMR4uv+7hZDgwNic5n4El+SKNOvgEFg2u/6kWpGt9N+fR3apGE6bzDxjB/eHt00ydhBSTPJNjn8K+t5qqwI3S8rUBA2KWRqeX9ZreeVkhfRdmFJ+aiCVKxKOL+E4YI2xaqeYfGJXZzcRPyHM0gkNcd7sb6KEzmW7HyZe9FPLTuvgRw2e6Djgw6PRzzItYFxvV1o3h+JOAZjfbY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7499d802-49f6-41eb-03e5-08d6e5d6922f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 14:45:05.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clisc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1204
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending as plain text

From: Cliff Schomburg=20
Sent: Thursday, May 30, 2019 6:29 PM
To: git@vger.kernel.org
Subject: Simple shortcut for "git push --set-upstream origin newBranchName"

Hi all,

This is more of a suggestion than a bug report.

I create new topic branches quite frequently and push them into the remote =
repo (origin).

It's a bit of a hassle to type "git push -set-upstream origin newBranchName=
" each and every time I want to push a new branch.

I'm proposing a shortcut for this command.=A0 Perhaps "git push -default" o=
r "git push -new-branch" which could be shortened to "git push -d" or "git =
push -nb" or something.

Based on the man-page for push, it looks like this could be an alias for:
=A0=A0=A0 "git push -set-upstream origin HEAD"
In which case HEAD should always be the current branch name.

Thoughts?=A0 Concerns?

Thanks,
Cliff


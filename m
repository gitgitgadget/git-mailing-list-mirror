Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696691F42D
	for <e@80x24.org>; Wed, 30 May 2018 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeE3TvA (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 15:51:00 -0400
Received: from us-smtp-delivery-139.mimecast.com ([216.205.24.139]:39755 "EHLO
        us-smtp-delivery-139.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932208AbeE3TuF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 May 2018 15:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zerochaos.com; s=mimecast20170602; t=1527709804; h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding; bh=AQpzkvlaKzY+83noLLhNNhohdCdfIhgcqps68W0muHw=; b=VJ0xGmqsmGgmVMSyyWLqmPe+gb2JpE4RcYGtwf7krXD2M8KmZ2gXSlyxhUOpDrTvlbF5fKvo1HzvC25H03t9Lw8iHXFvziUsfLIR/NXb4Z+btOykBn6p1gvVjeXQLfy6E2gwcSqDUd9uqLNOvFMmkrOz5LF+IK5ZqHehgj7RbvM=
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp0017.outbound.protection.outlook.com [216.32.180.17])
 (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-190-cUZzuYXLMO-pBU4p-IZWeg-1; Wed, 30 May 2018 15:48:58 -0400
Received: from DM5PR0102MB3431.prod.exchangelabs.com (52.132.129.22) by
 DM5PR0102MB3592.prod.exchangelabs.com (52.132.132.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.797.11; Wed, 30 May 2018 19:48:57 +0000
Received: from DM5PR0102MB3431.prod.exchangelabs.com
 ([fe80::ed58:473f:c80d:a6b5]) by DM5PR0102MB3431.prod.exchangelabs.com
 ([fe80::ed58:473f:c80d:a6b5%2]) with mapi id 15.20.0797.020; Wed, 30 May 2018
 19:48:57 +0000
From:   John Meyer <jmeyer@zerochaos.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git installer bugs
Thread-Topic: Git installer bugs
Thread-Index: AdP4TzNsQLWdBxBIS0mFSNTNusay8g==
Date:   Wed, 30 May 2018 19:48:56 +0000
Message-ID: <DM5PR0102MB343149C5313DFE76852857DCCD6C0@DM5PR0102MB3431.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.112.171.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR0102MB3592;7:KORIps3UImbG/jxIdtkcPR0gu27AKxeHxzyoTWbDJp6nxz+fv/1Q+Th1EzpBx3r97QdxWmeb9MdQVh/Zg4ZBA/O3DJOJeJNtUuFICXoIp27o93/K+DR9gVVLq3Av6IbqDFMPJd5L+EpIRLrgB2gmkZ1g22DSEG6badYh/HeQlzLa8pX24lN2vZE4i0BkME/NCZHlHAc/VGdoPiy14cHFozE+cilKLMuH+AxSU40TPsUY08MO1X3ijebcQhbUTFuz;20:HdE26Q6hEnfMDCeOjG9lBYeCePQfFM/jGP3M7466S6PaBFilKNFoQQ+LmI+5nv6GDCfUYFRwDWuvgYNlQjrzJwrLrRGX0Azbzpds26q8EkAMo72SPHZ2AtmzdZUTEd/lKJEHxLlCd7RYQJxfMrKVEoFF/1tqF/L7HEHeuVc5fis=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR0102MB3592;
x-ms-traffictypediagnostic: DM5PR0102MB3592:
x-microsoft-antispam-prvs: <DM5PR0102MB3592844A438B4150715D6BDDCD6C0@DM5PR0102MB3592.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(100217034793204);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR0102MB3592;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0102MB3592;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39850400004)(376002)(39380400002)(366004)(199004)(189003)(2351001)(59450400001)(106356001)(3480700004)(5660300001)(7116003)(53936002)(9686003)(7736002)(5640700003)(6436002)(5250100002)(305945005)(6916009)(81166006)(1730700003)(2501003)(81156014)(33656002)(2906002)(105586002)(186003)(26005)(14454004)(74316002)(2900100001)(478600001)(99286004)(486006)(476003)(8936002)(3280700002)(97736004)(102836004)(3660700001)(8676002)(316002)(6116002)(7696005)(25786009)(6506007)(66066001)(55016002)(3846002)(86362001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3592;H:DM5PR0102MB3431.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: k0ljGMh7lrxKVcBv8pqBXJRxL8/wAFx2vMzOo0rpqo+DcbiE2BRPc+UoSfgCkw0zYQMPAWUVqnYX6RaXxm0KAmvTFDu3p9isSH3U8NNhEulM66NxkF/Ij1xMzNcFYGHlaQAzYNaHqu0l5pFYwuj/bz4V3A0XEyAcgc50YgqX3Xc1/6WnFiJlbaGwuf/i41z6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 160c7e4f-daf4-49d3-97fb-08d5c66661af
X-OriginatorOrg: zerochaos.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160c7e4f-daf4-49d3-97fb-08d5c66661af
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 19:48:56.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1718ad97-4ed4-4b59-b5ab-e4a031924237
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3592
X-MC-Unique: cUZzuYXLMO-pBU4p-IZWeg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ran the installer, selected the option to not modify the path & the path wa=
s modified anyway... it removed git from the path (it was there from a prio=
r install).  I should NOT have to manually fix my path after an update, eve=
n the option to add git to the path should be smart enough to recognize it'=
s there already & leave the path unmodified (sorry, I know that's 2 differe=
nt bugs in 1 email, but they are related).


John Meyer
Technical Lead, ZeroChaos
jmeyer@zerochaos.com

Disclaimer: This email is intended only for the use of the party to which i=
t is addressed and may contain information that is privileged, confidential=
, or protected by law. If you are not the intended recipient you are hereby=
 notified that any dissemination, copying or distribution of this email or =
its contents is strictly prohibited. If you have received this message in e=
rror, please notify us immediately by replying to the message and deleting =
it from your device.

This email message has been delivered safely and archived online by Mimecas=
t.  For more information please visit http://www.mimecast.com


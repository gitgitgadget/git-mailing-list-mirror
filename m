Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50581F461
	for <e@80x24.org>; Wed, 24 Jul 2019 07:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfGXHKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 03:10:54 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com ([40.107.3.114]:57478
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfGXHKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 03:10:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG86zdQsqMq2M3nzZpgP9vWJicxr8kPImeAzQCOJXVeUoLODel98aaSoMDJpwYMuV6LmJ22spZIRq9Rtl+u7a1PBkPW94E+TF7vgRnC8u0MF1LzlNT5JXwEs/1kcwuE45VxBNnWsO0GJuXWJsbZXT9T3QF/gg5/5u2NlTpibs+dVJ3y0hNj5JjhUVdg5i7rEj/GCTlBs9NazNamJj+EBznE83Ut8v32YgrHakN3GPJ1ghwxVW01Ho9Qad0D8hEvTbzRUja6pkHow6Uw7qtnKx74WY6p5RJZ6gLTwedPfi9uwmRsDpqFRwMQ1lHpkeJYzbXPefzgiryLIvGUE8EoonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbdV9OoaYqUJn3JErn0zuu6Dym2b+yStkjlNLHBnXVg=;
 b=bppTYhfdTqipy4d/cISgOCAykRz0Fok56ElPw8UUMktug6+H93WH6CIT1j2Oe1Dx865gWzN9J0Q9u548uLFM07SdFLSM3DQwgK2SOQ+VvIhEm5Hou+QXa2W+tn+P1cCarkezrwftiEvPlGBUVmSSUt40ZWJ8n50cd0LfdtZ7IXMg1Qb4l6JIaAJv9fm9WneBnPLnTQgDi9jK/Z5TlFWl3CYUwhge6HcS4Z86RuzothsnaAXBX06aI6O1mTrND25hRlC3QLvpWKO0o6i/27/Z0AP5Du97IKSF3/bEi9J7EwuXBXkF/du04Hxt/3PqublFmkUhO3rKPYMuhTurojY9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=dynacommerce.com;dmarc=pass action=none
 header.from=dynacommerce.com;dkim=pass header.d=dynacommerce.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=DynaCommerce100.onmicrosoft.com;
 s=selector1-DynaCommerce100-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbdV9OoaYqUJn3JErn0zuu6Dym2b+yStkjlNLHBnXVg=;
 b=PFqqiHlylr2yPux71bSAi//BSNJnvleBKiypNDOTSxo8JW17cRcxlwn+1Jjrni+cwMuK3eUen4hWsUp/vmidq9zE/cS6C+BzqebowC2VOe82N92/MQlaPeRIEGxftE+JGBmt+zoGRXCIpnjlZSQnQPTuJLlNTbCk6XOYa4PL+ig=
Received: from AM6PR10MB2341.EURPRD10.PROD.OUTLOOK.COM (20.177.116.22) by
 AM6PR10MB2744.EURPRD10.PROD.OUTLOOK.COM (20.179.2.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 24 Jul 2019 07:10:51 +0000
Received: from AM6PR10MB2341.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::509b:9d98:9537:4645]) by AM6PR10MB2341.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::509b:9d98:9537:4645%5]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 07:10:51 +0000
From:   Gobinda Nandi <Gobinda.Nandi@Dynacommerce.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Need help
Thread-Topic: Need help
Thread-Index: AQHVQe7taeaN+usfp0u9CNa5E9JsWA==
Date:   Wed, 24 Jul 2019 07:10:51 +0000
Message-ID: <6962093F-3E16-432E-AD00-CF6DA4916FD4@dynacommerce.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gobinda.Nandi@Dynacommerce.com; 
x-originating-ip: [14.143.133.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 386587eb-42c1-41f9-bdc0-08d710060fb3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB2744;
x-ms-traffictypediagnostic: AM6PR10MB2744:
x-microsoft-antispam-prvs: <AM6PR10MB274444F5AAF424D366F17F2190C60@AM6PR10MB2744.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39850400004)(346002)(376002)(366004)(199004)(189003)(221733001)(78486014)(66066001)(3480700005)(476003)(6916009)(26005)(33656002)(71190400001)(2616005)(478600001)(71200400001)(256004)(186003)(66946007)(2501003)(14454004)(316002)(305945005)(6512007)(2351001)(6116002)(3846002)(7736002)(6506007)(102836004)(7116003)(55236004)(76116006)(36756003)(91956017)(86362001)(8676002)(2906002)(1730700003)(68736007)(6436002)(66556008)(486006)(6486002)(5640700003)(25786009)(81166006)(81156014)(4744005)(53936002)(99286004)(66446008)(64756008)(5660300002)(8936002)(66476007)(554374003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB2744;H:AM6PR10MB2341.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: Dynacommerce.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w5BCRYY2cgpo1tzTSBZwEt/7uZes+lKNJ5VWAReF83OJcck2GOjbmmg1z94sJtHqP5OQhuQPYBC57EhmA20sFPtPcym4kecKvRrrr7Jh9D58rzzDMfOs26wc91X7dlhbW6IM0Y3AUQXdCK+wyUhIcXBUldbLO45sP5QWkNT/WjLrYyOJ+kSRHbS85RgCpmnDzcNyqAN6zBnJZfnsxbYW2HUTwYxP0ak3TI9GwekVGW7QhpYlDVwHP2xXQQvFNzcTVCbfWre2qJVj8tf3XeZKrVf9VLGUbZE/DdNfQqurWVkAqqJlbgX64xeKggUtpsfvl3BUlMrE8HX47fbF1Zvp9GINbCV6LriOtUpgYm5eLDiKG8Z2ggfoucloX90kq6wCliQ5El+mLYTE9zYp3rAj57x2K63p/brGmqU0iO3CjSk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7FF2E3916E822F448E9E012B531DC070@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dynacommerce.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386587eb-42c1-41f9-bdc0-08d710060fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 07:10:51.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fa96b356-63ae-4dec-9a6f-3a8f08fba012
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gobinda.Nandi@Dynacommerce.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2744
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have cloned a project using GIT. There I am facing one issue and nobody i=
s confident that when that issue was not there. They are convinced that ear=
lier it was working well but noe its not. I am trying revert the version bu=
t still I am finding the issue. I know this can depend upon several variabl=
e but at least can you suggest how to check from git log.

If this is not a right place ask this type of query then plz ignore it.

Regards
Gobinda Nandi
Software Engineer


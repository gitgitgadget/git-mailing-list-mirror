Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=GovernmentBrands.onmicrosoft.com header.i=@GovernmentBrands.onmicrosoft.com header.b="DqZYZX45"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49EACF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 14:51:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkGPainvhbJ5qpTMG89Atxddwt/eY2qresKiQDv16tekOuH/v3BPrighEr3pxgfEtSVXd0CCoNRJ69SiXzsa5ySkf7MkHtTrbCFM3M6Q/SdwOg54Klu2bzk5aiFPnaCdI0rW6mKAkLL8mwDu1Hl6A5ygq72tcvL3aa/reCN0dFh0I+t+zwzW5hO1R9pSVh2r7GCR+p95qzU79p+pFOmZCkA3jcPPyZRXUh/BS59nBddKrcJpMoQxYoVamFO+4NTPJZJKyke3UDPcIIgihUTp15SjgYmQDqYSorXDTUGuZx94XCxssENN7q0Wg8ur1vKdNx2vrDSvIE650tdvoXCYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RomfJjEK+hp+xxVzuJ9Hx4ASDfZnvUeT0pRENIvYsyM=;
 b=OkhAi20mrbZxAURcQ5ENKnJzpxC3Lx8apU/H/WVIQpFmmyetqR0eNdBO/WjuarSI5kBwClmxaiAC5ofYGiLITMtF9FVG/K59f2cAdr5Dc97HviK82nhp9pHmMC0jVd7lv0laGUAF6Ee3VVzmfuR+/U4onMQVM5o6xHksqe1Kr4Qyy7K1T+Pw7dDQ5Pyf94vzgU3AngyXlq19r5Cc9lZyUUF+CUDZgKjiRh03FNq6NyTBEukh56dapPkGq4fo2/JLl1DH9SK2iP1qiQmHIKDalseIHfbZdAU7H8f+7XcTFsA9YFqUUOR5ITe9kg8XZ1jPKE4Z5VMZkraqYLN4ZOmGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=catalisgov.com; dmarc=pass action=none
 header.from=catalisgov.com; dkim=pass header.d=catalisgov.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=GovernmentBrands.onmicrosoft.com;
 s=selector2-GovernmentBrands-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RomfJjEK+hp+xxVzuJ9Hx4ASDfZnvUeT0pRENIvYsyM=;
 b=DqZYZX45Xvh/BeKcciMj/VkDSIZIDLqmluIhYI4OzGrQe+Til6Tf1KKBtJWZErOU6IPjJZAClORXmGy1wtqtrHwsyFxbHkrrDakLVqhYl1qxzoz45P91tqBIlJ/jWXgcvOLOI1hRPNWVojDOqsZuyhhVlM0yM6JuIQu0zSk55ig=
Received: from DS7PR13MB4686.namprd13.prod.outlook.com (2603:10b6:5:3a3::5) by
 SA1PR13MB4861.namprd13.prod.outlook.com (2603:10b6:806:1a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 22:51:49 +0000
Received: from DS7PR13MB4686.namprd13.prod.outlook.com
 ([fe80::546f:f20b:ed59:7fd2]) by DS7PR13MB4686.namprd13.prod.outlook.com
 ([fe80::546f:f20b:ed59:7fd2%2]) with mapi id 15.20.7068.030; Mon, 11 Dec 2023
 22:51:48 +0000
From: Daniel Ducharme <dducharme@catalisgov.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug in SVN.pm
Thread-Topic: Bug in SVN.pm
Thread-Index: AdoshJ01hWjwkij7TYWiNlDIQBOelA==
Date: Mon, 11 Dec 2023 22:51:48 +0000
Message-ID:
 <DS7PR13MB46861D9FF40E2A340FD2C8D2CF8FA@DS7PR13MB4686.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=catalisgov.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR13MB4686:EE_|SA1PR13MB4861:EE_
x-ms-office365-filtering-correlation-id: d246e813-c9f7-45a1-7462-08dbfa9bc243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nWjWLB7NdNF75yLtsGYiSFn79B7r10gjBK65WpUlL42iuIw5S7AQ7T1AvfeDzW/tT5P14AWkHnm0RwlvPy6EOpB+K0PLSdKVpvL0MOgMgvUGCabw8Q7Aus5zJlvv2zAvPJQtJ6aPvzumtKPiMSTeT+gBQlDk4jumfEGd/tHR3SBx2RRlifcy5mxpPJDXC8SRiqSn0mmCkH7doeX6IWpCUFziU7bYskspv91oGeZBP8K/EUYTGBsu1Tqf/dk+W21yfLHU13X1aN0oR8xzeLVoMnYWlDa0SWAgc+GPjJtJyoGukPqfAqkSz+cMkdRADvgOVXcE4z3tvgGd+iQWQ5X0mEq/hURxA1nOQMwBOuRVABCUx5oaE8e0vnODc5Vm/rKi+lVQoY9145MAbOJwqup3BWrDEzzGuG0hoUnr+89LxWvQ1GAVc9c6gYJmWVkOa77wik5bG4Rh3jYI5vX09Xqo9Oq31x8v6CHcfqkfnIhqH0bmwm8jsYTiXua6nPRrp2ds8S1HDrUPp4Qnn1p4w89D0ro3tNMSOxTQucQt/0j+HZDvURYHNkCTe9ulalLyJihsI/77wSccaUertho0TkAycefsF7Sw9E6frxitnXMtbGfF4/I1cxHwhsrjcBUE5btmDcVvyhKQU0fJ9fEKF/SJUce6v/hVtybBQwl63RAT3eQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4686.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(26005)(38070700009)(40140700001)(33656002)(86362001)(38100700002)(122000001)(3480700007)(5660300002)(316002)(8936002)(8676002)(2906002)(6506007)(7696005)(71200400001)(9686003)(52536014)(66476007)(55236004)(66446008)(64756008)(6916009)(66946007)(66556008)(478600001)(76116006)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?i7wfvhtq6djduly2TShv0i/k/CAZetuu5kdBvp/dKwyAjAq7CQIbAlhoO6?=
 =?iso-8859-1?Q?qN20u+t//yduc0/hhz6kCIQBbuqDYTBYgwFhzok11E98LlWZACiJ8vLSLb?=
 =?iso-8859-1?Q?Kdck54mC1raUJ8CMfZeXI6ffJ/mlg7m0Z7eBEWKaF+Lsm/i59NLFaRjGsG?=
 =?iso-8859-1?Q?BqGkERrXzGe80fpA4uN9cw7KUtMZ0vyovBEWf5zeMkCQgIKg/BWwOosmBd?=
 =?iso-8859-1?Q?nntVo+ERmx1eTzSM7PuVgSNQpkwY0aUhb7WDVAKrhfCU2tBwpvC2GHshix?=
 =?iso-8859-1?Q?F8Wzt/jZvv/WyZOvXWYxmrURVE8kbSMlHJfquiDoAZ6EfjvxYbcU0mLj8t?=
 =?iso-8859-1?Q?N+n+dSyAtQsHXtuqvIkfa8CLgGKt6ISJR+dvnlefWQtaUyOxdqprD9Ba9K?=
 =?iso-8859-1?Q?sW20CcAYNQMrlgBC4YgXhWpCb9zKtcAIVCLVhbe+aclbnTavDvtlTj3MjF?=
 =?iso-8859-1?Q?/UnggBvLAbG4MDsyPkpVeJts3YAuVF0FzzzbMPRdD4SdVQFzl8+D5Gmxk3?=
 =?iso-8859-1?Q?xfks0xfQ4ufUN6h94IIBLbYP139aRwpU4p71AyKRiEpB31yg58IxcfsZcm?=
 =?iso-8859-1?Q?QhYystaT3FinO64zdZbyoi99aPSkeFNIxcdk2krr/8CVgKyuaN9tAEklU1?=
 =?iso-8859-1?Q?rFnn9CTSHfrk46sPMUDCoJACUgEZpwOnlvFqTjpSy4Vjorey4WDiX5ylOZ?=
 =?iso-8859-1?Q?Z6/Py2WxQKU7ffy4Kp8mZa0pxZF3m0vyv1yeM5oaBbrSqIKN3whTZXAEc0?=
 =?iso-8859-1?Q?fgVgIV3Y5LWvpc7emCsijqnxHefHUaOC9NeelruJkx4XpBGKGLCwPZNMf0?=
 =?iso-8859-1?Q?tK0KrXK5r9iF81IL8BNd9ta9j3QUUJ1qhUOCDq6MUm56mbMvQh8h380nqt?=
 =?iso-8859-1?Q?jgio/KvVTvzl9dW6jP6hWcPthZQ6ieMQKPmz5lwkJ4HqF5P9J4hf4HpPJo?=
 =?iso-8859-1?Q?yJVYPaemL2K5tDqqMqNKOj/z8V7rQieUXrmLWyHJoPJCHlcenHBD9wEwUm?=
 =?iso-8859-1?Q?5PJLUWvfw4bFO3+Cm2MiTUi1O/Lc/FHHlJyKVqpLRf69wz/eVR8kp0Pb5O?=
 =?iso-8859-1?Q?QxA9SeOX0FPHY8ngHX+hpBFpmvCkU1yX2IAZSGMt2nmH96hEW0EnF1Nj7Q?=
 =?iso-8859-1?Q?cUu/uebCcgrLRePGp2L+hUysIl9ogcAMrMcXLKrKtlLT6y323dEhcwod3U?=
 =?iso-8859-1?Q?+jg2NGJZDUZQQdVz5fHBFm29yzJI7p57BYzAikDTH5tmWwq3kVOHPo1CAS?=
 =?iso-8859-1?Q?+mEB8qUxIoQOLR1TYjKrDFwXl6WDN34/PFzCnq6lKK+NtEoHBr74rhiEYK?=
 =?iso-8859-1?Q?3ERG779g1CBYws558jfyLqGE0n+605fQeqt+O+h20fa82uXWl20t26IFX9?=
 =?iso-8859-1?Q?LsmnpPuYypqfK4vQmaUpAHDxSheTYoPFSTr7rGPrkOpezKiSpBzhIChfv9?=
 =?iso-8859-1?Q?2gFheT9cz2IDzm+2ifRMMUdjIIW0BlGyAohNmSX3D7k9eEXEdel1rzXpiG?=
 =?iso-8859-1?Q?hLI3HgTnTKFY70CajlMW66Phj8PxiZp16uc8l5Q+oa8CeA6KV0UVZVc8sE?=
 =?iso-8859-1?Q?hZdGRiKQf2KE92lEqXa5n/9jvd7gdQ5mGYH4kR99julS+M72Lt3T0Wmj/u?=
 =?iso-8859-1?Q?9g9rMlDZTXKxvM9fo5/Z1j/W3cCE/yRFnA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: catalisgov.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4686.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d246e813-c9f7-45a1-7462-08dbfa9bc243
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 22:51:48.9103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e5a7e92-be30-4b8f-92d0-829d99296934
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oyiS31gT8QUtWmjByYNL+rloQjFMA+Pc63a3Q4h8x/3fvrhOfI4zPceCH8WUWG2e+IYerV6vF4eELbtr4kFhuq8OW8Ryv36lmP3iqKwTdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4861

Good afternoon,

Not sure if this is maintained as part of GIT, but the bug is located in th=
e file: C:\Program Files\Git\mingw64\share\perl5\Git\SVN.pm

sub parse_svn_date requires both the month, day, hour, and minute to be 2 d=
igits long and fails on 2007-3-12T17:46:4.000000Z as an example due to the =
regex. Suggestion is to make the regex instead /^(\d{4})\-(\d\d?)\-(\d\d?)T=
 (\d\d?)\:(\d\d?)\:(\d\d?)\.\d*Z$/x)

I have found this data to be present in a SVN repository converted off of V=
SS while trying to take some old VSS repos to git through SVN, not sure if =
standard SVN would have allowed these date patterns, but they should be val=
id. The above regex also contains a fix for single digit minute and second =
as I also ran into that as well.

I have fixed my local copy so I am good for my project, but it took me a co=
uple of hours to find and fix and figured this may help someone else so I w=
anted to get it reported. I am on git version 2.43.0.windows.1.

Daniel=A0=A0 Ducharme, Ph.D., RICA=A0l=A0 Director of Software Development
Catalis Tax and CAMA, Inc.
O: 781.476.2012
M: 401.743.5853
E: dducharme@catalisgov.com
=A0catalisgov.com


=A0


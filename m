Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="D4igsPBp"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2016.outbound.protection.outlook.com [40.92.45.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D73ED0
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 07:52:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtCsPKg+Rv0DzPCzg9ry9iGRn1Qxh4rnwl5728WQey6qO7cz7KjgZZE/UYSLh5wtS6/FevXPvV5Ot+8jvkqYqL9p1yklVvamORzKT2FJGX+NjSi0G4vomDeuyPWcj+1P6aLX18jj5gxpt9lAEjPg0yAZXBbbr5lNTR2u1mZ0ipsiRzmFIA3kaxXh6T2uNTOnRfpEN7fzVGqUiHfcMsFbzrBXDILzM9WzonwtXoq1XaNJ9W8ZqQzLAhmy0wt9vhttwgoLPJHYG5UdheJBaQLQcWnsduMWj9LaRhdlzilvvo/Ec45THMp84KDqPzWf58dHB0ZifS3uxcD0oi938wM8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me5MarQ+l7JDgTrv1qlC3iu4cTX1vWyuQxOytdu3Iag=;
 b=ogO9/w54c3c/WGUo9kcXn3UKnH5Oie+J9WjBC/Ehh0o1B4vaOPmS36CdTaOazB+uRXGGIc6jAHd9uLvb2FceYGzfPdP1Uhek4YrQPiV2i2CV6Lc39FlGhz5LjR52SvHJDhceZCYCLltEddbAiRV2wXLESv+IF81MMsKOAtlxr9U7hP/AX3hFn5iMrw31f6qyLmDiPP6fAXSo5i02nHQRZ1H3Rx2oE/G1vhuZ2yS/QsheSgbu0kkH7rwgvHvBwpF7ew3WzR4zagHIAp6lyHR+xuWtE2ze2BceZ30HIokWDe246/cf1q2OtWXKkFKHUFQhqciNvt98TUwwsPFhoiPnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me5MarQ+l7JDgTrv1qlC3iu4cTX1vWyuQxOytdu3Iag=;
 b=D4igsPBpG6xqTnhNGWA2KU895F2+9ufJvWC6v0myB9wJv/IlMl+eSC9q2v0fHLr5Z7jA7r4vXdxY2+FWrfRwPcPGj2QDvAxwM3prTKRuF2Sp4WKjcjNlGZmxgZSxB4H4oSXKnfQAmMulW/HC+Aun1ZZB7ve2V2fHjJtel90D6VFmT8Aweu6dzJxsV1NkvsylLy2dNG+GErlA9VUMK/EWyumk+LLXdP9hRxXNtiffL7exd4tWD21zKb/WzwKIe80TZK12m4D6Mj0FxQQzjUHANfvN91SeXm+NMQhtPUQV2RBKxm2dDa+9LlS+Js0IgrVpoBWLgA0dV7PVSMhgDaAZNg==
Received: from PH0PR03MB6250.namprd03.prod.outlook.com (2603:10b6:510:e8::15)
 by CO1PR03MB5762.namprd03.prod.outlook.com (2603:10b6:303:90::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 15:52:38 +0000
Received: from PH0PR03MB6250.namprd03.prod.outlook.com
 ([fe80::671e:f5c2:c29:f6f4]) by PH0PR03MB6250.namprd03.prod.outlook.com
 ([fe80::671e:f5c2:c29:f6f4%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:52:38 +0000
From: micah veintetres <micahonamission@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Assistance Needed
Thread-Topic: Assistance Needed
Thread-Index: AQHaLdxlylwyfhq2F0O4BQyvXurIaw==
Date: Wed, 13 Dec 2023 15:52:38 +0000
Message-ID:
 <PH0PR03MB62504F7FB7F10619D801169BBE8DA@PH0PR03MB6250.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [6j5rB+RPr2c9EVwtpK7c55sgAV4nMYt9]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6250:EE_|CO1PR03MB5762:EE_
x-ms-office365-filtering-correlation-id: 9d7c4cfe-c392-4546-d38a-08dbfbf3885e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LMIl8al11bg5B5DSTJw6MtzYonsj/68GLwGoEqCx0iPBc1V3rf9OM0ghyVtdXTqohm/Wtrpg6UyyDtfZBjLKp5pPOofxGAIFv7vhQ+Z80j2MSSVuI0rjLgHLCpYt2fArWcIqvNkxTCTcDmXJOGOz5Mo8u8aX6c+NbDXRNlep5dgXWPuGjhD0ahFaQXYBooXxbxrOIH1JyYHiLMk/uf31sa4mGRv7UCZUjdqwGB+qdYrBAumX5eaVXIkaUOVConhrE86DYEV0iM7MKVO05EP2vMjACc0suDjYvTEIkvWReJUNQ0c8FMVY27p4qdQlG7RepwZ0LNPu3acbSAiyqK3YqJU+L1LL0HbePngFLjBtJMxee1rUKrrnUeBYPZi3kWRYTy6v9eqA7qjczC7krqpXMYNxTbNDhYC1wVo7AyCrGnWzexW2NCDzPbsQDoaRTrEFPuWEZF1B3XyCuuS7DT4/CbJoXGad+RaHH6FGpw6p/ENC9sbOXTfijWrOPJPhxNliy9LDWAbNm83CnIALncl//g+mgt44/U2k9KubvdFLq8yrYa0nX7rwF7aLh4z0DIUyu66WgmIh8yIMmMuSgpI7AKfp/6pJoyBQAzdS2UfyZzc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3rRqDgEfe3zjm8KmaFRVCiYOOp/oUMAyYnfsOI0Ymw0yQYmv3a65kHEC7S?=
 =?iso-8859-1?Q?4WwBj8nW2J6RZd4oPMdWCjjRpgkXfCDp0DhKVaEweqdSsdM6BsxB1lNIOB?=
 =?iso-8859-1?Q?cTYwmVFlIee5IH49KUs6i+sP1r2uBLiTJHyBxaQFYOFIO7RIXzQG2ygLK3?=
 =?iso-8859-1?Q?eKOUrV6+C9lali8lEgKmXH34YR7Mm/ztw/RVOhxo1YkgDaZpX8Z4JjoXNf?=
 =?iso-8859-1?Q?MeHvEIYa9l3hQ5Qj5WijXZiDsqM2a9cb37T8pp6bGNhqrTjwLwKvfKwvY2?=
 =?iso-8859-1?Q?IxBRx9LeUDCa6Ezqytg0J6AkyaEgP4Jqjxal6zu8BYguI95rdLHakJjNMY?=
 =?iso-8859-1?Q?Y8giOPe/jv19+70f5Lxj/XuRU75wHv8DQGJcEzhUwYjehQw71K0koZDVTF?=
 =?iso-8859-1?Q?Adn+1fOsW0rDT33y+jmEdDX1woAFs06fDythbY+wngoYG2+kHsKMbfvnyA?=
 =?iso-8859-1?Q?4k7GkSnRSB0MYvFwgckXpIL5sAGsn1GTZSfa0LXraVf1q8p8S0yfqP3HJ1?=
 =?iso-8859-1?Q?1XaZ+t/qMiYrK5Z3AZzyqUKx2wJgYT1g79ON43kkcD2pBXGBAI9v8AzD5K?=
 =?iso-8859-1?Q?mH4m8Kf6pQzm9WmC4Zvz3wDnBLYeT5nCNKO+1stqegCY5APHUNPi8M5+vO?=
 =?iso-8859-1?Q?dz8Eg348XARbODNyFjjRZ/NJZ+5oRoUKI4iDxDKhYmTFM+s90j5BVxTheC?=
 =?iso-8859-1?Q?htBPTbhEwzTVhW/9xeQMzlbZzFKtTotASjfBpUeW/uSWWObdLyiGUoVRjV?=
 =?iso-8859-1?Q?BUyD5y6tY2YMAQEJfWmiEy8uuxEJD2DGTo9nC28fGbyMJOruvv3cwQ8Hne?=
 =?iso-8859-1?Q?PSIRdS1SK+cqIwDWwF2OM0PKWzeCGdGuJrFNDRPGPMVNEFH9mjFVAgtVSZ?=
 =?iso-8859-1?Q?UGVXwZcSJvbtnmWhOV/v+EnSg/5yE1+h6XW1AXPPS28puShwA5ZAOlP7Np?=
 =?iso-8859-1?Q?AtmQ2cF0hh4BLzoSlWfEBDgE92H6jY6sEyK1jKhUF8lGZqS/rCao2jj9dr?=
 =?iso-8859-1?Q?HQ/oBqjgeEDM/DwPpX5OlwKx5t477vM8dmvR5mPwJ9C1/8+HiUziyJofjt?=
 =?iso-8859-1?Q?kMmhaVIai+Skw77NivBrHKvf++o3NES5CELJhg79NpPgunxsddYwY0o3yV?=
 =?iso-8859-1?Q?Bc0CM9aaKqRczMjoEHre7qo4pnfl4FcKJBw7k0KOO/znpa2sP0Avr7ABYY?=
 =?iso-8859-1?Q?njHJ49gYafStTAwwAkgsRBWk+MIbxHybDfnZvl6TEcdC81KAZOIz6bYRof?=
 =?iso-8859-1?Q?n7pKIt+s+Q9T47OFHdNQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6250.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c4cfe-c392-4546-d38a-08dbfbf3885e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 15:52:38.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5762

I am in the middle of the worst tragedy I think man will ever see.=0A=
=0A=
The only safety I have found online is with github, who has been hit with s=
everal NSLs regarding a repository I setup documenting what the massacre of=
 my church during the height of Sunday morning worship services in April.=
=0A=
=0A=
I'm asking that everyone please clone this repository: https://github.com/m=
icahonamission/mcbcm.git=0A=
=0A=
The government has worked tirelessly to compromise my iPhone and finally st=
ole it at gunpoint, it is the second time they have stolen one.  My iPhones=
/iCloud held the only passkey to login.  So I've created a new one account =
and cloned the repository knowing they will be trying to modify it.  =0A=
=0A=
I need clones so they cannot keep this hidden.  The existing coverup operat=
ion has turned into a genocide in Kentucky.=0A=
=0A=
Please clone and fetch it often.  I'm going to pull in all of the untouched=
 wiki content into this repository later from the existing forks.=0A=
=0A=
Thank you,=0A=
-micah=0A=
=0A=
p.s. Before you consume any information about my church, the Creator asks y=
ou to pray for guidance as there is alot of information that is circulating=
 intended to confuse you or cover the matter up.  The Creator will let you =
know, He's just not intrusive, so you need to ask Him for some guidance fir=
st.  Thanks!=

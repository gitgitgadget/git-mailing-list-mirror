Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020099.outbound.protection.outlook.com [52.101.227.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0936405A
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765618; cv=fail; b=fEK4nZbkpR92aaebF9mjfzZqGLG5VT2FUJD+zOQyiRr5Q/gDizncp3g33JTBF7HHgkr88OwxKkshez094F38SJ1Ni2lm73KUInEBeP3Q0xFelLUkAX469tBSjxYmnNXWSldmXggEXTRMKl43AUaSS4cHwKZ2cHebUW7jA5R/dPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765618; c=relaxed/simple;
	bh=PbZBNl406nOhNvdFAPOwPDEVF//jI3yAA7en4npoHCo=;
	h=Message-ID:From:To:Subject:Date:Content-Type:MIME-Version; b=XRzsyJIcxozox64fgc1Vk8uskpDT+vCYeimLSjyKhVay/u+lM/c/B4Y5WLeqSnVjhHZB5N7ACGY44BAKTok3p0EHjRSVUkWovGQ6e9JH53GaCV2MLQQyLR1bikeFow6xsDKWhvKEiYYOZ5MpcfcbjpjYIr4i1lvn+/CiGiNiX+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro; spf=pass smtp.mailfrom=salesclosergrid1.pro; dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b=f/5CMucP; arc=fail smtp.client-ip=52.101.227.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b="f/5CMucP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoMFtp/G7Jcn6tGhYg69hBNdafXWGJsnM4igQkBaIPHxTgw1tlQ7zXPhpD2SD7FgwStmalLlpfk8NVioscGMddY3UWkYDCOCIiv4DC5ocnPv6s1L4GxbJSyEsjiHe/v4LvDYP3NGyaduZZv7Ff6PMTLA9AfiQNgkERqgLHKcQQJ4vVLJJ8ycfsfhWsfVJl6gh02l0IR5cBl3Z4BtYvng1AejkTOk2FCbUkdakA/QmCrKHcx/z0SjvzDxtNLTC+uvaY/iHCuYge3jPxKW9qgTCmELXHP3AID8mmuHpnjt1FyTYrOzZrJ1vk1+ODSJ6wURmiXfU/NimS9Buo40cEZXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbZBNl406nOhNvdFAPOwPDEVF//jI3yAA7en4npoHCo=;
 b=ZNR4xGURuvhaczhuwtHDO6V6Ke5Bzfcqw90gKzZh/46MMK3yNyP6alMs6SpZaCWfhoj+oLVIEScobUD1D+RY9NGdIOCHuLsgjbRO4ywYAKcKHyoGeZiakmIyEgOdZEa1p7isClFZxIgDPknC+31sPO96e+y1rB9J1yMpBHQyCMIIxk+BOUP831CmsuAk1/rAVwntDYP4TifIdzERxkeITmkO1f/eRllY3kmYnuvRe/Y3HFA1Gac7n8QYpt8ADT9la1Fu9SzbKf8N9NMdWaIgYquwvEEaL7xgeAu1/f6HDcqGsBY3TMTT3bbwiV4nHtq/WVhZpAUYQMwMb5BhmYJ45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=salesclosergrid1.pro; dmarc=pass action=none
 header.from=salesclosergrid1.pro; dkim=pass header.d=salesclosergrid1.pro;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salesclosergrid1.pro;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbZBNl406nOhNvdFAPOwPDEVF//jI3yAA7en4npoHCo=;
 b=f/5CMucPQqNdgyE94TctmLU26RHcx0tZc3D2gzMIrMxyYrQxOqUZAvdXb+HwY3NqsSQ5UE1R/Kj3kVXTMN+bHaWr0yjeNrawV/LRvnxRXcmvY+KiIvUdgA+KURcXPgFftHvkpmwE0gaXU1RU/2LEn+PbvMpPNwyfkP+aHqUD2BgT8GRh9nPVedOFgVuwrDOl4Rjkd3ii02RSrhafxOA7Hiv0FN6XB4VfgU7VZb8bpZrqQtQ4qLOmhrVwe+O1Z3bKobDCZdLNr1DffzUSs/hahnlsvdv0tFXn5LE1jMdYT/I+eiBuad0UAWuQAEpaAB5Q5npjHIkE/+G+u1jUJejcOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=salesclosergrid1.pro;
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:121::12)
 by PNWPR01MB13921.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:33c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 17:33:28 +0000
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c]) by PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 17:33:28 +0000
Message-ID: <01a03f22-3d29-7ecb-bdaf-35e59cebf4de@salesclosergrid1.pro>
From: Samantha Richardson <s.richardson@salesclosergrid1.pro>
To: git@vger.kernel.org
Subject: Git SCM sales
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:33:23 +0000
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN9PR03CA0463.namprd03.prod.outlook.com
 (2603:10b6:408:139::18) To PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:121::12)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB8812:EE_|PNWPR01MB13921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4055f089-e1fd-4fb0-669d-08df03982399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	qEp0el+4bkImAw8frzYTDbKQHCk3ebpykGZUUtm6A0Je7gb6euJwrjVFLDiN9xI8rFI0NUk+JTtgtP3Fb0t9ylR7unJzzvCcIMUkp+fVVOAU0dF0igu7rIUjavD3ICFc54kJyzUb65tCmzcyJbEYo0cljxDXegieYgBeV1F0IqSfGGKrhFVi158NzKDXmLFEw99SWJu2j6EDD8Jr4ovKpOdkayK0/PJGLhJuDJiasthkSI8cxE2CMBNjgozq1ZDl1J7717XSi2HHopk9r//8ftG3WeTRKvF9J2pj/Tfm4Kn1UtQMpzkw2QkI2035lXY2AAGuSXjYicTK83cyrRD4Fo1WQ72tiU8ahhlTOiQxl5niZHvnY9mZM5pKEvLFm13vAb/x+VS9qBY4KlFeS7t9E61E1UfgOqQz4liRj7WwIM/FPNxUMxV9rQRLufiFbMlos/E2KfObCcphC+RFOKZKetW+tGwUvahJhkc0A4KPiLJ23yB/GUZo/Mcc+Mbaik/YkCnz2K33Wvi/wfZzR35qVL0H+B/EkowFLV3zAJ3qB+VVAQY5d/XfW9lV7KElo7bCSnLHEAaUVvDyA7Mv/S3nTuCGEZpduU6nMjvBleADoJlGAVYuvEkJoeb5uJ5T9wdhi5qH8wkmC1SX5r9QznYZU9pSX+bCUaDNBPCpVWm5LGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0p6Z1orMk1BcExlTTVNVXZUY3ZSbFRxaXJNK3pUS0tsa3QvSnk3M3phSUh3?=
 =?utf-8?B?d0Fadml2NE5hTS80RFU5Z2dqeitzeGcvMkxISzdPUm9Zbk9pdmRuZEJ0Y1RG?=
 =?utf-8?B?Y2g1M005Qk5MemxTVTIyNnRnVjlJd2JiSHI0VVN0K1J3Z2ErMXRyekZwRDRF?=
 =?utf-8?B?emRtYVZRQkVYenBQSTEvL1FzV3FpMjh1SElBVEdYYUpPcElQYnVRWkkxTkRJ?=
 =?utf-8?B?L0xidTZMdDdPb3o5N20yWDZNNTR3WjIydFpIMVhGNHdlQnI2VGdQV0UrT2Y0?=
 =?utf-8?B?RlJQK3M5NTBUSUdXeC9ETWswNlcxSjhBMGhIdFFET1BwTUlJQU9UR1lNdE9l?=
 =?utf-8?B?VUtiV3FMQkViYmR5OUhEQkZXNFRFb1lmUVllTHRwaUd2a0IwSXJZVkpiYVpZ?=
 =?utf-8?B?ZWJsSXViYzFVdWpqVXBIUlRsZ3ppTytvaXV1NHVDR1F0TGVMeWFYWnNxUFc3?=
 =?utf-8?B?ZHFySWMwN3Z5dllBYXBTdFZwdmo3c1VaMGdqaU4vSEFiazZST3B6eGtYT2lx?=
 =?utf-8?B?clVGcUN4T1pZU0o0Tjlja3FvT1J4MFBXV0RacUJ5YzBmVE1LbkhmOC8xNU5W?=
 =?utf-8?B?dTIvUXhPNUFOaER6VGMvUktrcHFOY1kwSEhvKzFPakJZK2NkK2g3aEhPZlV2?=
 =?utf-8?B?RWhQK2o0KzJsVEU0dFM2SE5LSUYxbFV4MVZaWXhEOUFoRjAyN2M1SDZXUHNJ?=
 =?utf-8?B?UC9od3NvN040UHMrQkRGa3MzbERPYVlPZlZFMG5RdGVvU0hjZVNMSVYyd1ZC?=
 =?utf-8?B?RHVDdEF5SVE0QVpZVUpmV3Ixb0plZktFMWNHYk9LSDI2dk1lejAyTi8yL3NB?=
 =?utf-8?B?WUwySlI0azhlSEp3WkR3eXBIN1pzRDdiamlLOEx4QWVmOUljM1FFQ1phYWM3?=
 =?utf-8?B?RVNXMjZjbExDTC8rL1RYUkpuUVNnL2t4SG1tT0hkV3JFZE9oNHN6d1Y2Y09y?=
 =?utf-8?B?aG10cmV2dWY0WEZ2OVNZSHFaSnVOekRVUmdER0I4ZjRlWVo4TTVHR2VaTWxT?=
 =?utf-8?B?emZzd3N1dVRCOUpSQ3UvTlRzdnhuRFRZYkpWNHZRcXBDY3d6N2FBV2JHbEds?=
 =?utf-8?B?OElMZmMzN1d1YnhXeHpsZm5oZHg0U0VaVnpqVmpBejFETUJqeEJZZStyK1pl?=
 =?utf-8?B?aXNPMkVDVDZ0K0ZsVEZOR25HOHR2T3MxQWJQMWZITTNJcTlTM3ZsZTBuL1JI?=
 =?utf-8?B?QmVVMXdXMmMxR2pKbGtTaU5hNUJGSElRZjMwWERPQ3Fzend5TjlrV1Nkd3Jm?=
 =?utf-8?B?Q2JlUjdUYjEvZkFwL0QyanJtYUo3MDYzdll5U1RKZzVTNk5tZnU1ZE1MOE5j?=
 =?utf-8?B?Ty9iTjU1TTM4dzZreXBmMVd0WmRiRVNTMkpXMncrUXVibDFrTUlZNkQweFZV?=
 =?utf-8?B?cUxZQ3pYWFdQdjVBeE1SZVhLVVhBd3ZaTmZxbzloL01ycVZtYnZvU3hHRjBo?=
 =?utf-8?B?cnQzdWVndTF2TW5rZUJOUTVtWnVuNEtrZzVxWWVtbEEzR3ZmejlmTmNBS3RM?=
 =?utf-8?B?bnBjSkgyUHVUSXRPUXhBcStESFNNTlh1S3puQllQZnFQMWVJbjJkTHRyeWty?=
 =?utf-8?B?aTViMkVXZERnOHdGajA1VFJSa2taOUJTbEdJZjFVelRSNXgwZ2l6dXZWRk1R?=
 =?utf-8?B?QncvMDhGdWo3NUxPU2Q0YS9wQUZuUm5vOW5pVTlnOGhnNHl2WWpGWjVMY2NF?=
 =?utf-8?B?M0JzU2xOaTVFU2RoOVBNL0E3YnRRazFqdDJSUDViR3NCRVhmblVud2JjeEtt?=
 =?utf-8?B?cy9EejQwQjBQd0VBeWZNRE9RN0tKVjRmNGhsUkYzQ0lqaXVQWkhBY3hsN1dy?=
 =?utf-8?B?clpKYnk4ckJBRk80bGxOWDZMWG5NSjhJTC9VaWFLQ3huNnJ4L0ZNVGZML2V6?=
 =?utf-8?B?ZUZudTk0SWttemhIS0h2SzBVVnNlWjU3K2x1THJtZ2xjQ0xIQUtYRW9YUTl2?=
 =?utf-8?B?WnNoYjFtaUxIYXdheURhZE91RkR2YVM5alpZQytkdnZwNzhzVERPbEdVd21P?=
 =?utf-8?B?T1NmTmRjWTYrVzM2NkNXUHpyNy9xSk5Tci80VVErOWNaYm82c2JUalR5dktS?=
 =?utf-8?B?MlhJTmR0QnVOL2VuWFQ0MU12QWlBMW5yWEoycGJsM0ZnMi8yc3pnTnB0U3pu?=
 =?utf-8?B?cTNnNmtZSVpMeVIvRDBNRDd3Mm1Sb1hlMkZsZUpmZTY1UUYvRit0VzQrYVZl?=
 =?utf-8?B?MGpSTjdmRnlOcCtjdHhYSzJ6ZnlLeFdXb1ZjTjIwR1ZLUXJNazlrdlo2OGRE?=
 =?utf-8?B?cDBjMUREd0FnV0N2anJmbUxhamdXTlJ6d2EvbWZZUDZmVmROdzFDeTFBd2Ny?=
 =?utf-8?B?OFM5VUlmenNRaXY3M25NWXFzTEk1dXlkOExwRlFpWEdkU3FsaEQ5OEdiOVhE?=
 =?utf-8?Q?wJjvTzpv3aEyf3PA71FLhGWUuhoQMOhKl+QFg?=
X-OriginatorOrg: salesclosergrid1.pro
X-MS-Exchange-CrossTenant-Network-Message-Id: 4055f089-e1fd-4fb0-669d-08df03982399
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 17:33:28.0096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c0dce5ca-9947-448c-9bfb-4807cc7e2072
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zooJQVvM9yijvcMcksC9PXPUYzhxv6IfFbuy74Pj8isf7qSA7HHXXNI76OYdcS9U/PJzZXoK7sSm6U5iUMa14/XsDlYTRQ62vRcgctQKpcnEBE9UFx3hQaV+5oheRUhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNWPR01MB13921

Hi,

I work at SalesCloser, and we help open source developer communities talk o=
nly to pre-qualified, ready-to-buy prospects.

Git SCM Git supports projects from small to very large, with the Pro Git bo=
ok and broad community resources.

SalesCloser books 40% more appointments by qualifying every inquiry, so you=
r team meets only serious prospects.

Do you have 10 minutes to see how it works?


Samantha

P.S. Fine to pass if not a fit.

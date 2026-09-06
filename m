Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020106.outbound.protection.outlook.com [52.101.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCDD3168EE
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695319; cv=fail; b=ZK5LdRssAvz2LM93uIHhJBNSNdNF7lQmu7lcyDDvIuZaoTdZdgzDyWe0EES8N80i4DP+TDeZQViGe6d9PlCBKlSy7kFjGbgJclumSnuduJLy+x+LsFlLD+uChC60BVZfbpPt9GoSrMf0lTKB6nUJtSDMNj42GCS5wjNVGP7ja3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695319; c=relaxed/simple;
	bh=FGPVgzQbq257btzeYrzX7oWJEiCXqx1lwzKjkmXPaLs=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 Content-Type:MIME-Version; b=h4P4WO9OsoWmDjwdBKNZcjwjDqUk0+5xyqPr4z1WNQtkHprjnuXKH8OMfzdXv+hgVNjVhr+yBpjsK+X513myORLSIvq+7RN36vekjbB0Fgf4XZHRhS2gppylETeXre0xP+PIiAVq+JQWv7OFPGBZVhYPDS4EphHgvDpExGE/dWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro; spf=pass smtp.mailfrom=salesclosergrid1.pro; dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b=dHbozFxm; arc=fail smtp.client-ip=52.101.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b="dHbozFxm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AI2kRwT6o4Z+iAaMwV4tbSmjRDvp4iHodRNG5foKm6t9/kC8zOwAv1fCLnGMVm5aLQuKlFcwZHAsObj8zxwGU05obF/U42PTafY5gDcMGSt+ULzK+hnVobKLv+gkMDoLelqcpzhu+LknPdUJ9fHM3IcsAaOpgaorJjlVEIYEqLL9AXXtSBH+1DuL4h3tkDFbqh7x5yPlUM9IU6JDOvHps+KJ4QozRP4NbAf5/wii0/MnG51UruSOwHWmBgEL9Oz9IbJ/Ni5LjDGSbDvHNCwZODF1sclHxMYbV+mWA0bVtKsPPGeuSTJZmACncWMmW8Yfn47t0jPvaU/ShN7Sfhngtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGPVgzQbq257btzeYrzX7oWJEiCXqx1lwzKjkmXPaLs=;
 b=YPyGcbF0PqM3edsjQ4XuMs6YuZLW/BQXsTm2q8kOjR4L6b+eevD4KUahNa7QBwlI3NBJaXF/MMNisuoZBOHLy4zCEjjMDnveNiIYJi7gzaz1WnjEOdx73PV4qhw72k87eFaXWamwXmj56Huaop4gNX3lNOBtLYGQs2QTBDTSWzOhErW/TIsqnw3FEnQVplaJXI+5EjsZWJ2ig7I0Mvfmn24sIdYfehrdBeKFdCXZ6PMFHMNmU2gi26eIZrBDHneuXawyMI1ykkFe3wcozEarPShJP8nnKveee9lzlhtHB9cnOAJNPWiXATsVLehAiJekct+FUOJELU+YWLR4M8zZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=salesclosergrid1.pro; dmarc=pass action=none
 header.from=salesclosergrid1.pro; dkim=pass header.d=salesclosergrid1.pro;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salesclosergrid1.pro;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGPVgzQbq257btzeYrzX7oWJEiCXqx1lwzKjkmXPaLs=;
 b=dHbozFxmzk0aBoNiQ5noivCDJU8Nyc3PvI+IjKJFVXQvaAQ0pe9o5oTSHR69PIOZwwkY8E8js4Iwjqy9wQYT8h+Melwj1Qn1qVbzUH4hWkSketrQ8rl+8SOWgDaj86ziEH265rX2n4MwqyUlfnPL0ErcA8rOGLPGPEzXh+UHe4GaMz8QPmNuxFmEhcH+2din1XN4Ggbxq/z4jm5kHRv6WRweeA7orf7J8YuJ+qblqznk/7M20seQxN0Rvi7GWhXTYnN/fhxcLFrZ2CrQQM5LPkFmD3lbT9ZMCtaXsoK9LSGwFKZmoEk7MFy8T0vr8UejCM8HFoACuqpYr5N6PljU6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=salesclosergrid1.pro;
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:121::12)
 by PN0PR01MB9624.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Sun, 6 Sep 2026
 11:48:33 +0000
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c]) by PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c%6]) with mapi id 15.21.0406.005; Sun, 6 Sep 2026
 11:48:33 +0000
Message-ID: <01a0768c-6e0d-7919-91a6-e67d9456d82b@salesclosergrid1.pro>
In-Reply-To: <01a061f1-1f76-727b-b24f-bf1ddf237e9c@salesclosergrid1.pro>
References: <01a061f1-1f76-727b-b24f-bf1ddf237e9c@salesclosergrid1.pro>
From: Samantha Richardson <s.richardson@salesclosergrid1.pro>
To: git@vger.kernel.org
Subject: Re: Git SCM sales
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 11:48:29 +0000
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BLAPR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:208:32a::8) To PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:121::12)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB8812:EE_|PN0PR01MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3e1ee9-0685-464b-7fe1-08df0c0cc724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iCPb86hvmZn2aQCeu26TbixOMQPdDsNaH5W5ojNP7k6VMJA7YogOC7q6XsDYc+0ji5VbemhS543oHUR+bQdx6Y+s6l49jh/wsqTOJc6Parzukr2My9GxrPqOBzz5VRfsDVyQ41tRqeeMLYGrTMzsb6bgHzIAVVIpv/NdqrNxigQWUX640m/q0OOCRC7Rt+IvGTMsCbmAHK1C9nPe1UVUCnyJ8ibM0f5Pss5/FwhnkLw4/1AWm88L3xI2m0n9szpajZSOxPSwMdYBGiuHsYCZSx29DMDyihpiUlY3zWzyKK1xaaOfpBNWeqsHtP1MvcWC2mYuwVp2jSGk8YJzDg8BPJAV/7Ftc8Oho7hMwcBA+SNULlJs4moQ7g9Oux2XbjEpESP7HGFVon7T3Xn6wuO4RkfmT2ZZGhfI3d1lS1glET4E+ui4DqU/Tft/HvKyMMYTTanaHUmz8/IKAnpoVGxcUJFgHJhRh2dwTkFu/O1PeHF7GZWrjvg8euO8TkkE4aRgN8iGLNxyNW2ioZxSe+rQUaJ5zEyswGdxF9ZdQYGjWbgGAsOgLZ5uqbSa/dMcVVzCzE2Gi8l3JlQ0MUvHYX5k3ChZnZYrmNHNJ9ECA2g8SXYhYa+0J9NHzTsGbF+1Pdav4DG9vMkwysqxNU4RjGc4O9J4VowXmmgMm+hnRjroS9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTYwdkdWYk9aSEdwKzhsNERsa2hlRzVleWtjeW85ckRkREVlSjI4S0tUeEVL?=
 =?utf-8?B?SUVvRFRPMytPRkFuTTFoUjhyNGk5Rnh3TGtEdjBhU25IZDM2dkZ2czlqSjRI?=
 =?utf-8?B?d2d2cUZHa1RDeE1Qa1c5YkVtT21odUhFSDlHS0g1ZGV4WHFJNnJaMzE4NlNF?=
 =?utf-8?B?bkM2VGZ2QktiVzZ6UTlrb0RLSnl1eE12clBNY25JanpvbWxleXlKWVAxUWFo?=
 =?utf-8?B?cEQzUnc3Qkl3OGdVc1hKVk5jakh3Ky9ack9LelJkekk1UUliS3ZhZ2ZEZ0RV?=
 =?utf-8?B?MTdUaXdiT25hdWI5Q25SVU41SzlkNERpYldwUHdFNU9JNkRPaDlDVldFeGtm?=
 =?utf-8?B?QWl1VmxBZFY5UXgwbTU5d1UraHNlTms1QlV4ZmZHalVQV3Jxa0hVbURaaTl6?=
 =?utf-8?B?bWxxQm9sQWNzNmNycWFybVFlRU1MTlhJSS9VTGFjbkZSOGx2WkJaZGVJUVRE?=
 =?utf-8?B?SlltYlJzc3ltRVRXNlRIc2NnZjZNY2tGdnpiblNtdTNUQzQzODFyOXdxUFRS?=
 =?utf-8?B?dEZjcExLZDJDdVdLaVpKNG5JRXBpNnhTWTJoUDhiZ09yZ1laQTZiQlZjb0xT?=
 =?utf-8?B?bm1hTndneU5NM2k2K0x4dzB2YTZ1aDJjWCtDVWU4T0VXLzMxeXZzOEZ3UFBy?=
 =?utf-8?B?aHFiU3NOQmVLVEttOHZZZnQ0elFXcnZseVFLcjRUMEVoT21KSnZ6MG0rMGdY?=
 =?utf-8?B?VGQ0KzZ4anRSZ1EzUktBRnR6TURwRC9qZ09nVnF3K2xjVDF1MmpJeU9rUkJo?=
 =?utf-8?B?bHRxMmVPU01YVEJSZitMY3ZOZGg3UFRmQkxFRGdQQzZ4OUpGVUptTGI4cUkx?=
 =?utf-8?B?MDc2Z3NYMnBBR0N5SkQ5cnhxWlFTRFpzYVhZV2JiNnlTRS9kc0FIU05xM3ds?=
 =?utf-8?B?VjZwemwrdmVtWnI4R3JoWTFKMWt6UWFiTEdIbnErN0lUZHJvOHkzcU84T1VU?=
 =?utf-8?B?TG14dXRpbnlvLzhrb0JGRmhIVE5zajd1cERhbmVHaEZqbFVWdnFIKzRWcjda?=
 =?utf-8?B?blhPNVBtWHo5aXZ4aVdWUXFOeC8yNDE1T1VWNTBiK29tRGJiUVdzeXBtV0ZI?=
 =?utf-8?B?N1hFZkJGY3pPVndSeEJKWXI1UDBaMVRCem9MVWZON1dnMFpqdzN0ci9HOHox?=
 =?utf-8?B?S1JWa2Z2cVRqcE0xOHJwbFZqSXJiSUVqVXFnYkZaMzVzUlVQTTIwUUdnOFAr?=
 =?utf-8?B?Q2Jod0RpWUNPOFA3V1QvVzVDd0VzU2ZzZGo1OUtMQ2RRcGxiK3crNEtaVEpr?=
 =?utf-8?B?TFgrT0diMEZQNlB6cUM5RkNaekdPUHFPK1VXUWt0SVhIYVQ0N2FkYVowUUFW?=
 =?utf-8?B?S0FHS3ljL3dsOFIrdHpneGhyTXhDS2JXcFlRWkJmTFZWY3ZFWXBSeTlGazlG?=
 =?utf-8?B?TGw1cVVxNjl5Y0ZaOVRnRndxTnU2MGRrLy9tVnRGQWJzSTFUcDhvVDl2TTdj?=
 =?utf-8?B?V0xXQnZyN1N5VkxWVDRnNWduT1loREJkWXJxQ3RXTlVYR0pJUW8yblJmRE9F?=
 =?utf-8?B?R0htSU5CbksrZHZrWmZrUVc3RHVCMXVwNk9XbldWSTMyanlJR0F2enhHY1Zy?=
 =?utf-8?B?SmxmMitjQ0FBR0NCSW1jVHF6ZndPSkR1MHFHZ0hkODF5dGdDQVFkdkdKT2ZM?=
 =?utf-8?B?QW8xQXJuSTFucG9GU012V3ZZbHZMZitmdkxDaGlZcFlaQnMzYnU5LzV1RWVY?=
 =?utf-8?B?TWVQM1lmM2RLVGF3cG12U3BGUGlVRDM5dEpRaFgxc3VVTit5UXVHU0tzU1V3?=
 =?utf-8?B?OHYxR3dqemZsaTg3Mm8wZ0FxbVc1VFM4SzNsMThSZEJvTFFLT21EZlNjQWFV?=
 =?utf-8?B?OFBMWjZuMW5LakhLQTREL2J1dXQ0eFZGaUlBSkZpT0tIWisya1V1amtETW9t?=
 =?utf-8?B?QXA1N2pJb1NhMVV1U3dYTnQyWHpQV1Mva05LN29oL2FXR00yWEJIZnM5Z3E2?=
 =?utf-8?B?L1VOaWJ6elh0akhTT2MvMWNucjVkSXZnVHIwTzFmK0syK2Z4bmFQVWNaZUtW?=
 =?utf-8?B?TmpZSmg1TTFuMWRvR2hDbTkzL3IwdnlWemJlMHZlMUwwRUpUNE4vN3dZZ0dY?=
 =?utf-8?B?dzREYjdCdU9EcVFmNVJlT0ZzeXhvQzZSWUZLTFpoaFE5YllmWTF0R1ZZeGFk?=
 =?utf-8?B?anYybmcvUERuSVZzK3pGQnpUNGNETXpGMi9NS1ZuSU1xY0dITE5aRVBvdHgy?=
 =?utf-8?B?U1NmeFdzdlp3YlpBaThkZHpTMmVPYWQ5d2JRakIzVDFQTjlZYUJ1dERBczJR?=
 =?utf-8?B?eEpRWE81SEpVcU9YQkpYanB2VmVTT3J5S0ZSOWk0MVJGSURabmx1cUZvUGZt?=
 =?utf-8?B?WUt1YnhvTGdWY2svWlN4L2cvai9sTFluUjN3RUc4czBWRUJGNTZIZ2JPUkk1?=
 =?utf-8?Q?NkX3FlqJByXxW0SPR8N0T4kk49ngrGaoNeIKf?=
X-OriginatorOrg: salesclosergrid1.pro
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3e1ee9-0685-464b-7fe1-08df0c0cc724
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 11:48:33.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c0dce5ca-9947-448c-9bfb-4807cc7e2072
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EU9lVaxC4ye4aCJs48MqBlYs30vvFEffgj8py+t1HsbKMmJ9So4HQClyFKtjU7j0jyp9RFrcOSxRieegq+dk6STcUKZSJDEHodwlU+1MXnZanikeSbRUct9qIvHDKbX6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9624

Last note.

A contributor may seek help through another hosting community, especially w=
hen a new inquiry is comparing providers. SalesCloser keeps that conversati=
on with Git SCM instead of letting it disappear. Is this worth revisiting?

On Wed, September 2, 2026 11:46 AM, Samantha Richardson <s.richardson@sales=
closergrid1.pro>
[s.richardson@salesclosergrid1.pro]> wrote:

> Another angle.
>=20
> Maintainers can lose time sorting genuine issues from routine questions a=
t Git SCM. SalesCloser can handle the initial questions while your speciali=
sts stay focused. Would a short walkthrough fit your schedule?
> On Sun, August 30, 2026 12:39 PM, Samantha Richardson <s.richardson@sales=
closergrid1.pro>
> [s.richardson@salesclosergrid1.pro]> wrote:
>=20
> > One more thought.
> >=20
> > When someone asks about the pro git book at Git SCM, the first helpful =
reply can decide who gets the conversation. A contributor may seek help thr=
ough another hosting community?
> > On Fri, August 28, 2026 12:58 PM, Samantha Richardson <s.richardson@sal=
esclosergrid1.pro>
> > [s.richardson@salesclosergrid1.pro]> wrote:
> >=20
> > > Worth exploring?
> > > On Wed, August 26, 2026 5:33 PM, Samantha Richardson <s.richardson@sa=
lesclosergrid1.pro>
> > > [s.richardson@salesclosergrid1.pro]> wrote:
> > >=20
> > > > Hi,
> > > >=20
> > > > I work at SalesCloser, and we help open source developer communitie=
s talk only to pre-qualified, ready-to-buy prospects.
> > > >=20
> > > > Git SCM Git supports projects from small to very large, with the Pr=
o Git book and broad community resources.
> > > >=20
> > > > SalesCloser books 40% more appointments by qualifying every inquiry=
, so your team meets only serious prospects.
> > > >=20
> > > > Do you have 10 minutes to see how it works?
> > > >=20
> > > >=20
> > > > Samantha
> > > >=20
> > > > P.S. Fine to pass if not a fit.
> > > >

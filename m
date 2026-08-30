Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021126.outbound.protection.outlook.com [40.107.51.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E428686
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788093565; cv=fail; b=PLZ0b9DUCcPTo73O++tCOF/QagDcGVS3jwM7WIO5ig3MnRHxK4oapSTzUniXT/R9Hrnkyk4zlG+KIzRLcPbRDCqazUqFfF8WwkboAFFip2gfNJPmBxALayJQob7HckHrZskpHrKRK9i0grLtTpnFPt55p03n0Nkt9GoTu5+mKnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788093565; c=relaxed/simple;
	bh=wEHIXT7Wy2Pb7RXEV5E5HG/Vxr2hLFw5SNux0xhxSj8=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 Content-Type:MIME-Version; b=KJcyo4yxuAX76Vzqt7BWQDUFUqPuSCNuP9JgHdAiFYsEBx4YEWlVKIXUoo94BAL3cr7uzujAFYryBMpl4wQiAPFSLa8YHyAnJljrEwJTZ0YrC8rzQHOF1C91ylm66/v5vNwTkAWeUsIPVMsuh8OR7p1BniTKNrmJOhuEI71XB30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro; spf=pass smtp.mailfrom=salesclosergrid1.pro; dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b=WqjwLfzx; arc=fail smtp.client-ip=40.107.51.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b="WqjwLfzx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E25HOZ1kjmP/nE+dfHmK1PlBTESsGMNqQnuUBf3MwsgIGm7uHImFLlshszVwERKH5QW27Rpgzbf5pN/FUTwqCWQe5YB4kngsdQHNWWrxF9trONDeSr1Q9y/i1eNXlMY/Dm6luL5hDjBIh/IM9tm21thflbqb6Khm4MqiQ+hk/hfX6SBtqsNO3cRsx2zU0P9pgbekFZMu+Qi8pADeouK9JY4mFe3VjsjuPoCnTBuDMhQf5w7UsAHBs+8dU0smDlQAt1o5Lsb/pCSoWAMrLnfRf4yIb21+9pxMZWuKC5KJXQ62Nt1ew6VXjzTAyzvYT9G6cwJ14FCuopkX8qSziYZTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEHIXT7Wy2Pb7RXEV5E5HG/Vxr2hLFw5SNux0xhxSj8=;
 b=MLEWCSpg3vSq6XUBjDtO0z7FfMxY3BMh8W1t+9qPr6vyRvuhZ/7vBCEkYgmHA94bpyDvGxxhKhcQlI0cXep70gU0Z7iHekMvEh76y4mY67TMZ/fgEM2saDdT1XdCsrHEt4tGYE+EPNCoRx+SDKPwZkcklLiw4+vp1f+UZjMFmBkkCq2G6jOrrPn5G3E7DKcgaIvUTqoO64OcGtRSP9WtqY59TVPeksT389+VUrYjInoWSYoV59elxsMDyNtk/nZO8YfKiyfQse3DZc9TXKIPPF3EOAatnAYZdVIR2DOOOEwOuMY5aI4WxW1XVbH0bB29HKcM3CAcjQpQRdCY5BWhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=salesclosergrid1.pro; dmarc=pass action=none
 header.from=salesclosergrid1.pro; dkim=pass header.d=salesclosergrid1.pro;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salesclosergrid1.pro;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEHIXT7Wy2Pb7RXEV5E5HG/Vxr2hLFw5SNux0xhxSj8=;
 b=WqjwLfzxUGXpSTmhJwU6b+6iCuugDu0sJ+lW/VXY0C9aw1fMWHYVqdFsfrlRPvxGmS4O+725rLY4HBkrsvmKYF6NfKPhiL/yLyWORCh20GkLXg3R9smz+i4VP8s0fpmBXqYY7lfHZ1LLJX3TZxjiuCydCXl+Iwkmt3R4SmwpnD+dmihR94yMOE6zOerP2VHMtcg0eRE3clkHIHyfNx/UkQddemAebRklS6uVKMm5gFZpkhFANg9gpSI439CAoXBF8lO+d9zTc6ilHbN4qrggKghqerPVReD9MZga9pkKqX/uFMTn0oydEE7/Y1o4QzNZw6pxc2vKhXJRUBP+CalzWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=salesclosergrid1.pro;
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:121::12)
 by MA5PR01MB13161.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 30 Aug
 2026 12:39:19 +0000
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c]) by PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c%6]) with mapi id 15.21.0382.007; Sun, 30 Aug 2026
 12:39:19 +0000
Message-ID: <01a052ae-6632-77a1-bc96-7d03860660ab@salesclosergrid1.pro>
In-Reply-To: <01a04873-b685-7654-a5a6-46c9020b8990@salesclosergrid1.pro>
References: <01a04873-b685-7654-a5a6-46c9020b8990@salesclosergrid1.pro>
From: Samantha Richardson <s.richardson@salesclosergrid1.pro>
To: git@vger.kernel.org
Subject: Re: Git SCM sales
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 12:39:16 +0000
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: MN2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:208:23c::23) To PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:121::12)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB8812:EE_|MA5PR01MB13161:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8924a4-19c1-414e-5c67-08df0693b623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dv1NK1i+eEgcpNaeJe29F8XTdq2wXQ6GOuegQmBWhlxKl6QxJ6kgY9gQZfDBlPGnqftJKksvo4+sU7j5yNRuk3G5enKAV6dB8r+4dUZZhezF53T9wrIpHmDES9qmGOzHIxNHTF96d/g4TjuoVcito9y+pNmQdECVp4kaXzi4qzGTYXgFiVHI8Ju+UtgvoBwgVo09YSPAJd03mgKG1MyZo+eaVYYsj4cL0jPwBFOdHdXgMb8iJqm6f51xLYpHkkl8h2Ki6wdDR4zOsr89/NrLFDH3DkHW+iNvbLG1YKXx7o9vmAA8NMj1VxZXBNTcSQDrX3RX6CrEXRrEo3NmBg5ZkKFaqslTb2aHv51reK1g6blTBeIpAFYP6mKC/H80CoNTpRpvwMLIXWE47nxi5REvlwM0+l9ly1rEr64rxy8yeo13PCeQ+SAtIZjtDTVtjOn55POcs8EPBPTcAyjl5N+0K77RVaPkasiL/w53QxE+33EH8uC/FYqTrcLmzqiQcRuBStJVj1r038RKDH6VXUfDXT2vSRAa68V2zE0g3+gWa2HiAO9UVxo55Vq788huUECg/BAauBb7c/G4saPpgZCh56KfVbF3AAYFswo2TvlsiZ41F6Gc4yWvZxXvRN+CMuoIEFBN2HFWrUBosTQwJSnPFQ2GkD26RAVshQgLEpk2mNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHpBSWdJNG5wTVpXYllSQkhHc2tEU2xWR1dlcjdRZ25FZDRlQXlvQU1XM3dz?=
 =?utf-8?B?dVI5QWsvSmZQQWRPNkkxMTgrQjJuekFrRUdvUC92eFBWdkZBKzhiVUdIZTJX?=
 =?utf-8?B?S0ZQaGZ1dFZDT0pWcnRYNWc2bXB5VnZYRVBsK3ZCTzNWdFJlZFJDOTdyalhY?=
 =?utf-8?B?d09JRGpZcmFBKzQ5Q1p1OTJ1SlQxbUZYS2ptWmtGaFlMa2JrT1pGaXc2VlJT?=
 =?utf-8?B?Q2RuVzhEZHBSOEliQjJmaEh5REpGR1FyOVFKMCt3R1hLdjI1cjlJQ0N0dEph?=
 =?utf-8?B?cEJFRHVmNko0MmliS3VydCsvUlRlcmVNSlp4OUNVWFFWdkFRR0V5UU1qUkd2?=
 =?utf-8?B?TzZSZS9GeklBSG5PMS8wZXAwQmJpUkJEUGxjYlZJUXEyakFJWGdETG43ZlhY?=
 =?utf-8?B?OVhHNVI4MXV1QmVlL2NucTFUdFVOemVKSExaV0M3VFppRkl5aXd4VmFqSS91?=
 =?utf-8?B?V1JDR0xNa3hybGx5bVNHR3dIU2JObEY2SThlZFdPVURnYUNXc0M0NVhSazk0?=
 =?utf-8?B?UHlmN3FSSXdSdWdNWXdMMXEyazFDUTVscjljUmhJSktHbHJKRHl2R2plcXFQ?=
 =?utf-8?B?dC8xS1M0WitUa2F3dDB3UFpUZitPbmJ6c2U2RUNsRW5jRjdUWUw0eGR6SDJ6?=
 =?utf-8?B?ZGdWV05FYmVwR3RyOVVkSWpYeHA0a3F2V25lOEVKYTNhWGdLblczS2NBTEZi?=
 =?utf-8?B?aGgrZHJmQzI4ajVQRVlEekFsYU9HaUZrVVZFeHBPbTFTZXNWNWM4N2ZCYi8y?=
 =?utf-8?B?MFNvZURBK0RPalRKVjMyM1N3SnE0U3M4bzh1Vkc5SVIxWENMeGp6Yjc2bGY2?=
 =?utf-8?B?TUs5S25ZcytuaG5zZzYvRnVpR3d5UkZhU2ZzOU5DUnJ1VDZLYk5ONTNuUk5w?=
 =?utf-8?B?dTlIYmZoTmpRS3pHUDN6RFBoUmQ5TnN2d0pZYmZHMzUzbUZKRVZ0QnNxcVdZ?=
 =?utf-8?B?OEJuT3hyYW1SamZ3ZVhHdEJJNHk0M0VXeWZYeG9hNWd3UUVPSG8yMW9VRFJC?=
 =?utf-8?B?bUNHNVNYNzlzak5KQnpKRnVrRC9Vdnpnc1VrUHZxV3BoTXNtM2ZFYWtBbHJk?=
 =?utf-8?B?NHMzbk0zSFM1TVlVRkU1TkZvVVl4dzZERC9iQlBMdE81ODRCYUxvOGVEd2ly?=
 =?utf-8?B?R2xCcVEzZXIxZDFVdkN1UFEwdkk3bnlraXRYbVg0RVJYZWpwbGNSd0d4MmJX?=
 =?utf-8?B?SUQwSHdBS2d2UlZIRGRlK25pQ3pCTmpkRlF0VDhNKzVuT0dMaGRuakl5bWV2?=
 =?utf-8?B?YjRDNjdBUmk4Z2lrdmR0a1JyWmN6NmJRY1FRYXZUQ202RkJrUy9IbUdjK3ZC?=
 =?utf-8?B?OGpVOFllbUNQeWVNSzRkY0RBOFhSOFc0NS9KQTFTVWlWNUlIcUJ0aUJwak1q?=
 =?utf-8?B?bk80czJmeHUxUHgzRTJMRlRJT3M4QnRVbjNqby9hS1dVL2pDWmZ0UG5kMUFw?=
 =?utf-8?B?U1huV1YyRDJMNnBmSVFlRlRiVnZuRzFvZCsyZnhUY2xQL1RzS1crbjNlL1dB?=
 =?utf-8?B?S3lweFVVcG1CSmd6L0RQTXF0Qk44RE1DM2QvSE5zV201UnpsWTZMY2pzU2Jw?=
 =?utf-8?B?cWlKR3pkZEpubDVZb1NvNGhHSXh1VlhvelltcWJvZ09BZEl2NDVWNGNUd21y?=
 =?utf-8?B?Si9HcGhBM3pSMmdmeFZkS3dFZ3FtMHFobVpEWi9pakowY3ErbU9FRzNBKzYr?=
 =?utf-8?B?ZElabnpzcjFzYWd0NlJ1VmRTZVUxaW9udVphemMvVDJ0SVU3M1BTRDB1ajhu?=
 =?utf-8?B?bEg0WlZYV3ZGUEFaZEtGQnJEWkxVZHF3bHpITnRhNU14bzZETFIrSXBOQ0tQ?=
 =?utf-8?B?eWJidzlZekZ2TEJoc0VMM1VUck81NHhLN2NzOEtYelZ2c0F2R3lGYXNUaVda?=
 =?utf-8?B?SUZHcllNNmZuRFd5aXRBVEJvd0hFM2dwNXQ4SWEwRUlYSVY5WFYzK2UwaXpB?=
 =?utf-8?B?UnlwRS9LazFxcmgxelR0b2pndGJrMHBSbkFRMitzQVlLZDBIaDVDdVB5cWc3?=
 =?utf-8?B?RmdmWncvSDhvWlhvdVdiS012TEpweXBHWWRsNlgwUFMzaWtRc09LWnRTQmtP?=
 =?utf-8?B?UEJxSC9vY283elpRWXJKSU0ybzJhcXdjTDY0VWJheHNmMTREWmMvTloxMUlx?=
 =?utf-8?B?OXd4VGRmTXJybnIzQlVEczRFT1Zma3gxUmNVcFNsYWVsSFVWRTF6Y3JBVUpy?=
 =?utf-8?B?enhTWjFJbjJERkZ0ajduUnRMZFJkc1FyMHNBdVdDVy96NGpOZDExOE4vcjBU?=
 =?utf-8?B?Z3ovQ3NUazFhM1VWTkV3NG00V3ZsOXVBMmlXYkRnVUV4M0E2U2x5R0NwRXFD?=
 =?utf-8?B?TUxIVWcwSXhVV3N5a0tBTVVqTXNSRmhTdlJKWEZHazlYU2lONW1TOGczTXJ6?=
 =?utf-8?Q?QYExfAISBiDihpkA=3D?=
X-OriginatorOrg: salesclosergrid1.pro
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8924a4-19c1-414e-5c67-08df0693b623
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 12:39:19.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c0dce5ca-9947-448c-9bfb-4807cc7e2072
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EfHPwgt2xl976jWL87YaBRnSnCHQv/5f9onwS3ka6az+h0b80hPSR/mPK+Xb1UuTItyYZTtwvSdX/EkduP9hrMr/yZCRP7+dCBlCxr/f0u30mqAmB4/+eR/8YE8dgFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB13161

One more thought.

When someone asks about the pro git book at Git SCM, the first helpful repl=
y can decide who gets the conversation. A contributor may seek help through=
 another hosting community?

On Fri, August 28, 2026 12:58 PM, Samantha Richardson <s.richardson@salescl=
osergrid1.pro>
[s.richardson@salesclosergrid1.pro]> wrote:

> Worth exploring?
> On Wed, August 26, 2026 5:33 PM, Samantha Richardson <s.richardson@salesc=
losergrid1.pro>
> [s.richardson@salesclosergrid1.pro]> wrote:
>=20
> > Hi,
> >=20
> > I work at SalesCloser, and we help open source developer communities ta=
lk only to pre-qualified, ready-to-buy prospects.
> >=20
> > Git SCM Git supports projects from small to very large, with the Pro Gi=
t book and broad community resources.
> >=20
> > SalesCloser books 40% more appointments by qualifying every inquiry, so=
 your team meets only serious prospects.
> >=20
> > Do you have 10 minutes to see how it works?
> >=20
> >=20
> > Samantha
> >=20
> > P.S. Fine to pass if not a fit.
> >

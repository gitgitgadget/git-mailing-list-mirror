Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020142.outbound.protection.outlook.com [52.101.225.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664D3DAAD2
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921948; cv=fail; b=NwTeGKXc8tOG1oEwT7hiX1eSe6IIC5QgUb7b55LooVrHSOYzbvlP8T5/+fBPDeKxHHjUvwC3Ka/3IH2QjnQje9j3MWvK+ItBAiapT7LtIlYGVPYR+VRyr55gBEr1Kkh1HHGMQvyINByl4nx5T/Nq7iFRjoA5NUrtLF1DdP3CtQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921948; c=relaxed/simple;
	bh=ECU2OQ92bQB6OM/OO21WeoWy/cUcP0bx1/RAzwFaiMg=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 Content-Type:MIME-Version; b=P+6Tj6Q+8qtEE1jrtXaqeiq2vUc/bk7pQ7VpDdyLcS14Q+Mbk9knQDAKqKlLvvZ+qJFZOFYKr637VCC/gWfnRRi3XpMkaXOU/QrFW/J1gFKNFibD7GY3ux4IFV6KJANRwjKPOG5B9qCX1Petnw6jpwAzlQME4HuStrvLNn/vl5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro; spf=pass smtp.mailfrom=salesclosergrid1.pro; dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b=ro5Bwt1L; arc=fail smtp.client-ip=52.101.225.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b="ro5Bwt1L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhKPl7nSoX+/w9Ib7WDzHHFrc6DE2wBwKSe/KGO66BEuoZ+qZnTX339Ghj2dhZpkH37V/QYSZackdEIAW2Uq4ZbVu9Imer09WFaw+k9FmByqNPMl8lbwpBDic4RIU+E25etmTcxVtUA1uELvcxj+XkZpb/EHK0zSVFCnOiRTvNPo4bKlLlLDw2+6f/kwpywyGHoq1llb02LAHDZ6bXpLH/0WMdXSR75Ik3UBdch7rOoApobBVfNqhDpkpqHfDW5jvEs3DcPpLmshMWZA6RDiPh+JHEUTkqjbjR8jOYHnvXTnEQaWUBe67ys6OJDwdl2JYcinYXNYIbZTas85XZ0xXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECU2OQ92bQB6OM/OO21WeoWy/cUcP0bx1/RAzwFaiMg=;
 b=PVPmLQtN+xOhyuSLrzMJY4A72RBqE+jTVkUHOIdkAbsYZQmvyu2z+Mw/9xRVuDifJtW9ZDEEEa08V/QdljZRRxML8j5PePexhFZCiyvnKpNzWJX63ic4RVjJmWanbkYXZ5dbguuF8Oqne/TCT1tF4kWKoUSQcOk+2px0mr/F6NVdhtWa63OfGdXuWQbBHr8VTJ8rswZ1Wn7RZbfRwvQjaIAWZGU69HEXb3c0E9kq/jArm3nQXSH2tiU2CSZQHgBc6Mul2K8FydYQ9KeeYroLpk2YznIEAo1iwr1nxo0b1Y+NH4j+xU+2A88trefxb6AddntVNhyelbbLa13GD4CPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=salesclosergrid1.pro; dmarc=pass action=none
 header.from=salesclosergrid1.pro; dkim=pass header.d=salesclosergrid1.pro;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salesclosergrid1.pro;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECU2OQ92bQB6OM/OO21WeoWy/cUcP0bx1/RAzwFaiMg=;
 b=ro5Bwt1LQI47TeBTKTYltiXuq5Co/PXw5S6m3P1ujLwH/zIs+lVZ5MpALOMrzWfKnKVRQ8VwZ16HRjJWEqZnkJhkG3u5AUjyZqm+y3QAjIv5kacQuaV/U8b21igGCmBnAdLyxE5kkNFr6z03kkb60SO7s21GnoETbEakX/SvPc3cEy8p8rME0Eb17pQfNTPrdtFW6bAgc45Go93qF9TDkT1CUs/Gmsw3RBxeHQKOKOhTxumdTwfyWZc4PkTQlnhP0CnoIB2pJ6KdE3pF36mkNhZknnWuN9lQDDqdbDSwfofoDGBsqLt5PujC0WqL6oBdY0emysD8ISKiRVvGHUX3xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=salesclosergrid1.pro;
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:121::12)
 by MAUPR01MB12319.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Fri, 28 Aug
 2026 12:59:02 +0000
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c]) by PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c%6]) with mapi id 15.21.0382.007; Fri, 28 Aug 2026
 12:59:01 +0000
Message-ID: <01a04873-b685-7654-a5a6-46c9020b8990@salesclosergrid1.pro>
In-Reply-To: <01a03f22-3d29-7ecb-bdaf-35e59cebf4de@salesclosergrid1.pro>
References: <01a03f22-3d29-7ecb-bdaf-35e59cebf4de@salesclosergrid1.pro>
From: Samantha Richardson <s.richardson@salesclosergrid1.pro>
To: git@vger.kernel.org
Subject: Re: Git SCM sales
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:58:58 +0000
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BLAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:32d::10) To PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:121::12)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB8812:EE_|MAUPR01MB12319:EE_
X-MS-Office365-Filtering-Correlation-Id: b645fd7f-4533-4557-8b98-08df050421ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kuWH5r06BUHVnoababK+rCzVWzyzVae+B7W0ZarNL2RLzYoM/PGnS9ojEHu1WbkUQyKkL6Akg0CaBSNrDPHOuiYs4KH//UQt90MiLzgqvcCmjL3qH61GUI3yU7kpzsyErgAQ0DXvVpEBhiu4/xLLZXdo39Mgz+i9mUc+sYvreDdneTPNXKZJHZMtOk/+9fDPqsUHXEAHhuZWZbnBNz5wqJLDJhuKWHlprQeb+vq4MeJbzzxJXKyqiknNCy/TBHAhhgBIhX0/Y4BJH2D7kOL7O9+MA0zE9DAOdM9XcENsNrKauAyroyOTlQOPEEaBf5/lQrIF8EEzpUGI2SgQj6ubQTXnMp3kZElz5QVupZEbS729YLXsIQBar7QaNHjckFQt0MbrP02j9KfTz2ZhB0jt0ANVka+edOoVg01DN3OaSaPd4PaAwVnG1jBTIhmTxMd04Jvbv8OIgdrXzuCpNFaNH3NnXDbk0+DoRLfarnFC0q+KHkPSz2VeYnnKsifsH2HCLLPAtTcmX88m5ngfHW0qFwtZZfkE72gdeW4fhwVHgSWjfR8mQFdD7lLF+OXznPhXAUb5A8W94aIeGPHKOGynDBUYBl6xxQFjFV5+UO3PlhGoa52JeuGFlE9hPhhMx3/DG8qbRkMOPVoeY49LkXbmrdy7wdKseuSHQGAGp53C91o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0lRbjkvcCtuZGkwN1ZFU3JtWWYxYzFoVWhRa056S1d2aGFXVjRHSkFNSzZz?=
 =?utf-8?B?Y2llM3JVbC9CRWxuQmlSL3pkWHZHQTl4dk9ZTnVDamovVG4zWks2RFp2aEhl?=
 =?utf-8?B?VGE3dGowVExPV3B1MldHZU5wcU04Q3dGT2tJT2V5Z0NhTzVyMkdITk80RFBO?=
 =?utf-8?B?dVhDeWp0ditvcEQ1bkY0SzNHVEFlWWNkU1M4d2FlQklISitFZ3hQaWpFM2JU?=
 =?utf-8?B?MG5peTVseEhBMkp2ZldIR2F2ZVJBUnNwangwMVVCaVlPaThDcjBRNDhGVmNm?=
 =?utf-8?B?c0tCU0FYRjkwU05XcUN5YzJyNTJlTjhISXMvcXk5bmZZTUgrTzdNbVV0U1Y0?=
 =?utf-8?B?a0lGQkNNNkVvSnZ3NWNoZjRIMHFBOXBsYWhOenpnUGhhWmpNT0JhRXR4YjI5?=
 =?utf-8?B?YlFYR0puZ2lFOXJQaktMa3Q1ZUFzQld6cXcwTTE0cTFpcmdvdEZVVlhpa2xM?=
 =?utf-8?B?VnA0Ymc0Z1Y3S0tYMzJwWVRoanorWHlhYnJZMnY2SFdNT2kvU0JEVXVydEs3?=
 =?utf-8?B?ZVlUYk5rNTYrYlNGd25HM0tQenFieC9oZHZiV1cyQXZHcXkyMjFaeWJyNldT?=
 =?utf-8?B?dHpWWkNxQlUwWmYzMiszNnZLazcwNDAyOTVSYnZQZmFJYmdZWkR2WTk0VE9l?=
 =?utf-8?B?WTV5T25wTFdETmUrQUlhd0pBeDNrWWhTbFBkS1dPL0hxYmQ4eEVzY3dvLzE1?=
 =?utf-8?B?ZWhyQXlGczlLMEV0UmlFNTlmTjNPRFNaQkErby9mcnozV3djTFc1NkZoYVNL?=
 =?utf-8?B?emI2UEhza2hLMndveXR1N2tkNlZHQUZKbDAvZ3pMenNDQ0N3YUhHWm80UTh1?=
 =?utf-8?B?N3lPQTBzVUtNcldyVUZ2dGZjRm5jSFJHOTdCNFdBMWVVTWlVZXdISXYzT3lU?=
 =?utf-8?B?UVZsTndPV25tMTNXRTF1eFpDWDMzZTRSaFFvVVpDOW53OUF6VUp0YjBUTzF1?=
 =?utf-8?B?QTBuTzlXdms2QXlUMWlZSEcxS01CNlExeWhJaHlERUxjTUhMZEVnOTVkZ1ZV?=
 =?utf-8?B?OUZ0eW1NWUE4UnhxOVpkQTl6dWZzUFJpcmpFVVphTHhQWjhvZXdLbnk5Yjll?=
 =?utf-8?B?eElqUm5hMnNJaStoMG5DRHM2TXJCOHdkdUhWR1NWR1RJVzNiMGROSmxFRGNC?=
 =?utf-8?B?UkQzNVVLdGtQRytOeGs3YmI2R1EvcFZvSzd5UVlsTDZWNCtONnd2K092c3VL?=
 =?utf-8?B?anBTL25VbVRxUkMwb0dlVm5rVjk0Q3Rpd3VuQzB4bjlXYmhHVGlVSTdlYlBH?=
 =?utf-8?B?bGNMcVJHNnozRExjVjNGVzBxaGNreFBCaElFdjdkNkZsWmlJUXpEYmdKVWEr?=
 =?utf-8?B?aC9jeEllSTA4WFZrTTBXNklrR1FTTk9sdDVnWGRkQjV1cDU5cWg2S3ZhOGtY?=
 =?utf-8?B?anJFMDFaQzUxN3dGNXBuVlVqK1lCeldiL3lnWFcwbGg1bDJHRlJXZklucjE0?=
 =?utf-8?B?STBqaXR5TEVsWngwNzhTcDdwR0kzZjZSNkZhb3JXNWM2K2lGMHJXMC9UV2Rk?=
 =?utf-8?B?TGFKWTBKUHc1YWRHbTVzN3VtZEh3amVxdS9JNENOQUF1dWViemdOVks4NWNt?=
 =?utf-8?B?TzJLNkU1ZVBUVHFzOHlOaHJEOEJlMm90b1daR0lrV3hlZ0d0b2FLcjdhdGcx?=
 =?utf-8?B?bFQvQWU2Y3ZTdU1RT1YzcHFNcG1xcDkrZnVtMVRlNjBVU25SNWhCd1Z0RXJL?=
 =?utf-8?B?MGhCdmxaMU03TStqS000MzNxT2NSUy84eFZQZGI4bTRNL2svQjRYQUpHOXFh?=
 =?utf-8?B?azZ5UUwvcXVObU1KTVdWL2dhTzZRTUVVcEJDTGh4YUYvelIrOVdoL0NidlB3?=
 =?utf-8?B?SlQzQmhQbTI0ZWI2a1M4K1locDc0UWcxVDdqQmtWSTR3WHQ4aHZQZUM5bXBZ?=
 =?utf-8?B?VHBRVFA2SXpLcFdJMDZiUEF2WnNLMGRKSERuMks5MTM2RjlGZXVvdTdoOGZD?=
 =?utf-8?B?N3l5Y2Ztb3M5Mmx1b3NhUkI5RlJVQVYzQmNwQnNaYzRySWJDU2F4aVlzLzdV?=
 =?utf-8?B?OTYza0hITWFVbWxNaFJkb3NlN2dwT1JLMUVqRUI5OW9wVGhjblhyZlFnenBh?=
 =?utf-8?B?ODk0VW0xRUdGUW5vdHJDTUNGZExXemQzbUs3cWhBTVkzWERpTG43RGtPQWRu?=
 =?utf-8?B?OHdnemUrY2IxL1BqZ1BiOUN4RWZNNlF2T2gwalRXeG9MQTJTOFo0UnRzQzJt?=
 =?utf-8?B?SnlSRHFCTGRWck52YXRidVdRbW0zd0Zwd2ZLRHBkb2VDbFc4eTk2cjJYbDZS?=
 =?utf-8?B?bHB2WitNM0ZtNzQrY2FmYktTbWthVkZBSWFqSjd0NHhjMzU0Y0hBbjlNWUk5?=
 =?utf-8?B?NnJ1UkYvWktHbkM4eE5RbnVHNStBREpoT1lKVWRoNURSR1JESldlMThJK1E4?=
 =?utf-8?Q?ue/yxWpBvJ4JMtHpOxBeOZqtwchQgirgzPtBE?=
X-OriginatorOrg: salesclosergrid1.pro
X-MS-Exchange-CrossTenant-Network-Message-Id: b645fd7f-4533-4557-8b98-08df050421ac
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:59:01.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c0dce5ca-9947-448c-9bfb-4807cc7e2072
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVDw0Q1QdzQTAHpiEjwjJEgS10U59B0yXguI27JILBntQSFO9VUnL9iJqiHUA/c2zxaha+cjBg46yiRCjtupBbYsoilYypl9U/FZBdVlRr9XcU51qaHJiVZmhGeAmGZx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB12319

Worth exploring?

On Wed, August 26, 2026 5:33 PM, Samantha Richardson <s.richardson@salesclo=
sergrid1.pro>
[s.richardson@salesclosergrid1.pro]> wrote:

> Hi,
>=20
> I work at SalesCloser, and we help open source developer communities talk=
 only to pre-qualified, ready-to-buy prospects.
>=20
> Git SCM Git supports projects from small to very large, with the Pro Git =
book and broad community resources.
>=20
> SalesCloser books 40% more appointments by qualifying every inquiry, so y=
our team meets only serious prospects.
>=20
> Do you have 10 minutes to see how it works?
>=20
>=20
> Samantha
>=20
> P.S. Fine to pass if not a fit.
>

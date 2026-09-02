Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020114.outbound.protection.outlook.com [52.101.227.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B847607B
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349600; cv=fail; b=Pfg3KKuQaAWYTZJ+ftphM9pRuSQ3wkOpUcR3/v0Hn2oMeZy7bkoSdc+PGo9QsT7qjy/ezlbYzMkdeu9U69GoDqsnLWX/xEeYFTgwlHaA9YkH98CcGovXEqXo+4b/moUR1+hQt9yzem67ya0fNoMf/fKWsY4dRhhj2qJU9TDLNN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349600; c=relaxed/simple;
	bh=YJhwX2kYEy/kDbmjC8awdZgLaxoWigq9HvkKre7jcmo=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 Content-Type:MIME-Version; b=QeajIBSnFIxmtW4VA9pbSsIc4jrVeRdg6zgsjeA381Mn7CrHoH7sr1qzwCPqC1yzEeY5ZpKuiNACp/g++hpAtArbn+qaJnhphkMqkW+8PiHrM/AOizWMxFTmsRrs2mH6FaEPJKQi9hZRbMPqwL3i3nuIzbJqmuzRXzhQQ6DETnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro; spf=pass smtp.mailfrom=salesclosergrid1.pro; dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b=lbKJw9rB; arc=fail smtp.client-ip=52.101.227.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salesclosergrid1.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salesclosergrid1.pro header.i=@salesclosergrid1.pro header.b="lbKJw9rB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrcudYE/8sM8oARmKkNW5jdivTMpVR/qr7Jo9XDHPBdYs5mwg0L6f+OD02CYQXOtAQdqWKrSwrSwXo52Hrd7kmlZFs9xWUweAjH0T7PPfJt/lnBi5i6lQJWsAUvDUnO8k21jFzQvSX6LD6MSzfPotZkK3WyfV7uosWiXPQ82MBNNwAQ6mzx+jBIkQPpYww8Zl1MSPuEpsb2Fesj6NKPZ5f7BBkndEApPk1StYKghjZm1moDlZtHSt1BtU2BZEG/PkUXtQeHm+WkV2qQCYN1Hg9UImdJkVIGWAt+/vMn7L1TbaxHFBnYFo8hLAnRUV9E69VuEujLfn9O8YWMK3Ue9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJhwX2kYEy/kDbmjC8awdZgLaxoWigq9HvkKre7jcmo=;
 b=zXAe/t4RQiysfLzlOfh2Qv373RZfGm3E4CpCbQM5mnUEeELmUN5a6JtryQz+bVmW/QVCTzTi9l5cu8YmuucwJv4QDIB9JOnPNtYD620voeLsbqlQojSitMV4p6gpE3chmFqFp2Tjxv/PqSVoXkDW2Vt98xX7vMVwQOPc8G5GSzNoMh9qtl63XM7o51+SBLzfwSQkW3gXwydE1kfp9gGLiZOkAPxJXK/zQjKoocPjvbcSLi/eDfxlgVNe2gqSepYcwBkThGrXRZWy7xQ2n3OrHtUMdsy9Q+q4WJNs+qrI7NqgyqrCxD9vbjVAdmBrvomZsn6vgmpS0XGR3tAHh9bfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=salesclosergrid1.pro; dmarc=pass action=none
 header.from=salesclosergrid1.pro; dkim=pass header.d=salesclosergrid1.pro;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salesclosergrid1.pro;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJhwX2kYEy/kDbmjC8awdZgLaxoWigq9HvkKre7jcmo=;
 b=lbKJw9rBruNYEIVRUrTkWaVpxqMuLGIf96WHj/2YI6zhrJGEXDbT17GmRA24zKh1KJ8issHGMR1rnA2e1n46FHaG1ccXgm5+qA6LT+JYA6eo2ggz63g6uK7QZGoqIwwtC0gT+gP+nDm64FjqPsTY6X0qgR9Kztz9oAWq708bduFxdHrnsQpXipbJ8SRLQdDh0wDJvmXZZxGvqen+gFaPZpuhitfNEZlv22rchicYVdSaksxChkk8WuIZJZYz7xGhnZtacHeB6PfKp5A5p3Uoc5+Aaf2bl7J2QUR3NlQtV3pwmMNbR4tdtfIHAlzkNqSQWPY1q/oh426o8v8oINzRSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=salesclosergrid1.pro;
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:121::12)
 by PN3PPF6ED4D0A96.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 11:46:30 +0000
Received: from PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c]) by PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c063:462b:350a:2a1c%6]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 11:46:30 +0000
Message-ID: <01a061f1-1f76-727b-b24f-bf1ddf237e9c@salesclosergrid1.pro>
In-Reply-To: <01a052ae-6632-77a1-bc96-7d03860660ab@salesclosergrid1.pro>
References: <01a052ae-6632-77a1-bc96-7d03860660ab@salesclosergrid1.pro>
From: Samantha Richardson <s.richardson@salesclosergrid1.pro>
To: git@vger.kernel.org
Subject: Re: Git SCM sales
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:46:27 +0000
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BLAPR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:208:329::31) To PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:121::12)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB8812:EE_|PN3PPF6ED4D0A96:EE_
X-MS-Office365-Filtering-Correlation-Id: eca95bc5-c0dc-4393-098c-08df08e7d48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/B6Gm3TYyqanFWfdCCFFSSS6WI87Qjf0FMjKPaUQW3/Mdpt+LUnXyRfafYus7WHMY0scwDdQXvCjjBCO6UnoVlcBmuD2guxrpTvTQ4156rq4ZgL+TK1ghe3kh8FuwamX03q5yPaU+0UPjq8loA4+AxrlQgMbz4zfFUGJpQ8cK+yPsekENzg6n1WgqStvOsbS5ZmaaaSw7FTLn3Y8MxEbW6R40Yqws5jB7rLH1+lue28vOjGH6di61nrEQQ68gbZi7xYAtj4hwanzIOFfSvxrvDIuq6cxsIRvx8QeNdn2HizXoIwIj3dC4Jsa/W8SokvXPA7rwqoaoU6qiiYoPwgSRF3bf6nkxhaxmX1hVVeFXCkXm6sR/3hKgn3eMDxARjvmppaoC+CPz0hHm35tUglcMObAZKyHy7AloBK5nQtIA0tHlzxuTP1ua+OUn+OJlHdPSJc/6IqRSmuadp8gspjeYYHnNGupHByT2tzL4rrHrl1Xd4Rg5KryOVS+2mBL1JL126N5PYw+mCDq98SDl/v50/nr6ltaL+AwsOrdK1JOYwt5xEnM6n6Qe9CYi81szSyhikbX1wnPuMIho6sCMbFtg5mY0NjERXs8MCcdVSLiEJ7/XwIuo7DEP4St/byHuyj/U6QxV2muYkauXMXL+iHOvvQTGI+Or5QRtHiGdE1vUYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDNEK1l1Tk1FUzJZYlZBdHdyMjM2bkFtYjBDUzdmc0pYUTlGL0hNby9zZFdX?=
 =?utf-8?B?czVQVnRQV2gyZHZhUUpLU3VXNVNpZkJCTXpxQXN2dmEzSzRsRXlkbkwzRGNv?=
 =?utf-8?B?Y0pRWE1ldk1GSDBBdVkrT1ZOb0hEV1Z6Yk9oVzd5Y3J5YnI5a2lCS1dXa2lx?=
 =?utf-8?B?Q2I0YmRTaW1WWEUyZUxtTEhZQlQ4aUs4akwzcHl1Y2RyRVM4S2FtZUlOWXZ5?=
 =?utf-8?B?SC9JblUrSGV4VTl1QXU5bGFpWmM1WHgxNENNZlkvTmhteVpWS080cm9xTSt3?=
 =?utf-8?B?b3RXTjFYWm55NzJCb3dJc2tycG1sdXlDakhoNGxOWk5iUFZqK01XbXZPbzlD?=
 =?utf-8?B?dm9sVkJBbTF1RTVoSWZnRk83YkNCbkJQcW1YN2JERWllVTJ5THdXcmVOZS9C?=
 =?utf-8?B?cFFKMHdVYjJ4UFBnTk1OYld1UGRMSzNiSndxUmJ3OWwwcTYxY0JtNy9sdFhJ?=
 =?utf-8?B?bEZLRElNNDc1N3A5WjlMRytWVmNuZHBiZlJRT2NOY3RFNEc0ZGNJYjM0cXBU?=
 =?utf-8?B?RmQxZGx1aEZSMFR4RS9OQ0FoWXZPbkswUXlBRXE1cTNONS9VZVFYYk9pWEVw?=
 =?utf-8?B?NDZhcVcvRkRKanE2OVRSNktwVms0ZUxuS3JSQmdQVjl4QnNmYkhEMCtKU3Nm?=
 =?utf-8?B?KzdvT0NXOU1SWEJNekNBUUFWTEdDa1QrVXA5SE4xOEdqYTNxcXhtSWoxZFZ6?=
 =?utf-8?B?QU5aOW5oYkJDeExCY1pOVWZVdC9jTWFRU2g2TXgrYUdVNHhDVnltd1MwSENx?=
 =?utf-8?B?elBZdXU4STdWRGVxRjdIV2g5RUlORHFqajJNU0ZzRjV4RTNLclJLN1hrT003?=
 =?utf-8?B?dWFIUTFpanJFTmNUYTJTYzFhZUYySmFNZVNPTC9FTG13MVpIbzlsS3JqaVNm?=
 =?utf-8?B?RFI2U3FzMjhMY0ZYM1E2ZUJPRk5RZ0xPKzRPRm5tTlJzcy9YaGRxUnVhM1cv?=
 =?utf-8?B?eG5lZnR2bGxsTldubllpY0RFcFFwYVROUG1OZEpVZTNwRHhjRENBbi8zV2pK?=
 =?utf-8?B?bnV0L0tqdVR1NHFrZityN1ZRbkMySnFDT25Hbk5zOFpRMEt1c0s0aEtBOXcw?=
 =?utf-8?B?dVNMeGNLOGFuSjgxYWlzVlArL2t6UEhncWdUWGxTdW4yREtkSWJQdG9NOWVo?=
 =?utf-8?B?VVdvdEdNdXdQZ09Zdzd1cFdGUlJmNWxCQnY3dWtlb2VxSG0vUmZkMUR3TENN?=
 =?utf-8?B?TzFpaGxVRStCYlhaeHBMTzZuVy9QazB6c0pYWWQ3YmUvREZMVEFSR0o1dFRZ?=
 =?utf-8?B?ZHZYTWhtdWR4cURBWWdYaTY5RnRXYzlZb0FvZ1R2bS9OYVJQM1pDdkNaWVl5?=
 =?utf-8?B?L3I1alZVZzNZeFVpUkVsMThYSG5sNDRJRVJQUzZFWS96TzZNRHRXQVYwNTcz?=
 =?utf-8?B?Vzhwd2pzZWpIUEd0NHplR1llU1BLcDJ3WVZWbkJTZE5ZQ3FZVG9scU9FYndv?=
 =?utf-8?B?R1JuUVJmbWUwMmUyZ1V4cmNVODNOZWxUM2NOVVkzT1VYcUJtc21MUkJ6WVlT?=
 =?utf-8?B?QTNXbVNYM0JHQWs2QTZyNWhkcWxMbU5MS0JwL2p5ZmJxS0krWUJCUU9RNHk1?=
 =?utf-8?B?eldPQUVWSTY4TVJSRzN3ZFlOUDhlMUJvNmJWWWRuRCtnUTc0eEwxU2hoeGlj?=
 =?utf-8?B?UWtEa0RuQnBudEV4RUtUMTN6a2pQRkFvVXdIRWk1ZTdiWXlsVW9nSVkvZUdQ?=
 =?utf-8?B?RU5iaTJwV2NBR2dVTUw2SGJwVHZuRE1LS1JyeTYwYzZSV3RaUFhxamNQVkpS?=
 =?utf-8?B?K0svaXZPbEx1Wkk3ZDZHR1Rtb3RNVHR5QThkdFh5SDdJeHVBcFRZTmFsS0xT?=
 =?utf-8?B?NGlGQjEyWWJSazJOak9Dcm9oV1A4UENzSXJ6aEhXMXZ0R21pWUh0eitpaUYy?=
 =?utf-8?B?bnZuLzdlNVZ6MUgreE8yMk4xb0ZDY21kampNQ3VDdUpUelJNbUpacklzVHZo?=
 =?utf-8?B?eWhISzlZOVBMdE1kNTl6K3IrM1RUdnQwdkVURmRobmN5VlNwL082Z3krQkRH?=
 =?utf-8?B?QjV1RmNXbThwV2lodVYzSmhTa1owRWkzTmNoeGJyMERuRklkNXNnT2M1M2x2?=
 =?utf-8?B?ZDFkaUx4eTdmN2dDb3N1QTNIOFZob2FTYUVmeHFlbUxUK1ZaLy9pSGRRRUYv?=
 =?utf-8?B?bWUxdWRQbWM3dXdWUE5XbmtFNVdnNnRSZzcxY0pFeHRrcEtYSmtWWFdyZitm?=
 =?utf-8?B?NUVNckFOMloxWExNSm5JbDhDRms3eVNwMHNXaExQU0ZKUGE0bUp0N2ZVWm1v?=
 =?utf-8?B?eFZ6WW1HQzFxb1NLQTdHRFJ2RDliTXUzNVROYlRnMThLV0l3RkdEcVBsTkpu?=
 =?utf-8?B?bFM3RzdqTDg3ZTRoaG0yS1VldzR4cFlsbmdmRExqcE9Eb3RndWNiZVY5NHhz?=
 =?utf-8?Q?YjB5AzlG9tX3cIV2R5mKlg/D3lX8nGA03UmXz?=
X-OriginatorOrg: salesclosergrid1.pro
X-MS-Exchange-CrossTenant-Network-Message-Id: eca95bc5-c0dc-4393-098c-08df08e7d48a
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB8812.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 11:46:30.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c0dce5ca-9947-448c-9bfb-4807cc7e2072
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMGQHTp8BCnHXtt13BYgGqFcj7RnZuQ6pYSkefk/UgHAbf+EB5L46NF56uvTmH/tpD2AYiA6sGW+LrOJJGMfuU7khuGOh6SpmDiM94zY2vNaOtrubKfi+58qlVrPro4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPF6ED4D0A96

Another angle.

Maintainers can lose time sorting genuine issues from routine questions at =
Git SCM. SalesCloser can handle the initial questions while your specialist=
s stay focused. Would a short walkthrough fit your schedule?

On Sun, August 30, 2026 12:39 PM, Samantha Richardson <s.richardson@salescl=
osergrid1.pro>
[s.richardson@salesclosergrid1.pro]> wrote:

> One more thought.
>=20
> When someone asks about the pro git book at Git SCM, the first helpful re=
ply can decide who gets the conversation. A contributor may seek help throu=
gh another hosting community?
> On Fri, August 28, 2026 12:58 PM, Samantha Richardson <s.richardson@sales=
closergrid1.pro>
> [s.richardson@salesclosergrid1.pro]> wrote:
>=20
> > Worth exploring?
> > On Wed, August 26, 2026 5:33 PM, Samantha Richardson <s.richardson@sale=
sclosergrid1.pro>
> > [s.richardson@salesclosergrid1.pro]> wrote:
> >=20
> > > Hi,
> > >=20
> > > I work at SalesCloser, and we help open source developer communities =
talk only to pre-qualified, ready-to-buy prospects.
> > >=20
> > > Git SCM Git supports projects from small to very large, with the Pro =
Git book and broad community resources.
> > >=20
> > > SalesCloser books 40% more appointments by qualifying every inquiry, =
so your team meets only serious prospects.
> > >=20
> > > Do you have 10 minutes to see how it works?
> > >=20
> > >=20
> > > Samantha
> > >=20
> > > P.S. Fine to pass if not a fit.
> > >

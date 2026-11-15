Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794740592;
	b=M6uLKf2xdZjZkFdRn1N86EG73DoToUVt5krUZi/Jz8Yml1i0Qzh0mhJzbWyUiq80CHUa
	 ECiWvUi4s6/f66D2BJ9+nu2z8S48pu56oi/H6IbYMZTakfD9wz5j5Gpps3zzX8adl74dN
	 grbNG6tWZZ9BIMbT9VI/PdVK8zPnr66BCynrdXU6ABp6hX38cYib0gN6CNOZJ8uaaN25S
	 Lpd0qePpdaaV76q8HnK2q9X4zIOyfMLmvzJUWdge0JDGzKu/9ImJ8yRrihVGCmTyqnEEH
	 5JDSJHLiTw119zDSZNKKJQ0BIZ5OO8y+qpB0b02f+29y1qSGIlRyhCrf8KmOwN/yXbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794740592;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:Cc:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Sx2dCJTI7mWB9Co+hnIZ9rmIgxiZ0h6Jd28d7/0/WdU=;
	b=a4V11mARpIu9uwO847VLJtkSnePi/9UK7goE+ZUIQUPztx94mW8mdwxYmQUoNvgfQPEe
	 Gbnu/CCeJlvTeD1o9Vzj7NMpaU9wuNYvfVq63sewC6/F3P+HBDsY9nsUfjvQW7IYJ9fIk
	 7JW+iAcmwTDY0H1T61yEbfglnyTfFnSQadx7OzZAdlSo5jYwiCw/2PNqjWmyHrzs19ett
	 0EJbWvs4gM72R5PGj0iISMz/6N7rou6Sgx8eLqEyX4sh/Kd8DwXFcvkxCEiVDXAJ4aB7u
	 EJoHfIqJh/UeoqPL1YKyYiR6aFtJV6lkD1eg2q5Rf57XBnHVYLoxtDMy+Woaja1kYKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=live.nl;
	spf=pass smtp.mailfrom=live.nl;
	dkim=pass header.d=LIVE.NL header.i=@LIVE.NL header.a=rsa-sha256 header.s=selector1 header.b=YG4XthL8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.6
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010006.outbound.protection.outlook.com [52.103.33.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA47606A327
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 11:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA47606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=LIVE.NL header.i=@LIVE.NL header.a=rsa-sha256 header.s=selector1 header.b=YG4XthL8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1dOj2u+svzYe9+oo5+TJ7LrmeobOJoQnkHBQHU/yi7XnKTXZZySnK5z8iWqmHojQ8aSTLIWJyItyIxGtf8qZXfPFLwWx7SCgMBmwJSxvznySFNgHRjeaW90TpV+9bKfAdMUJw2ydlzGE6gxMRoehgk7ApNS1VIDfBWH10/bNTMG5lj6oZNj4l126euUBK85ZJBgAgPDfU4eC16CGlJJoijlx2tLtBt3Euw4+jZMk0zpDO3gOBHQsCDey8eXmlMP2/YY0XFe7moIzXGE4qQ5sup4b3b/4mJtL5Q99pITMa73YYNe1HVopFlb4ydGdZyo3/QZMf2ttRI5zzkmlvOB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx2dCJTI7mWB9Co+hnIZ9rmIgxiZ0h6Jd28d7/0/WdU=;
 b=fiHgsK9GwWcLW04gmmloh+jMeONC9rfnimCf7F6sqKFr2071ElZMrpBRXu6qVcRSjohj6hF3X1Mt8ZZwAvpTvmN/nb6/Rb0V+j9tDTV3Tox2tQSP7z63o4R0qjZfpBfze/ZzY5WNLOoArfbQ2aTXD7UPMYyHWiajCFS7tgyFtnbvTTnvQ0ph0S59hRNh69BzZ3vWKmG37cUHOZuO+fwidI7vo3Ngf+HDN+r1Q89/Qb2G3/Rs8QpWWSXESbs9i5CtKMcO6+YifEhOhz79ZFNkmB3saR/WXmFBu8xmlVll4/0WqO/fScpFDuYXuzieG7Y9Iw7VzdrXwSyNMGs58O/sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx2dCJTI7mWB9Co+hnIZ9rmIgxiZ0h6Jd28d7/0/WdU=;
 b=YG4XthL8z8+FJqC9jkju6LzifOv8SvTyFMelZs1vnYmsx7Bh4RgiExNZzJwXd5ygfeWaZxK4p2JHwhG79oUurmzTR7CIMo3NIIl4ReqoN+8LzIwNOC/QYka9oiIzR498ThyiSPG1Ls1lGD1hSM6kW19cUI/cIm4AOSKDa6Q+knnGgOizeLR+cM3QxVmXAdlFCOcol/aaF2xAMD3gv4S5aEOAd9jkjoenCzLJiJACHQDKWgzmbuBZZHDL4c/WDaPBf5nvqH4MuT4AsmnbvytgA3VqqAF8WDb95nakfYgcTCpNi3AyTiZA0c7JUK2sCukXChHeCa/HRyRo64cMx2WvnA==
Received: from GV4P192MB3287.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:2b8::11)
 by VI0P192MB509988.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:362::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 11:03:08 +0000
Received: from GV4P192MB3287.EURP192.PROD.OUTLOOK.COM
 ([fe80::7bad:f918:6386:5df3]) by GV4P192MB3287.EURP192.PROD.OUTLOOK.COM
 ([fe80::7bad:f918:6386:5df3%4]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 11:03:08 +0000
Message-ID:
 <GV4P192MB328727D81CAED2956E2C682BC07D2@GV4P192MB3287.EURP192.PROD.OUTLOOK.COM>
Date: Sun, 15 Nov 2026 12:03:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
To: "brian m. carlson" <sandals@crustytoothpaste.net>
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
 <adWTKt20ISC3qz2g@fruit.crustytoothpaste.net>
Content-Language: en-US
Cc: Matt Stark <msta@google.com>, git@vger.kernel.org, ps@pks.im,
 gitster@pobox.com, phillip.wood@dunelm.org.uk,
 Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
 Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
 philipmetzger@bluewin.ch, konstantin@linuxfoundation.org, newren@gmail.com,
 tytso@mit.edu, nico@cryptonector.com, rikingcoding@gmail.com
From: Ewout ter Hoeven <ewoutterhoeven@live.nl>
In-Reply-To: <adWTKt20ISC3qz2g@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::14) To GV4P192MB3287.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:150:2b8::11)
X-Microsoft-Original-Message-ID:
 <43a18d99-5a55-4319-87d2-39f470ba5398@live.nl>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4P192MB3287:EE_|VI0P192MB509988:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae82c0d-0ad8-4467-d75a-08df430807b1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|25010399006|24021099003|20031999006|39105399006|24071999003|37011999003|5072599009|6090799003|25031999004|15080799012|19110799012|23021999003|8060799015|1602099012|10035399007|40105399003|41105399003|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlJjamliYU85THZTckpaaVRycXlYblAxZ2xJWFdNMy85eitaVDk0WktQQVRL?=
 =?utf-8?B?S0ZzNUpiM1Zvek9zbHhPa2hSOVVpTGNIaFlua2xMN3VoR08ybVI5a3VKVjd2?=
 =?utf-8?B?OW03M2s4eWFaTjJ5Q0dUeW5yaDdQd2pJOHRJVDdabHBGMjVjSmlIQU1DeVIy?=
 =?utf-8?B?YUQ0VENkWlg5UVdqam1HYVlyK1MxOG5xemxLbCswek5SckwyWlRqWGpIWHM5?=
 =?utf-8?B?SjJwWGZ1OXFVQWhmQUdqcFpYT2ZSTXYxMkdPL3FrZ3haYTU3WkRSMmw2WTZw?=
 =?utf-8?B?S1dVRWk0VmsyVVhhVU1zRi9IWXVMZzdUM2NRUEhuKzVNcmxsSExyaG84WDlx?=
 =?utf-8?B?SGJYY211NkloMlNpNTUxaG9aTk5OSUwvdnhTSUhqYUFCZXR6azV0eE4vVE9N?=
 =?utf-8?B?OFZEU2NuUWtEUlN6TTV2YmhUcHFDVnZHSGhaSVF1K0QvTnlqT2NxOW9rNzFQ?=
 =?utf-8?B?SnFWQmxqQlNGc0drNUZla29uejNWdGlGekdUY3c0d0ZOczlIUTBrbzJVZEZ3?=
 =?utf-8?B?ZGlocEhpUmNPajY5eGZ3M2lTZ0laUVlTbTRZSmxuNnVmaVNpL0FBRFBZKzNI?=
 =?utf-8?B?anBMaTUzaTdLZHBJTnY4WWdSZHdXcXlGY3E1UkZyUHJ5MGFvVFAxcGJYVE90?=
 =?utf-8?B?YWRxTVFmS25TTTBWZ0VLMXB5Q3hYU3dxaWZyVElYY2VLNlR5M3pGbTE0OW1J?=
 =?utf-8?B?YWlKblkwUVdUNjdFUjVpbXYxVVp5NDNhZm9wYXFCaTFEUHdVdXYyT1hBQzht?=
 =?utf-8?B?U3NxUXBzeGxRcVE1MExITWxMVlJjcG1obUNrdldwSE1UQTZwL0tTME1OeWFR?=
 =?utf-8?B?YlR3cmNyblBaeGZHWGU1QXJZeXZwRFN4OG1Dbzcyb0ZXV0FiMVN2dFVFbjd3?=
 =?utf-8?B?TUVKa0UzY2xmTGI2RDJuRDI3azZKdGdGZnM2YjFndWNTaE9sMTFnZ2RKRlVM?=
 =?utf-8?B?REZ4c09qWGdUV0dsQXI5Umk5SVUrOVFzQitFcDFsSEJhL25XNjlnMVdmekkr?=
 =?utf-8?B?RDFZR3hHL1M0RHM2U0lvZEZsdHg2QVMySCtBUEF3Ym4xSE1wL0VEcTl6NkRr?=
 =?utf-8?B?RUJyK1B5YmFhZnN1S0tjalhaeFZib3o4SjRwQmkrUDZOWVAyTzloRlB0ZC9z?=
 =?utf-8?B?cmxIY2pjYXJLdUJrSVNXU3RBamlVczFReDdYaEVzOEc0YmYxcUx2U0xLR2s2?=
 =?utf-8?B?UTNqTVdEUlllcUxpSS9KcHY1cFlVVExIQ0M2WDNNc29rdDNFNXFsV2xaVVQx?=
 =?utf-8?B?c25teHVyTHF0YnIyRHNmQjRqaVpaSXFBSGhMbUQzbmZPU2w3ZVE1c0NYRUJk?=
 =?utf-8?B?aVBvTGU0WW1KMmx3c0x1RzhvdlJUVWVMaUpMRlNTUTc3NnNTUXZZb3RIMEh5?=
 =?utf-8?B?dTBFUFh1ZXQxeithY0daWEVIVFpEZFhGaUNxcTFDQjRmZ3Q1YnNPRVRtYnMy?=
 =?utf-8?B?UWNZVlgyREV4LzlIbG1BNmFndUtWRFZEend0Z0hsQkQrRC9UT1oxTmZZUVJ4?=
 =?utf-8?B?MGtPSkxSK0J3THhuM0NrT3FaNWVWZXFlWGlubmJGR0NyWW9Sb3pHd1NTQ3dE?=
 =?utf-8?Q?gI7NtMoLSLG2+6w7bodRhQNxk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTNsZ2UxbFJ4UFB4Q0RwNE5mVjVwdi9MZEdjZWlGZm5SOXRJU2dqQ0h1aVov?=
 =?utf-8?B?SnhpcEF3YWZjNExBNFhmemRMeU5hbnZVZ3dsKzJBQnR6RzNtek1BQzZsWDhj?=
 =?utf-8?B?R3AwaXUwNmxWcTByVU55cjhIS2JRTDlTNGV2bTczdktGc0JONjV6YkJWbVBL?=
 =?utf-8?B?eWFFYVMxcDV0L21EclB1Z1RkVTdFOUdZdHhxM3pmcjcwSFhGYy90dGY0SWNr?=
 =?utf-8?B?end2VlZQdlY0b0tjV0J0NVFKVGNTUXQ2TmRMcEFDcHo4MlhQYlVrL0FPQ1JG?=
 =?utf-8?B?WW1iOXptb1hGRDM2T0VWSmlYTzA3TTNxbXo1MnpZYUxvSVlyanJSa2plUUlY?=
 =?utf-8?B?dFdzS2hYek00dW5Za1N6WnR4WlVhT2R0RzNBLzdQUGtQNGdLMUJoQ3hxTWFq?=
 =?utf-8?B?Q2k1UGZ6cjBCS1BHbGV3NkxHSGVvUHNMRSt3N3NJd0Ftc3BDWTdNT0NRcEZ1?=
 =?utf-8?B?amRlNXNyWTAwQ25sNGs3b0k1MVVwMkdiYkVuTFJPWHhJeUFEYUlRNEhUNExv?=
 =?utf-8?B?OGR4TkF5WnZlN2t1c2tiYkxpMHhoUVRWOGZNUXNMQmZpSFlzYVBxanNqUnVh?=
 =?utf-8?B?WkJvWVRWbFRHYjlJTzI5Qm1GdkJYTFE5SHFXU2Y3UXR1YTl2am5zVkxqQ0Fn?=
 =?utf-8?B?WnhTWmhRejZmNm1BbDNuY0xKMFVZVktoZU5aRnRzWUU3cjNzZFF3YVlwNWJW?=
 =?utf-8?B?eC9PNmE0K1I3bm14cXM4bE1BeUh1WU9pTU5pM2Jjc1huWXc2STZFdEZBTG1X?=
 =?utf-8?B?MDNva3UySU1TNTRWNnl2Ly9kWTlab3Z0MjdyQTlhZWlMdHNScjJlWGEwMWlx?=
 =?utf-8?B?ZzIvbkNLUUkyUjcrOVgyckVWbzFvSEdQS0g0ckxqakYvblMyYUlzWDVzVUhP?=
 =?utf-8?B?UHVnTDlkRnN0NTVXN0EyM2xQQ2s5UVAvN1V5MEp2SFliTm5jMG5CdVROYm12?=
 =?utf-8?B?MXYrU0RSSlc4dzRNSTkzMW1Rd0tKQ3pJRHFEZnFna1o0L0llRVZ1WW5MK3Rv?=
 =?utf-8?B?T1ExVkhWMkprSG9kejREU1hTNUxjUFNGU0VYZ1NkN0hRU3JJa2R4Vm1wNlR1?=
 =?utf-8?B?dlFHTkx1L3dyNEtRc1hxT0puQ3pRVzJKdW9PZmh3SS9IbmsxT09lajB2TjRG?=
 =?utf-8?B?NDVTVnR5cGk0R3JsODc4dTlwU3pzUmVDRGFCZExYcXB4OEM0TUQ4Ym5tZEhH?=
 =?utf-8?B?N1RROFFnQURFMTdoSGs1dFhwWExtdTlwbllvRHltcjU4TGJYSGF5THlXckFV?=
 =?utf-8?B?SVEySDd5NXlWS2w2UENpVnN4Uk1iUGIyNDNxenZpQWo2QldoWk90eUxsd0ww?=
 =?utf-8?B?ZzFpZmZoMWdveHEzeUpFOHc3bDdzOGc1RE9PbG5DN1RIN1FMak1FWFlnVldP?=
 =?utf-8?B?Vk13V0QzOEhBTW5DVmJ2RGtyL3VQSjdNZ2FoM1UrSkpMeFl4bFkza1J2Szdo?=
 =?utf-8?B?MmVxTUlGTmJpeE5rSU5NYzZCUXJ6MDVHNTJzcGFFQkVPT3lORzIwSm9WRWRB?=
 =?utf-8?B?VS9GWVlMYnZXckdseC8xMHc4TzhCSXZxM3kyVjZ2QW1zQlVKc2hrVngxSUVD?=
 =?utf-8?B?MjVBT244eXBnZGUrNWEyNDlsdlRpSG5qMTZIVnhnUU9WRC85Nzh5MzFnUXpz?=
 =?utf-8?B?dGlvOW8rQ2ZNQXlPN0M1bnh6aU8xRE0xMUdocXFnRXdMSlBVUElSWUZheitQ?=
 =?utf-8?B?YTFmbTZQckpLSGZjYUV4OGhWeUtBUnBicjdMbjQwb3kxL2hJMUNhR3h0T0to?=
 =?utf-8?B?S1h2bzVuQWkrbDJVVHdsT0xqdGl5MkJCUGtnaXRQVDJRVStGTmdJdE5Ddmht?=
 =?utf-8?B?RTVrMzBoRVFGTEdlS2RjeUpjU1NzeHY3MU1nM3hrcTNmRTdHcjNuWG9UTVhw?=
 =?utf-8?B?WUQvQ0F6TjB2aDAwZW12bGVXR2U5MnluSndiQzhZWmVSMDNtaG1iMG1CbzhG?=
 =?utf-8?Q?xKhT+x3BJfeirUPQbHfG91CLfpRHEWwQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-4fb8a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae82c0d-0ad8-4467-d75a-08df430807b1
X-MS-Exchange-CrossTenant-AuthSource: GV4P192MB3287.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 11:03:08.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB509988

On 2026-04-07 at 23:28, brian m. carlson wrote:
 > Absent some well-defined documentation describing what it means, I don't
 > see how it could provide good value.

A concrete use case could be stacked pull/merge requests.

GitHub's stacked PRs (CLI in github/gh-stack) and GitLab's experimental
"glab stack" both have to answer "is this rewritten commit the same
change as before?" after every rebase. Without an identity that
survives rewrites they guess from branch names, recorded bases and
patch IDs, and the guesses fail in practice:

  - Renaming a branch with plain "git branch -m" strands the stack,
    because the tool tracks layers by branch name
    (https://github.com/github/gh-stack/issues/423).

  - When a lower layer is rewritten, its old commits are replayed onto
    the new copies because patch IDs no longer match; one user reports
    61 commits replayed, 53 of them already in the parent
    (https://github.com/github/gh-stack/discussions/600).

  - In a review of glab's stacked diffs, GitLab's Git (Gitaly) engineers
    discussed moving towards change IDs for the same reason
    (https://gitlab.com/gitlab-org/cli/-/issues/8040).

Each tool works around this with its own metadata, which plain git
commands then invalidate. A header that git preserves would let them
use git as the source of truth.

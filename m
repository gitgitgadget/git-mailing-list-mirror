Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.32.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784862;
	b=SyTJRmlbRo6Dvq0rhN0QZvvckUXYnVqLEcWYyUuopTssD8dZFINCe5mAgO9B9nVPzUFd
	 Ckg0nrbP7CIWbiFaIaZpx91LdDI7EMc5819dPMU1NQs4QNnqYxz6iRA5+gBzUCOlSE+E2
	 Eq7OPBGo/XjjylmaOKRMZbaDEmc9MI8J8WrYS63LLnX2K40f9GApDX88Y/s2tsiGAjFBc
	 oLvyU2j8F/Me19iQ1btjvhKUjp4xHGA4ngL0NchO0rI/K4trHulMGy7oV7uF04J5Jylc+
	 xtJj6Px51wdiF0FABuHRYi/1QaaaJFSszl9kIA5fO5Wc3CDtn+Bm2MmXFjIAKTaNn6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784862;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=iXEgdtuSQ0qVeJmvEWssBZacrr/9ebcks7k8V9h46ns=;
	b=qXQ2CU8O/3xjf6a9cUCmVSXNs8qflyd7QNCq47fEklA4ZoNr8LqhT1e3x4UBJimOEHCp
	 0d6WiYimcV2zmYMUinSEaQUAp9s0LEch2uqQcYr/270r3rx1B1ysinZsalYcvZ1s88mhC
	 KNeOS0oYfV5/QX9RYKnveV8WY8wedXLoVVfJNaPdDWL1YvmI98UfBF4+zfjoJlDPogu1W
	 mkOirJegFtFvRbkpuE2ToJZcDNKMXVl6INqhGfeJpb/0qEu2/iK22APOPzicXgWdBDGWn
	 yjUhDHDSW4ALVtBjnhcK9OEquCqqHUDhiE2Py954QefEsMlA9EojzfsJO/LfBD5tzNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=JxntZJIo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.32.1
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010001.outbound.protection.outlook.com [52.103.32.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D1606A32E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 09:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C8D1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=JxntZJIo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bya7i/0+boLX6PcT8+//uhK2O5fGWpVz5x3QOSROqyaUh/Sfn9vITBY4h+b/QkRvS5inpSR4aiMTrBIs8JpRuJpLW4jnHGtg8gUFrAj5Za/PE5S541gndpiIbqG3SK3aGoBg3P22JjdfdjAXeUdF8ZTJQkLY4ShtRlWMKxjV9QYkl6U5yXM5A9Qg2jD3N/0eYCh8Hfy8LBQVE4yq4nNSVHgbMwP68j791EVpK1EJvpRo9Sz1Nyqjt2pFc42rt2ocXiQQiYjTVCo5zXid35JSels9xnhK9ao33ErOpR7v2JLFxYYZcniPsB00Fdu+q08XZsmMSmMzmfR4Hoj2fRkrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXEgdtuSQ0qVeJmvEWssBZacrr/9ebcks7k8V9h46ns=;
 b=y+S1tfbL9EDLBXQ7FXM8puzeNGOComwKHfOrdzfzFmIHpgB1FKejaP2266IK+wm0uxFtPUYNONs78NrKeiwHPahCQodJVicn/c+L+/CN5aEEyz2uA6DjzWo7tl5nevtvKbiby/5iJ/mZ7XPWUsO+56pGNS9kkKP9c9nWjNK8OdDN4z8Wv+LjM3359YjRDM9Qq34n25CYWNlcJpmph0ca21AzzIJy2i3SEcMCH8EBlOdCDcLWREbxSAtIBEt9J9i7+6KDOC8T9QADlVxepNJCTTK6gI0K5K4KgJq5w90ZbJyxtUVMzFxNwKjJP5qSOK1Zbz1QWL96w5NGoAM9ZPD26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXEgdtuSQ0qVeJmvEWssBZacrr/9ebcks7k8V9h46ns=;
 b=JxntZJIo82Go/+UiH7BJzJ/HOrV1ZtJmGhPt0W+Fuh2JYSEOoyiV7sQEoLuvOybt/T+xDSy7D3VV5aML1ksljGHXJf9CkbNKqEBPo/8LTtIwVibs1qDLi1gbzYAuV8jTiOE6u8OQ7qBlKQwwGk7Ok6vg/9ZJJgnSqUPquEf4vOP26vTxAe/mXwsQZEJdXXAI2gXmE4OLm+02ETYk2sbU+Lvbp8rMtIjyujefMUsalkYgeERogMfo4/apWb650Z42EdsAYTtgHc/MaSJf85mt1E5nuLQ9mEIAGKj3y9V67kIFE/xzbStYq88chuGNXFd6177adGk35FyxuNNY6WMX4w==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by AM0PR03MB739683.eurprd03.prod.outlook.com
 (2603:10a6:20b:7ff::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 09:34:19 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:34:19 +0000
Message-ID:
 <VI0PR03MB11634E7F7FE122AF61085D7D8C0682@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Wed, 4 Nov 2026 09:34:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] http: preserve wwwauth_headers across redirects
To: Jeff King <peff@peff.net>, Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>
 <20261104062423.GA1763458@coredump.intra.peff.net>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <20261104062423.GA1763458@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0632.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::22) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <fd9a1fa1-7424-476a-9437-0603376ee398@outlook.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|AM0PR03MB739683:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a35320b-0a36-4939-e434-08df3a56cce6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|4140399003|24021099003|19110799012|23021999003|5072599009|37011999003|15080799012|8060799015|41001999006|12121999013|6090799003|12091999003|1602099012|10035399007|40105399003|52005399003|30101999006|56899033|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0dIU2pQRVN3ZnRvdHdXQTUrbldzWmFaQTUwTjNGUDhkdVJqemxHa1hmbWVQ?=
 =?utf-8?B?dE9UMDBJUEVQSGVTOVdmY2JOVGtob3F1anp4R0tFeHlWcU5ramw4Z2VNUnlE?=
 =?utf-8?B?UGZab2NWRG1Ib0J3dWVReG9TZ2lxVExpZWl0eXo3THdtNEJvOTNjQ2dTQ0NB?=
 =?utf-8?B?dGF6OFlCUkRZNkR6Sys5bzEra29odFVoZzI4bGltUzhERlJSK0U3aFozblNw?=
 =?utf-8?B?KzdaSGpZbGRoc3JFbm8zOHMyUC9QN3BrYUVzL3RqUUFrVHFhVHVoUzFpWHlW?=
 =?utf-8?B?T3p2WExlaEFJRzRqMG9nOGI1b0N5K3gvWUdpQWpDSnlxcEFuYmgzemY2RDZE?=
 =?utf-8?B?by80eWltcUVkVWhuU2c3Ums4aENCSXJQcFc4M3QvaXZCTFMrd2JMbmIya1pr?=
 =?utf-8?B?dlQzMFI3bE5wOW5YOWhUc1lEbWdpK2M0dG43ODB6MFErMVZpRVFDM3R1eEhW?=
 =?utf-8?B?K1lhdG5wbk03UjhvVlFmaWRDbjY1RnFYOHM5MzV6dmJlK0ViUmMyOVU5SGEx?=
 =?utf-8?B?VXZIcUtOV2c1T3RGYmFVVjRtR241TkJEc3g2cG9uWXFFUWRWTm91VjVScDcz?=
 =?utf-8?B?cmlPaHhicHZVZlJBVC9TK1E5OTB0eGkrWVcwbk5WdlFUQnNVTXFmMGV0STYy?=
 =?utf-8?B?b0pCb0w2UEo5NXZ0djJIckZnWWtPYVdPSVZFS1RLUzF5M2Z3RTdJOU9JdExz?=
 =?utf-8?B?Q3YrK0I3NGFYVTVVd2dySWt3Y2lRNGFwU0FUSlFYSXVTdFFRT0JXa0JmWG0z?=
 =?utf-8?B?NDNBc3ZlYkhaQk9TY0xsWWsvbGNhbFFrUUFNenlvMjFYV0Q3cjFEMlQvRUJH?=
 =?utf-8?B?dDFaNWJ0eEk5emFsNXVKRGNpSXFQL0NRVEgrbjQ4R1RlZ0xmaFdVQmVFQWJM?=
 =?utf-8?B?RzdlSzhMQ3VGbG5xd3lWVHViZmlENGRzZ2ZwSGJaVUtGS0lBZmlROGdJeGdJ?=
 =?utf-8?B?TWVxTVZpY3U1OVE1ZnFvcERmN3FIT2JvN3JNMGZ2c1JlMXpHTVRnZnN0Q2Rq?=
 =?utf-8?B?QzRWQXdaTEtZWDh3Um9FdkVMZTkzKzRxZVBNc1hBNGRTZWZIbWNBK2JVWXo2?=
 =?utf-8?B?YXd4WFNEdDlIMTc3dFFXUDBUSDViU0c1MnNtVGRDL3h0S1FZK0RPWlVHek90?=
 =?utf-8?B?Z0lDK0lvT2RxaXlTeTBib0NxUXhjN0Rha0pUQ2thY2UzWEhIQkpjbEIxV2ZH?=
 =?utf-8?B?WkFhaE1EbzB1SDNOZGlRZTZ5UXVibU04Z3I1dEoydDdJblMwL2hyZ2ZqbXdK?=
 =?utf-8?B?VWlDdkVkTE5NV0ZKMnFYZlRyYUhScVJJcGhiUWM4dnY3c3Fmblh3YzhnTGxW?=
 =?utf-8?B?YXFwNElzVHBlYmg5Ynp3QjVmcFhGZ2lWMHBibGdEZFBRc1ZtdlIvNTg5UXZS?=
 =?utf-8?B?SW5GQUhMNHJGQlYzSFV3bis3RU5nK0k3emN6MGQxVmpWdjRZSnNxSzVXdDlQ?=
 =?utf-8?B?QmdzbThDcWZQWEQvajRrNDAwYlFJcHlMQ1NGSmJWUytseWMzOTdacCtEUk9G?=
 =?utf-8?B?Vkt4cUJZa2I4aFpqcmJtbGtyS2RLaFpTMzk5alhpaGNiem9qRnRGVDBKM1A3?=
 =?utf-8?Q?6YOpvB4WKbEyggnUG2HuPQdig=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0hiTG9uSHZKUWoxbTlvUm1hZGs5UFBXTVUzcVErWEFBM3M3MXllSjM0Z09s?=
 =?utf-8?B?ZGliM2cvUmw5U3N1bjIvY3NQZFdBK3VnRmVCY1p4Q2dFUVVXMGxCTm50enNS?=
 =?utf-8?B?M1hDcEJIaHY2amx5My9GVzVsQVdsdlZDb20xeGgyVHA0Mko3YVRsTVkxeUlE?=
 =?utf-8?B?VWo2UnovVnd6Q1dmcEIvTmt0NE5Nd0ZBMXkwM29pREFoNXRiSTFyZ0FHbEsr?=
 =?utf-8?B?U1Y5VkZUbUpQNjlUS0xENzlDRW5SczQ4TUQ5K2JnWDZid0JQOWhiK1Jxdzdt?=
 =?utf-8?B?dENYK3BBNFhvYTFNUUQ0eG1JWDNWVDE5d094MnpBMHdLeFY2dTRYNU9rUk1D?=
 =?utf-8?B?S1ZhZ3NZOXcvUDdXL3ZubWRmcThGclZnSnRIZ2tJYyt2Q3dNR2pteUhlRWVU?=
 =?utf-8?B?MVlkQmRhZlp3RW9QV0c3emRWTWZSQkJaL3M4VDNWd2pKWkpxNVNNOHlrRFdJ?=
 =?utf-8?B?UStWWmhuTXRIL25HamhkV2VSdHQrTkdnZzFPQ3BKbDdRK1Z0OVE0N0JzTnc4?=
 =?utf-8?B?OE1NaGl5YS9tSVlsM01JZ25WVStvVmU2ekdLQ2tzcUI2bGdlK0xnQlhDeGl1?=
 =?utf-8?B?UzJZSElsS2pMWFN2Z1g5Z2Q1Q25yYXZxcURDbkxtL3NGQjBXNVZESjRiblNL?=
 =?utf-8?B?Q3NyM2ZFVFU4QjhuT2Z3Q2d0UjBMSVJZdHg1bVhnc3BRR1BuK3E3QmdXLzF5?=
 =?utf-8?B?N2VhaTlnaWdFeWIxMklwWTZvTVFyN0QwdDBOVjZsdS8rUmNxejF2Qk1ZMklx?=
 =?utf-8?B?TkFNZXNDQ2taRlpOSUdqRTB2Z1phdi8wZ25WRXFjSVppOXZaNmdMeUxkTE90?=
 =?utf-8?B?c3U5MTVlZlRCdWVRWk9NT3FDTG5weGxoZUY0SWtLVktBMTNpSzgxbytXR1Mz?=
 =?utf-8?B?T1NnM1p1UElIZDI0aTZpZkVlQkNsNXFoNDdBV3VFUURWMTg0dno5ZXE1QWVM?=
 =?utf-8?B?eis0b0xydnc4UXMzSmNPdjZScUdrblh0eVN4VkxJSXM5cllTVFYwMnFubUI2?=
 =?utf-8?B?VHFkMmhPSU9hRkpuNEo4SlFkQXlRYitlR3RaWVdIMHJ0UytBV3BEQXdjb0Jw?=
 =?utf-8?B?Z3gzQTVIRWh3cUMzc1hHTlozTkdGUkpPRTk3UWQxUGxtMVlzSlpCaTZtNkNP?=
 =?utf-8?B?OG5xaTJTa2RiSGpuSHBGR00wZ09VN1RLSDdDSFp1V2JnK01LTUpITU1FVmk2?=
 =?utf-8?B?R0Y2U2VLZHZ3eXlzNGp0YXNSLytJMk1JOFg4enkxYjR3ODBGWjVMaC9uRTRt?=
 =?utf-8?B?SU00VG5sZlQ2c21UdkJiS3Q2OStrOU5EYXBUQUhYTDVZSXRQdkw4SDBkL3pi?=
 =?utf-8?B?d05JNHpUNk5HTzNoSUZneC9qcTI1VFR4MS9oY0c4YTJjQWdjRWxvaHk0QnBB?=
 =?utf-8?B?TldTdTl3Q1FmQ3IwakhXMXJxOVVodWZJa2FXS3ZvT21oVG9HNXd4c0IzNTZq?=
 =?utf-8?B?ZFpyUGlFeTJRZjRmQXFrUlNvZDFQd2R0bnlNRnh5ZC9MaVZ1SXV6K3dGR3lI?=
 =?utf-8?B?aEpabk9xSUdtS1lKSW9Wa1BLU1lEV2FCSVFmRW1xQXVTQ2pldWYwWW43aERI?=
 =?utf-8?B?M0tUSW5pRFBzSWhVcGlQTFNBcGRHc3NSN2lkWTZQOG9FbENZZ0hLb1Z5V0dh?=
 =?utf-8?B?NUFLaVYyT1VicTc1Z2dCejZSY0QyZm11TXY4RkFoMkRhQWhuQ1plN1lJOWIv?=
 =?utf-8?B?aVNLK1VEWjk5cnc3R2M0K0EyRW9LUWlSTUJjeWszZGhubTRDNi9FZnprOEw4?=
 =?utf-8?B?QVRFZHcwN1JsalVuZjdEMDVFQk5iRW9wbjI3U1lPVlZhQkdrTWdFci90MkdC?=
 =?utf-8?B?MXhKTFcvbDQ4M0xaTnpLbU50WXQvVjNzeWJyODArOCtNZk5hWnRndjJvd2Ux?=
 =?utf-8?Q?Z07Iu8JSR/Bfe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a35320b-0a36-4939-e434-08df3a56cce6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:34:19.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB739683

On 04/11/2026 06:24, Jeff King wrote:

> On Wed, Aug 19, 2026 at 08:21:04PM -0700, Aaron Plattner wrote:
> 
>> When cURL follows a redirect, it calls the CURLOPT_HEADERFUNCTION for
>> each header received including ones from a redirect. http_request() sets
>> fwrite_wwwauth() as the header function, which will record the wwwauth[]
>> entries for the last step in the redirection chain.
>>
>> However, when http_request_recoverable() sees that cURL followed a
>> redirect, it attempts to update the credentials for the request from the
>> new URL using credential_from_url(). The first thing that does is call
>> credential_clear(), which clears everything including wwwauth_headers.
>>
>> If the new URL should use a credential helper rather than credentials
>> embedded in the URL, this loses the list of authentication methods that
>> the server provided in the redirect.
> 
> OK, the problem description makes sense. I think the root cause here is
> that wwwauth_headers should not really be in the credential struct in
> the first place. They are a property of the HTTP request, and we get
> them _back_ from the server; we don't send them. They are stuffed into
> the credential struct because we pass them to helpers, but they're
> otherwise unlike the rest of the struct in that respect.

Yeah, this was one of the awkward parts of passing WWW-Authenticate
headers through to credential helpers in the original implementation.

http.c has per-request slots, but much of its authentication and
configuration state is global. The credential struct already carried
helper configuration and interaction state, such as the helpers list,
use_http_path, approved and quit, so it was a convenient place to carry
the challenges to helpers too. That does leave URL-derived and
response-derived state with different lifetimes in the same object,
though.

I've wondered whether a clearer separation between shared HTTP client
state and per-request state would make this easier to reason about.
That would also need to account for callers like remote-curl.c and
http-push.c, which configure curl handles through the lower-level slot
API exposed by http.h.

The current split can make ownership and retries harder to follow, and
I've certainly contributed some of that complexity myself! ;-)

I've made a few exploratory attempts in that direction: a reusable
client with no global state and explicit per-request context and
policies for authentication and retries. Nothing ready to propose yet -
it's a messy space!

That's a broader cleanup, though, rather than a prerequisite for this
fix.

> So one possible path forward would be to pull them out of the struct,
> though I think that does create new headaches. We'd need to pass them in
> to credential_fill(), for example, so it can feed them to the helpers.

Right, I remember thinking the other alternative would be to expand the
credential_fill() function to take headers. Other than the churn, I also
didn't do this because WWW-Authenticate headers are an HTTP only
construct, and credential_fill is used for other things like SMTP creds
and the password to certificates.

You raised the smell in the original series about adding wwwauth_headers
and header_is_last_match to the credential struct:
https://lore.kernel.org/git/Y9JWnQeEV0weV4yu@coredump.intra.peff.net

Your follow-up clarified that the main concern was the internal HTTP
parsing flag. Moving it out would require some extra plumbing across
curl callbacks, so we left it as-is at the time:
https://lore.kernel.org/git/Y+TxRDatM9Iirwwu@coredump.intra.peff.net

> So it may be the past of least resistance to just hack around this reset
> problem and preserve them (i.e., your patch).
> 
>> The WWW-Authenticate challenge is not derived from the URL; it is
>> populated from the server's response, and after a redirect it describes
>> how to authenticate to the redirect target and it needs to survive the
>> URL update so that credential helpers can know which authentication
>> methods are allowed.
>>
>> Add a new credential_update_url() that wraps credential_from_url() and
>> preserves wwwauth_headers specifically. Use SWAP() to avoid having to
>> copy the whole strbuf.
> 
> So my biggest question/fear would be: are we creating a security problem
> wherein we use auth information from the original server with the
> redirected-to server (the avoidance of which is the whole point of
> clearing the credential struct in the first place).
> 
> And I think the answer is "no". These wwwauth headers are coming from
> the server back to us. And as described in 6b8dda9a4f (http: read HTTP
> WWW-Authenticate response headers, 2023-02-27), we get the headers from
> _all_ servers we talk to (the original and the redirect target). So we
> have to deal with this problem already, and do so by resetting the list
> when we see a new HTTP request start. So by definition, the wwwauth
> headers we get back are the ones from the redirected-to server. And so
> preserving them as we move to that new URL is the correct thing.

Right. fwrite_wwwauth() clears the challenge list whenever it sees a
new HTTP status line. After libcurl follows the redirects, the list
therefore belongs to the final response, not an earlier response in
the chain. Preserving it while updating the credential context to
match that response's URL is the intended behaviour.

> I see that the credential_update_url() wrapper is new in this iteration
> of the patch. I actually think it is a slight step in the wrong
> direction. We know that retaining wwwauth_headers is safe here only
> because we know we the updated URL we are feeding matches the response
> from that server. Any other hypothetical callers of the new function
> would also need to consider that (and if they get it wrong, it fails in
> the insecure direction).
> 
> That said, I'd highly doubt we'd ever get another caller either way (nor
> add any other data to the credential that is treated this way). So I am
> OK with it, but have a slight preference for the original inline
> treatment from the v1 patch.
> 
>> +void credential_update_url(struct credential *c, const char *url)
>> +{
>> +	struct strvec wwwauth_headers = STRVEC_INIT;
>> +
>> +	/*
>> +	 * credential_from_url() clears the whole credential. Preserve the
>> +	 * WWW-Authenticate list, which is derived from the server's original
>> +	 * response rather than from the URL and is required to authenticate to
>> +	 * the new URL.
>> +	 */
>> +	SWAP(wwwauth_headers, c->wwwauth_headers);
>> +	credential_from_url(c, url);
>> +	SWAP(c->wwwauth_headers, wwwauth_headers);
>> +	strvec_clear(&wwwauth_headers);
>> +}
> 
> OK. This strvec_clear() at the end is almost certainly a noop. We
> swapped in the value set by credential_from_url(), which will always be
> blank. But it probably does not hurt. OTOH, if that assumption is wrong,
> we are throwing away useful bits that we pulled from the URL, without
> even knowing what they are. So maybe:
> 
>    if (wwwauth_headers.nr)
> 	BUG("credential_from_url put something in the wwwauth_headers?");
> 
> would better describe what's going on.
> 
> I'm adding Matthew Cheetham to the cc, as he was the original author of
> these wwwauth bits.

I appreciate the cc! :-)

> -Peff


Thanks,
Matthew


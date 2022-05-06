Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5033C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 12:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391599AbiEFMEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391625AbiEFMEG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 08:04:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075038.outbound.protection.outlook.com [40.92.75.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF12AEF
        for <git@vger.kernel.org>; Fri,  6 May 2022 05:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzxN3xByHTnAQxlct5gozLZf7T7MsvWd+iMnpvSg+G48U4VsbZDgLm44x5N/RL4sp1SDdufETObcjENGiav7f4moCk/WyjpZq2P2HF8ZkagjwfIVCnbkSSacGXXuNzU2Bk7iPrBzmymE9PsXQ7wiMRYQjmjonhvZyZstG98Mv1xw3URkxHbxiHOKwzBjatK0MtExjGB7b/UcaHjhUllpitFrOTEwr6HiABsE+mI+8nthRY+05647YLiti7+/CPxhAxjvl2WsTAfzGIFVdObdy0FEJ6vR2nwT0hTwL+BjtSV9yg6nhk6pM6apUQ9XzAw8cu/eD/yGXzYXZIR0HLwN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvV0Xz/YYucfNQlB0ei668rtIUKnepYhvYeHn8p3W2I=;
 b=H6pAcm/CKWVMuFEwCvjqkzUzKfYhZ88XrE9DNRv9spU1D2p7MNzjg5HU6bfR07NRozughRxzo2RApCKLUOcO0uOuns3QBjYTrlqdAKdaeN+0hK5dD8wJdL8TnvedYsv4Q+y4QOiK9XvmwBoABxs5YhosOqF41oOWTIhZDVbuVkn/EKV7VnM1f5P+B3Dts3JKjDT/BB1HGQL+MedpsnJEZZUgCqoENiXvKq7i0JYco2h6R/H+FEkaaxvoQE5BBIez13ESIiwF2gI0yLhA8eUpaP/JYJvSqyL01Szbyt7wYGgBiY+kvPH99ZbokRyGOFb3u8A+M3JnOR+yL0PbHO4fiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by HE1PR0402MB3449.eurprd04.prod.outlook.com (2603:10a6:7:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 12:00:10 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::b8b7:ec3e:12fb:eddb]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::b8b7:ec3e:12fb:eddb%7]) with mapi id 15.20.5227.018; Fri, 6 May 2022
 12:00:10 +0000
Date:   Fri, 6 May 2022 14:00:08 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     =?ISO-8859-15?Q?Christian_Gr=FCn?= <christian.gruen@gmail.com>
cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Halil Sen <halilsen@gmail.com>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Resizing panels in the gitk window
In-Reply-To: <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
Message-ID: <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com> <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN:  [HdGvAKlwnB88Vu2qbKhu/gqGu5eeQ/CpVzyAIvwXB7JdZoMtSKWfe92NpDV6C5KT]
X-ClientProxiedBy: AM6PR08CA0029.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::17) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <55ed7dbe-2073-6dca-6e57-36b9b97f9717@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22e9370a-8ab1-4873-f667-08da2f57f7cb
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3449:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSdtCxIUbowNievQ/itAnEgKLqJ3hMaaPGmC+eqAjvskLp9byemJcbpXJ4qJmMajAMMpS3Y07cL9XznvhpSTKfEzKJL0cnctkdjzpB14SW1An3l1HbsKFrpw8hcoNfEF4YEsoWq7KcHeLvCIbEtZeq+GjvCL9qjkRyGHULZ81jExL9lSCdNVZTjRqMRIh3plXVbZWj6dh1M9I8WjD0gaQw6KO+Yjk0NHh+S/AlZodeBtpWfqfRN0eNyKYZB5op+nKTVZ9qTJgvXwiHQQ/z4MNnAZNiZ4H5jBIqpPPRjJTGNCSHzHrh33/70VNVd/wVrj6cMsUTWTGFu6866fOjC3fIg9s4MjflCzcGsmirNnAbb2P7zOUCn9V+7lbbkZQon7sLdGz+w53OaWmfNDv6QforOmTFIoB/zfGXCbXbdn+pAHwIx4mN5+HbfWdhyFjf2oyOeLqrpPcsY5KGYUN0lg/yRwy5bULp0ap7OKVyKdo1ejnbcOkglKIXwED6OgBQ8rk5+yt3dm3aScKfxxw31AgsSct0mYn90y03HAMOJjJfcb2dyuMVvs27e66C1u0xjhAeXLtPyF1o5nplDauKK/HJW/TUNJt5TIBSF8Q0pCBQhx+ZoLargQH1EcP15jWUdJsJ28MXmHktDRMtB3RZ94mT5/3riyPXLSAz8rncu6wyc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFlWcWJlVU0yMDRNTmI2RGEyWndqYkt1R3M0RWN5RnNvaW1kVmh3dm9jUkFk?=
 =?utf-8?B?djdCbUFmRFdZNEwrYUJZR3YybUlLL0FnRGJBdkh0Wis3dmRjcE9MQjBJMVlj?=
 =?utf-8?B?L25BcEc3Z29yQjVQVS85dUFEc0luNkE2bzd2YTIyckVIVS9EbHBGdnRxalJx?=
 =?utf-8?B?dVVYRFFtSzlDS3UveVF1cGZJZXB0VFhyaEVaNFFRejNJa3hJWmQ1V01oR0pJ?=
 =?utf-8?B?N2pOalFoY3Qxay8vMGZQY2tTSytaUnJ3aVRjNklOdWt4aXRCQzN0QWM5TVpM?=
 =?utf-8?B?Zjc5dTZUaVROTlVjY0loaUViQk5lSWsvMXF3WnhuYlB4Y3E3Qk9wNzMwOXdo?=
 =?utf-8?B?TUdZY2JzcmF3SkNpNWhPYmNqRXVPVi90WlJWSEk5Y2s0SXBHdjBKbDN1cklP?=
 =?utf-8?B?Rm8yMDU2UFhCdVppdTF3ZmpqMFJDSzdNUDVlRWFTWnl3cjYxSWhsOEpIVzha?=
 =?utf-8?B?RWpTc0dWalJQakRsVkFkME1RWU5TZmhkOEFHekorWmh4c1FEZGdqWlVCeGRW?=
 =?utf-8?B?dHY1c1Y1cHFtOCszVXM0NjhXUk9tM0lqWThkQ3dQbEx4bEtIaVAwTUZPNjcr?=
 =?utf-8?B?c1dTbVpMOXZBNmt6cllaZ0tYZlpDUENoNWpyRXg1ZDF4Mk9xNENWTTdTVG5s?=
 =?utf-8?B?NnpOeEoxK3ByeWsxVkpITEZmSUNEeWxrYlZ4VzVFMzIvVVpNazM5bjRyTlc0?=
 =?utf-8?B?Z1B2YmdrVFpPWm50WmZGeHNpWHdOckxobVNtRnhEeFFFM1hwUnE3aWlIS2tY?=
 =?utf-8?B?R3VWOUhLL2lHRmFtVVR3NElKRlVvSnZVRHE5eVZUMDhoUyswTE5nOGdqUklk?=
 =?utf-8?B?UmdJRXV6cWtXckxDWG02ZkEyV3RxQml1eXRGNGtaRWk0YjQyRXFhc1hDL3VG?=
 =?utf-8?B?R3VnV1U5U2k1cGlERjk1VGZaQ3FjZzIzaXJGa1lyMXFZZUVNRzhpZVB4UUpm?=
 =?utf-8?B?b2pINWJubU1sOFFSZHQ4c1BYbWhlTWI1RzlFM0plTXBsdnIwNXRiZnZXbmJi?=
 =?utf-8?B?T3FZZkVVNEVabDdlaDRqY3pod0pRSTR4d2k2c0NucHFVelp4NmZ5NUZIQ1c0?=
 =?utf-8?B?cHR3Q3hOVVNmUUNOOVk2ZEF0elZzb3Y3SVZMYTRnbnpLeWYxcGVQa0pQNWJI?=
 =?utf-8?B?SWhZU1h4NndlY0tML0xuS2lQRXBVWk1GUmNzRnBpTGJBVXRmRjdwcHc4eStq?=
 =?utf-8?B?YVV3ZXBZTTJEYWp0bnNFTzZTVzRkOEVYbWZMMEwwb0R5TzdvNWk4OGxxeFBX?=
 =?utf-8?B?aDQ3QnUyanNwOXpTN2JFTnFSM1YwcTRXUnVHNnZzYkxhL0FWRlRWSmt0U293?=
 =?utf-8?B?alc4YWhVa0Q4eExnb0FCRkNWZUdLcENZaEpPOHF4RUxHa1RKOXpoN3RaTXV6?=
 =?utf-8?B?aUtyTXEvaTJoZUtnVkkxL2JpVEYvazFvNU5zczZCanpkR1dSMU8xOWhqYTgv?=
 =?utf-8?B?TmRMbmFhbk53WGxpeGV6b2YxZzNCa2xzcmZRcGszMkJSZElRVWlSMXlwOG1h?=
 =?utf-8?B?YzVzQzJ5WVI0NXpOM1cyT0RoK1MrVXR2ejhwOTFOTzBDeHN0bEtPaEE4YzUv?=
 =?utf-8?B?dHhFb0REYmdKalBPdithc3FYU3ZTSldsc0ZtM1VCSDNRTWdQUVUzWjR5K1J2?=
 =?utf-8?B?S0U2bEQ5R2p6WFg0SVZ2NGcyTThrY1hQYjVGaUlFSmR2ZW9sS2pQMnNUeUZT?=
 =?utf-8?B?ZzNNQTF5a0RXKzc0Qzc0bGZQd3RVN2tEdk5KU3FSK3d6bmVuWmo5SG1ONmFF?=
 =?utf-8?B?b29Dcmt1RENFWlFZb1R0MC9OSm5kc3RHOXVEMTBTRUJJM2JJZWRNN2dsTThB?=
 =?utf-8?B?cnhMcFhsYXBKSGFhaXZNcXJDRWF1dWZlcWlMTHE1NDVpVWl2UGtQY1NCRFFW?=
 =?utf-8?B?WjlkU3FuaitFYUpCUDUzWjI1RWdYMGFDVUxYblAwT3lWRnlIV016ZDE1dUtP?=
 =?utf-8?B?N0VRL2RpbHVLbGRDQnlVZU9kYVFlNHBHaVZ5Q2d3QVdUaXREUHpXaWdsb3NP?=
 =?utf-8?B?MktRTGY1emt3PT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-03a34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e9370a-8ab1-4873-f667-08da2f57f7cb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 12:00:10.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3449
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 5 May 2022, Christian Grün wrote:

> Resizing panels in the gitk window leads to a error message that’s
> presented multiple times in a dialog:
>
> expected integer but got ""
> expected integer but got ""
>    while executing
> "$win sash place 0 $sash0 [lindex $s0 1]"
>    (procedure "resizeclistpanes" line 38)
>    invoked from within
> "resizeclistpanes .tf.histframe.pwclist 1834"
>    (command bound to event)
>
> Is this a known bug?

It looks like the issue at [1]. It sadly seems like nobody ever reviewed 
or applied thos suggested patches, but there is some more off-list 
discussion at [2].

> I’ll be happy to give more details.
> Best, Christian
>

Best regards

Matthias

[1] https://lore.kernel.org/git/pull.1219.git.git.1645386457.gitgitgadget@gmail.com/#t
[2] https://github.com/git/git/pull/1219#issuecomment-1113122632

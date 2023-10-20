Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBE35512
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="RmIfbmlt"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2118.outbound.protection.outlook.com [40.107.115.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D6D6F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdL5c386S7jrkt5JgaruhYLziA0iChSM9WfYaWYJP0KBbArsxPJM6+lZoqjU2nDTQ0Izkab1xY45lUYyRtVotzX5fRPHLJrn6P/w+GdJe8NCvF188FvbvY8tAQ+oVKN8XOLGtDX1jA0nGEMI0UiY0U4N+qUGDGaOAKK11V3rn1X1Gh/JsCXgzu7qkqwHW7a/4GmwY7/FdSEo58hd8YCLboKOZyMJM3o6rskOMP/aOb5DnUqba7QaZ9oeT9xSypumDiafVcXA0FnCR61di87lWOAQJXgOoCCCqbcT6QsVBNJHnfPm/RxAAfAwPrKWQg7KswT/K9WMkYmfJ5+Bz0sHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eFnNG2XeMK4jN7Q5Bf1ObwgCqYdpgbL4RKx1hH65Ec=;
 b=jwBJuM++2DX5DNOzPSTPViv3jLpvLSi/D4VjV4cmAo7yJdD7RKIYj9uTqYb6th2p82NavGk0hu2uwOhyuIQZzemyLG9bsHBAk7aoow5xzqtaEziZCFPKFhwwvUn+DGMBvmfZTmsqL/VoHFl3ZQyFMjz53wqyQieSh9QtRoXnr8PgceKH58t07gsN91NphHKmb0E1INCn5K1GRApagxPOL6oBBEaX4EuhpIxnD7UZKZD/lex1alrRLtIBWrzMCvfiyULsKEbOVvlmfcNyKKtffQfJ6hmePAsqlLtwyjDiXVmMO+C+83EDFn76JJJZx3O14XvKMQ+G03hYnI3Ir99Cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eFnNG2XeMK4jN7Q5Bf1ObwgCqYdpgbL4RKx1hH65Ec=;
 b=RmIfbmltMxd/Z6t0YNdJqbEi1Fijcuezo7fNCMFb/LIbOdBYSPYtU1OvE+nd3Ng1gmxxElhNfitB2vm4cP2GTLal0X6PAwZCX6zDivpCPaJWT8AjiDTecFEeKczR2k9lLNOGzwXHFdrEZPQxr2SCjM1nE94eEokxss8V3XNkl2c872BGHmE3RMslXZusQFxcJQMc6ZKMTRmrnGarXLfNJaitCbCPVt5juocLNCZ4nhDGlZ5xy1azRdi8z+AGTQzFAyPEk4bEy8paV7tXWXsXhg2Rt8nVTXPCowXHsJqexOYWNO7ET7hoVjEKeP7eUm6UyZb3y/cBX60ETN7lUAzQ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQBPR01MB10675.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 23:56:10 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8c95:73b2:5c1:7dd8]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8c95:73b2:5c1:7dd8%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 23:56:10 +0000
Message-ID: <b5bc179d-46b6-4c48-bfe5-769dac38489b@xiplink.com>
Date: Fri, 20 Oct 2023 19:56:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] git-rebase.txt: rewrite docu for fixup/squash (again)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>
References: <20231020092707.917514-1-oswald.buddenhagen@gmx.de>
 <841c3b59-9e7c-4492-9d66-8af42c3222ea@xiplink.com>
 <xmqq1qdoq3tt.fsf@gitster.g>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqq1qdoq3tt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::24) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YQBPR01MB10675:EE_
X-MS-Office365-Filtering-Correlation-Id: 178309af-df13-4b60-cbb6-08dbd1c8223a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3jsKk3Xu5f+tmboXVY77Pssa/+KfhC9tgyhsKxUXrxA5AX0ohRLo+4hGvN+U+xJUyjtXfAT5Zb+Mic/A6i6pIxbu+EzJR0GhHR0yL5DHzgEva73d5BuGGZiZMiqcR18ZBNwCci+/GkCzf2gtJqVxofBig+wVQxhq3c0nC+15lpFvsxdMcPPuYLss8OV7jueVUmFm+I/AyEzon5qoMled4Y8JMNEfyNep0luq9sSF6RgJbFBbi4KR9gQ8jYX3WwbtJnjiXENwpV9F+IygG/rN+7afvJ8neOEv4Lwt4n2iUd6qAhtAwbxi4NKizshwqeRdIbQQA7bm8+a3JTTNBqrBfDgh01HLPb0zv5qPEIKmljdxBGaBAB55HzJPLY+rEcPzVpGXAHz/L84Npl5IS2JkOYbvsQ6UCMysJz+ZyW+GHzOaXUAbFSDfyvEIRJrutzBKYN9OmmKliRXOsWtJ28ozFvRDTXF2NwRgObWeUwIRGIgkGB07XfcCIe2dfg8DMLzg1pwQCeZDj8eoWiXwZpRHzyOq4p8Fv4xvPb0b084Vz/za5HimEdmmMW/Qwx6xTX4oVBrOc1l5zG2s7at2l+VSZFxORi8BqsmAXAw7toGnOHmbTZk3ZQ9BYIdeBrbIabwv41gjJ9bmZ1+lvEX6Z0sz4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39840400004)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(2616005)(6506007)(53546011)(478600001)(41300700001)(2906002)(26005)(4744005)(4001150100001)(316002)(6916009)(66946007)(54906003)(66556008)(5660300002)(8676002)(8936002)(66476007)(4326008)(36756003)(38100700002)(31696002)(86362001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0NxN05zT2dNZkdzMVZpUFJDaXFBYnZrZno5akVEMUdiYnVSY0UwM1VMajNs?=
 =?utf-8?B?VVhKKzNLbmNySWJPM2ZOSFBXWXAxVWp6SEp4MnBrd2VMYVNQOFRqNTNYOTAz?=
 =?utf-8?B?UFpYVVR1RHYwTWpEZDJQSUZRL1ZJdVBBZ0NHa0pYVWNodlIzRTFaWVIyNVNC?=
 =?utf-8?B?ZWEveGMyQkxjTllCMEhkZ0JDV2l0SzBhQzhjZEZWQVJiMit0T01IS3daUzhT?=
 =?utf-8?B?bDhMVXRmR1dJT2FxdUtsTGRSK09RbzVya3ZKTTQ0MXZVVjdNVkVHc2l2MFBM?=
 =?utf-8?B?WG90TEkxTng3YThhUXdsdjBGc3dkL3pHaUhVakExNVdqM0sySjlZMTFaK21Q?=
 =?utf-8?B?eERHeHZ2a21JQTczSG11cG5rOUdORE5TWEhwYWtMOWxKM1NPUmxHajhTREZC?=
 =?utf-8?B?MW5lakFvTld1a2tOMWEyRDRpRjh1YllpQ0lqeEJXSkxRWW92aTRUZTZvL2JM?=
 =?utf-8?B?WnpvckIzcXh4NEhRajhteHhiNXhTUlYxVGY3Z2MyOFluUG5hOUl6Z1lCWTFF?=
 =?utf-8?B?SWJJbUdjZjBiQWdCM0lFRS92NWtzQzJ1cjFLbFFuTXVpWCt6MHg0eUFQc0Fz?=
 =?utf-8?B?RmpJKzRDcG9oTFVCN3dYNWthMmNUeTRBOTF3NC9PTFJsUHBGZzh5R3MzcmI0?=
 =?utf-8?B?bGxJcXlITkR0TFF2SzgxdTJIQy91dExaK1VVbUhBcHp3YVkrUGluMHJvWVNh?=
 =?utf-8?B?WGR6ZFBqcTRkNmtPR0JlZEtTT25tS1JvZmYrdXN5ZjQ5cG9MbnN1NzAra0xp?=
 =?utf-8?B?SmhVVldOSktPanBYaUVzdHJncllCY3RmcXk3Vlgxa2Z4Mkh2VFQ1c0FYSmxz?=
 =?utf-8?B?ZUZ4NXFmb2NicFVBcEllWm9mZ0ZuK2t2RGtxU3BFQkhlYUJ3Z3lJKzVKNlN5?=
 =?utf-8?B?MFlFUmlnZmxjK044SmxDQkpaNmFkUEtpbWhtcEtjSXREaEs3SzhPM3NSVzZ4?=
 =?utf-8?B?ekhhUzlralAvMDJSSGxscHdWeVJUVVE0Tmt5Q0JiL1pyeWV0VFZHNGxJdWs5?=
 =?utf-8?B?ckN4b1k4Tjg3cEZsRnFBb0RjekVzTjFqamkyQVk3WDJBa3h5Lzc3VWkzNE9H?=
 =?utf-8?B?NVF3MkJwbTh3RDhFWEY4OHkySEdzT0lTZlNkcEgvN0NMZFdsSG1ITXluNzMz?=
 =?utf-8?B?NzY2T1kyeUFlUkVXTko2b1dGcGw0UkxPQkZ3QzN0dXRRdGExQVJ5dXpheElt?=
 =?utf-8?B?Y3RRQlVBN0VFZ0x2dHBla3Z0SE9yMDRXdFFFb3dVam02NS9IcXR2cVZoZlJY?=
 =?utf-8?B?eVRGNzB0MUdsSVBNYTlTTnZaNmhtc3RwRERwektvZlArZXQydnVqZUtwbUR0?=
 =?utf-8?B?TEY4bzl4ZlM0NnpVWEZzWmNVT09YWkpZRjJ4dCtzR01UUUhPZSsxNGxqQmlE?=
 =?utf-8?B?MjRwTVVDTlNWbU8wSGU1THZKSlVQY3k4L1pCNmt4ZDB5ZkNRTzFKWG8zSXND?=
 =?utf-8?B?NFJBS2N5NFE0dkEydk1mRDZ4VnMxZUV1b2xXUEJPUEFJeEZNcFVkcWMzMFZQ?=
 =?utf-8?B?NlJUTVlBYXZiV3RyamlWd3Nnc2dvbE1zUFJwNkUrVElBeG02TDZ4SERWMUpy?=
 =?utf-8?B?eE9uQ0ZSUmY2Y05FV3NIMVFMN3JUVVd5M3ZkWk0waDcvU0tCTEJlTEZUMjFw?=
 =?utf-8?B?eGdoUFdDTndxaVdSZHhic3d4dGd2dGZOYjdsMGhlMjFTUjA5aldhVDExVEF5?=
 =?utf-8?B?RDhLYWNGQjB6NXNjWC8xdWcySXZlZDVEa3VjMkdKZHdsUytTZVlja2Rpbm9m?=
 =?utf-8?B?a2g0c3NVZDBBSzNmNHNvb2JieHZjR0RQWTFuczZPeEJmb1UrODlpcFVlbVBL?=
 =?utf-8?B?U3ZIZmdQNExhWjdmNWxiNVdPVXRZcEpJQ0U4Yzl5Mkl2YUMxT1A5N1NTem8v?=
 =?utf-8?B?NUIxbzBGTTJZM3dmbTFETE5EdStlc2hxcGVrSmFvZDNtNmJrVi9TS05BN0U5?=
 =?utf-8?B?NnBLc095cWJSNUkxWUxicXZmWWpiejdvc2JJNGxtOUViVlkzbUlqckt2WjJs?=
 =?utf-8?B?eWZPZWhocHhJN0Iwb1dPK0tEcVZaZW1qMW5tUDc4SlN6UCt2R3I1elJFMzFZ?=
 =?utf-8?B?OVpJa0ZvcmNoVktPWWl1N2RlcnNKMk1mSUEzdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178309af-df13-4b60-cbb6-08dbd1c8223a
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 23:56:10.2590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PYk11ixqsoR+dKxcM/38caMQn8+sUNawb1pTyyHNLSqBXWPE8WI7qU5J2EEcMIs2U5dt7a/G94QlDK2GsdIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10675


On 2023-10-20 19:19, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> [1] Makes me wonder if rebase should also support "squash -c"...
> 
> How would it be different from "fixup -c", though?
> 
> A "pick" followed by either "fixup -c" or "squash -c" will have the
> same effect on the contents (i.e., apply the changes both commits
> want to make to their respective parents) and present the end user
> an editor buffer filled with the commit specified by the "-c"
> option, right?
> 
> Or am I missing something?

No, you're not.

I should have added "as a convenience".  Squash and fixup are similar 
enough that it seems reasonable for them to both support -c.  Saves 
people from having to remember that only fixup allows -c.

		M.

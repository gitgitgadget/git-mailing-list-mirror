Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2023.outbound.protection.outlook.com [40.92.90.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EE1EF01
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8hXRRuajxoIJjUmUr/+cNH54ExkhdQCEJJGn/4pCHkJ5Sq8q6qP+fUZ4P6ZA9DetmbMxAtAa1zhmzu0tvHcWoBrb6oXZ0XfmvC4HFVA+Vz/cbMEpIhOW72EfH84CCSsc+7Sxg4HaNwD9U709pSZd397YZA1LXnE11EdiouUbMpgFJppACBduZFgeDqVieeQURHJhIVfqZ/NX108cuAZ2BCYHrmFtdnwASyvw+6Q05bMSNDTbmA2v96lz5wTC26ZlbkjBmUoFpDOe9+H8J1QEHIc/LbvMmO1dosy3tWpmQQwBiXMNtj0euvcHtK+7Xsj3vAWTeVDALZHNEoVkisvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GsItUaQceKplzEEr/3uZLhxtlkmjGYx5gsSoH8dnqU=;
 b=k+YbcNcvEEV2UtvD5koRTrlAPuRgXJtn55I8QlczR8rPQvDlxxMHj6g9WJ85ppqxTyJXoM+Gwm/yWUtnmFyP7c9R7qXzN/+aZzvchZkcsYoN3FwW3JGzU5kelI+TK9ihEuzCctksvqE4sQtCi4Gz56Im5FSzFerTGpp5bfXR/4n76O/VcIMoFZHVhxfT/JxmeyH5eN1Gduch5cKwweiqSXRWiCAVYVQd3N3B8xTwjw9jNxw9ROyAQZOLIhkhjlBZ7aCYkLM0m8hqQbhCjIOmkU27blbSyuuAE2o2yjTTWWoXJZqpIgdmc1bP0Gv0Be3dzoRotY1aDds1uFbbVp1nUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DU0P250MB0410.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:342::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Sat, 13 Jan
 2024 09:24:15 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ab0:984c:98b0:1982]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ab0:984c:98b0:1982%6]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 09:24:15 +0000
Date: Sat, 13 Jan 2024 10:24:12 +0100 (CET)
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
cc: Michael Litwak <michael.litwak@nuix.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggested clarification for .gitattributes reference
 documentation
In-Reply-To: <20240113074323.GA6819@tb-raspi4>
Message-ID:
 <DB9P250MB0692C605DFA88572D091D959A56E2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com> <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net> <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <SJ0PR10MB56932ABBEEEC6F8ADE23995AFA6E2@SJ0PR10MB5693.namprd10.prod.outlook.com> <20240113074323.GA6819@tb-raspi4>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN: [HOsBNXg43sI42ADu15lK76acwBQAI2id]
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <1ac3d8c3-584b-acb6-3549-791002c28efa@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DU0P250MB0410:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b25aa3-1538-4663-69f0-08dc141968e8
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayFHq4Z/zFUbVOrKUTy4rE0kGF3Yb4jcTXJIAzLdo7VW8k9J3I+8U8/PXHYM05cPaj7h8HIo74GtFL0GwUa8CQcqgKrCk7IPeg9IGuge/VEKaB9koZydoQbrMZJSgPEKSxzor7As08thoA7xQmC19nOPdCX5Gd5zE1LIWQSbvVKgZq/5H/vmbnS0LgPiMFiwahDU+KgDHQv61dVXYKSaowidz4eR+vzNwyzWiFOm+tTg021tIZQq8fwo9gzRSweQ7RYN3nIZC29pOGy+Et58qmgD0F74MyPxb1/+nd4gAFN5WVoU0UIc8n89oBVZoSAT/HRSydbSq6eX1cRnVs5aYS3scIJB8LkYLj3Fxd7KwBl1OwDs5N8zbe9wwCA5VANPaBmESTLB5YGVOit768Ie2wmvlVgulRvFOXLJjbnTonTFtrwH+K2yqdXX+f3d6wPscbgXBcMSaTI7YIzCSXzeOcOiPFZvSNxr9qv26aMk8H1HWW5fX+QulHHHQ0OArzeOMmtTv1DwMLilSW/MP1DzPvowzn7+U1AqaX1osSeU62Oa9mZ488bkmEWIrJAb6ZbA0gJPlZACU2sUYjlHhUjWxgdOrjkI8iR0Pd2Y/EVyBAI03V3Kd2N4SC8tCHQ8N6WeslRI5um6Qxq0XfLkGXQ5NVAC3OXQEIVIXHw3GSb5GfaK/nDhGHAoKpfcgr+UmQcu0rdMo2dfVSRY/4eHCTHSDh117IRhB9SO1Uw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8jqBPGE/I+MvHmv9uM51vXyB4yJSpzljkABoWDkhhUPQkbwLSNjzOs/5z8rJPpUMSwMCni0VJWYN3CFcfUePjVJLruEOoevk0vX9852iNIKh3F8h/yVgtUd3gsecCxjBecXefdypuyF9ZB1/lRaC+jS2cECWH3l5eTZK4p8N60ygkcseJuVsCUtblYRLTMlXhnNpSe6McaCRfhsezlDG22GnD7Ny+W59HKVd3z9KuP7/56uYlvVR+cdPWlSXbwwIDCMzgDEMnHT5hqjF+Ie1t8i9Dk9lw6Nvyj5dqeBc+WPmJNmgnXbK2YHSTPd91SVSKul6bO3epXiOuxBB83Kx1fz1t8uKkU2jbR2C0FaFj8LHZCjQDA2siQ0mofzidkrJh3xkA6tq5xzFIyKjETqPnCGC6LpzCTO3lcwWbzgV0NOOlqMoSJ7i+eO4V0cBOhGwcb/eNodS3u52TEL49jKjvB92s9gptTA76MH0vP9404HMLIvlsPNLG+Ob5ePp2dmgy5y7jPGQYZVRQl+fjgViGtUC+wcLRjPgeCepIZu7CZtQItRV170oowPTU0BQJMmgHZbEVQV1yfUMRmNUHaQjNfQAH9LzycPJqzsXZ0fwzbL/ATWoxnRy84fmlqoqXWp/Bep8Bt3K1ph4pcc55iEZ2w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-15?Q?5LS7ZhkvnerEFAQ0zem09/UZkCRt2sc3pQyeX9KylSHBUSYyNXYuac3F8?=
 =?iso-8859-15?Q?v+sL8p5thAgiFFZPg3nzUbH8eavvSKEtz3HLpqI+4ESIZJ5pgS67EH6JS?=
 =?iso-8859-15?Q?YsxyKZZv3bVcFekgrn7Y2bQs/W3gQQ89ExUjaDDUHMv8y0pSEOSiL1R8C?=
 =?iso-8859-15?Q?pRTIsujk3QZannCoC6El/PGm20hyTT5RHnrrzd/TZsyB0dblGU12IJfR0?=
 =?iso-8859-15?Q?pW07+4rYZ0CKyJqC0MdR79SAmvy4fh51lm2GzN/uySNZkmUf3gMvUtJmp?=
 =?iso-8859-15?Q?7MJTTdzP1GfqL8YjCmjf95xu8297TRwgM4JQ7JUy1A288hjPCpZTIsaYc?=
 =?iso-8859-15?Q?WC5k7laW3gbj0DWJgI3bixQdPW5MsEqCYwnBlFNeZIaWkzR4BX0b1vPdh?=
 =?iso-8859-15?Q?NPOoHmUaGFX4bHvgXwHM6c9FygWKjETcUMZwrh27enONccei1xUAsU24d?=
 =?iso-8859-15?Q?96M7asbaFm99DW24osu7KG06iT4oRXDqWvqr3cTnHCnHfp+4eChuSWVJb?=
 =?iso-8859-15?Q?EmcSyIu2XiZdsy/ZGlCViMziph9bHuEfkxqPb/339B+7DRWogHgN9N6Xt?=
 =?iso-8859-15?Q?OdJoSfgr1Uwfe/AzHO3x7xZKUE0KoROZbvlLNo9HKNbldWEZCfM0j2cIR?=
 =?iso-8859-15?Q?bmjkzPqpEKBAS3XoeZDLMVaRH1vy6sOoLWF3UiaDOAH1MxOXDLKBtZ7ru?=
 =?iso-8859-15?Q?Ud427FV+6A6n6J3YXLTlOFc1y/qHxfDoYE3iR9yqOpALN1IudRkhETCg7?=
 =?iso-8859-15?Q?qMxnsbKf4kYZj/+BE+VIXYGopJY5nkElnJhqYic9cwRgCANQR3bTVgar0?=
 =?iso-8859-15?Q?XXohiqYIF1sSLbCUO6OuphVn37bMvK3YKOVSclGCmRu/0RYg1JDDCAyEI?=
 =?iso-8859-15?Q?AHlS22B4YgPS2JTZfbZNRpUBwmcHxvuYxMFiU4/GxeCm8NFVGGgAJ4tXx?=
 =?iso-8859-15?Q?F4aJkiSkQFep7MWvn/0F7laLjdYkEKtTsORCsuB22543xTBsByH4bqtao?=
 =?iso-8859-15?Q?RPO+LXCvCjmx8ILqsWtfe015thMU2mL7r4VEWoU0a0JKbgs01jksih+TW?=
 =?iso-8859-15?Q?6wXr816XMEkevpl91HdsqNK/C+6Vx8+FB62ZaLXe9AQ2WvFysxQG7F+qu?=
 =?iso-8859-15?Q?1LszCK6g5EXe2PJwVgVbsej8LUbBdfbRtlKoTW6oZ8qiECrHPXqtTEdzs?=
 =?iso-8859-15?Q?6q6v71QJtpcsn92NkDzaDLGGOKznjhOjpe/zSvnSMLEeFPEJzK2BJFK+6?=
 =?iso-8859-15?Q?4XiEvHurJyZfWoQAN0yem5XFG1ZTlALjiz7DABMPw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-0fa01.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b25aa3-1538-4663-69f0-08dc141968e8
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 09:24:15.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P250MB0410



On Sat, 13 Jan 2024, Torsten Bögershausen wrote:

> On Sat, Jan 13, 2024 at 02:56:27AM +0000, Michael Litwak wrote:
>> I just installed Git for Windows 2.43.0 and noticed the installer offers three options for altering the PATH:
>>
>> 1) Run git from git bash only
>>
>> 2) Run git from git bash, cmd.exe and PowerShell (RECOMMENDED)
>>
>> 3) Run git from git bash, cmd.exe and PowerShell with optional utilities (warning: will override find, sort and other system utilities).
>>
>> It turns out iconv.exe is accessible from cmd.exe (Command Prompt) only when you take the third option.  But iconv.exe is NOT optional.  It is required for git to deal with UTF-16LE with BOM text conversions (and probably for numerous other encoding conversions).

For end users directly calling iconv.exe is definitely optional.

> Plese wait a second - and thanks for bringing this up.
> To my knowledge the binary iconv.exe (or just iconv under non-Windows)
> is never called from Git itself.
> Git is using iconv_open() and friends, which are all inside
> a library, either the C-library "libc", or "libiconv"
> (not 100% sure about the naming here)

Exactly. I can't find a single instance of Git for Windows calling 
iconv.exe instead of using the corresponding library functions. [1]

And even if it did, iconv.exe is definitely on the path for git.exe [2] 
unless you're calling /(mingw|clangarm)(64|32)/bin/git.exe directly, in 
which case the solution is to call /cmd/git.exe instead.

[1] 
https://github.com/search?q=repo%3Agit-for-windows%2Fgit%20iconv%20NOT%20path%3A%2F%5Et%5C%2F%2F%20NOT%20path%3A%2F%5EDocumentation%5C%2F%2F&type=code
[2] 
https://github.com/git-for-windows/MINGW-packages/blob/0c91cf2079184ae6a604e8f7a406a47d39305e72/mingw-w64-git/git-wrapper.c#L166-L258

> iconv.exe is not needed in everyday life, or is it ?
> If yes, when ?
> iconv.exe is used when you run the test-suite, to verify
> what Git is doing.
>
> Could you elaborate a little bit more,
> when iconv.exe is missing, and what is happening, please ?
>
>>
>> But when PATH option #2 is chosen, and iconv.exe is unreachable from a Windows Command Prompt, the git commands which call upon iconv.exe do NOT indicate the error.  The call to iconv.exe fails silently.  It is only later after you commit, push and clone the repo again that you see the encoding failures.
>>
>> And the warning about overriding find and sort must be taken with a grain of salt, since the Windows versions of those programs are accessed via a Windows folder which appears earlier in the PATH.

We should probably consider rewording that warning.

>> So this Git for Windows installer screen is misleading.  And perhaps iconv.exe should be relocated so it is accessible even when PATH option #2 is chosen.  I intend to submit an issue on the Git for Windows issue tracker regarding this.  I'll also submit an issue about the lack of an error when running 'git add' for a UTF-16LE with BOM file under PATH option #2.
>>
>> Thanks,
>> - Michael
>>
> []
>

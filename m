Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2025.outbound.protection.outlook.com [40.92.91.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EC3A1AB
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEXwkXTc45nElCCmjeDJCH+TJwv757fNTowd6vOBmebDKwTIWaEgEyJFB+of2De7lVX+P4pNCzbdqx2GJLDVTy/FX0MW2IBQ1/hVcvjB4qFBkcpi3Mpy3WjLyb/sWjevEsmQRMF56SGXJ/EEJmk/jTCvdQjz/C0gnL/mSjxWFLHn3hrW5Y2EbhNchfVWR8s0ClpTPk8ejxHHSCJa5N0HuPmD2QlTjd5Cu30n7H4b/kDRIIb7dJMzMJ5UeimYSoNxeLs+62eFeIU3kiHGeUAGOVDlHxnYeAFn36jMzwczIubVDF1rkKkI7geCJWBAZXhZcwSA3TeISjPkHORyJMn6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KClrpqLyD19Skgkv/qBgvEk3RLiBWJkNhCNj/23FNL8=;
 b=JLFU7/OUG7NomBkEUbHs4kZgRMz2Aq8M+d9mpyEH6p/N+KG3M/RWlblKKcLy3YsVN2fkDJC8+20/Wx2xN0ih+0UdYyoPG7dTzm9tZxljoeMSkN1t/nY31AmoIGS2hrB8AEFJIyztKAbu1P3VKbp0YiCun1B1MrYohtGaxomoCQlILnFLTu8dANT+uRSgHujMe2UnGwD5BIjDWzNWWv6NM57mIgOrZSqkMOWGViD3IXGMqRiFuRkeTb3VejKA2MHsvLupTBD9kZor+Qvfw5qtvrw7t/+E6wwJ6Vpb4rNLSd/d/NI0GXdpi8MfY2jksDWX+qRSyE2Q2CxHVIpG7oYWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by AM8P250MB0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:3db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 16:12:43 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ab0:984c:98b0:1982]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ab0:984c:98b0:1982%6]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 16:12:43 +0000
Date: Tue, 9 Jan 2024 17:12:41 +0100 (CET)
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: "Lopez Sanchez, Jose Maria" <jose.maria.lopez.sanchez@edag.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Credential error - Cache credential helper does not work
 properly
In-Reply-To: <FRYP281MB329114171822EE43AF9C8C0DFD6A2@FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM>
Message-ID:
 <DB9P250MB0692D62AD8AEC9F50A72C733A56A2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <FRYP281MB329114171822EE43AF9C8C0DFD6A2@FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN: [Sw4L0gcWcS7hdSQjBFkWYwLKKh7DUO4j]
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <4b40c976-b464-f21b-86a2-3f34bb74e4ff@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|AM8P250MB0020:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a67ad9-616d-483f-edee-08dc112dcf48
X-MS-Exchange-SLBlob-MailProps:
	3QTjV0QDnj8I+c3A7NbLL6tohk6bF6uDOu/RH91yW9mDHnHXY2BJAhHyR1c3bx78YHGxUxlEG4mm4MD54LnRfRthTZOoH/S9pdcOcWsnnel+A0lf4Pl9wCWEkurWOE1WI3KBIX/4halS2M71jUs1kEWhHMLjRoaWf4R9Tc2NoRzjnscqmoRkyHKoGt509MKPp1YlJh1vKBI3L3xucCQqBEIrasEXnlvRV6GPSYcFmp8OdIq2JUl6zjUASKxFsexlProG/r95550+UvCAhVjmD27tVy63aQ/eA5tRz1HYkvNACvB67Foi+eqX8+qSJw4KBpJl4VpA1uYLzzmzN1ya0uV+MCti+yapLcRdF1UANqaWg6ndnbsz7UPvzI1qKhonvARRJR8WuxCH73RSFItAE/b6i2EACJP3K/sz2K9hgoQJi6aPc/JVysvdZCGyOSDZewdBKO3Ej6m1DC4pCdwuPcyZ/wnpBhTJaBYNh5BLkcObx2nnYmeJqboC/UFcGCNg59oH6Nk1k4j7+dHggCK40zwm8bex9WmvOW6VXqHsSy8pGf+x0JE3KfwX7gYAqrMuxhKB6DPfrVBm/GMGQlX1X7LElgaa39+YH1i/PbHbngMW8TsiSZCx4zhgOw1ijdYIwY2a0ecdKkAL5v8rvf90oy9Zp/S9mL4XwjKQxpz0UoGAF/Q5ux0eVeRI+1zjRGnsZSr4Gx0NetuMQrXdj86h7tijJzoSRPBwbN4lEAJe3b/IfnBOdNKZ8fEgSpfVjy8HLaUOiYr4ZHthYuLCYtW+/Z2Mf2yukwxT7ov5XtPoQwpQ9uDyIqmwcObNC9UO7j+OIFfnfuGAvgxQlvwoblTHgZyHHrUScAdhMvJpxuM76owVLlSmvT3URA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uLpL0nD+WXtTCh9wrZqtl9pIU+ZEb30ajk2+90bOkhkchc7+cNbbhLBValO+Pg3fXrZ5TCSeXTuvtTtW2nY8WrH27KuhqU3IyEzZH+QcB4d2DwmO3hgc8kJGWD2fR9FPvLxcNo6+b7K4+MqU1yBIfrVac4bEgPL2WvgvlBVaX/EHr6ORclvEU3YlFEdZZHNyJRTXoE0XiqPg+/fNfhv1xS7TIJHuq8ncf1JltRef3Z6WsQ9OciNK+wM9CTwVuD+gMQaig4GkQqXM+T729MwzkhLXgOYT8LIqD/8m6JGqIAjfKeRYUmRVAkpUXBxWZ2+PUnmSoT8WD5/RK3ilol23lPZYKcfvgmcEgrRAE+JnRLcVI/TezBBeR7lM0rVle0d3+rSBUHP7NmoNx615hwCASSC68OmOZnx9aSzlu0VwmnM5OP5yEi8waaRTf/DLfUA2FJyk0ARiZ2E1grm6K4oTnKSKQBlRDl/pxO0NKJhtHxmUHy+wghNzncyghHBjrpeH7PaJYPQWxMIHUmx8hrhpelY25CDBZthzfj/8B14eWNvwgZsgzB8GHVWpuSU9Awd1naWKau/bSYUJ9nbuQ047Pzg+BfUTclB2GyNGV4omooiH5/4IrJVCbqstYsZzsYZwyuL3KoxwQUU8T/rVMafpZw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0F6bkc0c0x3V1dubHNKOHNwdExsNjRSZjlxazM1NXZjNHRKbk5zbnVmOWRa?=
 =?utf-8?B?Q0dKZmdybHpsMGc4ayt2bGtZRFZlamR2L0VkbEJDT0VSZDM5VERWd1oraE1R?=
 =?utf-8?B?Zk1wWUVGbnNSN1d4bTVGa01oa0J6cFczMmZHeGcxdS81UEtjVWJZT0lxbG5k?=
 =?utf-8?B?Yk9CRlNicE0yOUoxeGVQTXVMWkFqQUdESklTSGlCMmFyeEhEdXRtSXdDT0Vj?=
 =?utf-8?B?elBPVFc2enR6YzBkcmJYY1dhWDJncHcrZXBYcHBGenlsYXQ4bjM3L0ZVenFp?=
 =?utf-8?B?c1lwNDRIN0huaFdmVmtOd0VyU1FOVnJOakpaZzA2NU1sWkpzVlBJbWhSZ3Z0?=
 =?utf-8?B?RVhmWkNsUENTUndIYnZZYldLTisxTDNZaVJ1cys4MjRlNGY0dWs5TlRDdkJX?=
 =?utf-8?B?UUtua0ZsWWNGQnlhdDAycU5VRkl5VlRCRmI2OFFXY09wRS9ncDFNR3BHV296?=
 =?utf-8?B?THR4dTlmTmNSOTFxTE9McWdkaE84UmN6WFcySklZSnlFRzFDZGZpRGNWS2ZX?=
 =?utf-8?B?aE5pVXMwTWV0ZU9GdUxtSnZxUXcvQWJ5V01FWVZpOHhXL3gvQXJuL081bHps?=
 =?utf-8?B?YnYrV2FlUWVuZzVrR0FVVzkzQWxBNEFCd2FlY1BrYnpndU5vNEZMTGx2dUZo?=
 =?utf-8?B?UFdrdWZ3a2RMTitiSEVIYmM3UEtBaUwrQXBkM05ya2pidlpBL1g0NC9vdmF3?=
 =?utf-8?B?R1hZdEgwKzdqYURNZG4vL1JmQ0lVaDdMbHYvcG1VNURmaFlsbmF2SUV6OEdO?=
 =?utf-8?B?aFYzOTZJSVpSUFp6aytWMFNjeVZkSkpNUU82U0Vhc0U2MzBoSGZWUjNEczFU?=
 =?utf-8?B?WThFWHVzdEtNS0ViSk1sNDN6cUlyTE9FeUUxZENMRyt6OE1jMUlXMGVqS0J0?=
 =?utf-8?B?NXhlUzgzTlZHaVUyblp0OGpXTHV0alpKaTliaU5wcjFUcDE3aTNEV1pkL0o2?=
 =?utf-8?B?WU93MlEySlEwdDVSRThUWTZBdlc1YnI2QmNVNGFGS2hua2lwUjhDeXVicjFQ?=
 =?utf-8?B?dFY4ODhHMFRzaDNZK1R5RUhwY2NaLzdjZkFLcyt5RkxqV2hLcVV6ZEw0QXZQ?=
 =?utf-8?B?YmU0TFZBTFhOY3VmNExYVmlBczRodDJreTNwcmFWc0pvL1FQR2l1UGM3cm9a?=
 =?utf-8?B?cFFlY3FPK2VzUmFwYmtMUWNOS1lwR2ZyTGZBalNIR3J0c1JhY0xVV3hiVFFn?=
 =?utf-8?B?N0p2TnR0S3FXazVLRTVTLzNHNXNXYmdmRUIvU1RUZE5mTHNEWUNIQ0Y3djZD?=
 =?utf-8?B?RmdEMTU5RDFQMDAzOEtmaE9hTUVNc29HUFZJQ3ZVL2lXa3J5d3JLVlF3cHNU?=
 =?utf-8?B?dFdteUVHdUU2TDF4WEFnY0Q3MkRuTjBtK0NQcWhkU0E3cmx5TVRxQWZkcGtC?=
 =?utf-8?B?N0VqeStBK2pBaVlGUzBGYlo1cGpkdU1SU0xpQSs1ajJhaGIxY2MrN0VoWS9a?=
 =?utf-8?B?eGp6MHJzWmRqTmRLT2tUQm1XTW1ROGR3ZDhYYjhoMC9vUm93Z29zU0lNV1Ar?=
 =?utf-8?B?aUVkdHlRNGtkSVVidGQxdVVaaFAvNmtrUEhONVYrdU54am9sM3N5Zi9mMjMz?=
 =?utf-8?B?MnZ2c0Zhb0t6Qzk1dk1zV2dsaUNvUFI1dWwyNlN4elQxbTFXbG1abkk2dzV1?=
 =?utf-8?B?TXlTWHg0KzQ1eTVsNG5kR0dmcXFGNkE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-0fa01.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a67ad9-616d-483f-edee-08dc112dcf48
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 16:12:43.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P250MB0020



On Tue, 9 Jan 2024, Lopez Sanchez, Jose Maria wrote:

> Dear Mr. / Ms.
>
> I am José María López Sánchez a senior system engineer working for the EDAG Group company. We are willing to use GIT to start controlling our project versions.
> I have an issue when I want to stop inserting repeatedly my credentials. The cache function is not working somehow.
> I have typed the following:
>
>> C:\Users\jl83870\Desktop\00_temp\GIT EAGEL\eagel-project>git config credential.helper 'cache

Looks like you're running this on Windows, so you're probably using Git 
for Windows, where this helper will error out with the message "fatal: 
credential-cache unavailable; no unix socket support", even when 
otherwise configured correctly [1]. If you compiled your own git (2.34.0 
or newer) without NO_UNIX_SOCKETS this helper should work on Windows 10 
build  17063 and newer [2][3]. You seem to be running this in CMD 
or maybe powershell. Different quoting rules apply for the two, but the 
leading "'" before the "cache" is definitely wrong without a trailing
counterpart.

[1] https://github.com/git-for-windows/git/issues/3892
[2] https://devblogs.microsoft.com/commandline/af_unix-comes-to-windows/
[3] https://github.com/git/git/commit/bb390b1f49406d967e8bf3401337cf1d9535f820

>
> Then I introduced once my credentials to store them in cache. If the command worked, the second time that I attempted to pull the remote server, I should not have typed the credentials again to be able to trigger the command.
>
>> C:\Users\jl83870\Desktop\00_temp\GIT EAGEL\eagel-project>git pull origin
>> git credential-'cache get: -c: line 0: unexpected EOF while looking for matching `''
>> git credential-'cache get: -c: line 1: syntax error: unexpected end of file
>> Username for 'https://csp.edag.de': jl83870
>> Password for 'https://jl83870@csp.edag.de':
>> git credential-'cache store: -c: line 0: unexpected EOF while looking for matching `''
>> git credential-'cache store: -c: line 1: syntax error: unexpected end of file
>> Already up to date.

The superfluous "'" made it into the config file and is causing these 
error messages.

> As I mentioned above, when I want to pull again, appears the same previous code.
>
> I have also tried with the below options:
> -       git config credential.helper cache (without ‘ )
> -       git config credential helper cache --timeout=1800
> -       git config credential.helper ‘cache --timeout=1800’
> -       git config credential.helper ‘cache [--timeout=1800]’

I assume the "‘" and "‘" are supposed to be "'" and your MUA mangled them 
a little. Otherwise that's definitely part of the problem.
If you're on CMD you want either
> git config credential.helper cache
or 
> git config credential.helper "cache --timeout=1800"

If you're on powershell
> git config credential.helper 'cache --timeout=1800'
should also work.

Do note that the Git documentation assumes a POSIX shell when it gives 
examples of commands.

Best regards

Matthias

> Am I programming something wrong? Could you please help me with it?
>
> Mit freundlichen Grüßen / Best regards / Saludos cordiales
> i.A. José María López Sánchez
> Senior Systemingenieur Antriebsstrang / Senior Systems engineer Drivetrain / Ingeniero senior de sistemas de trenes de transmisión
> Fahrzeug-Integration / Vehicle Integration / Integración de vehículos
>
> EDAG Engineering Spain, S.L I Reesbergstraße 1 I 36039 Fulda I Germany​
> Phone:  +49 661 6000-83870
> E-Mail:  jose.maria.lopez.sanchez@edag.com I www.edag.com
>
> YOUR GLOBAL MOBILITY​ AND
> INDUSTRY ENGINEERING EXPERTS
> Find us online: LinkedIn I XING I Facebook I Instagram I Twitter I YouTube I TechInsights
>
> EDAG Engineering Spain, S.L, Carretera del Prat, 65, E-08940 Cornellá de Llobregat (Barcelona), Spanien
> El court register: Registro Mercantil de Barcelona, Tomo 41564, Folio 15, Hoja 92217
>
> Please consider the environment before printing this e-mail.
>
> This e-mail may contain confidential and / or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorised copying, disclosure or distribution of the material in this e-mail is strictly forbidden.
>
> ________________________________
> Die Pflichtinformationen nach Art. 12 ff. DSGVO erhalten Sie hier<https://www.edag.com/de/rechtliches/datenschutz-teams-e-mail>. / Mandatory information pursuant to Article 12 et seq. GDPR can be found here<https://www.edag.com/en/legal/data-privacy-teams-e-mail>.
>

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC015AFE
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2086.outbound.protection.outlook.com [40.92.73.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A14F7
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 02:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn1/S1CKKh4klJdZcEME/RwTzEKYWz4LPatWpZNoCfiXb4y3IS5FTZVsQoYiaZooS1kF+qpKl2svlVVZ8gCUoUv/GZmLfBn2HvOVJZhDFRRvQkfj6vpinP9MXbFU7iOje6xdVhSxtB54KCuCRHmlroeeUKgp+Feum+vG4SA9DbfM/H3GhXzhujXPnyNB/59n6ThYjcUYo8qs1IYoS/+8I1L4c1K0TYSpKcJDhQijWrRv5SZeQ3q3ze3+JXGOmmH0MvY1N73TzkXaVd0+L/KLzV2vpGyG+eabsnZqBfE1GPpzze+HaD/Qqci0QXbyboN8Qh3RZ3G1Xu/4nUOLQrV42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg5AOt/x+MFOqbNZlr6UykIrx44HduQisM76M/eSjFk=;
 b=XLmmgXkEMPt1Sn74lHCMXbt80iMR316UWQJ5eh9jto6+ZK3fzLdI1DaReWJG+P+T4CPLiztYFbzt9onJDLdR2deffT0KXMPgwSeVLcSVP08zDfCQqNit+/FhDCBwFetp4VNfAcfvrWuwlNGJ3WE0p0PTzlhWlZuvBRqQ8+X1bIc0Zo1J18P3j4O/RYGmb6YHhcw0fOWdutimHw2RwG+5LiBFSzVxJVz2xH7dONVtIkzNotvnfhYTksi7JxEDBPehvxchTt7f8bnkWuZOUmzZpt9xjKtiAZm6Fk/HoRqwIVrPpaYAaHNgbQH8VSb6yrlIMyhqrv5nyenWd8XBk8Omdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by PR3P250MB0067.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:172::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 09:44:35 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::61b4:15a4:93f0:adb6]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::61b4:15a4:93f0:adb6%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:44:33 +0000
Date: Wed, 18 Oct 2023 11:44:32 +0200 (CEST)
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: John Trites <jtrites@tritesengserv.com>
cc: git@vger.kernel.org
Subject: Re: Git does not work on my machine!!!
In-Reply-To: <002301da006e$2e2d3c50$8a87b4f0$@tritesengserv.com>
Message-ID:
 <DB9P250MB0692C372C7DED9C4901995E1A5D5A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <002301da006e$2e2d3c50$8a87b4f0$@tritesengserv.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-TMN: [f6Z5tzY59Bu7EAPBfx+qJKKnx+4t96fQ]
X-ClientProxiedBy: FR0P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::14) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <5424f261-39c2-8cad-f914-e180dbd5b2d7@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|PR3P250MB0067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7d66ce-b99a-4ba1-f544-08dbcfbed557
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p5kdeW0SHa8BqKAHVeSyXiOPBcmibYvyyWi3JRg+0RgHAdonSPGoVQWGMgUREK7z56PAAinGtMcjOwKkrpdC0i47zmlNM0Xk+cRbhczJ6sDARDercHnx64UMzQTBcDClxgzMh/44ds/aDi2FcBqQoVr1YHG5fPk9Wp/hkgPfSLiGQBm/5l+gG57uiELS3p9tV111gM+dZARRGG5swA5O35D1EMCpuTkwI8HtJ58uSLzXXmOXvCc7dV6YE8oFUTX3RwsY1b55zAKFUODMng8pu3kXD9I9voqSXfMwQBYdAt7PMa52A7ihahaB8AMnRUE0ovivPtQyLbT/iTi8YkusM6ZlvBbtNXoSOrQb2qMHKzF33dAmDxzoOG6K+hjantNHSfbQPDazn3eGUuO5v7qwnkwmSsS99amU+oQjPmIiZTkpDZUsYPo+bvwUbQSLAszdtWf6XMXKGbUb8U7P9Zwnj0RURuthG8h4iIZQgCTN1CMOBbTjpnPKtx9NymTDs6ZnMtS5K0df0ttpnfeylXiEW7KGOxsVZZNHGZ7xxofVUAJ4APmDUyedbA9zTEbrfgj2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BRlvnEysH22wlQca0W4f9A98bP/avZjkIOgJtl171uZPEJlC1rv9+DNWfVPt?=
 =?us-ascii?Q?cbzjfvvyb+3LwZdyYfE2d1aXtCrWAsykkhwZh8CZ060JCYPaQtbLRulJjtCK?=
 =?us-ascii?Q?1T8ODIe5Cn6qMNcBxDptZeo1bkKjdUZJ46wfCsPyVQFMhW7pARKJUam8RbGk?=
 =?us-ascii?Q?MEgejeI1KSe6LSgC/3RUwe16xrOsuYLTR4TxKy+o/KeUQyhi2pXV0ghu7r4h?=
 =?us-ascii?Q?H/2ATO4TwYC4DHYXUV3WIKKTlL1vo+RvlPwmFGoX9PR43HE7Lb/EYbxUS262?=
 =?us-ascii?Q?984iplVVFlqvrHaKeDykxrF5+YcjAKRe+LFLlpMqlT0/FP69QMBJNnfuHM40?=
 =?us-ascii?Q?KMRFaNo9xW1YSBDKDp8w5zpo7d0ELy/1qz9Na7mkbJl5s5DKDgCu6+wyOxjN?=
 =?us-ascii?Q?boa7H3Rs+VAyNi8DMsjJZRWAawPQnuTFz8mL5SR1F/m37DIZisXz4RmySBLs?=
 =?us-ascii?Q?3wc5F+ucgSMMDkCvBhx3VW03fY253Sf5mCxcdzgcLC0r6yrSPYnR9v5UUVs5?=
 =?us-ascii?Q?CRGAeUHBtj3PE5JPAM68MsYUlFlNtnvLS1HP5q8ZmGsTYuHWqYY1LFjgTfWz?=
 =?us-ascii?Q?1mHnjN6piU4QSsE9VsisX3OYMkiRgEo43nKwRkIAGk9GiORCYECYcGBF0kz+?=
 =?us-ascii?Q?sm+qzIlQAbeZE667BAU0HMJ0Tf+suWIu/Qrqfg0gerpM1sZS/HbESBxlLZ/O?=
 =?us-ascii?Q?IydhwdhVb3Gpocff1HKGRjFwTPgLvppQ+Wmgg6UrEUyxqHwYfz6zuuh9nKWN?=
 =?us-ascii?Q?g9Vett8whRWL11gBEUA2ZMMRmU5psUAmuTPtB8cvQWQ7GrPy42BMD2+usfV2?=
 =?us-ascii?Q?YgZMVSqbjQsvORlX3lpAV3mqNo9fmQQhj4KDeLDfuLaBsRxGsNskpxYCEsEI?=
 =?us-ascii?Q?m7QLF10VFTNip/l44o3koNjTp4JeN0JEtrNTbRia/CC2pcsGx5BEXcH1nej8?=
 =?us-ascii?Q?Sanr4JV6zd5vZnu/U7Ivkx0Il5ReSZuXgayIhBrOaYSZfio2RRbrv/6oPBON?=
 =?us-ascii?Q?Uwt51qBeDrUleRCharWyzCRkgBL6wsdkoU9zE+eyqYk94n4nbrveHHEZvWd4?=
 =?us-ascii?Q?JMDyXRsVkw5Ccz4mCmwH6os7lD5X7znBIZ0Jl/wA0jl/Dv2oE3vRnsTQjYHE?=
 =?us-ascii?Q?Rz15xy2E2C8rbSna/nW66ngvzaXiF0wsqrxjV1r8CCA0C36CXJrg7RkcUMie?=
 =?us-ascii?Q?4HCySHoR1SX7NM9x9VxHoL13YjsZtDnPa7eNqA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e3d53.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7d66ce-b99a-4ba1-f544-08dbcfbed557
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:44:33.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P250MB0067
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On Mon, 16 Oct 2023, jtrites@tritesengserv.com wrote:

> I would appreciate some help resolving this issue!!!
>
> JohnTrites@MSI MINGW64 /c/Users/JohnTrites
> $ git config --global user.name "JohnTrites"
> error: could not lock config file C:/Users/John
> Trites/AppData/Roaming/SPB_16.6/.gitconfig: No such file or directory

Hi John,

it looks like some of your environment variables are misconfigured.
This could be $HOME or $HOMEDRIVE and $HOMEPATH or $USERPROFILE, that 
points to a seemingly non-existent Directory:
"C:/Users/John Trites/AppData/Roaming/SPB_16.6/"

hope that helps.

Best regards

Matthias

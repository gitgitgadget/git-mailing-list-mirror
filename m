Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2031.outbound.protection.outlook.com [40.92.45.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988AE73F0F
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937991; cv=fail; b=Rg3td0Kif/aTUhJiK5v6mNtgjTVGcs4RKRWG6mRXi2OIbgT9czqg1r+QQbnZExW9veTY3mTDNVQoqxzvN32InhYuUu2PmupvOaqc/0z7xmiB6RJ7o/vF0J8rKt0XLs/oonPJLyvnrC3Wp7gReHxxmsQV1LWfF0W3WWf7BRUM2T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937991; c=relaxed/simple;
	bh=CvJ34McVXwN32lCVFdBaECLcgcWSwbzGNVMrTYoIVIw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LsU7wVlENsph72+qDZuFp7yTfDnTm4rkSnJFpkOo/idpubYYUMM15WfqqOunZ3piAn6WKazmkY/RQCTDKR8PLafqfVVZpNGpZAuqHko6Qkw1YmF67RswU8DFQ6NUiz+du7xxIBCe3+1lJn5XMB5Cf05sSWkkom1uhVUdQI5LJPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; arc=fail smtp.client-ip=40.92.45.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maJV8VllmfMRH4E3yE8JFH4vMFCToZKL99n0Rt9HGAioAd+RzYTW0TXjUWR+ywbIwB+9wINnEpjVdz5j5kcfyzgu4zxUusWSDA16y48TpIY6YVIYI+OxW5gU9X7CBGG1WDYvmb1z2DRx/Pn1jGfvwFMPEzUgjRD/FE7sY6VVV87cO7UANwoUo4E9Tu8D3u9Te5JlB6JJo9cy2F+1j9AEHktCvJ0nXC2Br1WTN5gZdIRT+QZzkak4yvUDfKKycT8C2w/BpebolVEb4Io6N/V5+/qSrI1dSQ27fBoHP+eAW1H+ErKGm4+4SIJf6t8SDzQx6ogRq4Tn4vhM/Lsv7qviXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvJ34McVXwN32lCVFdBaECLcgcWSwbzGNVMrTYoIVIw=;
 b=ckTqdR+2MKvybXgnIudHsnaZFDqmDJCMyOytotnV8kAsITClNdnCSZUUjdaTcFYH+LoeRLhb5eGLxT8ogi1P721LYVdRjyjeqejrptOO6/71ZbDOBaHcJlDt6zefTerQ1NgbHxg2jkaa8K3OPP4rTZO1AC54aWarCY83hnSHwpRDcL6F+7MjpsalzcWp3NJ9JxCUEQz2d4txBlG2jucFg0Dy5/2b6NrvPvrbP91TOmttoCBhKAnSbnRInBQzrju8U85codFgueVKEeFip7W81qjpJr5wGGIG1FAOe7OaiNvGsoRFHISIA5Tbd9tuBZBwQNmC7jLqIGkeeOUGe/H6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12)
 by SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 08:59:47 +0000
Received: from MW4PR10MB6324.namprd10.prod.outlook.com
 ([fe80::b8fc:5bac:6272:88fe]) by MW4PR10MB6324.namprd10.prod.outlook.com
 ([fe80::b8fc:5bac:6272:88fe%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 08:59:47 +0000
From: Chaython Meredith <chaython@live.ca>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git For Windows, not installing right
Thread-Topic: Git For Windows, not installing right
Thread-Index: AQHaaJHsXoYxgFxVlkiqT1MyvujeUA==
Date: Mon, 26 Feb 2024 08:59:47 +0000
Message-ID:
 <MW4PR10MB6324B0F27AE4025F111E2547CE5A2@MW4PR10MB6324.namprd10.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [iBHaWVNni29/a2rVwqDOWCO7Uz8vSYy4]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR10MB6324:EE_|SJ0PR10MB4605:EE_
x-ms-office365-filtering-correlation-id: 8e72a210-8a0a-45bb-67e0-08dc36a94880
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cfTDncHULxY5m4K2JAqT0GFZSIfIerR3WiOu+DAR35Y8LQJ5a59ERm0uqvRi+XWzwEEKHYPuYgAd78zZQLUzgfTw6wkF/HYluuQITxuIlvy2PZeSkOGep+3ujGZr8Nl51mtlWcZ2GQzmx+fDdxz4VQ21a8N0jvBtFiKAmFwdE9n74ry+lk64GQyY67rN1RyxmefzpmW8WvJ92R6XIMg7/PM0JwnUr/LUq8IAfXUG0P0b0qSW8oEfQ776Nm7+M13NhbaQ5QWSigFhng7egr5U1OYZ5hgKb0EidDYFQ8RXaYQv373I9sYgxKTFUS96wz95s6EYEBN7epTrYMNJ9uHJEEkShTgzzODzp6P85Epv0+7KghmkuhgEzPhL9zZJG0QbqGjxthBi9AHfam00XNr2uSFOIBMfFEfJORf42az1L5jDSdrdutB73Jpipvu2T+Em5sBDWk6PlndGrsMLDIVxTSDeJoiFo+vW5M6T+jrDkNtyKKuqqnuKe03o4Lw9Xn3uI3ZfYd8GzMp/TRcflzg0AZHvCSIK1dEEKpbEbsTFmYeiFjV/Xn/b/8PNSvBb28suasgsDssFm/Wv0MGzfjgHSjgShYyzw4Ae6S5ibghKKdMFZJg7hapvkPp94AZwhVS6tJ0APNRUpL8wPRLtiO1veCyhIONfL7JgDZnOcyxZRNE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?d6XRAcMJIsaQVhaiHJNaCoWm1EsWq4mHfO3OqkQoMgpGPpGgyhkkqQirNG?=
 =?iso-8859-1?Q?rJn2fDS8dryVyMyuoQxR4kOwLA78C97xS3cLMyQIyRxRI3OuiF2nIYDF/3?=
 =?iso-8859-1?Q?XRe6bQBr7jesQNhUydOWSPxaPByc8en2GJeGDiZP6VwHC0pPNtz7KkclNH?=
 =?iso-8859-1?Q?wvbt7sLdex4gRtaCTaj0QVLQsoACymiBNbNkLc6apTOYcP3xX4mtn9PxH0?=
 =?iso-8859-1?Q?y0IpJgcSYYePkP3cuttBqgjjqWRv6NAZya9r2HWx/Wcyiha9McNvgY5T0n?=
 =?iso-8859-1?Q?8V1m1BgPtB/HzBXdc4xSxFAEZtmVFWBQQ6JBd7nDYNwwSSHr4OEDLMrx5G?=
 =?iso-8859-1?Q?UXFRol3Hl7TZhPOvskRlqGPbCPu+kyfCBePpI7PzqxIZcS4w/3pwBF3I9f?=
 =?iso-8859-1?Q?DEwAKnCGIKOg62LoZEYvsYYmFi9lN5/u/urU6DIzaP16oEXUNk19dSlEV5?=
 =?iso-8859-1?Q?IcIwJZtZJmQJBZNQIz+ePu6MzHF2Qsq61tfbXdLNQ5uJ0PaYuCxtvZX3ir?=
 =?iso-8859-1?Q?Yxh9ysFq2ZmrzkVGosHbliUAcopWrMyXFUg6R55M6qrk7BHzdUDs/BbMfT?=
 =?iso-8859-1?Q?Q0LiW7Ik3sgfSwY0wb/Os0uR0m3q3S4Q8+AM4zW4TbirZDvJn7RzpIbCDX?=
 =?iso-8859-1?Q?mKj0b2ANURSixujvcTzVNV1qfQKNhLczGUsPQ1YCSeuNqh5DAWMpiTIUoH?=
 =?iso-8859-1?Q?xUbpmwZvNLvwH4eOvHHQnvzxlhXrJoQ9KN3rHP7AD7t7jZ4yIOKo/f5MJ1?=
 =?iso-8859-1?Q?ocibe4Lo0qJdia3cdMpDzve+Vcq55rxbUECU4/0snbLeJ2dZYr7Qg3okgd?=
 =?iso-8859-1?Q?BaDC/LN3DkgCt3S9zy78nuMhAkbRqhKDQYHOiOMmEsUrMLNvuvKQVVxeu3?=
 =?iso-8859-1?Q?VKwAJPV0sEG3r1Uc5Oag26aOYw/CYV8z9ybPC1pv2jtAhWQif71qtAjq6t?=
 =?iso-8859-1?Q?jeDS6BNjAKAcMfGNXrM/RAI+k8HUK7b6z6eKUg+WeViF/S1NB+ssFOpsTb?=
 =?iso-8859-1?Q?iF204XOSWmfj68D9dNkk98rHw1CbX908wqJL4VDIOVupQiQ9iG84/lT+Bz?=
 =?iso-8859-1?Q?XB4xm1d8B2hL6JmusE6gnmzZG03vWQUfr/4S4RISMeoLF33HaCfbMtZx6e?=
 =?iso-8859-1?Q?OADrl9meN827M7Am13JjIJPUh820641EmDnLOrZaUbZ8BVEP0XdoT0pINm?=
 =?iso-8859-1?Q?WJF2M24a2dwqPUt4MI8US95XJtFSz/DvFDkxWtybRrds4TzF3qw2paQib8?=
 =?iso-8859-1?Q?MvAoLQPFeAHu2dX9FmCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-28291.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6324.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e72a210-8a0a-45bb-67e0-08dc36a94880
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 08:59:47.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605

Git for windows, is not setting environmental variables, despite being aske=
d to during installation.=0A=
After setting up environmental variables, errors still occur.=0A=
=0A=
git 2.4.4 with all extras selected [unix tools etc] errors out in visual st=
udio code. When trying to clone a repository.=0A=
> git clone https://github.com/Chaython/simplewall.git c:\Users\Chay\Git\si=
mplewall --progress=0A=
git: 'remote-https' is not a git command. See 'git --help'.=0A=
=0A=
I've tried changing installation settings... Installing from winget... Inst=
alling from chocolatey and obviously manually installing the x64 executable=
. Each time trying BCU/Geek to properly uninstall all leftovers.=0A=
I normally clone using github client, however I thought it would both be mo=
re convenient to use visual studio and github client didn't automatically i=
mport .gitmodules so I could compile the application....=

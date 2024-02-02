Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78212D770
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900236; cv=fail; b=tIEQUIt9QbqnbZfoHuIOnVIZFkhJhnVuRAz0SdaMcWGjRZgr4U7tZ/hsbgz5xfuqfJmgdp8YAgEbIPaezwE3Y4b0ogkLdstqLprDhrWvB1CiCmuU0G/C+LzrZRN+fAarJ9oY47VG41XRhabng72alXrypxf3csZl2uxaV6nml64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900236; c=relaxed/simple;
	bh=Z4tyJqx4F5K1P+5Np7UGqSOrgni7KIJEprVeJtMiHTs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nVvHOIcu/VeNbQiYBfCH7tpSMooDDfP378eUM4jRo766qHnNSmeX4HvFN6Yi0J/FDmheAvsQhtLavx/OAThbm6h8CJ1/OH2x+YJl8j6gUHTv7H0CoRuZ/qFOWrgeseyvotQXbhg+4EJNjM5J3jbkmmsJ7W0X2x881YUTrj8oV9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dlhcorp.com; spf=pass smtp.mailfrom=dlhcorp.com; arc=fail smtp.client-ip=40.107.94.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dlhcorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dlhcorp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9BmjY0EDbWj+XT4mapL/MU3sOtSdf+/RRphtpZ3dFUEsnIzdHQJ4i1s0d9ACWJ0AXefja1dLijDIwZMm5XitpabJJdYeAuHzqrNZBm0GXPPgpMXqSAzE+cblyAYnp2cjF33lotkUqplX462ioePQBwnNN8EyHm4pjfvD6UtHPvK0Zcab3VjFgH+UYQhe5IQapwNlzO/mX+V4Lt7qNBKyIFbtJ5Ng5OfA9tP6Gcwwx/6uxgcQgLUuEL9I+HX9ZKHNNGwGMlYLKYgBPN1jl5E4jM6i3TzgOLp9SocxGL6x1Wz0AzIagBFdk9hfnJykMgqV1mwFJ2ghsnQ2EPtg/KWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDNbiA/llxqkcQMG+G2s5O9WiNfHpKi5FySJaKvKL9c=;
 b=WPud/QTrdLhCF/vLbPUbCPrrD4KFnSDIm8N4ZLSAY7+NmZY6DfsoqJXuObb8iio4ilWOfX/dWxqyA+KrM/kw5Rft2fueqeT2fq3hiz/KBHYMds0wFNuChEViLkQPZMFRPs36IRSvSI60EZEYHp33RkWObMY5/UOCb53xFa1AsDZs1V39JsRuruDpaqNIGdMWzxCH5tFLpSExeRz7GZtimsd/jMYkqYj4+aAQUEKDdnVdNEl4o3Wd54rJDJSyBOYiq1CgYNJUTE0PrmE2moVeGuPly/JTf9AP0Pl+74L6bEd6/hyvUxNaU9zSQCMzFaW4mhWaZDhmiwrgoIDNum7YIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dlhcorp.com; dmarc=pass action=none header.from=dlhcorp.com;
 dkim=pass header.d=dlhcorp.com; arc=none
Received: from LV8PR13MB6560.namprd13.prod.outlook.com (2603:10b6:408:22a::12)
 by PH0PR13MB6136.namprd13.prod.outlook.com (2603:10b6:510:29d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Fri, 2 Feb
 2024 18:57:11 +0000
Received: from LV8PR13MB6560.namprd13.prod.outlook.com
 ([fe80::738c:4313:3c3f:7aea]) by LV8PR13MB6560.namprd13.prod.outlook.com
 ([fe80::738c:4313:3c3f:7aea%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 18:57:11 +0000
From: Christian Castro <christian.castro@dlhcorp.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag for
 this title
Thread-Topic: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag
 for this title
Thread-Index: AdpWBxy+1+dpg/5hSeqyrICsnZ7myw==
Date: Fri, 2 Feb 2024 18:57:11 +0000
Message-ID:
 <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dlhcorp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR13MB6560:EE_|PH0PR13MB6136:EE_
x-ms-office365-filtering-correlation-id: caef7ad7-31a9-4ca8-e7a9-08dc2420c364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UakHDFeMQMt7JG7JXoPEmG939Y2jDZAOrJzjnzw+b0NROrIjYEKE78S8Pl/jUZ5q4HIP+Rg3K7GbBdDzn1/hcdNF3v2tMczP1yS9KTuitjP9cnvLlju+tTVLCBd6hHIUPWg1egCNC3SvbKQguzYWR5J7PfGjGLJUWtXm0tRozkT9cKnCRxUPg/wcvAfJhKUnC84FrwLB07bMvCEwuC/6KkTpiTDC7A6LTmbcby0WeBciqz9H06VLsE0nKALsmT7QUP50fMIM0m5qeqLdXno8h6drwsRcwnO+tfHALApOmfPmwNZkiQqUl4owdJGRJITAmHxhseGHo/L62I/nri+/BILN9kqPZ1QLqV7YfSraNfIDB5kEYoReg7UEzevf8o4e2SkhlIjqIwaLKzW5bF1KfhQWlwQ/48PH47sPTxqAw2jdiIqlCz+1xqS2SmYCobU6KXZc4G9m9XoLJaksG15/cyPsLmieu0oNbpvFGOZkfxYydRN2vaHCXfaI3U52qeEbzwhv0AZ4vkv2T3EZcRL361YoUrpox1csw73OJSs7Nz4E/owSnxj/9d7bFdWwfRgoxVQjwF8NAKRMpgOeyb1ru5Y48hQzNj+PQ5CFoWYJsmrNUWnTVFh9H23uW7nEucY3Ytdv8A40c3eHEflcQ+FWYwbs2qovj1uH7OqXIGPYdkI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR13MB6560.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39850400004)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(86362001)(33656002)(40140700001)(38070700009)(41300700001)(66946007)(66476007)(316002)(6916009)(7696005)(66556008)(76116006)(64756008)(26005)(8936002)(6506007)(8676002)(9686003)(55016003)(66446008)(45080400002)(122000001)(38100700002)(478600001)(44832011)(71200400001)(52536014)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AnMdSuvgoNl+/FjDz8kFdFwr5QDCvGa1mGrG5amooyCvYO71pP9OagvSPn?=
 =?iso-8859-1?Q?kZ11gtXZlceYTS9xzMKcugVprDtIaNvmeq2LYl+LTbImHZDu3f3FshKL1d?=
 =?iso-8859-1?Q?pJaFuGZ8+kXaqcaVobszRV4vOjnF7Oaq0aEtLq5gPsGmx1faMoXkWA0M+P?=
 =?iso-8859-1?Q?uzC0610gyr6kvlMCWE6doQhW2sAyjLcLonlqRGw4Ne32xN457SRdttxyRX?=
 =?iso-8859-1?Q?gwsDog702/P+ZhrLcYze57GIB8+WlgBx0kBMqXPPxxPU9EcH1/Dc3MMxzc?=
 =?iso-8859-1?Q?jDYibWbsfA0HevLx9XzoNmNFl28O6ZhcKyR/obrFruxgQ9HerKFBC4dYab?=
 =?iso-8859-1?Q?jObpRwvcNBUtt3lusip/bSgo03DmUtBsOghOIQGm7qPx0fejuI2G0hMxB+?=
 =?iso-8859-1?Q?AA5eB2v5+aRMivD/UlZK2JVWOA0PSOaq/fXiRayi7c3tFUeZpj9bAvTuNn?=
 =?iso-8859-1?Q?Ud0M7DiUUUXpZtWsJMZUDx5PndJ6n8FvMHHNH8MX92yfEjinopeb+Axms9?=
 =?iso-8859-1?Q?mHBibWPe0R60Slk30fOH4V/vDzwTZ0yFKcxtT7ss55zw+nzO30231BzNTn?=
 =?iso-8859-1?Q?YRFG2HiMO4Nnzhm8LE/wRUt4MdyzU6bd54zbjk1NPEpYdJHbHFulNjO2rs?=
 =?iso-8859-1?Q?b6H07Gm74FaJj4O3Jq9/emeJu3pY36Of5aksisieandeMjPBieRdQLFyJm?=
 =?iso-8859-1?Q?5cQsgnb9X8D7rAUTnUrdiaIiTBofDYey24W6kPoOBBn5RbT0f2fL6tet2m?=
 =?iso-8859-1?Q?TcG34iN7KO8XC/00cqIzoBJY7jXxq4H0g5q5Z4De0DxJXrL/7TrQKC+LTB?=
 =?iso-8859-1?Q?4w+0sTmibXh/kde7KXIW7DGR7EwSVYls2F7JFqPxUNRLlTVxxJqVbKoAIb?=
 =?iso-8859-1?Q?xQq7vAGz0NsoNDqw6hC9JwQ7iR7meO6jZDcuwCgnGZJGDXM6AY/Tyxepso?=
 =?iso-8859-1?Q?URCzONJYqhOI9OK874nLgVHIqy4aXWkHdNpitWZ9V2mwPAhQHeqtUnBmKT?=
 =?iso-8859-1?Q?0jPDk5oBcev0l2/TVw7fKcc1VwiiS9lC8T+GOOfCZuRnDWXvMs2vwXDP6/?=
 =?iso-8859-1?Q?4K4JTZlI5RLI5ssuS3gV4I0hqRCeG/MjAf8wI/UybWHt9Sq1DfAwZ9X4Jn?=
 =?iso-8859-1?Q?+WNnlu1M1MBnOh0UbxUdKAf299GTUoAj9g/uulVGYVgYvcPa28T/404/ez?=
 =?iso-8859-1?Q?DSt4cCJHWegXwyoSqWqTxLtl4vHyTNOQUWtWKZoFwbZBZDG6I9+rrV0zVb?=
 =?iso-8859-1?Q?wisTbtF7mdgfTozcko86um7da0CxNh5+YrXZKUTHVBekEC1RK5NSNdS5X2?=
 =?iso-8859-1?Q?zx0l6z96badwHnVAf29SpfisBqWmGjUhgzBzjNOeA1J2C0gWzM8jnXN6Xd?=
 =?iso-8859-1?Q?oq1DcVU+CNlZ7mcB4dCQK4pGPUXN8qJcjPCHNY8cQgWrgOgxKnp5JV6nHZ?=
 =?iso-8859-1?Q?6D2OpoDyVNGuRKgLR8KaVIbFCTzwUuN3b8E0PGTav+ejlWakotMTPynOQC?=
 =?iso-8859-1?Q?prGcV9782yrmMUjDapZqGjDxX1iJDSZxuMMgDTIl1DQzv0CUILpBXF6S/G?=
 =?iso-8859-1?Q?Xs13uD6W+8Wce4uF8FK3kTKagk3ot88d/y/sxuHKDTRvcPpQriP1ahsJzi?=
 =?iso-8859-1?Q?ke50VMaOMQSg+uBchYbqg/P4Y4zwyeMuYbnHIc6B+FsKPtrt1RwBvbMQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dlhcorp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR13MB6560.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caef7ad7-31a9-4ca8-e7a9-08dc2420c364
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 18:57:11.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6b3df673-4d3c-4327-9918-0c35b6a50da3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpW+UE42OdTGMlIM4oNYrpjgOBF77VAH4dXMDYQOPKJLhNBmO9gkDq1wWsoCIAAIL2FugTGlmtuBdgkbGrXjKUflmlImKa8DCVXiJFGkjYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6136

Hello Git for Windows,


I have a question on the GUID and/or SWID tag for Git for Windows 2.43.0.

Can you tell me where in the product the GUID and/or SWID tag would be stor=
ed in Windows for Git for Windows 2.43.0?
Our scanning software has detected both 2.39.2 and 2.43.0 on the same Windo=
ws but this is not so, only 2.43.0 is installed.
This was an upgrade from 2.39.2 though so not sure if that is messed up the=
 results somehow.

I've looked in C:\ProgramData and there are no regid folders not regid.xyz =
files exist for this product (for the SWID tag).

The Windows registry also does not have a GUID information for this product=
 located under:
HKLM\Software\GitForWindows
HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1


If you've included a GUID and/or SWID tag for your product somewhere in the=
 installation process, can you please tell me where these are stored under =
Windows so I can fix? I'd appreciate it.



Thank you,

Christian Castro
Sr. Systems Administrator
Office:  301-628-3551
DLHcorp.com



****WARNING**** This email message (including any attachments) are to be tr=
eated as confidential/proprietary and may contain copyrighted or other lega=
lly protected information. It is intended only for the addressee(s) identif=
ied above. If you are not the addressee(s), or an employee or agent of the =
addressee(s), please note that any dissemination, distribution, or copying =
of this communication is strictly prohibited. If you have received this inf=
ormation in error, please destroy the information and notify the sender of =
the error. Thank you.

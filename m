Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2069.outbound.protection.outlook.com [40.92.40.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D932C7E
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OixYGXvx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3iNxcan2OPB0o/5H7EQ8CdvHQJR5yhexFU9EuRYzEGwVoi/h8sh1JL0rS4BCPhcg47YFmcnuaCX3cnhW2cDaPfii1k9EoCTS3/drrP2sjtMonl2jcGYhpE6jSXEayHGzr8xh+m/WJvBuRdalDg4mNGooKAe/C8i6mG25xXHZ5oD5kZzdSKE5YuNKOeVGL06ad+W5xcprT5nioLhY3zqDDBBbN4kZXGWg9P6Q3IH9KpEVkX+y2wYEAuGUxOcnfb742AV7cikHosY9IptfdyNOrN4tpJHmPDDnw4i+39IloYtpbZGygtuPmvTqG2f6KF5W8Uov6hqGBc07xiD0XpT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcoi2f4/fLzx1YjIQg7mwPj4RBGrEJCAs1t2Zbc4+s0=;
 b=aXhGPj2U+wvUV54TtpyCIhtzNDbMjbo5uM5mHWVxyL54p+XFylFgc82IvXn2mRTneL6lNPiMh5Ow9WpKh9m+y29XQFFsjbrg3yeOQintUsHetfFh7IxEvV9jzetjWCs9ZB0LjEH+wbhcigwJEZqMPa7kUpf2QpJwyd9bDQCr0j2pDuwgxv0hpydRhouYQZVnoVTylthN3LUNiqohkRrSno3LjxQmZqRGoLIcxrB5V+5mDSJIw5GA9BCLJKnDn35b/KeU8BDRt3SlrES81T2uNP8m5yZsPqFyzSz32AvZo7V8a+ZOkR4R7zpq3F9o+fwCif15AgNGwDrAxCesLStalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcoi2f4/fLzx1YjIQg7mwPj4RBGrEJCAs1t2Zbc4+s0=;
 b=OixYGXvx8ewuNrPQjFuBH/efsTPT4UBHdOxd1gFa80TdfIGUjOUwLv1J6+sN+yGw1j1lUXV4eVl9Na4GapEKxwHl3hRlhZNf4ag4TNCFpWCFnOnq3yWFOE9+XVefDHc1ikGvf/rWiAkhC42UfYsIIsvpuAc/tJ3tNWFt9/n9TusgFw9PEIj1RBywl0kLx+oAddN0UPcVm89yQ+cveLoDS9LbtlvndrlmBs7y+pIzcVZ7TWjcQ6EwG1Q99CTcdEumu4eNGPUKSh79EeIvSlYTClxLT/9sFJ1yOM9CuTfhgCTkXmgHgtU07RDQWSo5IJo8axam7rNwYQyKWlrL8erQ4w==
Received: from IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 19:40:23 +0000
Received: from IA1PR12MB6044.namprd12.prod.outlook.com
 ([fe80::8125:9e49:3de3:cde9]) by IA1PR12MB6044.namprd12.prod.outlook.com
 ([fe80::8125:9e49:3de3:cde9%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 19:40:23 +0000
From: Jonathan Abrams <jonathansabrams@outlook.com>
To: Eric Sunshine <sunshine@sunshineco.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Unable to install git-2.43.0 from source on macOS Big Sur 11.7.10
Thread-Topic: Unable to install git-2.43.0 from source on macOS Big Sur
 11.7.10
Thread-Index: AQHaMTn5gqt2b8w7eE2l3446JZLgjrCuOVaAgAC12VKAAU+3gIADuF8a
Date: Thu, 21 Dec 2023 19:40:23 +0000
Message-ID:
 <IA1PR12MB6044112A08508ED982F743E2B895A@IA1PR12MB6044.namprd12.prod.outlook.com>
References:
 <IA1PR12MB604488A775E3390E9B7E56BEB891A@IA1PR12MB6044.namprd12.prod.outlook.com>
 <CAPig+cTEmiQzD7D7qEKDsyGf+08AtNQzy=GfPZDrRtM2ytKnUw@mail.gmail.com>
 <IA1PR12MB60445F50DD0F844B2B779BA8B890A@IA1PR12MB6044.namprd12.prod.outlook.com>
 <CAPig+cQgTNq8rKiXm_dDha+Rz-=Z9O4_gvWLWdcPJe1yp=hQ8Q@mail.gmail.com>
In-Reply-To:
 <CAPig+cQgTNq8rKiXm_dDha+Rz-=Z9O4_gvWLWdcPJe1yp=hQ8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [++wscBcxcfADvRHq6Klpy6JlWhkCvlDV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6044:EE_|IA0PR12MB8423:EE_
x-ms-office365-filtering-correlation-id: 475f53a4-2f0e-491e-daaa-08dc025cac7a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jScOLZBIODyWOb+QcZ4RgCOQEiGxaHsL/UNLp+nIKkgMucM8eaw5LPd3iyc5pKPg3mvE65P2BTmuP5wJiC1M5rGOdiQxZNOWd74wL+KSGDskNAOZWTYEBHeSSIdzHpLpHhoeFwK/r8DzCj5YvhPxHuufLCxtqcJYPcOsWyB7iEfrM6NErDvNu7LolSClKC3c4PNXdC/0R4z+Gaw9x4htpgfJIQ3iUc3t+MTA5MtA/cOIKYapt9NuUtA4zM4pYAQMonVLk7/QV3jJkc2y1mBVOgCLV2TyC4y8NDLsnvFD0yx7/HHpKO6IN3+5i4qL0Vd/R4O/FoxEThV9IaL3mkhVoI8svgg3qCUIF/GktJfJI/YbB7WB0fMe4c4iBO7jFx++TXpUTNCuS3xm+HewUS3zbOBtG3+MMI6a2/vlxzsDZm+b/vhBoDR5911+AH7xA0LA4C2HE1DFBN9d5KKgnrVD3UE888xIvKykQMfKxSTkZqRzEcurK1598fSMHQdRDuOGAVYfjr8/FTExCzlptbhoNiRIiD2V8s8tx4pmFnX2Jg22UPevQFStCNF+LlGXrPAh
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OfmU3gyh4tMdExrd/YrSJAOUVTkN9vwmESGmNDilSoHdtpcRMm4xBQbfv/?=
 =?iso-8859-1?Q?V6Gvw+25rh7/8uARrr59rUfq+yZ3KbqLs2nNrnOnvVXJGvS6lYltDhzCBI?=
 =?iso-8859-1?Q?gD3zbIfMRmzJ+8vZIgh8fCgCn+K+mXKWfZbKWSByiBMpEglNvjt85JckE7?=
 =?iso-8859-1?Q?Cm+kcoQKwnR8qpXfeXnbfW4oqr2IUbGo/+1acPgj5hTYbW81ej7HszvCY1?=
 =?iso-8859-1?Q?MXqwZnTgyHA5UMW2jWUWoCwTWqM4YCKRra9dSNE2bDBXgEbf7utDdNL0lG?=
 =?iso-8859-1?Q?IRmqddXTwSw1ZJw4NgWJiVh0kRBAaEuvnRvWM4SNCsmEyowX0alJ58My2Z?=
 =?iso-8859-1?Q?LCD1ocmNRCLUTNJTiftakwgZSwYyAfaFUUsKfeT3GXDuEiPCoQic1zSHmm?=
 =?iso-8859-1?Q?tqsuCxrAZRIOohEG1tRvfbqxe8MnwoWMJ7hsEfxzMpImQXI/iH23U+C3Vf?=
 =?iso-8859-1?Q?QfIxJUwALYJZgdJVpd5Vu574UYRwpOzO4V/xmb50OhHqppdbFNUIoHjGY7?=
 =?iso-8859-1?Q?tfzClfTtBB+u+tNnzh/dZwbifcnYCJglsxDEBExjPoKniJ7k/aNVikEEY3?=
 =?iso-8859-1?Q?kSa6ClWVb3EsL7/w2679ZRv1QaXGoCIkGdedt6Awtg8hJp+VrkLXhYJ0XQ?=
 =?iso-8859-1?Q?2MuOO1d2K6kVi53GahHvJziKhf0MZQCyXH+YAJ8AG/B75WKAt+khflPwwn?=
 =?iso-8859-1?Q?YWXl/GHNsQlrSteOWWLSngVcZMHS9qJtqM6bfvtPnUMrbQPdfItJBvlvyT?=
 =?iso-8859-1?Q?TsyAqQOBZ1c/mp9j8UeHeG6A2H0yiq5FALYmUXGEvymrzw4dWu07F2ht05?=
 =?iso-8859-1?Q?uiB2TEsTqjHpXAdnG5yMp7BlsbpsQx6XWOfZNrOKC5YSr5ONSv/FPVsveR?=
 =?iso-8859-1?Q?6YzDSzMJgyCIjqyrMwAYacyYCVvC34PSqDmAc0XD9TFg5qJBcpiN2RZxoK?=
 =?iso-8859-1?Q?OYcK2HncCXDmm4JBg58O2MzqPGbe4suxZFW1Yl/4jvVXqLD3e8n+ctOdmy?=
 =?iso-8859-1?Q?tJVR6/iLFbNTMABK6SWM997Hj3tOOHR26rMSorsUIUaHixiqVY6Ipeu3Sm?=
 =?iso-8859-1?Q?2Kr6pBxYgae3L4s2F0TPSchs5Ry2IwoNqsTOHwpXe5bkrPqGD3lAtvXQ4c?=
 =?iso-8859-1?Q?uKc2w/M3WM3F+085ihIA7MqI+2WUVpLMg8g5cTxjYJtjqaYst7ZSRr34tK?=
 =?iso-8859-1?Q?taFCsjJxpz1ZH1z9oUKmyB+UQ+OlLYs9YT91oSNrG8qfl4H9ehdPXNebyj?=
 =?iso-8859-1?Q?jK3A+Oe+6YGlO5SDFU6Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6044.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 475f53a4-2f0e-491e-daaa-08dc025cac7a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 19:40:23.3197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

After deactivating the conda environment, I get a different error.=A0 The c=
ommands I entered are:=0A=
=0A=
conda deactivate=0A=
make configure=0A=
./configure --prefix=3D/usr=0A=
make V=3D1 all doc=0A=
=0A=
This ends with the following error.=0A=
/usr/bin/perl ./build-docdep.perl >doc.dep=0A=
/Applications/Xcode.app/Contents/Developer/usr/bin/make -C ../ =A0GIT-VERSI=
ON-FILE=0A=
make[2]: `GIT-VERSION-FILE' is up to date.=0A=
fatal: not a git repository (or any of the parent directories): .git=0A=
/Applications/Xcode.app/Contents/Developer/usr/bin/make -C ../ =A0GIT-VERSI=
ON-FILE=0A=
make[2]: `GIT-VERSION-FILE' is up to date.=0A=
=A0 =A0 * new asciidoc flags=0A=
asciidoc =A0-f asciidoc.conf -amanmanual=3D'Git Manual' -amansource=3D'Git =
2.43.0' -arevdate=3D'' -b xhtml11 -d manpage -o git-add.html git-add.txt=0A=
make[1]: asciidoc: No such file or directory=0A=
make[1]: *** [git-add.html] Error 1=0A=
make: *** [doc] Error 2=0A=
=0A=
Your suggestion to run the following commands results in a different error.=
=A0 The suggested commands were:=0A=
cd git-2.43.0=0A=
conda deactivate=0A=
make distclean=0A=
make all=0A=
=0A=
This ends with the following error.=0A=
GIT_VERSION =3D 2.43.0=0A=
=A0 =A0 * new build flags=0A=
=A0 =A0 CC oss-fuzz/fuzz-commit-graph.o=0A=
=A0 =A0 CC oss-fuzz/fuzz-pack-headers.o=0A=
=A0 =A0 CC oss-fuzz/fuzz-pack-idx.o=0A=
=A0 =A0 CC daemon.o=0A=
=A0 =A0 * new link flags=0A=
=A0 =A0 CC common-main.o=0A=
In file included from common-main.c:3:=0A=
./gettext.h:17:11: fatal error: 'libintl.h' file not found=0A=
# =A0 =A0 =A0 include <libintl.h>=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^~~~~~~~~~~=0A=
1 error generated.=0A=
make: *** [common-main.o] Error 1=0A=
=0A=
Looking around line 17 in ./gettext.h, I see this.=0A=
#ifndef NO_GETTEXT=0A=
#	include <libintl.h>=0A=
=0A=
Executing gettext --version returned nothing.  I then downloaded gettext an=
d installed it using the following commands.=0A=
./configure=0A=
make=0A=
make check=0A=
sudo make install=0A=
=0A=
I then executed your suggested commands again.=0A=
conda deactivate=0A=
make distclean=0A=
make all=0A=
sudo make install=0A=
=0A=
This installed GIT.  Thank you for your guidance!=0A=
=0A=
Jonathan S. Abrams=

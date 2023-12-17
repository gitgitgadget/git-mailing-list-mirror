Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2053.outbound.protection.outlook.com [40.92.42.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CAB1E4BD
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bU4hjw8k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+uUrX28LG4Owj0FoRB2O5HjXaLglMUWFFeKaj4iBgS11ToVFcG51XMDSqCt8KQQTCdikU4XgY4Vff6gu81atUk4RQmUmPEqChfK7VzSawWSw2gRda6/5COLxFzUuVsCkCBwB6+Lhq7f0hMBKBSEelJiJlQD5Upm5VRSB6E4L3YjvKEHtQxNta1hLc797ENAFuAFpf3St2Daa0YXq4mE5eU/OQDvLYkfOBMxqrpUpf7WPClzldxjq7Hv6zRVASx/vMGFBFuRMJqaVSEvJ6zOu4bOw2HbtA460y+EUDF/ZSYKVPOknO0O72jHnkB/f2Zza3DAPDy1/FLfCZEuVHnSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62xyEqL/hnAn9rB/5RNunr8DYwpqXrEnPsviFu3eWM0=;
 b=ib91VDjHy6CvNNj7XXLmpIwsetI7DTYZmbQeoD9A017maxx3QLh2uA4VwkTCSJg97yw2sMJbMO8AladxXQxHQSpLXpGQxLbAJXgJf3N8W6PaczMhhfqafmQ3qdXnS7Q0Fs8Y45IHSqHhYIadgG9mt6iCc8cT9Pu05hw0vY16wNJSm7JDtzsDV5zVuWtbuyB3QGh2Vl3H58H4Y6T4MfB2dEbwMZCeBn8qy4Vu58BicQB0cYzS/4kE77JDzDKNAZKReu2uJ7vmxGgL6FitnmS5StiHfLq3eR3GneD07ZWoTwnN5xGvBQLnbr5K7iwxuGFo3p59+Y6RGEGdIXemsX1sZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62xyEqL/hnAn9rB/5RNunr8DYwpqXrEnPsviFu3eWM0=;
 b=bU4hjw8kuMtLGckQz/xLNYzOJJ4ccqWjv3IiAOJIxIIwzdqJAd3NlA2qDGe3+tS1bnYgG0gv+t2juF0wIhqEe9B493BQLJ6ZuS7QjXYl8GJPONJQYoRCA6XGq9e1RO7+vxvYf3PkdaCxfC+YU41Px81eIYOZH3/dgawWlMBFWwELLRup3pybIB/7lraX23EgsDPIUoy4G43Uo9JBmYsyj+f7qz1CUuw2OusOhcl/dY4QXZ6D/h/t8DW6wTC+LXFKnGS5Cc99cVX5FYDBLVlPpf6GnaK1W0DclxSDiYf/QMtsvpEBbBnM3ZaIQJnEaiHG968a8Zh/aj4D5zBVkZ2Dpg==
Received: from IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 22:54:33 +0000
Received: from IA1PR12MB6044.namprd12.prod.outlook.com
 ([fe80::8125:9e49:3de3:cde9]) by IA1PR12MB6044.namprd12.prod.outlook.com
 ([fe80::8125:9e49:3de3:cde9%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 22:54:33 +0000
From: Jonathan Abrams <jonathansabrams@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Unable to install git-2.43.0 from source on macOS Big Sur 11.7.10
Thread-Topic: Unable to install git-2.43.0 from source on macOS Big Sur
 11.7.10
Thread-Index: AQHaMTn5gqt2b8w7eE2l3446JZLgjg==
Date: Sun, 17 Dec 2023 22:54:33 +0000
Message-ID:
 <IA1PR12MB604488A775E3390E9B7E56BEB891A@IA1PR12MB6044.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [/otisL94s6FgO9CKHdAs5GC6d9t62Jfe]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6044:EE_|PH0PR12MB8006:EE_
x-ms-office365-filtering-correlation-id: 3168007f-1bd0-4e26-3a43-08dbff5322b8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lK2I68SPkIG2+NqNmBWW2a387gIkYAa9X0DPSjnUzhtiQCd6sWQZdSDWLOTFYjx+WEwJrSiNYeF3IOWs93IhoF/NMEjlnhKZRME/vMRbHUo8f9KisL9bKu586T/bRJVsiCeVa1hD2Xx+lpNlulN0fvW2NjDJRyUjAHeUPhMlB+tK7sl4lRewYUU70cfbRi77ij51D3HiwFwJ0MAVlb7ewh+yOKbwMb+ASj2N2PL/gVr/pGeVviiqV/QAvdw6GkrnoNkVO2F/3K5So249VlNpWtdSBIuuYMjXP8dOIUIhp7WooyHt3Tvovbgl0paVDrhr2u3tRjxKaXzGmj6W/fgFBegD7QuE81Ifi488QBF7ZuYvkzQIhQx8cUk7kpxKNpg672NEgxYA7OQayB9hpxf12Gu3Vk69TJ+UmwQQGuV1TSiYVNJ0S4wKAvHMSIaqssRNtt3UPT+taquTKYmAY0KQLwrpWOVALKGHKZQFLKgw9ROkrZXsoNq68v9NFX1/sDjFJSocd1xhUwgzJJyZucwzfafWmE8EEQnWGhC98xSsxM9VbJQspsei5tYKANKw0LvCo72qUZpJisSrNHOU5dBdsdAAynE86FMnvhiQbN2pARE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gk3u2HaXlp0F5IXVrdRb5fmt9quCZ/mWYEhqHu9NH45ZGurpEp2Ha1zcuP?=
 =?iso-8859-1?Q?dOHSRKfGU+IGFPsqTlDXjKblBL/1dNPAFL6FSNp13m9Rde+c5vwZrZ/pe/?=
 =?iso-8859-1?Q?P25G4Q/juZ4g840oUFict11VpHqLFXaUsf9uZbn2LPUIBTeBC1e+yatMIf?=
 =?iso-8859-1?Q?H8VpEXNYgzfNLtjXKHfx+W2R26F4IirdvMl/1EoRRZTG5ZnKbwndEySaWy?=
 =?iso-8859-1?Q?GZanc2/HbGBGUI/xDt0OAC9Aqvse5usbY8lw4aQa+Y808WaGiM9eo+ks2+?=
 =?iso-8859-1?Q?Xc5uaz5AWxjxbX1WBwwumxlj2qXhJkAs+UfpvpRldDEL50oCdLh8lYMZNV?=
 =?iso-8859-1?Q?AxSw9oEH/NQV9FEcB8eIUcCvj4DcrjE8ql+pVOkZH6wPMAhX3xPZ6fJ5T9?=
 =?iso-8859-1?Q?qxCnO/hbOWQdsMqSvNfJd8aBmWuwZVuWWV7ciV3jMgG16rkyLI0wk6UqTA?=
 =?iso-8859-1?Q?tFv6gjDDzuS4XIKJW9FdLNtQCQN3Au2DQV0i5nzgVnsuWlzXYZabBQpSNd?=
 =?iso-8859-1?Q?bJeb63WqiGpZ68RKonwFLyG/4HLjklLU5W4SwxPsR6s1TJUL5YEJThxFqF?=
 =?iso-8859-1?Q?rgUszYcEK5+SAmOKuUXdkJuw5vTSd4+e5SRLS87LyhKJAKbOsA8yqtn0Lj?=
 =?iso-8859-1?Q?W0d8BaihpPbFefectcxOXERCttQcou6r8YsMFvg79aLQzf/za0OeKXzIDt?=
 =?iso-8859-1?Q?w2s4s2ROykZhQq4stE4Pd2zG+bLwHArQCbr+nQxFqK3aqfwOZsL1vv2Mv7?=
 =?iso-8859-1?Q?YteF4gOqb4VHS32aT9cbF0bcLu0LU71tiyZDxl0yGZokEzchwjOIskhuEV?=
 =?iso-8859-1?Q?SqOLNkeNXFz8kVVuOjSXrxwE8djm7vh3ZSVWpof8cclR5PnOtA9rrJn46y?=
 =?iso-8859-1?Q?F83vePddyLxwDWPwhdgnHNM1Q/YrrYH94TzTcYeRNPE/+JBGKg0Uw5gk30?=
 =?iso-8859-1?Q?tEWMEaSEo7sevXD5pe6pjm0RHB4LaaxlIv31EotivGx+ltmoWETKfutOdw?=
 =?iso-8859-1?Q?h/fJ1C9rIJkrJQzZG8Vsr/biO5UKoQhdHy4IFyaL1GDDlQd+5Ox7CiAvDZ?=
 =?iso-8859-1?Q?iltGesOaOG9iHLiUkNGenoxs3oJDeY8ask5rRl4+0uHxqs2OkQkwXDsH1R?=
 =?iso-8859-1?Q?dN0O33FPjHrqOSg3WkcYiucPv/rgsumBfVYCMALP01/lsqsTrI03SQzNIA?=
 =?iso-8859-1?Q?JlXDhzA/uyfN0aeQux9vBtVtG6UPWREkk6SQEX3ivJHHA7crdqF9rztWGo?=
 =?iso-8859-1?Q?TqHGIj9IgKlTEkeuKd0A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3168007f-1bd0-4e26-3a43-08dbff5322b8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2023 22:54:33.2482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006

Hello,=0A=
=0A=
I am trying to install git-2.43.0 from source on macOS Big Sur 11.7.10.  I =
have Xcode 13.2.1 installed.  I have read https://github.com/git/git/blob/m=
aster/INSTALL.=0A=
=0A=
The command that will not complete successfully is sudo make all doc.  The =
Terminal output before the error is as follows.=0A=
--=0A=
    AR libgit.a=0A=
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolch=
ain/usr/bin/ranlib: file: libgit.a(zlib-uncompress2.o) has no symbols=0A=
    CC xdiff/xdiffi.o=0A=
    CC xdiff/xemit.o=0A=
    CC xdiff/xhistogram.o=0A=
    CC xdiff/xmerge.o=0A=
    CC xdiff/xpatience.o=0A=
    CC xdiff/xprepare.o=0A=
    CC xdiff/xutils.o=0A=
    AR xdiff/lib.a=0A=
    CC reftable/basics.o=0A=
    CC reftable/error.o=0A=
    CC reftable/block.o=0A=
    CC reftable/blocksource.o=0A=
    CC reftable/iter.o=0A=
    CC reftable/publicbasics.o=0A=
    CC reftable/merged.o=0A=
    CC reftable/pq.o=0A=
    CC reftable/reader.o=0A=
    CC reftable/record.o=0A=
    CC reftable/refname.o=0A=
    CC reftable/generic.o=0A=
    CC reftable/stack.o=0A=
    CC reftable/tree.o=0A=
    CC reftable/writer.o=0A=
    AR reftable/libreftable.a=0A=
    LINK git-daemon=0A=
Undefined symbols for architecture x86_64:=0A=
  "_libiconv", referenced from:=0A=
      _precompose_utf8_readdir in libgit.a(precompose_utf8.o)=0A=
      _reencode_string_iconv in libgit.a(utf8.o)=0A=
  "_libiconv_close", referenced from:=0A=
      _precompose_string_if_needed in libgit.a(precompose_utf8.o)=0A=
      _precompose_utf8_closedir in libgit.a(precompose_utf8.o)=0A=
      _reencode_string_len in libgit.a(utf8.o)=0A=
  "_libiconv_open", referenced from:=0A=
      _precompose_string_if_needed in libgit.a(precompose_utf8.o)=0A=
      _precompose_utf8_opendir in libgit.a(precompose_utf8.o)=0A=
      _reencode_string_len in libgit.a(utf8.o)=0A=
ld: symbol(s) not found for architecture x86_64=0A=
clang: error: linker command failed with exit code 1 (use -v to see invocat=
ion)=0A=
make: *** [git-daemon] Error 1=0A=
--=0A=
Does anyone reading this know how to resolve this error?=0A=
=0A=
Thank you,=0A=
=0A=
Jonathan S. Abrams=

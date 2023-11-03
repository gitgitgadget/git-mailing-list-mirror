Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050BF18C2A
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=va.gov header.i=@va.gov header.b="r793seDg";
	dkim=pass (1024-bit key) header.d=DVAGOV.onmicrosoft.com header.i=@DVAGOV.onmicrosoft.com header.b="v0PyOaUa"
Received: from gwnma03-mta.va.gov (gwnmta1.va.gov [152.133.26.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD941A8
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=va.gov; i=@va.gov; q=dns/txt; s=vasel6;
  t=1699020649; x=1730556649;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aU3JiV8bpkMmy/NjsiJFpzcT/Iqhy+Nce5vkTluSAV4=;
  b=r793seDg1cjuzcf2D72TOjrjU3+05PtK5uXJV60orDUAUMelSFZIGzTs
   DjhvaAXa3tl6aBlZ0P61Wn1+QyHuDhHo18ccvBhxcfrSPgsHuPsSuYEIY
   ogANMFJcOCyVipMjc0YHk3bKa0+bSg3pdMPWAODYwLNJXe5qMM7fCzk1k
   wWy2NSbWK9xaqXTjpJXxERe9WXS6kN3xpLNkomEc4b1aXlkveujvBzpgz
   w3ZASLvrCubzWyT+zf/kKL8DFLwhqN0k02t1v57Y5+u/xcRc6RqVGsLs9
   DCZJy86g2UdGhY1L5g8zvWqnrgXGogRXbXvtLNDFXj1Gaby7VIsIX4tox
   w==;
IronPort-SDR: Tb/FWY0hIzbffdX7dL5DQSlFHEAk3Q1g6t4DfJiELAG4rxhF3tOlEsFnFk/X2gIaKfn1hNdvGV
 WjVQgW/iscgw==
IronPort-Data: A9a23:5pQREqPWaGJQmh/vrR1zlcFynXyQoLVcMsEvi/4bfWQNrUokgTFUn
 WAeX2yAbveNMzakeIwgYIm090xTucLQnN9jG1dlrnsFo1CmCCbm6XV1Cm+qYkt+COWdEho/h
 yk5QoCYfJBvJpPkjk72dOCn8BGQ7InQLlbGILes1htZG0k8E0/NtTo5w7Ri29cw2oDja++wk
 YiaT/P3aQbNNwFcYjp8B5Kr8HuDjdyq0N8qlgVWicNj4Dcyo0Io4Kc3fsldGZdYrr58RYZWT
 86bpF2wE/iwEx0FUrtJmZ6jGqEGryK7AOSAtpZWc/DKbhlqiQcZivx+Ht5ELEBdhnOOgsx7z
 8hLudqoUwA1M6bQmeMbFR5FDyV5Oq4A87jCSZS9mZXLiReaLz21n6ooVSnaPqVBkgpzKVpS+
 OIVLnY3cxyCnOOyxJqlQ69jgdpLwMzDYtND5i4+k2yDZRohadWZK0nQ3vdX3SsYmM9DB7Dda
 tAfZD4paw7PCyCjkH9/5IkWxb/u3CWjNWQE9xTMzZfbKlP7lGRZuIUB+vKFEjBWba25Rnqlm
 18=
IronPort-HdrOrdr: A9a23:bZ5Z660vytjuG1bLVvwgPgqjBSlyeYIsimQD101hICG9Lfbzqy
 n+pp8mPEHP4Ar5AEtQ4OxoS5PwOU80kqQFqLX5XI3SKjUO3VHEEGgM1/qG/9SNIUPDH6tmpM
 FdmstFeZXN5DpB/KLHCWCDerpO/DDEytHOuQ609RdQpHRRGsNdBnBCe2Wm+yNNJTVuNN4cLt
 6x98BHrz2vdTA8dcKgHEQIWODFupniiI/mSQRuPW9s1CC+yReTrJLqGRmR2RkTFxlVx605zG
 TDmwvloo2+rvCAzAPG3WO71eUapDKh8KoOOCW/sLlaFtzesHfoWG1VYczMgNl6mpDu1L9gqq
 i2n/5pBbUI15qWRBD/nfKl4Xic7B8+r3Dl0lOWmn3lvIjwQy87EdNIgcZDfgLe8FdIhqAI7E
 tn5RPri3NsN2KzoA3to9zTEx16nEu9pnQv1eYVknxESIMbLLtct5YW8k9ZGIoJWHuS0vFRLM
 B+SMXHoPpGe1KTaH7U+mFp3dy3R3w2WhOLWFILtMCZ2yVf2Hp500wbzsoCmWpozuNId7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTnfARBrdWVjiUWgP1Jt3Sk4lh6SHnondvtvaBKDg5KFC56
 j8bA==
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="684476652"
X-IronPort-AV: E=Sophos;i="6.03,273,1694736000"; 
   d="scan'";a="684476652"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjSvuesdg0Vp7LydkvFiVs/U8ghzSn/YbbIE2+t/eAXhbIIehytQ0NpD36Au0G62NTuFH2osdbxPbyOsi3Yf7ZRjpirT+mkBcS4S4CWWRk5UYZy7AcsiVIWWwHssY1c2j/tzs6IC9+1UKl5LTT0xy6jh3c/D5fv1fmkZKTg29g6MtZVq/tVkWuu8VHKKka8VnRRkzQ96ENA5HhtqsrvEi3/CjymBcA/rZuWwvN9JhVnhXVinXETqAdW4w8gdkvfha8nEC20fjKB5jQww+8FAX0DdCJ6bbv47dcYmS7MJW8p3o50xOZgDo96D5IylB5ZQlrUgZYdrXT5blOS3KUU30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU3JiV8bpkMmy/NjsiJFpzcT/Iqhy+Nce5vkTluSAV4=;
 b=XmKBHeKSk1vQ+RZc2ohq3iQ3DVsEkyuU8+5OWBJ4IyMob0d+wjN4+nN6Dv85xQwXkjbfOW0nXJipykRVBhDbWh7rzw5mCvVPgzjUDcHkmKAcL88bR7ElPeS6qwUfgXFz+hfMvzjmLu0nEdMq8OICeLUEzGTtMEmp+bmblWDhzW3pjI2d+4wQa4kXhO79l2i93MusFjwJ5ATGKid0DGBQGvSYDRrEa3gnUimP//r3iAbkxtF+K5HbU47Y83Ub0SHnUoKRa7Vzmg8rvNvz1viRfueMlfbmLwnr2oszWnxdOylx34OcEN/XZTBa0iEL7g9W53jzXp261CcKUmtxzDsmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=va.gov; dmarc=pass action=none header.from=va.gov; dkim=pass
 header.d=va.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=DVAGOV.onmicrosoft.com; s=selector2-DVAGOV-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU3JiV8bpkMmy/NjsiJFpzcT/Iqhy+Nce5vkTluSAV4=;
 b=v0PyOaUaxVOmk9X5JEVjdBHFbg7bEzQUsersPgVYDPfr8N9r9ruYOOry8+VuERVSE0x9yV6ctXqGMn36d4dzJVaxjb+GyduDAcqdNEDtwcZb33S/V8wqppeQfbfYn0s2h4jX71RuDgwvHx40Kiltu6pUZOr7fI0Xi+QtWCWCnW4=
From: "Rudisill, Steven L. (Booz Allen Hamilton)" <Steven.Rudisill@va.gov>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: mintty bug in current git bash (Git-2.42.0.2-64-bit.exe)
Thread-Topic: mintty bug in current git bash (Git-2.42.0.2-64-bit.exe)
Thread-Index: AdoNtYshu0g9iVKXSQitX9DgUepPDgAqdoQA
Date: Fri, 3 Nov 2023 14:10:45 +0000
Message-ID:
 <SJ0PR09MB99693718DDA17BC15532A3099CA5A@SJ0PR09MB9969.namprd09.prod.outlook.com>
References:
 <SJ0PR09MB99699E1D1F577734F535CB1D9CA6A@SJ0PR09MB9969.namprd09.prod.outlook.com>
In-Reply-To:
 <SJ0PR09MB99699E1D1F577734F535CB1D9CA6A@SJ0PR09MB9969.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=va.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR09MB9969:EE_|SA0PR09MB7337:EE_
x-ms-office365-filtering-correlation-id: 9df5df61-0621-4484-9481-08dbdc76ac4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MwzaNkmbC601khV2klHHooliy5tY4vBErZwRstA9OuE2WcouCFf3LtjFS/a0Z8KtWZ0wfFAer2XG7Y3y/KmTE9EshxLbAbJb7cMyZ/leuvdtNusnutUCubw0UAoB3eyfLFLZKvJJK0eqbeKy+k6C5DDIgG0m4SM/sJpilad7afYHFvtw5IhcrPhzZSKmE6a/gpymaC9GkMD7xRLiuNJIy1QVQfA2hnyRL2y4yQG33meojzll+rNu6MxjYqQ2uwMJoz5Gq++UbfvtWomw3f6+LoexhiWZr7pMnD16q7zRw1PD+BkdXp2D0sCbSH73V0gQps0ONmz+Og3BUfeHj3zUT4cbB2GWo9ctyGZOyogtQwiAj6ZLugmk1XnkLqQfvSIfsFMBW67kqauylJ9EEouj/F2+zrD/f7Z6roHF2089yOJ2vFHJFrObpDt+dMY1MHJbW8xoP5X8mXeIRAcYDoywsz23L2g94Rc2+ykKJe1eKwRudQkdAF/4NprdLrhriVHKFFz0JNF6Imp/wU4LHz2Oa0G9TdhJlFd/qE1aSJWvWqT2er7OhnEs06WSHdkF3YQWKgJBZi4qh6NQ847ZzoEod6Jzz/z72BcBbIEw7Ye8M15lQ46VNRSSgd0Us88OjNAx670B0h9xg92CJ+orLzNLsQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB9969.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(1800799009)(451199024)(186009)(26005)(9686003)(38100700002)(82960400001)(122000001)(55016003)(83380400001)(966005)(498600001)(7696005)(71200400001)(6506007)(66446008)(66476007)(76116006)(64756008)(6916009)(66556008)(66946007)(33656002)(2906002)(8936002)(8676002)(86362001)(52536014)(38070700009)(4744005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wJWY7wy+G9TdAnTug75u7XEFKMRaSt9XAgN1dvfaYi9JpGNvagqwqEwVw3XU?=
 =?us-ascii?Q?6Mzv2klFdjS9QOzuoq/QjAVYD000+xPf+F74uOhgeHRCFBcmFpLcusCCcJVi?=
 =?us-ascii?Q?JNXfxNxUS1tMnk1vWOsUxH2U+Tj9penOeO4K+L+AX0lH+pLNFDJ0XEh9+acX?=
 =?us-ascii?Q?C0HZIwsuF66qUpU0FLlcy8ox4MCVh6k6EvGpwT5Rf61q+CagAVeQuTz2pK11?=
 =?us-ascii?Q?stMpaoe0gc/HtvxKS2PxnEwKAyimTis9exwC0UcmbmK39o6QwIWfotNCRYZe?=
 =?us-ascii?Q?ICVGoqN3wg5xYL3Gcx55relFcvPivehhVX4QFjB5ZciEwRbvmWFaVD72mNER?=
 =?us-ascii?Q?GeHuAjUde6dGtCbrgwmHnAhyaIKsfzxpOV3MlHD28lobikmf1XANkWC9iYIi?=
 =?us-ascii?Q?c6XISd5/NyVZNtYJs+cXMagz/yEvz6vIeoIg2USbxBwkVMKF3vorWjsUlMO3?=
 =?us-ascii?Q?gH7mH83RXz+KBQOOoLOqZsviZlYLho81grOyaT3AFYrhJO+yTjAQhfRyeg9T?=
 =?us-ascii?Q?mbU7beMPnhBTtjVrdPb3yYPl5ajet7IKa20d0groh+/2A2eLGNC4aB8xDpqt?=
 =?us-ascii?Q?tXqH0RjKv8Et5RPh8jMnq8xPOtb6KikVfzL75ikw/sfvcPIUPXBP3isxsEOs?=
 =?us-ascii?Q?Dxgsy1ksp71ZlBG9H0wdfRLmhX/gic8yrh2CLB5qvL08mh6tMws4O4vLHGeh?=
 =?us-ascii?Q?jDkOCvyKF7+ALR2dKoKzsBSM8mrboXkCz/AOpNAtQlB19L7fubrs7bcqlBvT?=
 =?us-ascii?Q?4KKueXLdMUUVJkrHsUUoPEu7Q+L21MJZRi9ZaOuJIas2G81mWQpGDS5FVpxT?=
 =?us-ascii?Q?c3Iau+fAESvT1dwXTUlmc1bqoxxLn+3zodUShspzmLAfFnN5WzJzvf8/kV06?=
 =?us-ascii?Q?lz1l4isaA2U8JZpZcoXBpoJGQea7RCbyHLrLWuPestE81Kn9dhvuNPFTnwfH?=
 =?us-ascii?Q?HqtWMyIA8r1enfEGmt0LhqeipTAF+g+NiAxEsAV2sXupC9yuS4Izop+1zXw0?=
 =?us-ascii?Q?6kepldOzVQ0w0zJmVmxWSE8Mfj54Z8iQQnlZ2tnsK6aLSnrbGmE/d1es56wX?=
 =?us-ascii?Q?AeGoRKurb9uSPA3gIoqkoYumIHXfv2Z15Az0KAEhTmSGI2FXZtoMux21LRMQ?=
 =?us-ascii?Q?VV+763xeMdfCaJ2QVVkJInHTyTz2tkOKQHC/YSlB4diwTI45aujYdzahHLLz?=
 =?us-ascii?Q?8jX/hZtQU6OlqvVlPv8nv/A+QxmsFI79/Ojz7x9nWg6ZA45QJzb5bKPqs5fe?=
 =?us-ascii?Q?/kLh0C5j9c31nZB45TbMn2wbgPGmGWEfPZwV2FUXw6gQRsgwgtLwJMkWDWdc?=
 =?us-ascii?Q?K4FM9eo0LJW+VjjLUhpDA5gJVn5BJmKT/SbiqIZAXzqaw7smCoozgvFZ9i8n?=
 =?us-ascii?Q?W2YdumltfsiFQatbVFpUMjDy1lWdV9lH/cIkTUF7zdxv8u3SLPdVl6KF80ds?=
 =?us-ascii?Q?uu0VCNLVwrigNoskcz3oqgVIERqUfUBJhUSyLSb8+CcxqVwcXB3DCMr4mHVF?=
 =?us-ascii?Q?D5biBbH/m3+tRWncvd/KOERxeUcrfb0Fip/4sPZeKzf2ASt+Qm5wJNAegG2D?=
 =?us-ascii?Q?3Jk+2C3p5lZpXEflkwQzZs/Ghe9nh4GHyeQW8KvL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: va.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB9969.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df5df61-0621-4484-9481-08dbdc76ac4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 14:10:45.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e95f1b23-abaf-45ee-821d-b7ab251ab3bf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR09MB7337

Hi git,

Mintty has a bug - when double-clicking on text, the preceding '~' or '.' i=
s not selected.
https://github.com/mintty/mintty/issues/1237

This really slows down interacting in git bash because this is a very frequ=
ent console interaction:
Double-clicking to select a path (which copies it to the paste buffer since=
 the text is highlighted), then easily paste to manipulate text.
The pasted text is omitting the preceding '~' or '.' character.

Please release a new git bash version that uses the updated mintty with the=
 fix for this bug. The issue link above indicates that this is a bug and ha=
s been fixed.
Further, it might be nice if git bash had an update feature?

Regards,
Steven

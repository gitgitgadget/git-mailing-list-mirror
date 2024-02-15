Received: from mail101.atlas-elektronik.com (mail101.atlas-elektronik.com [194.156.172.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA94A08
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.156.172.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997768; cv=none; b=p87CTNU6Ty8GFdWpyoFIowCvkd6QnsHvr+xV7g9AJrfRkCVr84H0Zhhu1yD7uZpfBu/1dv4uPzd153JBV+ApbBTe6l6rxO4StY0QJJ1bAIR7Av6sF0TPUMRt/mvOzzG+16H4ziD0o0Yr17Dwxo6o7QlDoztV/3Fq3FenNvOf6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997768; c=relaxed/simple;
	bh=7DiHvyGcHFhi4/Dpy4ZBtUxPNBvp1BVO6ESqWdaWYgY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EeMQJrqUPNekj/QX4z0NkNmRtd4oak+JXrHtsvxCHURItZrCIcNpx7O0CyAg3Ie1x3uHDPzQhjxZHbbR4cfHaGJaE7fl2CSXU0ddR4RCgu67TJeAtKH31bVGU/7066yc6LxS0kzBhZuimU58ynJProdX4F9gN2vyBqLfj1Ot2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atlas-elektronik.com; spf=pass smtp.mailfrom=atlas-elektronik.com; arc=none smtp.client-ip=194.156.172.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atlas-elektronik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas-elektronik.com
X-CSE-ConnectionGUID: KarWHbrQR+WZBZtAv2XinA==
X-CSE-MsgGUID: c+m2r29rSvuTmQv/hXpsdw==
X-IPAS-Result: =?us-ascii?q?A2FAAwCL+M1l/zbHxApaHgEBCxIMQIFEC4MzgWGWPIIij?=
 =?us-ascii?q?2qLeoF+DwEBAQEBAQEBAQcBAUQEAQGFBgKHXCc0CQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEGAQEBBQEBAQEBAQYEAQICgRmFL0qGVQYnYgIBTjElAgQBEgiFWLJZg?=
 =?us-ascii?q?QEzgQGEeLAigUiIJgGKK4JPgRWDaIUQhVQiBIISgzuZUCyBJ4ElbRsQHjcRE?=
 =?us-ascii?q?BMNAwhuHQIRIjoDBQMEMgoSDAsfBVQDQwYOOwsDAhoFAwMEWVcFDRoCECwoA?=
 =?us-ascii?q?wMSSQIQFAM4AwMGAwoxMFVBDFADZB8yCTwPDBoCGxsNJCMCLEADCQoQAhYDH?=
 =?us-ascii?q?RYEMhEJCyYDKgY5AhIMBgYGXSMWCQQlAwgEAxBEAyF0EQMECgMTBwsHeINGB?=
 =?us-ascii?q?BNHEIE0iieBKwNEHUADCwdmPTUUGwgBgTagBIFbgSilUaFOB6U8LheXPpJlm?=
 =?us-ascii?q?FggqC4CBAIEBQIWgWSCFnCDN1IZD44rF5NReDsCBwEKAQEDCYpoAQE?=
IronPort-Data: A9a23:Bby0W6+XGC8dRuxdquIQDrUD4H+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 GQcUDvVM/6MYGKgc95zOYy3pEhV78XUztRnTQc6rSAxFiIbosfsO4+Ufxz6V8+wwm0vb67GA
 +E2MISowBUcFyeEzvuLGua/9SEUOYagH+KtWLKs1hhZHFIiEGF5z0s7x4bVu6Yw6fChGQSBp
 NjulMPWPV6hylZcP3kdg065gEoHUM/a5nVA4DTSWdgR5AWCzyNMUcpFTU2MByKQrrd8T7bSq
 9nrkenRElPxp38FFt6jm7DnRUwGKpa60d+m0yc+twCK23CulwRqukoJHKN0hXR/0l1lq+tMJ
 OBl7vRcf+uJ0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQ7ISoyThqZvtj1/4CRePVFmJ4TLc/CadZ3VnFIlVk1DN4KbLDpGoPv3YcBmj4sgslVWPvaa
 skFcz1pbReGaBpKUrsVIMtm2r752D+mImwe9Q79SakfugA/yCRqzLXjOdyTfNWHWsh9l1qcr
 3mD8mD0AQ0AM9qeynyO9XfEaurnwXqkCd1IRdVU8NZhw1jJ3DZCEiYISGe+mOf+in6mQN5Af
 hl8Fi0G6PJaGFaQZtb8QzWmr3Oe+B0RQdxdF6s98g7l90bPywqUBmJdSDtZMIVgvdMyTCdv2
 1uEnM/zAjpus/ueTnf1GqqokA5e8BM9dQcqDRLohyNfizU/iOnfVi7yc+s=
IronPort-HdrOrdr: A9a23:rpHw6av+DI1CIIgOMZJYHPfz7skCC4Mji2hC6mlwRA09TyXBrb
 HXoB1p726OtN93YgBVpTngAtj0fZqyz+8Q3WB8B9aftUzdyRKVxeJZnPzfKl/bakrDH4dmvM
 8KH8cRNDSzNykdsS+Q2njaLz9U+qjjzEnev5a9854Cd2FXQpAlxT1UTiycFUp7ThRHA50WKL
 qwj/AsmxOQPV4sQoCeHHcqY8jvzuenqLvWJTErQycg7QmFnXeJxdfBYlGl9yZbfB9m+/MJ9G
 jIlBG8xpzLiYDM9vaW7R6o030foqqd9jOaafb89fT88VjX+3eVjF4NYcz9gBkl5OqtrEsplM
 OJow0lJa1ImgDslj/Zm2qQ5yDwlD007Xvj1VvdhWHsocGRfkNLN+NRwYgDawDe4UY7pt1w1r
 lEtljpxaZqMQ==
X-Talos-CUID: 9a23:B1HVj2yDPb94s+q/z5iIBgU3E9oaUnfH9U2THH2SO3pAVuelSFm5rfY=
X-Talos-MUID: 9a23:+bCGmwZX2KYdw+BTvHzp3is4Zd1T/bmSDXkT1pU2o9KIKnkl
Received: from dehb1nmp01.atlas-elektronik.com ([10.196.199.54])
  by MGW101FE.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 12:48:13 +0100
Received: from mgw202partner.atlas.de ([10.206.101.61])
	by DEHB1NMP01.atlas-elektronik.com  with ESMTP id 41FBmCsY007655-41FBmCsa007655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 12:48:12 +0100
X-CSE-ConnectionGUID: UAKD/p8TT4eYXMjUz+685A==
X-CSE-MsgGUID: 8wSjdVuqQjCHLSVLAFKOhA==
Received: from dehb1pex03.atlas.de ([10.248.64.138])
  by mgw202data.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 12:48:12 +0100
Received: from DEHB1PEX04.atlas.de (10.248.64.139) by DEHB1PEX03.atlas.de
 (10.248.64.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 15 Feb
 2024 12:48:12 +0100
Received: from DEHB1PEX04.atlas.de ([fe80::f72:53ae:3a42:3bb5]) by
 DEHB1PEX04.atlas.de ([fe80::f72:53ae:3a42:3bb5%5]) with mapi id
 15.02.1118.026; Thu, 15 Feb 2024 12:48:12 +0100
From: <stefan.naewe@atlas-elektronik.com>
To: <rmy@frippery.org>, <git@vger.kernel.org>
Subject: AW: git-archive: --add-virtual-file doesn't seem to respect --prefix
Thread-Topic: git-archive: --add-virtual-file doesn't seem to respect --prefix
Thread-Index: AQHaX9WJ7d6TTFbqx0aqIZV+/KhKSLELScaQ
Date: Thu, 15 Feb 2024 11:48:12 +0000
Message-ID: <a143e25a70b44b82b4ee6fa3bb2bcda4@atlas-elektronik.com>
References: <65cdaa23.MHIIVADqwryAD0ON%rmy@frippery.org>
In-Reply-To: <65cdaa23.MHIIVADqwryAD0ON%rmy@frippery.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-bjprotectivemarking: <?xml version="1.0" encoding="us-ascii"?><sisl
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema" sislVersion="0"
 policy="1474dc32-5c20-42f5-ae16-31584b33af28" origin="userSelected"
 xmlns="http://www.boldonjames.com/2008/01/sie/internal/label"><element
 uid="92b19d4d-09b6-433b-88f8-352dd5b3c937" value="" /><element
 uid="690e14d9-e77b-4e35-9e0a-efe93554201d" value="" /></sisl>
dlp-product: dlpe-windows
dlp-version: 11.10.101.3
dlp-reaction: no-action
x-bromium-msgid: ea19da45-9418-4222-afe0-5dc9ff282dcd
x-bj-tkms-isms: Offen
x-c2processedorg: 8e578ea2-b414-4638-aa54-659db1be7428
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.206.101.61
X-FE-Policy-ID: 1:1:17:SYSTEM

Classification=A0-=A0ISMS:=A0Offen=A0|=A0VS:=A0OFFEN

> -----Urspr=FCngliche Nachricht-----
> Von: Ron Yorston <rmy@frippery.org>
> Gesendet: Donnerstag, 15. Februar 2024 07:08
> An: git@vger.kernel.org
> Betreff: Bug: git-archive: --add-virtual-file doesn't seem to respect --p=
refix
>=20
> The man page for git-archive has similar language regarding the --add-fil=
e and --
> add-virtual-file options:
>=20
>    The path of the file in the archive is built by concatenating the
>    value of the last --prefix option (if any) before...
>=20
> However this doesn't seem to be true for --add-virtual-file.  In any git =
repository:
>=20
>    $ touch real_added_file
>    $ git archive --format=3Dtar --prefix=3Dprefix/ --add-file=3Dreal_adde=
d_file \
>       --add-virtual-file=3Dvirtual_added_file: HEAD | \
>       tar tvf - | grep added_file
>    -rw-rw-r-- root/root         0 2017-02-22 17:18 prefix/real_added_file
>    -rw-rw-r-- root/root         0 2017-02-22 17:18 virtual_added_file
>=20
> I expected to see 'prefix/virtual_added_file'.
>=20
> Ron

Maybe something like this does the job:


diff --git a/archive.c b/archive.c
index 941495f5d7..b6b885a632 100644
--- a/archive.c
+++ b/archive.c
@@ -331,11 +331,11 @@ int write_archive_entries(struct archiver_args *args,

                put_be64(fake_oid.hash, i + 1);

+               strbuf_reset(&path_in_archive);
+               if (info->base)
+                       strbuf_addstr(&path_in_archive, info->base);
+               strbuf_addstr(&path_in_archive, basename(path));
                if (!info->content) {
-                       strbuf_reset(&path_in_archive);
-                       if (info->base)
-                               strbuf_addstr(&path_in_archive, info->base)=
;
-                       strbuf_addstr(&path_in_archive, basename(path));

                        strbuf_reset(&content);
                        if (strbuf_read_file(&content, path, info->stat.st_=
size) < 0)
@@ -347,7 +347,7 @@ int write_archive_entries(struct archiver_args *args,
                                                  content.buf, content.len)=
;
                } else {
                        err =3D write_entry(args, &fake_oid,
-                                         path, strlen(path),
+                                         path_in_archive.buf, path_in_arch=
ive.len,
                                          canon_mode(info->stat.st_mode),
                                          info->content, info->stat.st_size=
);
                }


Stefan

Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D75231
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563764; cv=none; b=lVHe9hznB2zJanIO1GlkUIAsLri2DRM8T6dLcyt2ck1R9Q2SOLXgeCLA2XHry6G72FkDJQAbwGV0E/N9aP6cqRtpu/H+C3iHs0NVYzAkizrRZrpXYcs7ACf/KKx7Ye8parDrNzl//WKBbbo1xOah07bd0OtZOBi5mHqus45tzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563764; c=relaxed/simple;
	bh=HjFJlpltAC+ik+T6cmHtyT6ZQxjCYLAmMAGBDHZC8b4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=akB/n0JQKWcBMjaFutzw0hTkaN/FGUjudM1blItKEc+Q1ryDNAx43qVVQ+v/wTyyjPTPWJSkJvmwpUdtUNayjUg52kxTjxiD8QvHZHv5MD1NXn8lTRnPIOto25nmsmSd0P9Huia3sxmIKHhUl3dTaNxTnuTfszciegZlkIdWAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZhV35soD; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZhV35soD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713563759; x=1714168559;
	i=johannes.schindelin@gmx.de;
	bh=27ApcedhNCr0fJklbzMCgU+lVLAPPnVERiK/HRuQZHI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZhV35soDuxlkrt9k7BBzGG8dR/6KieISPLl4wdkinEhLLKPB+F5QKUfwT6giSWJ6
	 9rZQZHb/BrRhIFq1m9g2Y3AcamSRn3ChwfYQS/TqPcVsO5d110UZH5qw8J55MMRf0
	 V48gnZZgSRqKzd3z5cQLTM794jnxhoWhGDQJHPfR0C1/UcwRF8Rdh1CT0NryrSPXv
	 mfGG712CN9TGHizOHq4ctakWuDwyFMfdXoXtTIsfvBZZL15/+s2v1KdJS58DzpifG
	 N6im4AHchF8hQEU/svRJ5TQpT5YKVo/MDuWIPdNKxRos64GUhkl62Mk+Gk0SzSvRM
	 8uv+CUCebLMWQGMdrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1113-401.v4dlmfbwbvlezlyjnbnry1jt3f.cx.internal.cloudapp.net
 ([74.249.5.98]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MEFzr-1rqU5D3dNF-00ADBT; Fri, 19 Apr 2024 23:55:59 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.45.0-rc0
Date: Fri, 19 Apr 2024 21:55:56 +0000
Message-ID: <20240419215556.3579-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:jAvuaALcfaJPygTWtVWJuidFnsvySQRZJk3RO2Q4RDXXOz5gTOK
 tCfL9SoUWT1ErI+nO19M9ZJeKA+epEIA4+F2W6ho9GXvmJEalJmdizx1oHwSVDmU24Kvu7k
 ZmBIoRuJX3jjYo1PLPIB1E6CTyJDvPiEf2DsYlbPi2KgJEPSsalz+zG9Lm0iSoyXbipow6x
 PlzaGVoWLHLpZshi2kK+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WAGxJ/O2jZs=;+x4G7lSHJBg/wsTAS1t7ann/b0j
 1KYPaAXwMnMdJNdb+ncrKk51pDXG1693+HoIKMErxhKJ2GJbHua3xi2sL1EvV+TW+kOZ5+LJi
 fIMbfdVx/zp4BoRChd+KQ6RkEABFmpjkUZNXFZ8R7Lqw+nA6oL1G99gsZwXvGojwT9OnY6M+W
 kKrn7j669dULpVyH80np1NcDpEMWDL6x8zxvZI31S+4M5TWhkUhSW+FzNsZmOsoyeOrp6DqX3
 18+ogbOlNc0t7HOVlxB7gSPLoYn9dudt1g0ZQXGGLm1o9exdQ1hJPrPyMqPJ8qbEQRyXRzsul
 1jGSdk1EIZcalJDh4QVAkq2YsyBAzFtc4f64rV45HLMWdj+smpIzo6Q1+LI4H1mXfqneJ1lLR
 ifBWoqxHzth3BJp+RSMPxqV7s82K8Q8b/hil4HBJbuLKHoA3QecZ+H8k5NRn5s0ULZva8fWlf
 7AKrvwazxNNPt/eSz6P+j9kEh3nZWMAqIfXsLACWBtl2CU7tQjE3v6rks4TEBols8ZI3EWbMf
 1nXUT+ehiAc2kZ7JSa7l1wfDlG0hchtCF0dTehTFVB+z6ZTorIQKRu1X8X33cmgYdIOQf8qvu
 Iw/kGiJkU03iDl867Lbe5M6n4LG+/jGmBZLbGhTj5KfetD7ENq+ckQ1I/YiHB85wAcDHz1ph4
 cmx2Zv74QSduqSIh8SSocblNAwg5p+jEJGgY8l4NzN4/zAV/9l+BbfzTPqamycTM8Ydk5/4/5
 LlRzvgWQmhma5G+Zc4WjpGe3W5UMIFCyFXNFEy1t0o3MWf6uQE/Si9MyZ87+/3UT2OINEPNH/
 2YWzdPaj1DSHcfyX5XaNRSCer9etjewg6aiK//QEucTSQ=

Dear Git users,

I hereby announce that Git for Windows 2.45.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.45.0-rc0.windows.1

Changes since Git for Windows v2.44.0 (February 23rd 2024)

New Features

  * Comes with Git v2.45.0-rc0.
  * Comes with PCRE2 v10.43.
  * Comes with GNU Privacy Guard v2.4.5.
  * Comes with Git LFS v3.5.1.
  * MinGit now supports running git difftool.
  * Comes with OpenSSH v9.7.P1.
  * Comes with GNU TLS v3.8.4.
  * Comes with Tig v2.5.9.
  * Comes with cURL v8.7.1.
  * Comes with Git Credential Manager v2.5.0.

Bug Fixes

  * Since v2.14.0(2), Git for Windows' installer registers the Open Git
    Bash here and Open Git GUI here context menu items also in the
    special Libraries folders, but the uninstaller never removed them
    from those folders, which was fixed.
  * A regression where git clone no longer worked in the presence of
    includeIf.*.onbranch config settings has been fixed.
  * Apparently some anti-malware programs fiddle with the mode of
    stdout which can lead to problems because expected output is
    missing, which was fixed.

Git-2.45.0-rc0-64-bit.exe | 63f07d6fc53b0ac836f0667e891378ba7a00c56c5bd2989309ed55c55fb22b74
Git-2.45.0-rc0-32-bit.exe | 806b4b4ad5ca8bf3c02ac332d3a808bd8b827e9d503489d39378abb5a99133e5
PortableGit-2.45.0-rc0-64-bit.7z.exe | 17f8be3a2223868f8da1ef0701ed1e1189859e1a9f0354d9d1f1046dd1ea472b
PortableGit-2.45.0-rc0-32-bit.7z.exe | d98df3750a3265134b909d59310e87d4591d04ba8586c67953b1ca09b75a011e
MinGit-2.45.0-rc0-64-bit.zip | 05635a6945d160e8cb3ecc33643925184c2732db88c3382a831af07bd1b41248
MinGit-2.45.0-rc0-32-bit.zip | 590de1226b0e5853ace6c7eb0a7eb75dd4cb70fcc7b91799bcf7cfed0ca3c587
MinGit-2.45.0-rc0-busybox-64-bit.zip | c978df1eb415822d0ce890191f35dc915d550ca5d8989f82fda831242ec5b784
MinGit-2.45.0-rc0-busybox-32-bit.zip | 7cb98a1a2fb819dafbde296a805ee87e44a5c2e86bcea43e66982dd3b958b646
Git-2.45.0-rc0-64-bit.tar.bz2 | 3083bef250da158f5ae1a7e8077b2da57662760d5d5c773ce899362a7442a148
Git-2.45.0-rc0-32-bit.tar.bz2 | d40fa3708b133c9b4782ff35178cf8a57fad9353b4d7472b3bee8c460e3b42f9

Ciao,
Johannes

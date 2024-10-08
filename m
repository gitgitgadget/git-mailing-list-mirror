Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C018B464
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381892; cv=none; b=TQoKKZxsFnr714SS0sMvjL5Jw/+H6zgltxEEdILqrn5/VV1PCBgbJnn6qJ3Aao2kJWxnD9zgRFpRbM63qPbXkuI8WHAGZ0k9QnvuAh8VkThK5+P+osMSuOUf2doTV6mIxbf1KBoWpUzjKl5U1GYjXSvZnBMtIcmMTxEfi2TWYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381892; c=relaxed/simple;
	bh=BeDrxsCWMci4jOZNOHF4VyVub8GiSBmHWaQ5IgpkvMI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dIMddPihbsLYZCDsf1Jv1IJ3A8kfCBBQ1lEMSKH0hxxJvJXNu3eHF+5eWLoNJdeLZY9EWSvjaGmYIAMQxUEnE36koi/8+9Si7lPk9Zo3KA02YNZFWMIqRiTDNAtcb9Rz0CJNTYhUyqd2NsGlDhi6dKoBjtYkWCP5e6uk/Wjv5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=LuQS4E1U; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="LuQS4E1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728381887; x=1728986687;
	i=johannes.schindelin@gmx.de;
	bh=XGEa3C2IgRslHjGWYR5QpsrAfknUDzkcijHPLQ/IITU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LuQS4E1URIZ0ryw6JLlI7YFseXhykpEWWAt3nelzNQTExlQni406maxYx6x0K7jd
	 H68qj+R3ilZtIRQtZO4IZEx3uFui+6d6JpjAWbMRwXKsUvSvSIX6ABlH9g/iiDt0R
	 vjtIIYKO1/9ghXy0KSdmmkAKL9NFHfGlUl4INHZFc5Jw4dh0ry9lmf4R+fTxzStDA
	 OoIkajP/MKDb5Q3zERHwuL1YX0zliDCZiSEcPmCgeiKXCwifszLLDRq3P4KPNSGh2
	 q2FDmWJ1u3c28h5wu2Soh1HftX92bpOoljTMBgmY24wJbZM8O8IKeBdjJMklH9jyS
	 xnbB0OmYzN8ayLLjQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1109-973.c1mkocgufe1ehiau2kxkl3vnrf.dx.internal.cloudapp.net
 ([52.234.33.112]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1Mnaof-1teuTb2Ssn-00o3Dj; Tue, 08 Oct 2024 12:04:47 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.47.0
Date: Tue,  8 Oct 2024 10:04:43 +0000
Message-ID: <20241008100443.3377-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.46.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HgaGkYhOPL7o0tdlwAU+vu9zu3kljM5Dz7s2bwRFMGMruilHwYq
 X/dRBySrWzPAEbqC0xMHE//XI7H9oOia4+jGHgTqR9yqJ6DFIs9Gx71C4Ft92E84HpS1ob6
 Yhh/WivnFjPieOJ/pejYE53vprQN9i9k1o3e1ddiAIkGWYqyCFJdHFA5MGUwxLsc0YuYkXe
 VW6BoSynnztMWFS78LJuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lS7GaGILTao=;vjYrQTppy8C7fMIEOIl51jx3uSs
 6jHniHGMASg+2OfD8rlAUCqiBJX45mIClUAg3TH4woLFe5k+8NZJOV6UUlDyfD1iSlMP1Uhjo
 LlEGbDgQk1+PBjm/bd/7HikXGyfA4Bdpzm0/LdaAsBbTC1IEE8arZFvz1YWfvUDq7Sc5dVk1F
 q4huR34NJqW5zGM7KzLaIrB6e7iz3MIf3bYuvdsMR0wDG00Lo+7suOZuqca+w7dky0zl/mjNI
 cqLi+aFlfOVdoTH4sAd6J1v8epv5ONmmehreojStSiLFfaj6XvuPmpmqqRy04jUqYo5LMnVC7
 w5rJh+NVVDGChIb61MpKhU2tTbcOXgGAXOGSLCDWpw9y/dj57p8xExOCovD5S8B639icFJIc8
 HK9Wd3QDMU5xfJrNt3olZhJ89F1LLDx5SrLwaBzZ8Lqp5DEPVnpG57cNL2dbuvYPlDWCA0k9q
 kk+p5ShDWKQnIq4/TYTfQyg4yBERg5yV0uj+xuvrKf9zsvzQXhJDIjp5pCawaG9ym2nNLR0DN
 mbAxM3NcEakHdzmE/GDwDV7H3w/laz86wSTihh44EfHHTxXutcBe5bqBM/W/21yKZ0LH2FpDn
 70+wekjr6OzTz/zp+6PtI096Q9a/+o/K07PQQ3bqA3W4RwqR3mmdjGvO1WCnMDnTmafbPIcqW
 UkHQjEXrUo2AJjmIYiOFBK2qIylWSRiVz1ACddzK43R+Vkz6cFL3QfiFkA2lpSnfbayLDLS46
 lyKcgdLDP6OED/z492l+LnPlMBNw4aiLisqNpLJmE4iKY0olnd+eQVWnZkvUq1tIdMW+FYHBW
 xUESTD2zK1FpsuBnU4sy/I8Q==

Dear Git users,

I hereby announce that Git for Windows 2.47.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.46.2 (September 24th 2024)

Git for Windows for Windows v2.47 drops support for Windows 7 and for
Windows 8, as announced previously.

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.47.0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.5.4, which drops Windows 7 and Windows 8 support.
  * The new, experimental git backfill command was added: It helps
    fetching relevant Git objects smartly in a partial, sparse clone.
  * The new, experimental git survey command was added. This command is
    designed to help identify less-than-ideal data shape in monorepos,
    and it will likely see highly active development. Stay tuned!
  * Comes with Git Credential Manager v2.6.0.

Git-2.47.0-64-bit.exe | 30e8585fd7055eb1417ca4472dbcfcf65dd80c355613d3a6e115d695e7dc31bd
Git-2.47.0-32-bit.exe | 082fccce46d7d5b34a0fd146dbc21ef2c7597f468a0e9a41c3814536a04d6668
PortableGit-2.47.0-64-bit.7z.exe | 0b7fcd76902ebde5b4c00ebae597d7f65dff8c3dd0ae59f5059e1aaa3adace87
PortableGit-2.47.0-32-bit.7z.exe | b2def285b907ce1d47abd2df8df83df629b768defe08c1fcd4ad91582fc6606b
MinGit-2.47.0-64-bit.zip | 6b175d4675bfa7014ba649e3c0976da2a281d89bd9a096f1f41437f9995497a8
MinGit-2.47.0-32-bit.zip | 8d009e2e2d0d17f9c31255065e83183f3f03f15ed238aff9592da0213bedc176
MinGit-2.47.0-busybox-64-bit.zip | 805e3553de73225ea757d80676fafdde004a73b3ae2dac0954d64e87337ebc4f
MinGit-2.47.0-busybox-32-bit.zip | 705b0b547d327f012b91a85122cbc58189297ba2e34885609186613ba4874882
Git-2.47.0-64-bit.tar.bz2 | 63d07aa9593be64e0e2510f69b14beac85e5fb6d3dc66fc0a7e17b8dea0ccfe0
Git-2.47.0-32-bit.tar.bz2 | c13099b232d9e3ff59538bea4e55cc6738c554f5030ce93df8ede7e6044e23b3

Ciao,
Johannes

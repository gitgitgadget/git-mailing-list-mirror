Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873B2EA72A
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656622; cv=none; b=hRxcfu7JkkJTjpGeVrxOVq2HVrZeEuLtr+/uxbscJDlTjJt9/qAmyqXUfHzK+ZWwX6OL/29KvxeYcKHKTqsvA3mAA9XUR3lyulL1rSxO6fR37ko3tc9OvVfQPd9IHA7a3BsQ47+SouyC3hB/mTRuD5VL0mciqtbZcWWlY0H0jp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656622; c=relaxed/simple;
	bh=Iag7zGB8efj2/crePpVekxw5EgdcFQElrj+W3yNgGqo=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=EtPT54jpovaPY9EGx2Rb7m5S/J6hIWsAdfZulLho5sZNQWtifbC+Ubi4TB2KzU1PJ/JmvDVOFdT3eu0tkjsUaRGV0RpRfNMB3bNCPtG8xv7m5JiGS6xil9N3Zxa5Af0tc+uOJLIqxXvaKYsOXsguCDDV9s7DEr6MghsZjINIifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=OZI7FmSW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="OZI7FmSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761656616; x=1762261416;
	i=johannes.schindelin@gmx.de;
	bh=/d4wrTqwHTRbfkLPGmIaHqHUtpoPlapj5K5y31UFEFk=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=OZI7FmSWCPhjuB986n2JA2fZzVb4yXXV69L1W3xbc06sHlsJ1sm+sfD1CCI8bPVz
	 gvp13N3tK3mMRpGbsthMNMbap9N4nx/7hNtItB3lTvaNFP2hTyTkIaYbdiUUe219b
	 Dpoguz/9I1YRK+f123fzjYGzlbxqP9hIR0J+/WtGpI99nMfw1BdSahC+FkOwY9Pd9
	 sDruw4dWCswsT9Nh/VGObdRdxSg27PcA2UYWACn/lGYWxus0ExLl2VFEzNEcOkwIZ
	 KzzxMXCbzi5Ohm/Fmu2buhS0hURd/EudBc09lLy6saLKa1I5iFnj5duh8lu9xtHT0
	 1oUuT81/RgkPzVMt4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.168]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1vhixp2Oo1-00ViDE; Tue, 28
 Oct 2025 14:03:36 +0100
Date: Tue, 28 Oct 2025 14:03:34 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MSt8Q-1vhzwk30xy-00Usrn@mail.gmx.net>
X-Provags-ID: V03:K1:U01O7TyregyONymfsBGZBbVyh5r1mYRR88xGg5zLBWX7FTpU7J3
 /cqm1iJJ5gg/qz2PNUzZNa9GBwNUzcsbs463crKU9m5iSRGmk7R5zKlhbSb3JYQegoT/2bx
 qovIG6HTKF9ShizMTiw18HHMukAngZ5hmewvDCvi9DV5YN27ZNQ+dyQej4eQWHY6bG8wEMX
 pB1j6xPUFt+gluYWfPROw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0+/Jm8NBb70=;rGuXc34c0Wi0RywBy19cBeGdI4U
 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
 vOv2S2db8EAoT0OilM3+wAaxIZvvX6RvHCw=

Dear Git users,

I hereby announce that Git for Windows 2.51.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.51.1 (October 17th 2025)

New Features

  * Comes with Git v2.51.2.

Bug Fixes

  * The default credential helper in the portable variant of Git for
    Windows (credential-helper-selector) is now high DPI aware.

Git-2.51.2-64-bit.exe | ebd318e1d3ee0cc1ac8ead026f1edf8678dcb42c7d74d757b8e2fa8a1be0b25f
Git-2.51.2-arm64.exe | cfa59dc9ca121844a9346224e856ee11916ebd606b211d4291f8b97aa482dd94
PortableGit-2.51.2-64-bit.7z.exe | f5764d546ff9a2511b50ec4e20424c5f4669de1695abc3fa4128e7f7d4a7b2cd
PortableGit-2.51.2-arm64.7z.exe | 73375f4278c84611e788b2adb604fb98213bc8f0accecf3d5d5800748c6fa32e
MinGit-2.51.2-64-bit.zip | 8f0a7bc389c0bccc9daf6107cff4efb176348e34b8d787f02a36679a5588e072
MinGit-2.51.2-arm64.zip | a050e17fedb2e5e8025850194c1e43df1b5f96ec93b0f43c99f43d7fc4da7da7
MinGit-2.51.2-32-bit.zip | 7ccaecf25ad5bcdacd50a162b8de798638dda1c0fc4f4893bbd90867a8a57279
MinGit-2.51.2-busybox-64-bit.zip | 7c85f2cd62453ff24eb5c7c466152b3e5882255f744284518216a76876e02923
MinGit-2.51.2-busybox-32-bit.zip | efd750af9855ad3ad32e268cd7590557a45fd1b0917367687e7c8181eec046b7
Git-2.51.2-64-bit.tar.bz2 | 79b257dd677ed2c18bec0b5357fcd68cdd6cfa32bce4d379ad06e32a15a4b31f
Git-2.51.2-arm64.tar.bz2 | cb119217e363cbcb6d8acc94d1c4b23b3ce8a603ec6a633675c853cfc16d2452

Ciao,
Johannes

Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F825AD51
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762608281; cv=none; b=mrvmk8KSKXXTucHABX2c2x+yA/+qczX5adLCDwTvIhTxCZDzegIn5ujYnB8uIGoPod6Hy7F2XwCPya/1idOuSs8ZGT4tfOgIIb3tIxU3gl7JZBN6PwWqFB5cl8qYi/jIohEUZmEd4fqYyq7KVg7KApoO7N7AypLWONHfbdagcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762608281; c=relaxed/simple;
	bh=XutsXa7xYjr8s7aa0GuOG1U8ag9pEuRfMu+0YcResV8=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=D3dNlkSZwc7lTC+qCTscpFA4yIVzeaukMfmTjWIUiIjzC1sGvQDZhk09HHz2+cGU/ubyGU4JQEyAQa7Mlr/qlhwjrRhg6lCc6JcJeTi8D96gX2C2rsjf9zDOpInjfoereF4NVrCOiEF83XPebof7H1X8itPOIa084Y+PDvcCI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oxheaTH2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oxheaTH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762608276; x=1763213076;
	i=johannes.schindelin@gmx.de;
	bh=xBEeqR7oHM8sSBD3YFbdug1ZHMvzC8XRw0OW3kM6anM=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=oxheaTH2UlFN1CkZ9gP98B7VJ+wUvFemb2TjqB5ArOsZr7OtIlLyvRUXDUneqOge
	 dFRX+RtAcBDRff9j0ox7TJak0we9P8S9hn7dGD2jIwINklHGE7STJsnzWitbxIXmU
	 8F+jp/1/iQ0MZUPivPgF7XYODS/V16EPRMwo9etL1TPGvhVglMJnzGGntQeJp104J
	 fmtqgdzvnR3QBvn6FY3YBq+hIt5hG1BN8ELXTxeglQx0aifVD0gJQZDjqo/5u0qwm
	 2q1DC9gX95/b8ZV7fusHVsOes6dYUthqlkBIwMG4iS85ixbBbetltHiB/b+dr/gh+
	 azF9GyQxBpngkFY/Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.65]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59GA-1vGcT23Eiy-00Ghlk; Sat, 08
 Nov 2025 14:24:36 +0100
Date: Sat, 8 Nov 2025 14:24:35 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.52.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1Mnps0-1w1ZPS3O1q-00ZskU@mail.gmx.net>
X-Provags-ID: V03:K1:OB6NkA/eYwQjU1yAgMLLzSGSnRNNKPIi8pWgj32+EK3hFu0B3Ze
 04yKq0/XtKTsgfrzYpQcXHQ64E2pEBr1fp5ZsZ2u2QPG5ZDTtOWbgU1AdOd+vaDNNzT3QGr
 RQPIo+XVZur8MchdAAmtsVEN2FYlEvmRidzB05QzTb86DTH6BpWn0I5cTQepbTrbJHvyJN+
 XaavXJ4CIFQhZBaBPJloQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cn0cR7vjtl8=;18yB0EE6gxVbLrPQpCXnSHtepfR
 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

Dear Git users,

I hereby announce that Git for Windows 2.52.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.52.0-rc1.windows.1

Changes since Git for Windows v2.51.2 (October 28th 2025)

As announced in several recent release notes, git svn is no longer
supported by the Git for Windows project.

New Features

  * Comes with Git v2.52.0-rc1.
  * Comes with PCRE2 v10.47.
  * Comes with cURL v8.17.0.

Git-2.52.0-rc1-64-bit.exe | 89f66e77aed48edb04eab13da8835f73e9ec00d1443424667752bd2b5b6856d5
Git-2.52.0-rc1-arm64.exe | 58b3ec59b1712da931f8656eca750af4bcafe7a494a3d5ecbb63316c2d39db45
PortableGit-2.52.0-rc1-64-bit.7z.exe | 98d87312b15b82122ce8cc87360bd4dab8e0eaa5611649e0f0d96539f86dbe3a
PortableGit-2.52.0-rc1-arm64.7z.exe | 65446192b399a6c564a9e655937074c94fa493c529267594333293f682858165
MinGit-2.52.0-rc1-64-bit.zip | 9fa8300c9c0c1a86efd8d3c4b580904025c8a2dcf3abc11a5e9c5cd69e95e08e
MinGit-2.52.0-rc1-arm64.zip | 32260dfeaafedde73ea627e16b7c567d258abff701af88aba54a328b9e8e755f
MinGit-2.52.0-rc1-32-bit.zip | 7c5a18bb6cc5f7df5b3b42ca03133fd11ff20080e3759d76a0a5a91dc8067a4d
MinGit-2.52.0-rc1-busybox-64-bit.zip | 4eaecfbe6ad6100d99272ccc19b74173373c331fd533f37c789041d0bdd7b44b
MinGit-2.52.0-rc1-busybox-32-bit.zip | cbf713fa4aba909fed9c574971f211a3ba84525289d772c05ff6327a07be907d
Git-2.52.0-rc1-64-bit.tar.bz2 | fcc82823c7d38817a704c5b395f96a1e1a06af399a48b8ad35765aeb9c694e9d
Git-2.52.0-rc1-arm64.tar.bz2 | c8819551755f7783659e098ab73b7b80bbece68346fadcfb2d4acea5cb7a13e1

Ciao,
Johannes

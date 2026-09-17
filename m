Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053B3A5E8E
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668520; cv=none; b=G3jkMDwoEKNcTLgsEJL1oF88pcYUORWxc/qtnJw4P2/hNbss678g8X8mDIrXglcsTjn9SPtMW/5jYQqMIgzGIBo9omFBqwo4Cf30MX7O/ZP5OPpSnMeMACKHWkPOW7O2rG7AJaxKkvfCsv7e3LGwOSPudlSNSjXIC+4OYWG8ykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668520; c=relaxed/simple;
	bh=5FPWY4Naxwpc9P79EKUhIxLQM00DIGdeIlSRrhmQ1YQ=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=KS1/DJpdW95Ym4x80ehfh4AXxY3TqS3wLwTHU18dPI9DK87ewwXyWurk08LMTRsR/kTMEJ3Vyuq2G/MC0FmiGN3WRpKc1cVcNbbG9LRBLXKOByyBavPfQa5zO1iVUFVuCXFCMgKGMIMiXzWZTc9vZfFgBMFCpnmF7GSsBku0bcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Zp5xjJGg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Zp5xjJGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789668515; x=1790273315;
	i=johannes.schindelin@gmx.de;
	bh=PwQjEdG9QdmpCJwWmtbJXjBRe5wLAPKPSeDTqnTsoWs=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=Zp5xjJGgP/VEKwPJfHpeBC3jFPKIxTt3iKeEvD5Fln8Cext0SZ45KXmT+eQ0aggK
	 0H9n8wYfo7/+NihnkKIY3wVFnihAIzSGnlGX+RVxY/hrQqLx1y3WTRQW10q4D+fc5
	 9hgmceGt8YW4RGOWRKXoBqC1k+l6CQZfSbKXIIu/Td0t2QccE6r3YGOkD3QLJLEpp
	 joq3AcWRBxwnFwPNAkgQ/BLmvzud/gBy1qEUUYAhE63FSDkqxvhk2M9MYEctgfVWQ
	 X8igHoMt6o6cIROve6E288R/0FeTca/eejTvEdGOoxcFRvY1YbGVPkzmgeS+FkP3X
	 aH9qbpV7MLOs8NxjMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1xNpTy3f76-00U98t; Thu, 17
 Sep 2026 20:08:34 +0200
Date: Thu, 17 Sep 2026 20:08:33 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.56.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1N3siG-1wh2TC3yvw-00tHIN@mail.gmx.net>
X-Provags-ID: V03:K1:uUa/Tup5xFzpxKrmMkE9aqz413Te9ZInBVGklak3SKlTR5NVcpv
 uuVomljtwf4CzPPXLfDVrXyK6LX3BZV6zBFYo6S9i/+VL8B2hcv86WIoDktEx7Ru1/7bk1t
 Nb+UixoWJsT50lx1llKCkrJkjJSU27HyRFbigFpd6OyBxobWY9SUp8xwTPpCrpyFRod2jok
 5u+FjzmstVfcq2880B5hQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ritF3h4/q18=;CzMFwLth07Huo/Jp5yhqMl4avJb
 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
 w=

Dear Git users,

I hereby announce that Git for Windows 2.56.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.56.0-rc1.windows.1

Changes since Git for Windows v2.55.0(5) (August 20th 2026)

Following the MSYS2 project, on which Git for Windows is based, Windows
8.1 support was dropped; In doing so, internal paths changed (/mingw64/
bin/git.exe does not exist anymore, /ucrt64/bin/git.exe takes its role;
if this breaks your setups, consider switching to /cmd/git.exe instead,
which is guaranteed to stay stable).

An issue with the installer for the previous version
(v2.55.0.windows.5) caused the "Use external OpenSSH" option to be
disabled for some users. This caused the bundled version of OpenSSH to
be installed and overwrote any previously-saved choice of external
OpenSSH. If you rely on an external OpenSSH installation, and you
updated to v2.55.0(5), you should consider re-running the latest
installer with "Only show new options" unchecked so that you can
re-enable the external OpenSSH option. The bundled version of OpenSSH
will be uninstalled automatically. If you do not rely on an external
OpenSSH installation, or you did not install v2.55.0(5) specifically,
you can safely ignore this notice.

New Features

  * Comes with Git v2.56.0-rc1.
  * Comes with Git LFS v3.8.0.
  * Comes with cURL v8.22.0.
  * Comes with OpenSSL v3.5.8.

Bug Fixes

  * The installer is now actually a 64-bit one, which fixes the problem
    that the external OpenSSH option was broken in Git for Windows
    v2.55.0(5) (see notice above).
  * It is now finally possible to commit 4GB objects or larger in Git
    for Windows.
  * Fixes a bug where parallel checkouts could abort with "* stack
    smashing detected *: terminated".
  * A bug introduced in Git for Windows v2.55.0(5), which caused vim to
    often open existing files with the first line missing, was fixed.

Git-2.56.0-rc1-64-bit.exe | ad9c15eb23b1a0db8e72f1ed31ed22b0494eb9a31843c406dc2cf04f62b1a6eb
Git-2.56.0-rc1-arm64.exe | 11e2d03f1585bce60f9f1475eaa3462d04d569baf03dcb6875904e5a127a0e0d
PortableGit-2.56.0-rc1-64-bit.7z.exe | 678013e835ae8d649694c18ff9277668150a00dcea9e2481f49a276bb2055990
PortableGit-2.56.0-rc1-arm64.7z.exe | a98c742cceed0928dd6041ae68124c8d517ef22757c5cd2e702406dc6366456b
MinGit-2.56.0-rc1-64-bit.zip | 1568396d71947c9b6c22da09f9cd91bdf9590de8d67d93a33167f81c8331a8b9
MinGit-2.56.0-rc1-arm64.zip | b3169c638e45f90d9c594b06ed10e3f3320e182997cb6dc2a4d48fb7bcf595e4
MinGit-2.56.0-rc1-32-bit.zip | be965e3f648ba34788f0a73502f879b51dd3811c3fc8ed55f57c56c789620a96
MinGit-2.56.0-rc1-busybox-64-bit.zip | f38dd4f6e31963395fa0bf085fc5bc45e7f0b24b62bc5ce2ef5c0fbc9b739d82
MinGit-2.56.0-rc1-busybox-arm64.zip | aeecb7d9bf849a0b84f3d02bc9912aa1f70e714b119f5c0c2f4533c05cfcafbe
MinGit-2.56.0-rc1-busybox-32-bit.zip | 4b350d657e3b7ba20dde892e1bf5d5247247c52f67543454e5d132adb032d83a
Git-2.56.0-rc1-64-bit.tar.bz2 | 2b5b4b74e6e1f006d38241df5d4ea0fe89bc8836baa006dfebf87eb5eac0fed1
Git-2.56.0-rc1-arm64.tar.bz2 | 7c454454fbfc4472bd8bbbe4d2da402a243f4543e64f774671f510f071c65281

Ciao,
Johannes

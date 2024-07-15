Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50711836E7
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025772; cv=none; b=HBBZzu21CA6wUbptydxFkn5ZQSsvgnyANVd1ZCyUrMjmx4a7B2svwA+jBimYYdQGEqzSmdTq5l7UqlXoGzqUEtFrdd13OD4QrAbJM8ewn2kaIyqyIZ+cTfE7CX3FzXcYE/Iv9GrQlQR2benbo8ua18mr511nHqABHjwOBdlGSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025772; c=relaxed/simple;
	bh=1ZElPQfVOu/FamtUQukdo1+8jhmD1uN5SSRsgQdKR2E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kjKo7EpEX4etLB1X696eTyOcyTu+xHGbvN4Kc7kAD7XcYPal7OlSknNRjlmlBvqCEuWbjaqPTqxnL+lvls56aYxQH1JiB+vt+2ID4cMlLzPB+cWnkFFybe7xNNXffOU4m9O+dAPMn0Qww9dX2pGjvL6Qp96cBq81vl0fAoFmiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=m4unc67g; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="m4unc67g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721025767; x=1721630567;
	i=johannes.schindelin@gmx.de;
	bh=WtpebRxFdNdKO5ciutWm8winmQqJFtW5Umvko6OTOeE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m4unc67ghzJjJqGbsL1tICdfTp5wBdGY54DLrKc/t7/V4yH+e8GM/XmmUgKOKVIq
	 bXmytqfVz9KXxgzPlHB2oc3DxnxsF+7RS0i01tM6jZhhmSvttSsXoEal1j/UFStLM
	 iRfhJMhgm2sNY8wxvMdelHaAtefMHd4fSuCRY7PELQhOiyTGcEVaxD+vUqmmOY4gu
	 MG7IRdihCkrmjb7fo1jqiSGhdqf1ssvIwdQoOjtyRvCh7oqZP23NWTKfyOenqUvAx
	 xgagt6vL4agdsRkFnc8lV6hHZ0qRrXHf9/76QUOmmrSLK1MCK1yaeWoEwcA5RamuZ
	 FrNx7KHrrr0u3AYojQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1429-436.yiaga5qy33te3l4zvvaow0wupa.dx.internal.cloudapp.net
 ([52.238.29.130]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MGhyc-1sYFcq2ZiE-004rZK; Mon, 15 Jul 2024 08:42:47 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.46.0-rc0
Date: Mon, 15 Jul 2024 06:42:43 +0000
Message-ID: <20240715064243.3401-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:uZ8SCuXgBVNtA5hRr1VCOsJQOA0W0iy9E6WMHWM2hXWaBuzA9j5
 +EYTyEBicHeUTkFTHAnXrf6tCViZEQYpzsWIo81gTOzI5C+dMCGcmwhNBpzQMgm657ZcXjK
 bvEeIFTvW+zlsUXry45jaCxbazOBqQHpufTEQMSW7NTyk7jObLflC51yge0eOhqeQWx0WOl
 90n7xD9Rz/uwFgdSNmCBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OYrhDRujQsY=;GDEUfGel7/tWkhpEEfcZzCPRLlQ
 aPXwmjNeXtRzBS3dQ8SjRhDRNeL+3FwhSAznQYf3hbHy5WRqhllsnUsR1RA4XDm1ClSLVhFxa
 VxDiWdVIdQMpUA/omfYDC/rvjltPdXX25+oBVvxeZ+Xmju/R32VB8TGwdZVZwlFdBymUj+csj
 9/KUbiDhw0zumCvefUZhG8+Ry2+8pjO0l5/I8uuQnqnpBji4uXPUgZyzlHfFyEXJC/gqrDDJW
 vVR/lOpG8c8JAy1DE7BLAnw8GQLLLLrwJ+XqhjAbj0zgHm0g8NjaqPQ9SlVXdYmOGzChTVxIU
 8dmV3Tv9KmUHJhHdjgy7dBXaRa7UnwmS1fOLz8KWh5QfwDRrQnGJ6xJ3BBBFJQTS/+08ybFd0
 mkDXGG+ckebZ7qx7RlaH0xewnbISkm5EjjOtfwxE4jKs75UwG13V5h4Fv4iGtG6AZgwPLIWi4
 +DFSr8SVKmYWGBCpygRatPSkzEnOVJcv3dBFTCGnR6AI8A7iiBRw5VL/F0XkyXbXEqbCIQxe5
 m8najo2O6zAtM6xDY1aujUSHA7Tgm8oFfaeqZI2JD8nnmueCi6rOTSNl9dE/HwiAXf6ybLADW
 ES2o598HepO4DtUyHy5CGsFq+6X5ZONYlFDZjnuGegNcUkJGuvPeTKpY0IbK6ZGhguEPYlNt8
 Iy4GorDpbVirnxrXy8qqVOrjIWa8QydLuuOaJC1SjIW70XPmca59C0PqWWoT6anPqTLkJ5dDF
 NXmoLpzQ4k8iNxKAkU7Z0t2hkbMIwhHKRJ+7cwJQnxGvUxC5AFGtJfKA6X3aNFNMgw9K8lq6g
 42sXvXs10swIRJfhGSHhkQMw==

Dear Git users,

I hereby announce that Git for Windows 2.46.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.46.0-rc0.windows.1

Changes since Git for Windows v2.45.2 (June 3rd 2024)

Git for Windows for Windows v2.46 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.46.0-rc0.
  * Comes with OpenSSL v3.2.2.
  * Comes with PCRE2 v10.44.
  * Comes with OpenSSH v9.8.P1.
  * Comes with Git Credential Manager v2.5.1.
  * Comes with MinTTY v3.7.4.
  * git config respects two user-wide configs: .gitconfig in the home
    directory, and .config/git/config. Since the latter isn't a
    Windows-native directory, Git for Windows now looks for Git/config
    in the AppData directory, unless .config/git/config exists.

Bug Fixes

  * Git Bash's ls command can now be used in OneDrive-managed folders
    without having to hydrate all the files.
  * Git LFS v3.5.x and newer no longer support Windows 7. Instead of a
    helpful error message, it now simply crashes on that Windows
    version, leaving the user with the error message "panic before
    malloc heap initialized". This has been addressed: In addition to
    the unhelpful error message, Git is now saying what is going on and
    how to get out of the situation.

Git-2.46.0-rc0-64-bit.exe | dbf112c9c18bdbfe3166ec45ad443056f24136e502a8eb9570b877a1dc8ef6b8
Git-2.46.0-rc0-32-bit.exe | 7793e727e55b8e8b7a6677ea9ecc040692ba8f9629a962afaa2da54edef7fd20
PortableGit-2.46.0-rc0-64-bit.7z.exe | a16622fcb11233eb447d3c34dec992830d97c641b5293150babad62330b587ae
PortableGit-2.46.0-rc0-32-bit.7z.exe | a19bd864c1be63133dd548629dbf87375db9d7640a13b17fe6da29295f933254
MinGit-2.46.0-rc0-64-bit.zip | c7c894ead5affd8958982cd7ac0f0703784561fee1203121707a76172a181a9a
MinGit-2.46.0-rc0-32-bit.zip | 3487e58bd60d6a9a16771954c82ea7a8f936a8eda60931783890e710e37df9c4
MinGit-2.46.0-rc0-busybox-64-bit.zip | d9086f0f3010a9dc4d2ed9e1b4dbf48a9ff1b9ec09d3a7a13d34e211693e90f3
MinGit-2.46.0-rc0-busybox-32-bit.zip | 1efc39ea79bfd9d12e4507140dfbe008894c96c3926df41d68facc7bd2170bd5
Git-2.46.0-rc0-64-bit.tar.bz2 | 9e7a64a2b17bde4e94a35e4142c981e33c5fc75b660e8b18130a5b5655b082af
Git-2.46.0-rc0-32-bit.tar.bz2 | 773aa579ed14369471019741ec8d699ef8d9fed2624617184dda0a9e4d54b212

Ciao,
Johannes

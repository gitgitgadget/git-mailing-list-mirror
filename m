Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C242B9BF
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445372; cv=none; b=dxKXrXapPk0chKaKgJousibYmXmXypYkEFNVFSvhxKF/YczW/RcGVtFLrafhlkDz/4txbl4IoGFOWrS+8o6GG/JqEXfeDPWjtXlLueSIufITWmUfXLMxqKjvwp8d2Z8q4jP9uHhTw6W/xn/UKeGNOkt6/llm/12icqLR1lbx8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445372; c=relaxed/simple;
	bh=Aq9mwaNusGELIFwCf3qAdzk7N368vWw9kXGd/gBpnK0=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=LZswDYj1Xr8YXTrvw8ZzfMLJqmw8o70M0hJ95cqZ4A8eoM88fIQuB8/Rto2jH5NzCZ+Sv33gXqfdwEsTtLN9hyQeZfwEJQTftav0OOROcts5usR3wmO51x+WM4Y4gJDOaOTep7XH2PF3bKG/cnWc789cabU2PmyuO9O/fCpSxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=av0DkOa0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="av0DkOa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736445367; x=1737050167;
	i=johannes.schindelin@gmx.de;
	bh=rrBidfyMK4OZ9vWyQ6T2haX2wWR/GJVUNOhyp9L9GNk=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=av0DkOa0oIZXfNdvIC3oM6QanSviyO2IkN7kx4Ntde4OQX5V+ud4f0ohuKBywnY4
	 AjDvWgAac991OI7wZcJcGSqGdXK2n1sdNvKBtIIvlgVzuhWJxbQHinf/gZgvt2HYD
	 53QIYB9nGIquqgai7uaYQfAsvZwAIiarrOJcd/IXGB7SD5r8bBZpKaYfS0t3NZocK
	 D62Q6SzwspIYtV6WEXY9ezKe3XaV5dFfQe+lVFnSedho0iUKTnd9iLnniJ0a8ZlyO
	 xcaqZuYbmXOV8pJtunDp24ZSIxazFunNtzysGPaEedRTOjKJ9KboKM9Tq++3Ax8D/
	 ENpc+c0B5sG9EHpu7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1szu4C1kvD-00pXG8; Thu, 09
 Jan 2025 18:56:07 +0100
Date: Thu, 9 Jan 2025 18:56:07 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.48.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MrQJ5-1tC3fM1wr1-00bDOC@mail.gmx.net>
X-Provags-ID: V03:K1:IAR/blIfHwLJHgaiUofuYyHjtqPD0fTZ3Hynksz+gytvU7zbxJk
 x2KfeP6c1JNlw/M83iHQnu/n1ON1mqOrp/3kFTDFM4NWnYTAMrWhp55aOE0mgSkmVG90u/F
 orYSSF6wzpUUSyqM560Kt1Jx3xTyve+3YhdnrlqqRd4nUrLmUxWYPeUYFK2a7Dh1X4QzRzN
 YEmgqajlovRZao1iCIGQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:meUPUrDrmXY=;I+VwHIofiONpPnNwYiC/EVm1+dK
 bVcO4CpurGP9VlAxV4EO/imQekb0nQ13wZmkHEOqTeWi9ebNN67BFg5S84MNJ7+RV/CYPTBGH
 hJK/gh4S1yJOFOnztQeKP3sD4Cio1INs333c9jgixZSJvXjKH4spDBHaXnUasP9rgIb+RtzNm
 QVYVgDVuwyFlx++fM2rb3RmDN9nJO8i76qE8FRtyplsE7sj1CN3C5TgZtdMBzyf37E1fJH/sB
 SzdC6dx0jFWkgOq8NLejM8XHKj/N9Dk4TKK9Zki90BVbmWBJF5O5afX1Chk4Tz0JDk+BYYoQ3
 +RkSP6an3hxuacan0LW2SYRReiwHyT4PLrPqE5sUiZyBhPOisBu82XwURbsWUYiflZBfnFfeX
 QvC3KDvzrOElG5Oldt358td0R5Ki3npD3tGzNv7DFVlRQVb+sKeaQ4wTS4j0CoVQr2sRAWjex
 kP9qoJo4J6t9d4Z5cDOvsLnSVoW28/XSK5UrlA1XawjMEcFFM5brXAhE51TvthbfhFBZzzQbB
 F4yLMrbW8UHMDaz6gvWoKxTauf4VvuKNd9WHlnL3qv6G82EpUAv6+ESqSYrDUFbH/ygC9r05F
 sdoRcTURFUjg8DR8xDVZEGErGp25qY38pkfC4kvnWh9S967It2i6r/ALgP5nKpGo6dkU9LPdO
 +UBNvhDFaulZh16IiEeg6Xwmdd+9bcT4sb5upe11qQlHk9PMNZfkkvTIhnuGSV26J2nQjtRov
 D/9RMfvEmDZnMe51JoczJSOR3ilu0B7OkuSlpWdHJfdjmiSuHmZ5GUNST5CRwmSyfibkZ4O0R
 yl7FOrU7ydFMI77kT4wh5J3T+C4i35YVzdv1LjGQ3xEgkXRRiNoeEB+RUYrg1TW/IBjUxLzf4
 9bCh7q4WcHMOogpDzOIl0pzNYeZMGZA3e52Npi7oUPcQgC73fUaFMwKi3EuRXrpWpEAaG4OoV
 nGwsYWPgwyCa42OqNPT1nVLNHM9Ov+/SIKOaQcMPtsgHDYhz1aRK7OgfcJprztcoe4eMbEB95
 nLnso2F4dLH9ayekDFEdEzLTVH0PlbZSsKT9X4vcogvNBm6tgYqcKlpX7GvcBiGwov00X1LaY
 XlxBtegVz0rZ+eZi9iervTceq7bXjJYVe9NXASRDmokm1hPO4gpdY7Dd/RN7H8FY4YJ1Z34Is
 =

Dear Git users,

after addressing many issues that have cropped up over the holidays, here
is Git for Windows 2.48.0-rc2:

    https://github.com/git-for-windows/git/releases/tag/v2.48.0-rc2.windows.1

Due to the amount of work that was necessary to get it this far, I ask
everybody who can test to do so.

Changes since Git for Windows v2.47.1 (November 25th 2024)

New Features

  * Comes with Git v2.48.0-rc2.
  * Comes with cURL v8.11.1.
  * Comes with MinTTY v3.7.7.
  * New Git for Windows installation now default to the Windows-native
    HTTPS transport backend.

Bug Fixes

  * The installer now correctly blocks the installation on Windows 7
    and Windows 8 as these versions of Windows are no longer supported
    since Git for Windows v2.47.0
  * When using the cache credential helper, it could error out with
    "fatal: unable to connect to cache daemon: Unknown error" under
    certain circumstances; This was fixed.

Git-2.48.0-rc2-64-bit.exe | 2d7067c84c57e075f2599734cf38a1498aa58cd0ed871141f6062aed97abc150
Git-2.48.0-rc2-arm64.exe | 712739bb49832d571732e3e74b111d7cb4a63cd622ef3e87d01efe35046d9a4f
Git-2.48.0-rc2-32-bit.exe | 741ceb11c0a66ce1c440ce0a60b88b0d461e786e5eea29a9d622d3553fc2ba1e
PortableGit-2.48.0-rc2-64-bit.7z.exe | 6f36815609b831e1596b496fac87861fde39f0d55a7a6086ca40b4d7340834f5
PortableGit-2.48.0-rc2-arm64.7z.exe | c88a264f1e2a56a89bd5f6ba7b5bd0ff96f2b886c7d1099f22780239c84b249a
PortableGit-2.48.0-rc2-32-bit.7z.exe | ad0052b327287e77cbc16e9ada38be899df505c80133882f7c14c3bb3da584e7
MinGit-2.48.0-rc2-64-bit.zip | dc0c8dfe397d29a1541f5dcc05fb8d843f1ffce0ca4dbc109ded9c447c567cb0
MinGit-2.48.0-rc2-arm64.zip | 11c17fa4df1398440400dab9eece1e250b759ecc0ffae2bc284b348bbb746f9e
MinGit-2.48.0-rc2-32-bit.zip | 0a3501081f99ff6ace63e7bfae6340525152fbc148555873fe47a6660f216eca
MinGit-2.48.0-rc2-busybox-64-bit.zip | 686efeccfdb7aa0d27eb7623a29f59418b393b526300817410f0a52552f5a540
MinGit-2.48.0-rc2-busybox-32-bit.zip | 00b8a353fa2713bfc7de81c93d3012bad351cb8180adbd7916103c7e0d66e610
Git-2.48.0-rc2-64-bit.tar.bz2 | 62308faa458047cca64517e46440112738c8b630a666a296dd0ce415a4e0f354
Git-2.48.0-rc2-arm64.tar.bz2 | dbb82b4101821d9515cd98e83f09819a3e91091d6af154ffb44d89434e22191b
Git-2.48.0-rc2-32-bit.tar.bz2 | ae1c21237a6e062a504c26b3ff579ddf5558aff622feb7aebffcd8864e46ed91

Ciao,
Johannes

Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29177107
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340977; cv=none; b=Ty+LjA9DD7tX/5B49HxaHHpyAtxL4JHFNNUpnLA3MfEK02j0zPgaxSnnL1y3vZD57LXqW8OPd/5vmuX1oYsJmsy+P7Rn79mGZkIWuomv8kTI1XxHY3LMJlwnoAasglzK0DAMElliUQUVaC4E6SSYJBx0/mb/ThNIzkDYCeBYAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340977; c=relaxed/simple;
	bh=iADzViIO28nqLLXpSSIgkFFdas4R3FpIR9Aivn0xdHI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UeJpOOZZCTuBrIUL1MbiL9yK3iGEWtbe1jmfGxJkIdsIRSvAF2a+Qde2vqsjF4qk6NBY7IHQHzjt1aWAz4VSND/W0T8zRwyaccBmeLZMjaEyck1DgeFtiAPtpUTHcGM4FwNej3WPAWcLJaPQRMI9nvyciUwFUfeOlrnxyjjb284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ierFYSYV; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ierFYSYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721340972; x=1721945772;
	i=johannes.schindelin@gmx.de;
	bh=t+xUZ1sJ6EQif9CDdTHRpYuK+Elu84Cl2LUuEYO9mSQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ierFYSYVOV+x8wZDugsmWDoZOiJ3KvyAHTMZePPTHBVK4mP6jLT9Dw6dwJZ9hr/9
	 CibhHSFwmr3pm+oS8VlNIYCfjMXS9Vd7MgkFHTlN8CI7MiXwGLqKO0cUi4+yyY5pA
	 QRcRp3tOMvQxH6SynNRi1uIN2N/Ufwi21Sgu8P7cw0VlNMmYnX6IsfAWvasBwye+f
	 fenEhOoqP1sbzAJXTyb3u2f3FZa+ti/3jFTi3EmO4eWV7rDGVGjcNNge2MloeVWoD
	 TTiGm1es/GfqmTatBGcDtQXOxZRv3m3rDUTtIeQCNN6TjrUv1uiaCnTCJP3DBzrAT
	 cGrdS6c3HCDpQh3voA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az768-602.40rqqy2ogysuddehfxxvv4ylpd.ex.internal.cloudapp.net
 ([172.183.108.35]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MfpOd-1roLys3oG9-00b4tB; Fri, 19 Jul 2024 00:16:12 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.46.0-rc1
Date: Thu, 18 Jul 2024 22:16:09 +0000
Message-ID: <20240718221609.3298-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:MvhUSTxCxN84d2Sj7+aTSJWdkiQ2cPQK/MpXGH5T8+7X6Df526m
 nAmaEp1A3xo9ajiqeLxm61dZw1dzZ/jx/9vZ1CEET+/jTfEYUOpgb1jFtrkyLvRrueN/bgg
 mhPgzJECb+rkkH6Bq9VvFPawWI7t7ZU3uU2wiUZb9knHESCad/D+b7aQos0nwG6eDRhF9aJ
 cd6VFX/PVwnznbi4zngKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d+mhhLG6iEQ=;Fl28AJQlY2vQVxkmzarM0ghkpbU
 HPw9dQ7mr2hclDc1kKJS0W46hgYbtCUKIFXw270e+T0HvxB0I6JQRp9mRSfaoQSJpM1ILVic4
 0x04fvyT9clQxK4RaHKbUu7kWhv2SP5dk5i9JML7lc9mgugvOKxStlR8Ye1+rjYOGbnjm3V0X
 L0w3hwL4o9/6234OKgE6H8kInBRi335LagNJ4nKnCIWtAeFufH6OCHMYAMp59XGoECjQvsPSu
 NqRPOu3oNITDqTGLUXRa0fpv11Y4lcLFVBw5EeXB8yyXIFpXqd7xaZ3uall9X2RtIkMa8pyIK
 bJUBntB18STEcVdVpzGtjXjmsVsrFwwMTylbeIeyrvpEvDLK+duxYKLuaJg5VEH+jxec9DEn6
 zhQqEI0E6x4JPx0Ys40AZwqolhUVcESfbBMl0vQddfRo68GPu3jhDRE5LPaBeIoP17AVb29zn
 7Qd/tJ4+nnVwmkmkHWt62xka5kaO+zbS9D4qA2lBasmHRiAE3kz4/LZWF+bnhekKyvkn8Z7tf
 4T87bwxOtIZv0TXEr/61zWMoZNXHjpOgMXXv+i9fQ9ioVY/H3uzBn4o80P4Mn2x09qvH3Er28
 EJH+MIjrVMtrhmKpigs41oTsF+HXM+cFQwD6DF7kDP3nTSPAPLb6+VdHFqFZ2c1mcy/D8SAY5
 2caa91WmL+E4ioYF2nZI8/Qvkdr9ycjn3GMMyvfpi0lkzG7nr/XUZGUKquVMnky2fqiyKW7iA
 X8+5W5H9q63oqHQ9m2OuAmMve29e0ZlIfV3aoXw3VPv6nCMqhXEI5iHSisIoCA6WRF6frL/u8
 jFZLDpRijv4HPH8/zd5ys2Zg==

Dear Git users,

I hereby announce that Git for Windows 2.46.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.46.0-rc1.windows.1

Changes since Git for Windows v2.45.2 (June 3rd 2024)

Git for Windows for Windows v2.46 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.46.0-rc1.
  * Comes with OpenSSL v3.2.2.
  * Comes with PCRE2 v10.44.
  * Comes with OpenSSH v9.8.P1.
  * Comes with Git Credential Manager v2.5.1.
  * Comes with MinTTY v3.7.4.
  * git config respects two user-wide configs: .gitconfig in the home
    directory, and .config/git/config. Since the latter isn't a
    Windows-native directory, Git for Windows now looks for Git/config
    in the AppData directory, unless .config/git/config exists.
  * The FSMonitor feature is no longer experimental, and therefore no
    longer offered as installer option. Users are encouraged to enable
    this on a per-repository basis, via the config setting
    core.fsmonitor=true (scalar clone does this automatically).
  * The server-side component of OpenSSH, which had been shipped with
    Git for Windows for historical reasons only, is now no longer
    distributed with it.

Bug Fixes

  * Git Bash's ls command can now be used in OneDrive-managed folders
    without having to hydrate all the files.
  * Git LFS v3.5.x and newer no longer support Windows 7. Instead of a
    helpful error message, it now simply crashes on that Windows
    version, leaving the user with the error message "panic before
    malloc heap initialized". This has been addressed: In addition to
    the unhelpful error message, Git is now saying what is going on and
    how to get out of the situation.
  * As of v2.45.0, the manual pages of git clone and git init were
    broken, which has been fixed.

Git-2.46.0-rc1-64-bit.exe | f5d15b031edefa1922ea1003a43c7d7544ce97bb708a1456988f7756b31fb670
Git-2.46.0-rc1-32-bit.exe | 653b50a1e8adcb36245e544480427afe0040086b43f549aec77b203aee2cf438
PortableGit-2.46.0-rc1-64-bit.7z.exe | 1078d579a704ca5a760b3b20b6b534c9facc50788670136973363224e8ea2fa3
PortableGit-2.46.0-rc1-32-bit.7z.exe | 97bf609641a47af7ac88cf97f4da2ca1eeb0f8b76a852331f95801f3ef55911f
MinGit-2.46.0-rc1-64-bit.zip | c5cb8c340977848908c0b19c27b75e0639c6adcc391eac425cbe0cbbf8d7f7a3
MinGit-2.46.0-rc1-32-bit.zip | 1c90b55863a0b62027200a2141d5dc6a41b4b2268194cadf1aa6c2b991096acc
MinGit-2.46.0-rc1-busybox-64-bit.zip | fc51ef382a747231cc9cb64659a13f3a2a7936ef2de79308edf7fc90517db77a
MinGit-2.46.0-rc1-busybox-32-bit.zip | b1800f48904446d54d9cfcc432d75635aa0e194d742fe0bc731315797dc91e73
Git-2.46.0-rc1-64-bit.tar.bz2 | 81f59d7c2f0f47f80d2f9c8cd4e4a293f3afcd416f24807df8cf83482d521298
Git-2.46.0-rc1-32-bit.tar.bz2 | b2c6b2eb008914c2cde713a78bcabd9472855b5dd61e814e5aff03235932b44e

Ciao,
Johannes

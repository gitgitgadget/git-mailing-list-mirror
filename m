Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1F44C94
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455999; cv=none; b=jlaqvFa23XjD/ajYbSHUq5o/05LYf7pTUg21gt93prvBOJ0JEgeCAhqSPHV7ulIExwar4t3AE8xVRkIJrZFa7h4briEfKAUD/+AFbfrM3GZKCs+QRVNjCqquGyM/KxHUi83fyFqbLhmKP/ZlQFR9YtZ+E4XGo0fpBupXZmiEUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455999; c=relaxed/simple;
	bh=MDM8OEpgcqUKXiFiOK1ARe2Hcyjwt/XEx2eCo0q3pIU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AjkJGEdOQmbA7K2bhyr6RGdFskw/2YRv+/8WIeTGEzwT5dyzkYxG3Mml/1+KlGnzzui73J7LfGtTGJ3tryAQ7ByRJuNZR1KT9Zd3UNCm8vrjXQersXE4fdwmB7Q1KlI7MeFM2kSHIi7xruC+0UYFE5QIKZx/H236j3vEZy88PGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=T5Lg9bD7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="T5Lg9bD7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708455994; x=1709060794; i=johannes.schindelin@gmx.de;
	bh=MDM8OEpgcqUKXiFiOK1ARe2Hcyjwt/XEx2eCo0q3pIU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=T5Lg9bD7O4L8Qeu269yIb3uzWjO07FlXg7O4JClYP1+3IYOPIRzq+v7/AYFIZEht
	 Ipsvj88JZ2X15iPz2SgFJcGSfU+0q4NR1nYUA+niUCx9/V9nyYXQnKng4lofz59n+
	 TbASObn5R4s6Z3TIVdkJn9szPxXK9gOxKx3l381fqHzOBwk9NL8JN+UvMjrkRjOAd
	 7w/jg83OpTlqp/scB7Br+LGM4dbNCW88TnWkMJydV6RcHRQQJC7jVFe1ka3wpx36M
	 aruNoxqL9IX3sKmRirpBsZda7bEFpoTkax5tSHdfDJdOR0QmVSWlmePKww955VfCc
	 mc6gWu1lbuDdIY5VzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az698-202.qjd1uhw1tstuviscw2qx4dak1c.dx.internal.cloudapp.net
 ([52.238.27.66]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1M2f5T-1reQir0COF-004Ey6; Tue, 20 Feb 2024 20:06:34 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.44.0-rc2
Date: Tue, 20 Feb 2024 19:06:30 +0000
Message-ID: <20240220190630.3700-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:+3HZLsdg5k+3Tx6AS22oOIUIUZR5qC3fSmi0JCVb8rp3wdoAacs
 KXM5IO+YTWi4ywDtatHUv2xdr8l5oPszL8X53IJngZn5g8n9l3ONdtzNxZkTzTu6F3pkY1k
 8e3xnO3lnrKkK8TX7P19qcRy+VFcBohNzYTzpTcz2qcioZ0JZxVtlStgtWQ5/TFE8XE1TwO
 0e+yXNreHjOksD6R3f6kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+BbwaAhpby4=;e4uZdnIRmA9Ut+YeeyWAiIm45jR
 7uwjEVwf9K45m74XWFmT0kTSmPRNmTf75SrrWrRxbW28WloCXXwtO5x0PyF3rmRW+7qiH+q5Z
 2BZ3lx5sKFpzOk0NuzVxxo0ETQ/Vu1HONsIgSn6Li+PfXKwy9NMFmlUS5qc+MfgH6ELUOfY21
 f6POv0sZtgPpKY2vOqpFBa2Tyr/QUjxQ+ODRceMkWepM7uREL/HwA1UF3i0vGSsXyPXE0hooR
 krpZYBrQJoLXoUVEEqvngDtb6j8k/4RJU4IAbP6+Q9W0m/jt38aWn6p0/b02Sr2uEaKeaSQmE
 1ieUzvg1na8Z5oqs7aWcGEJnLIEXDKweGED9je03qgGJlnXBR75CrvV/fpYukN1vvJLuiZhmc
 irvmDeszy+b6pCw2mdxTWrZHwKL/LomnWRmGCOa/lzNGWQxE1mzE08Eqw9pJOo2OlYns7caBG
 8Omphp1d5ib3r+XYF7Gk5UyftZYqxwmsyB2P4R2P1pmHU0rAWSvHZmE0Z0w3MFTORdFA6dkAa
 y8+COwFIEvWpGQVI6rqD4Yts+iLHpA68+0O0/0dFyW+EccFiIBejm+WZqcvI4dgx7CtD4H5fB
 22AftNxAhUcSFyQJPe8e+jQfMSAYKhm43R0i5zNyvNeMpyoWmrkGnntTXAO4SxB+fihRrCzTv
 L3nAPy7dX1jrhrMTbHyeAb37mRw8NBn1qIHkmB7W1b5iX3UZipjGziEkQG1IXafAhFtJMhJ+f
 Eq9rL22ruCId1yRRUp73YghSLOAxe58q01x/raIpgSFpP5OSemsvm1aoVZoJxLb0wE+GXg8Yq
 uKIeKizoP20ydDRC1cdWqBsHoibuxC8BnuVjmXE774HUY=

Dear Git users,

I hereby announce that Git for Windows 2.44.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.44.0-rc2.windows.1

Changes since Git for Windows v2.43.0 (November 20th 2023)

Git for Windows for Windows v2.44 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.44.0-rc2.
  * Comes with libfido2 v1.14.0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.4.10.
  * Comes with Perl v5.38.2.
  * Git for Windows learned to detect and use native Windows support
    for ANSI sequences, which allows using 24-bit colors in terminal
    windows.
  * Comes with Git LFS v3.4.1.
  * The repository viewer Tig that is included in Git for Windows can
    now be called also directly from PowerShell/CMD.
  * Comes with OpenSSH v9.6.P1.
  * Comes with Bash v5.2.26.
  * Comes with GNU TLS v3.8.3.
  * Comes with OpenSSL v3.2.1.
  * Comes with cURL v8.6.0.
  * Comes with GNU Privacy Guard v2.4.4.

Bug Fixes

  * The 32-bit variant of Git for Windows was missing some MSYS2
    runtime updates, which was addressed; Do note 32-bit support is
    phased out.
  * The Git for Windows installer showed cut-off text in some setups.
    This has been fixed.
  * The git credential-manager --help command previously would not find
    a page to display in the web browser, which has been fixed.
  * A couple of bugs that could cause Git Bash to hang in certain
    scenarios were fixed.

Git-2.44.0-rc2-64-bit.exe | d188ba8cb0d36fda22fa12759de00c9e23cc45f57521f05184d3cf8c36a6fec3
Git-2.44.0-rc2-32-bit.exe | 12149c903330ccae8298a6890d3eed49939393c3a806775ef0ddb27674315556
PortableGit-2.44.0-rc2-64-bit.7z.exe | 4b753124cec6aa6635001c48716b249cc43a37db10aec3f0cccfc68d6d20ac7c
PortableGit-2.44.0-rc2-32-bit.7z.exe | b8cfa7ae7549a3c12a4e19fb9598e16161858075bba3df4110f0585e2476bb5a
MinGit-2.44.0-rc2-64-bit.zip | 6db61b0855f4dd67770a221debea944c7a69cb8fa37acb5b1c85c10ea914464e
MinGit-2.44.0-rc2-32-bit.zip | e92da5248e2165c1a25fcfce0469754cee218e8954bfe7711890d06803be1659
MinGit-2.44.0-rc2-busybox-64-bit.zip | 117839c34a0dba2323d46bf1c66172b4452c9323ab8f917266ef088aec1dc118
MinGit-2.44.0-rc2-busybox-32-bit.zip | d9820cccb91d80f46914c047f65424599cb29e87ff7a015e9fcd82b84e7b9abd
Git-2.44.0-rc2-64-bit.tar.bz2 | e6346c6ca380035642334d81480f24e74dfaed56f3b8d8313df6989c7b7cad11
Git-2.44.0-rc2-32-bit.tar.bz2 | d94aee3941b289f6b1ebf20cca84165628603cce71a067c44338b20e380deaa3

Ciao,
Johannes

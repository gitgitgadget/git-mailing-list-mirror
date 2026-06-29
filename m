Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AC3839BB
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757565; cv=none; b=Uh8DjRSaMPjculW/rBwI3/Ag57i+Rft3FZKZHa/Rt6+SWBYfl4z4JTCaT25hAMQLaWuXTJ10ga4o9XonMpjK648MlJppQgNiLo6vkncuk79UOMU+ZU2gchydC/ReNs98qZvCFf6/E4hjFB5OXHFiFue6pyKuifIYXZFqbgiLX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757565; c=relaxed/simple;
	bh=wKmOOilVwGw1yr+jdXguG1vA2LyU4RxlcKXQD7RvF4U=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=OxXsbzSIcBu7eMIZhd0pA29AlJMhZEQYv+veAqJb1deJPh/exW4VybhB3VUwkrUx0UZSSyqD3I1v8waWELyU94SMWLn/G5OwEa6Zs+hCKmowJbsPtwEDMnJC2tje4xckmtKuUXWVrVnBb9n5UFfcbck+QgoGqZn9Q7EDsh4jWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=KAhSgTpm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="KAhSgTpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782757560; x=1783362360;
	i=johannes.schindelin@gmx.de;
	bh=bgL0TqYuTOfbPqTW0MCd039yKyXskZkGTJosZxV24To=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=KAhSgTpmxfyd3gCdu6NCAaIPmYeVHWK8NMS9Lw0Q+/yfY2kZdIMYbTDy8DX6kTDq
	 hGGZeeJhqr6xzG8f8XSkEoeM8Vg50xO70WprolRbZUg2XIbp5N6nqfAPljvGVuaSR
	 h1T9wfGLvXHDY5IX1IAtv4ayy4onwD+za2hEEor9K7Wma3YVVGKX5TsQdGYsJUPjk
	 rHxcsFBEDRlTPku0yf5jze62UbfmXQen6TYMIx+oyWWkMA+Tym2x59r3TbZP6fL7y
	 5lgquFXMBUqiRcatljLRnr9bMYwwodvqJtyzMRNwgdXezGJbETlWQpM5BGeQ7igBS
	 QwfSKw/HAI1l7yz7gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1wN0wb2rEP-00U63g; Mon, 29
 Jun 2026 20:26:00 +0200
Date: Mon, 29 Jun 2026 20:26:02 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1N79yQ-1xCEzM30ns-00vPbV@mail.gmx.net>
X-Provags-ID: V03:K1:5NkJFgYPLGjvfojuhsMdQ7LvKGn6JslaJQtBCfwv+Ey2s8IGN/6
 HmGNDZtICOIcJcPE11+GyvZaY1ks/xMcdFsKLJQcd7uLwXvpK2Dtk9SKOdFNIpe4hbdKGmV
 rdkMpb1N07g2s4fgNRdmJ1gPv9ehBvEyqRwApGDjWjxLUWf9olKOx1HvznyDS1MAuVYmtD9
 MXv6f0FY83bx1z+qwMyQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5T/NSuCl8ak=;Jwq+QpNZU3HyOw8f08zh9f4BYt3
 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

Dear Git users,

I hereby announce that Git for Windows 2.55.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.54.0 (April 20th 2026)

Following the MSYS2 project, on which Git for Windows is based, Windows
8.1 support will be dropped after Git for Windows v2.55.

New Features

  * Comes with Git v2.55.0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.9.
  * Comes with Git Credential Manager v2.8.0.
  * Comes with less 702.
  * The FSCache now accelerates more git add scenarios.
  * Comes with OpenSSL v3.5.7.
  * The diff helper handling Word documents was ported from Perl to
    Rust.
  * Comes with Bash v5.3.15.
  * Comes with cURL v8.21.0.

Bug Fixes

  * A regression in v2.54.0 that could cause endless "Unlink of file
    '.git/objects/pack/pack-.idx' failed. Should I try again?" loops on
    older Windows 10 versions during git fetch operations was fixed.
  * A bug that prevented proper shutdown of processes launched via Git
    Bash under certain circumstances was fixed.
  * A bug was fixed which could cause parallel checkouts to fail under
    certain circumstances when the FSCache is enabled.
  * Git Bash (MinTTY) now respects screen scaling settings under more
    circumstances.
  * A couple of bugs revolving around very large clones/packfiles/
    objects were fixed.
  * Following TortoiseGit v2.19, .git file validations have been
    tightened. As a consequence, access to remote repositories via UNC
    file paths needs to be allowed explicitly via the safe.directory
    configuration.

Git-2.55.0-64-bit.exe | 0c66e4a5875da5a74f9754386de7555ba301503b03bbdcdbafa69dc6464e548d
Git-2.55.0-arm64.exe | 1c28f00262df9e2721036492d5e206862420325516a9a074d3fec1b9f44431d8
PortableGit-2.55.0-64-bit.7z.exe | dfa8cad3ce7e685b9bfbbb2125afcf7c68d4f53490426702ffac367dac62e928
PortableGit-2.55.0-arm64.7z.exe | b1fe421482c6e5a1aa1135406d7eeb89adf5436b3e5af183cdcd6ffe3c6bc8f2
MinGit-2.55.0-64-bit.zip | 31497e7968196332263459ee319d2524e3ebc5786ab895e2abad34ffdd4f4ebf
MinGit-2.55.0-arm64.zip | 377e283290e2de455cdd5cdbd99653bd911db752a8986d1ad914a5ac2fbd1192
MinGit-2.55.0-32-bit.zip | 04e432c04015e07fc01f3fd2d1b2e1d5c3340e44ba1ebb88dd2397a28444f2ae
MinGit-2.55.0-busybox-64-bit.zip | c6e2825dbb596afc89f27e205b4c3d573c3533f7f8c2fd2c1e02baaaaabf219b
MinGit-2.55.0-busybox-32-bit.zip | 393405be25c80aa3825a556f9ab94f85344ac199bdac10f7e02d6a3ecc5d89bf
Git-2.55.0-64-bit.tar.bz2 | 25bc3235291249f39bd463cd9fb86d9b4295b19d53d81af0238414bc68e16110
Git-2.55.0-arm64.tar.bz2 | 440998321e239588588ce5c8df1a45ffe99551691ac47d148dbbdae76776b582

Ciao,
Johannes

Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2F6F068
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721858470; cv=none; b=DVtrnfQZ3yDZbdBDUWfJlcY7fj30aEfi2keCJxPUHUNJApS/sCx+EVLEI7CUvYa+Xv2chdhwt+2XODrM4OFffbBBQiEf6uEK9b6c2nLR7WTTv93u70elsT2DlniJh8wfHvRmXkf6NDhhRBBgGsGkE0gK+qLHpEOyJe9TjdFwnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721858470; c=relaxed/simple;
	bh=PZi+Wo6avi7h5VhpK0B18oNU8CWCW0Bq6+53W/ZA5Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e8PVvmJT2gcqK+yUeHCtGhDItWhV5DIhF4EXBQI3TFxLwQw3gvZ8V/DGZUZrsFBI1W/9IMqw4E75db2gwVTIA93RWnOgVNvB7etPv5qtxqedw9PfZRRauRfJQP9p21uk4Gwqcun5aFckyLtfl16RSP2Hsq7virmvr+GnFHHyIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=FdVdbSOH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="FdVdbSOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721858465; x=1722463265;
	i=johannes.schindelin@gmx.de;
	bh=qSQP0me9IRr8DlVPthFZuQZoBsFNJUJMOAKnZck1+SU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FdVdbSOH6mZiWszt8OdEE9JpX+W1J7qj+eHMg/3gVgScCtPmcl37cwmsWPTrw0TR
	 V7B8l72/rP2ahlFrun6Y8xyQisbYT7sAeGjnZAUgOCER7zN0KShEbviIi8+XZrUd3
	 Hh0t2O7RgT/+D+fsu6YiFzORfjPWsVNPyL/LJx9qRzSY4CLdgtghp+9nRmGWF5KNF
	 ZBc0+v9XLhB8tmHWW9fgb8WPH9rI+puZIcX3eqnVo9K8pgFNgNiFvN7W8qV1BwphV
	 0Nkf/yPJt8rR5Gtcq6rigPaqRZvVPVsxAIiJnrz8WjL07VChQoSCJEAHdjsUfwTbm
	 1JNjcnb8fk1hQm5gtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az569-109.howdd30p31kevpcfp33h0nwd0f.bx.internal.cloudapp.net
 ([20.55.14.145]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MC30P-1sQvXx3nMj-0042CM; Thu, 25 Jul 2024 00:01:05 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.46.0-rc2
Date: Wed, 24 Jul 2024 22:01:02 +0000
Message-ID: <20240724220102.3295-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:Gia0nJAIutU3qthIkqb/ac5X6graf48pa9+OP1QsyfqR1Ro3VcY
 nTWeH29X1Tz+kMQ1oVxoINnCSsgDhVrIIiSerRxf4xurxmsz+RtHwqUNn+u3szA5Brt1JzD
 sNqbu8D2cXSGU2d/NDGK2ShI6nYnyoUJ9IJ3AleHd/dW0gtcnK2oax0E8JY8O05XgF1qjsI
 ewagL0aS8m1SmzeHqnJ4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hH+B1nUymsw=;J8SjgF+7aerlLAdp/XJi2WicFrs
 O4N3B7TmCzgbdvRymMySQarxMUcjh1kbtG4O3wqUQZSQa/+89bp5me5/MVIuwdV7hM2yY91LL
 uPlNv7byC7fTmZBzpFV237ri0Lb7KXOQBmAh6qIoL5dx7ep89UYRhlaBqm9pqkOiAOsruHAms
 CCtrhdg8M87CDjAotMioP5Fa7DSQbKoVrt2PTc/uQH0W+mGJ7RqeevErasCimtBRO2qw9aaT0
 fn+axX1zD7aUO+XKwzd0oKTb9xQt/BHQzh2FqU9Xnli1MG/8aFM9Yddv8JH6ZfDBncNE7R6W7
 /StHen9LHXW9Gorhs8nPdhajhrhB7zHduEes/U2bOuY6mTupuRsQRcmlDVjsf0HSgBBkeQRl5
 q0EvDBpsU8mre2UczA8GXjqTR8ESQJTOsa4Lbdkwr0imq/5ObyYfXrHypkj5cyJIqhQ8McOQr
 93ARO5KwhdQ0ezyIE2buaBaICnLnpnu7vXKc8hTpznXnL1z8iqW/Ctb0AHXLuuSqwjtBKkl/c
 3EIKs1yK4NBAiuXCD8MRPVczTBR7N6SpD6OnGbeg/KZUXaa0m7BDgMemHnh0DJhM5isHP04Xr
 4BOvM+q/UcOHP+p6WhzdvaaJAsEu/x5mZqbvaGwh3Ft/K4Zd2xCPFgGOP4G0EkXOjs2KkykLj
 zakkD0uzbH1XS8gHKfiawEj+jIzAeukogUznT16Rv+HZhiATm7WE3yPkC2lYS5/sjofYZgnWs
 gw0eqqogxQLqTs2MpWLxqdw7Hq03fKp40XK0IaOkSoutWERROYYer378TjQrsepu6NdGdd7an
 CR7weTTfEbLnO4eXEGkAuoGg==

Dear Git users,

I hereby announce that Git for Windows 2.46.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.46.0-rc2.windows.1

Changes since Git for Windows v2.45.2 (June 3rd 2024)

Git for Windows for Windows v2.46 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.46.0-rc2.
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
  * Comes with cURL v8.9.0.

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

Git-2.46.0-rc2-64-bit.exe | cc0cf12b502e96a48f6c2463284293bed89574b702b6e132a474f5af52c0c471
Git-2.46.0-rc2-32-bit.exe | db1952361f4be7f68086a087cb75cd02a3ba04ebeb19677be365388f5a0dc9a6
PortableGit-2.46.0-rc2-64-bit.7z.exe | aab4ff096e00a2a0ec61ed5f694ca7a43e2b822a8146a582ef5604f736ca9612
PortableGit-2.46.0-rc2-32-bit.7z.exe | 380d73873b76d91d1d68d3d12dc1c587d5b3e381087a24f3ca5c36e0cce08baf
MinGit-2.46.0-rc2-64-bit.zip | 99a6a1e76b9c65fe215d21094b9ccedffc0ac7a9ea8822e814ea2eb1dff40409
MinGit-2.46.0-rc2-32-bit.zip | b0de3ba90476154853b8887059103a7f848551291d29cedae890a43f8ba20ee7
MinGit-2.46.0-rc2-busybox-64-bit.zip | 134da84783b8e73e963c9d52a3c57c15b5b10e733233cd4e39be13231528f230
MinGit-2.46.0-rc2-busybox-32-bit.zip | 5f6a858df98b3b8588d1cc7d7d5d00a9b79533a90930165620f5b38d086ddc93
Git-2.46.0-rc2-64-bit.tar.bz2 | 39c95b8afd9677d7fa2be30b94a5833f2184d014f486ce9cba44caa6ba7892be
Git-2.46.0-rc2-32-bit.tar.bz2 | 1837daf14dad04074a8b7ec77ba9220e6c113cc0c50d589b081c55a6f61fdd9a

Ciao,
Johannes

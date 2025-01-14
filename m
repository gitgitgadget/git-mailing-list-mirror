Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DF15575E
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817556; cv=none; b=dp9unv3ZeqQY1KNLJdCn9vFA+ou4I350nJf8FtmLigUToULYD/j8S3TJnjSlZpl6IWhznihlvbMk24XsWGVwq7wOiAUGbmCvmMt5LOh8uUcajnyhwI1HoIGy+Tlql5hYmBihtb8d/crMKoz+Ib+YotJbJ1Zuykly37U4Nnmxd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817556; c=relaxed/simple;
	bh=x9WtbWPY8dDhi00ZwzRRjtjMbezrxQ+g9J+tnQxDvZk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=i6TH/i46iNkRKQB1rmriXGjnWy98kp24T5zsfYNLhxJj8tF/baQzisuwDY6eBKCDhykX7rKFgIiNydPQZvyee1CzrTE3T3XhOXJZB9AU/Qiy0DnLca0EI0HbMv+KFeTKyHDqfKWNAx+655QkG1S7IVMBmR5EXj9x+ioVItcT2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=pI7eyoUC; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="pI7eyoUC"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id XVXFtueG9QyRxXVXHtk0eS; Tue, 14 Jan 2025 01:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1736817363; bh=iFawJTLdbISNhbhvQhAAB4Vr2p8qx6RZ3ZqCjB4LFnA=;
	h=Date:To:Cc:From:Subject;
	b=pI7eyoUCMZD2aaBvlFLpHV+6b/lc7fWeuyIYQbIwCT9V+jUPalPYVAlmrN2PYMpdf
	 jQPHbX3uTOLLfuFJvIwqg48xZRIT6YCbXTEbA5fgENtsHpM7JJ7Ar+GcfDatsYyvJX
	 DwLbMDFK5gmjyUh5VG4SR1GmY/rvZPoGuJTB4o6Nlgifo/S3gofjfRt8DOa8aNZdUa
	 mh6YKlE5ELmEHDsp57J8WS4T1O1FcW5DbuPMSuqroX7AWXydzB1VGu5bSnEEIfwBul
	 JtzoUSiqe49CUET8morm20P0RnKMPjHwI9b1prBk7y8xFgywUN5Gf7M3v98CMLwWhm
	 uYluQCUIs8vkg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XaAqz555 c=1 sm=1 tr=0 ts=6785bad3
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=YSoiVvdwKX9CNbU0rqgA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <6c5d0f90-79f0-4fba-8edb-f80d0665873b@ramsayjones.plus.com>
Date: Tue, 14 Jan 2025 01:16:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, GIT Mailing-list <git@vger.kernel.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: 'seen' branch identifies as v2.48.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGLcytWcw5R5T7XHM3KaEPxbZ0nTQ6XqFQ50YvInpm9vkz782MNQAtoaXdRFRQxtVeCHvIzoDUKDcIxQibe4m1BvYnyHcXiRb6ZxaP+UYm+dCl3A3MSj
 o5oc+j/Ml6ZHc4VpxLau21r26Luf3/+S/rTcTSviRGVw03zz/U+kWz+0AlbfdEnn649c5brsmYYu3YqR6mcn6+kXXQAlntV3vHs=

Hi Junio,

When building git from tonight's seen branch, it claims to be version 2.48.0,
thus:

  $ pwd
  /home/ramsay/git
  $ 
  
  $ ./git version
  git version 2.48.0
  $ 
  
  $ git describe
  v2.48.0-246-g568b3e75e9
  $ 
  
  $ git log -1
  commit 568b3e75e9cc62870cace4e290d7c2bd3241e3e5 (HEAD -> seen, origin/seen)
  Merge: 1a6fedb381 20d77dd0a5
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Mon Jan 13 10:20:35 2025 -0800
  
      Merge branch 'ps/zlib-ng' into seen
      
      * ps/zlib-ng:
        compat/zlib: allow use of zlib-ng as backend
        git-zlib: cast away potential constness of `next_in` pointer
        compat/zlib: provide stubs for `deflateSetHeader()`
        compat/zlib: provide `deflateBound()` shim centrally
        git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
        compat: introduce new "zlib.h" header
        git-compat-util: drop `z_const` define
        compat: drop `uncompress2()` compatibility shim
  $ 
  
  $ cat GIT-VERSION
  v2.48.0
  $ 
 
An additional wrinkle on cygwin is that, after having built git (or more
precisely git-version.exe) then 'make sparse' and 'make hdr-check' spew to
stderr, like:

  /home/ramsay/git/GIT-VERSION-GEN: line 27: warning: command substitution: \
    ignored null byte in input 

which is caused by GIT-VERSION, git-version and git-version.exe being 'seen'
as the same file on cygwin (case insensitive filessytem + cygwin 'magic'):

  $ ls -l GIT-VERSION
  -rwxr-xr-x 140 ramsay None 21M Jan 14 00:05 GIT-VERSION*
  $ 
 
  $ file GIT-VERSION
  GIT-VERSION: PE32+ executable (console) x86-64, for MS Windows, 19 sections
  $ 
 
  $ ls -l *version*
  -rwxr-xr-x 140 ramsay None  21M Jan 14 00:05 git-version.exe*
  -rw-r--r--   1 ramsay None 3.4K Jan 13 23:49 version.c
  -rw-r--r--   1 ramsay None  619 Jan 13 23:49 version.h
  -rw-r--r--   1 ramsay None   50 Jan 14 00:24 version.hcc
  -rw-r--r--   1 ramsay None  21K Jan 14 00:13 version.o
  -rw-r--r--   1 ramsay None    0 Jan 14 00:13 version.sp
  -rw-r--r--   1 ramsay None 5.4K Dec 24 14:03 versioncmp.c
  -rw-r--r--   1 ramsay None  118 Sep  8 21:39 versioncmp.h
  -rw-r--r--   1 ramsay None   53 Jan 14 00:24 versioncmp.hcc
  -rw-r--r--   1 ramsay None  15K Jan 13 23:59 versioncmp.o
  -rw-r--r--   1 ramsay None    0 Jan 14 00:13 versioncmp.sp
  -rw-r--r--   1 ramsay None  199 Jan 14 00:13 version-def.h
  -rw-r--r--   1 ramsay None  207 Dec 16 19:08 version-def.h.in
  $ 

I normally like to find solutions before posting problems to the list, but
unfortunately I don't have time to look into this at the moment. Sorry!

Just a heads up.

ATB,
Ramsay Jones

 

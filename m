Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299FD20C00E
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081085; cv=none; b=fTmlrq8Uf3KUP1PsVyQMdw/QiFfIhAnTXwJe8AiJMlqT0LX0E/6SXByDTpgFdIHXrefGKpgDzGmY6pOeLa2EhXRPxXJ8p3/TxncumL9wk04NSnrpLr9Bbdp9WKuIK2K/+MSsRyG29GCJbxWgcQ3eviJRo/FOpkzqRKTBm3lpAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081085; c=relaxed/simple;
	bh=j9nic0Mmem3pEydAOPehB8aIDHLQrAO+Y2aPYJkDXQ8=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EFSeZoJp6epIzZ2IwpVKEZq+7whjVFDriGLlrddP5VYmWnwR00ET5oGJGHvc3v62HLbdCmgqET5DShVLvB8INUTwIfsnmA3vMY6OIfyAgz/D08VVDXjY39wNEQwYjxV5vujYTb3q+R6emzmgtC5wV+CV53VZIzcuv3mnJKGic4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 571KaFMS2025801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Aug 2025 20:36:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Skybuck Flying'" <skybuck2000@hotmail.com>, <git@vger.kernel.org>
References: <DB7PR02MB426582D352EC00FDCDC5CD45B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
In-Reply-To: <DB7PR02MB426582D352EC00FDCDC5CD45B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Subject: RE: .env is not being ignored by this .gitignore file.
Date: Fri, 1 Aug 2025 16:36:09 -0400
Organization: Nexbridge Inc.
Message-ID: <01ef01dc0323$ed679700$c836c500$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHVBrtbx1AyxD+iQ9bIKHqjLSBmJrRcOKsA
Content-Language: en-ca
X-Antivirus: Norton (VPS 250801-4, 8/1/2025), Outbound message
X-Antivirus-Status: Clean

On August 1, 2025 4:14 PM Skybuck Flying wrote:
>Command line tool "Gemini cli" uses .env text files to store API keys.
>
>I am trying to make git version 2.43.0.windows.1 ignore these .env files.
>
>However for some reason it refuses to do so. (Any idea why ?)
>
>Here is the .gitignore file:
>
># Modern Delphi 12.3 .gitignore
>#
>#--------------------------------------------------------------------------
-----
># Delphi / C++Builder Compiled Output & Binaries
>#--------------------------------------------------------------------------
-----
>*.exe
>*.dll
>*.so
>*.a
>*.lib
>*.bpl
>*.dcp
>*.dcu
>*.obj
>*.o
>*.res # Compiled resource files
>
>#--------------------------------------------------------------------------
-----
># IDE Generated, User-Specific & Intermediate Files
>#--------------------------------------------------------------------------
-----
>*.~*
>*.bak
>*.old
>*.tmp # General temporary files
>*.temp # General temporary files
>*.local
>*.dsk
>*.cfg
>*.map
>*.tds
>*.drc
>*.rsm
>*.log
>*.pch
>*.ipch
>*.stat
>*.identcache
>*.dproj.local
>*.dproj.user
>*.groupproj.local
>*.groupproj.user
>*.bkm # Delphi IDE bookmarks
>*.tvsconfig # TestInsight configuration files *.history # Files with
.history extension
>
># Legacy project files
>*.dof
>*.kof
>
>#--------------------------------------------------------------------------
-----
># IDE History, Recovery & Autosave
>#--------------------------------------------------------------------------
-----
>**/__history/
>**/__recovery/
>*.autosave
>
>#--------------------------------------------------------------------------
-----
># Output Directories (using **/ to match at any depth)
>#--------------------------------------------------------------------------
-----
>**/Win32/
>**/Win64/
>**/Debug/
>**/Release/
>
># Cross-platform output folders
>**/Linux64/
>**/OSX64/
>**/OSXARM64/
>**/Android/
>**/Android64/
>**/iOSDevice32/
>**/iOSDevice64/
>**/iOSSimulator/
>
>#--------------------------------------------------------------------------
-----
># Common Temporary / Local / Sensitive Files (General)
>#--------------------------------------------------------------------------
-----
>*.zip # General compressed archives (often backups or downloads) *.env #
>Environment variable files (CRITICAL for sensitive data)=

It does not work when .gitignore contains
*.zip # Something
*.env # Something else

But does correctly for
*.zip
*.env

Try removing the comment or move it to the prior line. I am on git 2.45.1.

--Randall


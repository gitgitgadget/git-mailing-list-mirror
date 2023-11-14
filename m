Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7C2C197
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Ygy1FWZQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E861397
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699995911; x=1700600711; i=johannes.schindelin@gmx.de;
	bh=QUYVJwUCXd/fcnwgAli3F2XXE+MyChTZLuV/4e6DHms=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Ygy1FWZQJwGNjqMp6jS0sNQrH7DSXwfm5WUKIvJjX8EK9/UH5xaxbfzVu/UifihZ
	 ESDj4F4Dy9MYUZZEneAMFOEqqx5cMccRgEkg3R94Gk2Q5scyI3yAOsBF201zkDkVB
	 ErsGL5fZHccgoTQIHuGk5z1DQWKYO2YrTCV5feol5d7UewmVDzMpikMFMCZE6IP3a
	 KDNKHKe6BWfPj8G3pyHv6bXvlSjvwGy+pNm3xq5pQAvkiPeSWdU+Fl94vkWg+E67y
	 kF6YpYz6rv3Pgz+KZbecc52BL7RZJUGa0AdByf5REl9vIgMvMmbW1HEkHOg4YlsbW
	 V93qE3uLtcQAgpo8gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az575-716.txkdwr3xd4ruhezurzmahy12zg.cx.internal.cloudapp.net
 ([20.109.38.35]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MQv8x-1qhEsy2APn-00NznZ; Tue, 14 Nov 2023 22:05:11 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.43.0-rc2
Date: Tue, 14 Nov 2023 21:05:09 +0000
Message-ID: <20231114210509.3742-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:0dvOZNbJwnRbtd4bQ9PTwZU9KKTEQRLkTCrZVHUAO8hUhmOgS8T
 AHebpAe16fZ39hlpWfc5rtm0PrPqSFCrkfIAxV+NxjC2Ph5uGgegkoVPJTdhxacrk1SHo5j
 8HShXuMB52Obuqd2/xSlkqu8YYNuXk1apAOogHSgYdEIekImhsJP310IpWmSc8FUR5bJQzX
 zwXXhf4dkLiRSF6PHOgHw==
UI-OutboundReport: notjunk:1;M01:P0:QsIssbl4ztM=;vACV6LLXHMJGbP7xbIBiHaqwipA
 uMsROTvLFTcqkqa/HIVJvIA/Jf7WYexITttGZGw49GxmMDKcpir6d9yIBMOqVXSMeyWdVtGyw
 DEFddnYi8SBTZowKRGDswyE0rFyxA8PwXIp6ylCuDItDq/MgaesI/T54g02BymEjBB6Mj01FH
 yXQ+LNBLJIpp8bSTBtsD0oeYHXrd/JC+kXD/6nGX4HGSdEPS0Mfir1TlPe4iUa/14IuuJ4Jjz
 iYXWr4kd2GZrMIh+TMLgwuudJcZu7SX3NRkXmXWxcNrf2FUjP4CzQCAEnC51a7zx2at7HR1fw
 uJOXg+YSEPMeXuV0tqJadzjMccOc6mhJLrOH3CR8G3crw4EUXdsda0f5NSZ0QPWjvapYWio0o
 ykp9cUlglDn378CVHtKXlaOzNybGWkDZRnM5jYNGohl0DaoDj2USv//1cxbK7YC5xeZs2hyam
 rt+3UalMgZi+Lt5HyC91RoCZ8tfgnzSNQwJ8hnXbhUfCHeNe1iI8ZRf5Rd6IGknVQEjBvn+PE
 GO9Zg5k1N3kNOzfRNjI5wR2NHmESAHzTBoLA0tiIi9lSp5dpCYUtJFWUZVzq49SvR/xLc0ivW
 PcbhdTILtU72N0caBUNaRXwA/2jN4vcmSwgXhbvxCKX1dNrpnRU9oU7Vq8NH9nxXSQfWfg40J
 +eJSTddhtGizkZUa1uDCQ6io9oxeTBQ7Kbvfq7ccx0+GSC5jdUsee8rCLWkgd5Kdvwoq0XPeK
 ixC76qW0xyI/QcvQMCTTRGeU7iFknlnTOSmgVI+bs6XCcEtZzhvYmpevm8fOqXjiy+DCRZVEQ
 aNiHMGDHMgo8WsN3+fcfV9/1bfCPEG+qt9BTC6FHunzkXKI2lAqFk3dU8FbcxWPtvXpI+yIZW
 0ZXIhftGK3uTT/1jGpzipi5hQNKuQuvZMpukZaiLvNBArnMne9Mp1S+teSPd7YDxf3m2i5wv1
 YnQirg==

Dear Git users,

I hereby announce that Git for Windows 2.43.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.43.0-rc2.windows.1

Changes since Git for Windows v2.42.0(2) (August 30th 2023)

New Features

  * Comes with Git v2.43.0-rc2.
  * Comes with MSYS2 runtime v3.4.9.
  * Comes with GNU TLS v3.8.1.
  * When installing into a Windows setup with Mandatory Address Space
    Layout Randomization (ASLR) enabled, which is incompatible with the
    MSYS2 runtime powering Git Bash, SSH and some other programs
    distributed with Git for Windows, the Git for Windows installer now
    offers to add exceptions that will allow those programs to work as
    expected.
  * Comes with OpenSSH v9.5.P1.
  * Comes with cURL v8.4.0.
  * Comes with OpenSSL v3.1.4.
  * Comes with Git Credential Manager v2.4.1.
  * Comes with Bash v5.2.21.
  * Comes with MinTTY v3.7.0.

Bug Fixes

  * Symbolic links whose target is an absolute path without the drive
    prefix accidentally had a drive prefix added when checked out,
    rendering them "eternally modified". This bug has been fixed.
  * Git for Windows's installer is no longer confused by global GIT_*
    environment variables.
  * The installer no longer claims that "fast-forward or merge" is the
    default git pull behavior: The default behavior has changed in Git
    a while ago, to "fast-forward only".

Git-2.43.0-rc2-64-bit.exe | 47eab02a2ef7ec969fc812918f16697c15199aa76cb42b4b352a882265017dd5
Git-2.43.0-rc2-32-bit.exe | 95618190eecde6e4a155dc45d3eb02e056fce67cb3510f44d513f9eba25e28f6
PortableGit-2.43.0-rc2-64-bit.7z.exe | 4a364e3b6b02357e316293223f620431dfabe665ea19beb6c2ae995effa6f48f
PortableGit-2.43.0-rc2-32-bit.7z.exe | 6c66cf90bfc634a93e4587f6b76e0c126a244d5f87421dc08eeb585bf7bef048
MinGit-2.43.0-rc2-64-bit.zip | 77720ce608791c4d55fcd80df1953f0b7e2889ed8683a5adce6133edd116d071
MinGit-2.43.0-rc2-32-bit.zip | fbb71e2a7092edbd5e3b3eb12d907b00c0f5757ab5d4b8ab76df3b882d2fdbc0
MinGit-2.43.0-rc2-busybox-64-bit.zip | c99191e111a37c7bc619827426f687925629a24a743e7d4dc64743301f96c07a
MinGit-2.43.0-rc2-busybox-32-bit.zip | 2da34c6d61dd481e6c33a317dccf464b8e9bffaf94e251823d780dba4c23d8cf
Git-2.43.0-rc2-64-bit.tar.bz2 | 3cd453298075b7da69fa14a095f1c9552c9d360c4a5946b1d5d1748243e9aaa1
Git-2.43.0-rc2-32-bit.tar.bz2 | d32f73e4027d416397d9382e017ddbf0b41d0ba38c78588f44723c1e8e7ceae4

Ciao,
Johannes

Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PBomzJdn"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B3E8
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700506886; x=1701111686; i=johannes.schindelin@gmx.de;
	bh=putMZ0rVUn+xiXoCFjBS8cxVPS1NhVD3u7ZZv7R818w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=PBomzJdnhEoWrasw2PyI4sVVbYpCTIRvSNKHY3KhJHFCMuRNzcF6vXx7oi47nc+Q
	 Vw3ztGeOewickMuVcBfu5XTVEGPVqtjvh0GmXQ/hKW2R+7ba2QvSfg/8Sjgujzve+
	 bx5iI0Y+d/vpCJbwVas6OQLH5tMnkHODXNFgLFtwvxLQ6wIQCcdRdPTVcslqcI4CV
	 xsQmFT8oPU1/LNXNeI9JfdyKAqPPYHHJd6DfZDVMVTaT5JVy8Mpx6AeQAOzh7nK5m
	 Yywtp1v/oW9CH8tlxSfDpDynti28KHyY/mShnXuJkoeClLuL3uyQuOFcfaKGGAxb6
	 WCeu53Zs/x3NaKD0iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1435-256.w10t344lelvuxfmjd4pvrrtsxg.cx.internal.cloudapp.net
 ([20.57.13.220]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1Mwfac-1rFXq80eHS-00yANr; Mon, 20 Nov 2023 20:01:26 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.43.0
Date: Mon, 20 Nov 2023 19:01:23 +0000
Message-ID: <20231120190124.3694-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:wDkNjHPPatDeUTphR3FQplPe03pgy+zSp3YyBpRzr+UH1w/uSBn
 CUrBDW1ohohAZTlFKQscKk4+YVPLQD15KmVAzJKpgrWJvuUB1Scr/E9rDVr+LSIOtLdMlPd
 E2s3pjHmpAM2KGvuJQtKdOd7p7VUfH5ArBIJIVJRWStw6E62I8RtFeOGBVz7gslYXeOk/y6
 YKViCoKyLBmscvdhcU1Mw==
UI-OutboundReport: notjunk:1;M01:P0:yubaSugOj90=;eqZdTiXwpXVxijDkLR5qsJ4X0cr
 YlcZ8b8CfOOZu7cWzfFDAP6X/mZ3+T/M2N8l9OZA7CcBYWucFrY2SJ0OOYQFW3E38mCLgYnEL
 bd/Dlwhl5OhHPwPvsS4q5DxjR79TnIdAXV1GVOChveAQfRa4zR8uLyLIm1tg7mAIc6XZU0OgH
 clN7AmSkH1/zedMZeC/MDf8i/dbJ+e0UUV6CP4g7Tw+3WlZcw6/t68ikrLvjOYmmsNTUZfNv/
 xDBbe/2BXcVi5CNWNO9tQhDcxXv1PgqPWUnAcpCOWhnt0a1z4J9ySWcTfcsU/5z0lHS4XmCUB
 G4fzWbg9up9TLyX5ASbqUPZNCcLCeEZPb+bv438leVzG8LhYoL/H4iiYQGd2yDEnQFgdWeaH/
 siNpcf3ZxCatR6nPUtggiy/YszVtid420RYyWJ4W4G6b7+Z4MhUP8HA6cH+igeLhAE0QOt0Z/
 FAW10K9GkSyaDi5mZ1JYAdsoivtPi0pYzjgkEYdD09kgv2lGEA0Te89PWY4dStmEDTo9cqRrj
 FcZAxy9lNnQukpL9wWXzZ/jR2TEL/yq1dixk6+w5YDLuKMVqYMS5/fS3cz7ELEqc9ITgQ2HXv
 HHQCE+6hxiYbkD0MXCC6fYMwWQ1aCM8X8jcKFgbWh8zIZ52tBnmLuZGK4CybjuQKoGrlCOAdk
 qKQiZQo1fZ39tuNN1OKHKZiB4nGa3FnODQ6eCkMv+Lu7Kl6WFLTN/M4eacdtY/l2ybjuEuDzs
 WQ/9R1LpfGFSF2eDMJwj7NrKE3rJjYlgFxcVMF9sfspUk/HBdmbozcfCKcx6g1R/mjmUt5iQ/
 j8apQZtelFEMAdPqwLrXg7MqLJtZKUtS/YcFDGSrP+UMBzMakdoAYkfJDxRR92AtXXEqOomcY
 TE5GgLbTCHWn8MOEmqBwIRY5ZOE2cWsvHNdbh1WZBEtc6iNCg9mMHQVm3WAObpE4vN6KYvWuG
 u2+jCA==

Dear Git users,

I hereby announce that Git for Windows 2.43.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.42.0(2) (August 30th 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Following the footsteps of the MSYS2 and Cygwin projects on which Git
for Windows depends, the 32-bit variant of Git for Windows is being
phased out.

New Features

  * Comes with Git v2.43.0.
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

Git-2.43.0-64-bit.exe | a6058d7c4c16bfa5bcd6fde051a92de8c68535fd7ebade55fc0ab1c41be3c8d5
Git-2.43.0-32-bit.exe | aee1587a4004c6a57b614c81fdc2ae1fa33de0daaf6b650cf6467e4253e024a9
PortableGit-2.43.0-64-bit.7z.exe | c76216d032685fa972d129eca30f8c9fb957eb9f46ccbce954e70e07d6211961
PortableGit-2.43.0-32-bit.7z.exe | c33f9aa7bf9c59e24db71b65e9d75b1e8532562175afef380119aa1eee90afd1
MinGit-2.43.0-64-bit.zip | 1905d93068e986258fafc69517df8fddff829bb2a289c1fa4dcc6cdf720ddf36
MinGit-2.43.0-32-bit.zip | d46fac9c17b55627f714aefa36c3b00d81651d2bb4076a12b4455b5f841f1a9e
MinGit-2.43.0-busybox-64-bit.zip | 2bd705f2c378ccbbf25a9095432aada3ac9dd2d963eff51421944beaccdc3e0c
MinGit-2.43.0-busybox-32-bit.zip | 70799d1f5b9d2469f44299ff33461efd7814531dd9bfb7ae912d1cbf83478162
Git-2.43.0-64-bit.tar.bz2 | 4c19cc73003e55ec71d6f1ce4a961ab32ca22f9c57217d224982535161123f79
Git-2.43.0-32-bit.tar.bz2 | 192f58080247f1eea2845fb61e37e91c05a89b44260c7e045b936ca3e45ac7f6

Ciao,
Johannes

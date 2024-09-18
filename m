Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1F165EFE
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656788; cv=none; b=Fgp5ZvSh433a87CHiG/MX73gng4MXkpDpK0E4u5fergIDpKlyXddzH5TB1dYoc6NtGoQxwFuAnx7kMZXsJMsT0qLcRfTZzalaZADcmCp5OxFDjdpz0X3D0VFxKchLvz+TjifR3fIFm2q4fLEFfsQenEJvJTgq/RNCGobBYJxlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656788; c=relaxed/simple;
	bh=QLsS+Up6XENnTarPFJwwf/mUt4O6dKUv6A7zooQCKik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UK/0MjnlipRUrxU8UufMH2RNBclYf74KmfWyV2eAW1dm1r8NhuHUDgaJAHAIICYkurGRdu/Q9Cvc76X0woyr02GMem6aQGStTPp/1LInkIQnqKgms0p68Njq86CBZYekacL9rB5lsPTKnrTdXolI9Ktd7pgqVjjN7SultsWW2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=L3ANnbPQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="L3ANnbPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726656783; x=1727261583;
	i=johannes.schindelin@gmx.de;
	bh=Jrty3HbWzr3zGqks9d5ZectL2JGeJFz5mWwwpV2jEEA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L3ANnbPQLCezRM6+M9Ro4ZpKjpTw0qxn7ow+RUHdDz7Ndj0jY7BlwMLBP3XzMvv3
	 ribS800gHfLrazE7ynWSbO6/mzs15IXr6Xc08I3Nz+CwWI4xQmz+B+/NRLsNUgS7f
	 yQvd7lKP50rXgwLh0n8lxB1vqnC2JFl8KH1PJwJQSE+plP1lFHHn0fRh3TCBvASEh
	 NFaAQEAKJVKxuFtoWMuPlLd0q8GPDBc+CbkIJYZVixlLbnqdNVRf8vw6Ojpf8X3ux
	 d4TwyEh1ApHhWHA56wYF1MmveEagcBIymVpgH6XWxNLsnMeingxQxaXe62swPH8iL
	 Dd1F5SCVsmEx3xEZtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1108-921.qx2vdsazxcienorwhmthlehiqd.ex.internal.cloudapp.net
 ([172.183.132.100]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MyKDU-1s3J1X0ANY-00yf6w; Wed, 18 Sep 2024 12:53:03 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.46.1
Date: Wed, 18 Sep 2024 10:53:00 +0000
Message-ID: <20240918105300.3352-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.46.1
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8yR12pg2LqqFWclxO0lBEFS4wDP/HDj3VTP46BChLJKiX68yWeO
 r5y8nQzql6Ht0mL9ACpB++NpNnP6GnUbOX1LWV6bT5zLwbDgmx5OBags3yCCVoP/TAKxW97
 BvfQlYTTOZyzQhRDLGsnA5iwPGYuhFHDiXMzb2lEe7TKrJol98bWXdUCg7odqeH12FeryC2
 lZlYoqkPPWD0q18dMXTHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s/XIAElsRoM=;NCMaWLFhnRmsQmCf+nQPQH/2jrs
 jzDBfKqIV2AtsCcKUUkPgp6VJk399hDlWNPF3NHJCedbbjULyYzmdrzdOv9gwwXskLU/mHB4a
 hZEYmYmfTkyTnNgFJ7Si1cFNywsssLfHmFdTD/VRVVfRCTiHxvuBRqsfRy3UdtCR/J//h8mBj
 Uu/P/QKr0j9lRplT5LjNgrkWTm0qf9UfkshxTSYF1+YokowLx4bQM0WZFxZSJszhhufsjEEST
 ZSEVz54/5frpsg8G+2R9t1jzdLtivROR6o1gliXvzj8PgOwcFHJca7sCq0nAdorZw4GMJbJ7Y
 6mdZajwpa7YXCRq70yoH8JMdWTOac2ysNyzHIifPV6AO04F9WyG6CX8TczkOGqEP1G2/oxhVz
 vlE3esl4+Y5w98KVOYckyn+U00CdLDg3591c6qy2GZEr7kDSm4i8ENcwk2hjm2qpoczA1Kf4y
 ZgRrs5+jtwaBxjrNi1Jt726NHNLOYq/xEA4BBR4Tno1AoeAL2wZlG1mwENnsV3NQ+L1eCZHIx
 l4GU9CXVtiRk8bkvGbq17NOP2JY6rOBCr0ciEpN2r0oVwYFw8UR8Z3ISS1Vn8HC/Vz6U9wowF
 bhtFJB4aAUUgXeFnTrUHhFJ1LlEuSQ+bdemUxyani2W4KPJzkdl+3xDO8X2eFdcOw4k9CbM0+
 GsF7BWeyUkpCwXAozbAXb2atEbuUkLqSQjHprwz7VMqOMk7lOAcjYp3e7H/1ViVG8SWpsuFpD
 /ZV0zFvm7bgLyFPi7PChUbgdyNw8B6FSkx7h27c6Cac8qo4fO1m8EDq+hybCyefZZ8dNTeCgm
 mjOKb67/TmF88DNBEIBn5HFA==

Dear Git users,

I hereby announce that Git for Windows 2.46.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.46.0 (July 29th 2024)

New Features

  * Comes with Git v2.46.1.
  * Comes with Bash v5.2.32.
  * Comes with OpenSSL v3.2.3.
  * Comes with MinTTY v3.7.5.
  * Comes with cURL v8.10.1.

Bug Fixes

  * The support code enabled via core.WSLCompat did not work well with
    files stored in subdirectories of the worktree, which has been
    fixed.
  * When using an askpass helper (e.g. implicitly when running inside
    VS Code's internal terminal), Git v2.46.0 would error out with
    "read error: Invalid argument"; This bug has been fixed.

Git-2.46.1-64-bit.exe | ab47dfeb4f5effac44fdc2c11b60ee055477ae752fbd0aaafd91b7b0dedd6396
Git-2.46.1-32-bit.exe | 8c172998a695923b4bc5ccf29f27a7e6679ccae6f8f50acfe5039d878318f200
PortableGit-2.46.1-64-bit.7z.exe | 327c09353e27609b376346ca3397aebe8832298f0448b4b9b2e87c9d37423e1c
PortableGit-2.46.1-32-bit.7z.exe | 84abc0c5d419f5c58629e7d9e7a4bad4bc338e859426baf19c752395091ed804
MinGit-2.46.1-64-bit.zip | d33b5a5838125aa2e06a917ffa7065831355fc13088abfaab3d0e3403d5928d2
MinGit-2.46.1-32-bit.zip | 5481b8105295a122936a0c3b52db5befa17c3c417a79f296fa3231e99f6772a8
MinGit-2.46.1-busybox-64-bit.zip | 9a3bd0fb310262d5cc91e8187602c9d548605cebd4320a83179f9d3ebf5e484d
MinGit-2.46.1-busybox-32-bit.zip | af304e12aa7724fc78780acf4b1113d8475405557f027345763de9581202b64f
Git-2.46.1-64-bit.tar.bz2 | e2c9c5d82936fe4b888d3dc349f77dca932dc35b9730ec068f3467797eebcd1f
Git-2.46.1-32-bit.tar.bz2 | 5b5109fa15e25c376510ac6491d9d65788d3c36c556ad06a9bce30bc92668063

Ciao,
Johannes

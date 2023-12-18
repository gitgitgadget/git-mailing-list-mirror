Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1D19458
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="L53Onz/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702898500; x=1703503300; i=johannes.schindelin@gmx.de;
	bh=TACMikBcQogTwUEV8+HiHqZTWVv6U5ak5bfzmjPVS/8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=L53Onz/NRUibue5QTb2Qbce6QdkSP4EuMjPy/QYXQg6S37KON2XAJzPL+BLYC4Bu
	 ivxfvHQMypTG7Lu+RkC2l+qpMJE/fZZR/V7SZJBhhV7YGpFjRir3TmD6ckJQnCa+y
	 f7LeP2bhfJDYbGP6K+z+UzrgSQIEI70fTMjJ9xa/jeBXrlU7D1oPeRO49oyQrz2vx
	 RXO+ItGl3uyvfowQmrLXG6QrjUTHCBbH91EeqRZwQ/0vRJKFJewNe4sj8D113R2jV
	 XLNuD2ZeqJIKTRo6SlJhd8frBKGC4OUyR1b7dJ4sUb1qszN5XcL/lp9aQ1uilcJc/
	 AVJREPUSEO2iLWFabw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.125]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1rlgmo1Ic2-00WaC1; Mon, 18
 Dec 2023 12:21:40 +0100
Date: Mon, 18 Dec 2023 12:21:39 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andreas Scholz <andr3asr@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Question regarding Git updater
In-Reply-To: <CAHDWvZyHDbjOnnCYCkfMY+HPWobrcgP6c1kkWFrRgWV4fHED=w@mail.gmail.com>
Message-ID: <20f16646-7bb4-b8bc-dcda-861c1e3fe2a6@gmx.de>
References: <CAHDWvZyHDbjOnnCYCkfMY+HPWobrcgP6c1kkWFrRgWV4fHED=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gGkgDF/0s6qKbKl7AAW2oRNvVXSkptvjkigQK/+A8NJFqqfT1iF
 Sp75B3EaS+VhnHKviAXxfA611i279OIPkkyCmM3gBW5iK/94/QCCGP6eNTJUH9qvHvEeFjn
 p2aRtv+ga1VtWFkacYY289CrpWTAiGD1zyuyKiOUPql2SqWnUKy1CMPiQZ7eqazDyV0uA7i
 dnVjxIKV64j8ED0qVTxaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1HUWQrm5Y/c=;eXaYfCAs6Sv0l/LuPShpDnJ5oDt
 kNZuCTcTxyjmirT5yvMqiaqM2UUsCZ0AE5GkxyrvCfK1lCv39VygsEErfcgm5zvGCCnxLT/g8
 lK1D3Zit4hIUxMlAXRx4Tuc1TgCRpOhwz30ZAcjjqtlhPqjFnymE56whvZh+d3BVkNAULiSLy
 HDAiA5vt2qT3WG26IBGbfOnE6rRHA9by0iYCjcqSuhqt1V/hSOkKQhidM1RK4TiVyuf/+haVM
 U7hLg2dabFUulhsQjB8+kxyFQARWJbrkz0t4mN7hj14ioEZP5KcE+Kr0Mu4ysdsQUdQW0nEQv
 gADsVMEMiIrissnZ+bKY5y4ASB6hFMjfTzA3M0s/3J4CjjCmwfmLLRkySgQdtIbzaBBQSE5Yp
 z9u2Ax2wi6fAbBwx4RBN1hbAx41ojvTGFoHQM21UEi5VDZHzxpXktX11gyY6rYegTRVRkpaGJ
 OzPBy3p+1j0LyvRLLCFgVvACyC0DuAq6w2BYwenwa37NoPzikAcuP7yeB1fJslsB/wWi+3Dmt
 5AEh8ioKaxe8JGBOidwsp85oNPPYVNOEV4ZLiQy+VO08F7KaeGW+xyOl1rrfbkQWstQiOGI3c
 H3dj9gmkkiHjC56BTNKY+1qG/+pSTHf9Xb6jwGLhLHVMuHDO4PmO0Gg2GRw3MWSsvvrRYUOyr
 2A9iqEx0uBGJ5P2OY5C1VJO3XimAvRTJR54NpeTnHGha+70XRRpwYLmT26gjOsm8ggzp9WixG
 hX9G9oXEytr3UMDali8VfbwTo/SoUu3srH9a4LEPFj98ozklWhBxaABx7scoehXNgS49oJbcP
 23GIgPzBVWo8Bel+6QFIUDnIxc8iFOAg8ZUrhTkUm6OhvzYudS5Z6U1+3ck8Fxk0d/KOq+7Gj
 HklLeU+/D8/MxOLd9QNjrsZJOXzAtkpQcjpnxmGKkAei6GWlh4/qyF131Tz6sVZ00e6GMJB8t
 N1Nv3g==

Hi Andreas,

On Thu, 14 Dec 2023, Andreas Scholz wrote:

> I hope you can help me with answering my question regarding the update
> mechanism for Git after it has been installed.

Assuming that you mean Git for Windows and its updater that you can enable
by checking the "Check daily for Git for Windows updates" option on the
Components page, I will provide answers below (if you are not talking
about Git for Windows, I apologize, and ask for clarification):

> 1) Does the updater autonomously figure out if there is a newer
> version than the current one that is installed?

Git for Windows' updater is backed by a Unix shell script:
https://github.com/git-for-windows/build-extra/blob/HEAD/git-extra/git-update-git-for-windows

When configured to run regularly via a scheduled task, it will be called
with the options `--quiet --gui`. It starts by determining the latest tag:
https://github.com/git-for-windows/build-extra/blob/15b05c2399f152783d1fe9f167692dd5cd8ae1e1/git-extra/git-update-git-for-windows#L222
which downloads https://gitforwindows.org/latest-tag.txt, a file that is
hosted on GitHub Pages and that is updated as part of every Git for
Windows release.

The script then continues by determining the local version:
https://github.com/git-for-windows/build-extra/blob/15b05c2399f152783d1fe9f167692dd5cd8ae1e1/git-extra/git-update-git-for-windows#L248
and comparing both versions:
https://github.com/git-for-windows/build-extra/blob/15b05c2399f152783d1fe9f167692dd5cd8ae1e1/git-extra/git-update-git-for-windows#L257-L262
exiting with success if they match.

Most notably, it does _not_ verify that the remote version is newer,
meaning: If you build and install a custom Git version that reports a
version number, say, 100.100.100, the updater will still propose to update
from that, even if the current version is v2.43.0.

> 2) Or does the updater only ask, when the user actively uses a command
> to ask Git to check for a newer version?

Users are welcome to run `git update-git-for-windows` manually. If
aforementioned checkbox was checked during installation, this won't be
necessary, strictly speaking.

> 3) In both cases, what information about the user/system is sent with
> the request? Is this information stored on a server or database etc.?

The information that is sent is the IP address and the HTTP headers sent
by `curl` in
https://github.com/git-for-windows/build-extra/blob/15b05c2399f152783d1fe9f167692dd5cd8ae1e1/git-extra/git-update-git-for-windows#L120-L125
i.e. a User-Agent (`curl` does not seem to include the current OS there),
but not the current Git for Windows version (an information that, if
available, would actually help me perform my role of Git for Windows
maintainer a lot better). Since the request goes to GitHub Pages, which
does not store any information, all of that information vanishes right
after the HTTP response is sent.

Ciao,
Johannes

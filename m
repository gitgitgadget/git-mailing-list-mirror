Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914461E50E
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956566; cv=none; b=L2zGL7EfMHIV3o5UeqXk7p5OrULORVnmrCGABDKWA2s2T+au2mZN/Kz/yWPgY6oAD6prSPxRUbYwW41NqgVzTz6ocR1ksafw3jD5f+Nl8gcyTEi9huhx4rwcZ14kHWfpBEggCku7njep6EofeJ9yBvLGlCULHqkVx8gVHzkbGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956566; c=relaxed/simple;
	bh=HC5O7nfT+gLTu5lLBoh9ziRmG6CT46fpGPjp06RAXSk=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=fk7jatDoshwtl/+8rBKP1VX8yfMMWRj+aqO2RH9J8uAElEZCe3UYtLxDrk3rgzEAMlHQlVARfuk99LEsSL+Mvyd5Q6aoRHc3KR+OV0iMZBXriO7vDN9PRAtQohhkWJSovYapWKZ3uh6er309FN1+AVBdJFMhELPqtvQivhzHrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=QNP1qdL1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="QNP1qdL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1748956560; x=1749561360;
	i=johannes.schindelin@gmx.de;
	bh=NyIvwnNwOC+xm3SfHuA7IRjd+JkwTxawtS15R/ax80E=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=QNP1qdL1TfOGk57GA3v/7yKqZ5IoLIx3s214QLB987Pjwuj0U/Aj4NUQDhJ9Yqys
	 mVlXNqDWcDfl8s8QPfbnytzDayzhlYQbhFP5v3RzdFnhV2huYRN/EqN5mgPf60Sj7
	 epDR4iO0GRn+YbcskFkql/84lGaWhXQtczM6nfoGhfxUwvsZJJX/0UABVnWWr+Yza
	 XBJ8LVybt2oAToDuWSqWLgocIUFLA+VqmxGg9/7czXg+5fpUqGsfpZ2YoYR1mN5A/
	 OPa/jlvZUFlQdesVsGy1OEkVsQHCBA0/Xq4Y86f4baRpiZoyVGXoUVdCbNJzNm2Ex
	 v8HtnWLh1e/LKiODNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.83]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1urvtn03Qt-00fQlI; Tue, 03
 Jun 2025 15:16:00 +0200
Date: Tue, 3 Jun 2025 15:15:58 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.50.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MKKYx-1uaP550Ffb-00NlLw@mail.gmx.net>
X-Provags-ID: V03:K1:9Z5wh+GbrQLk/GeJx3+qIjpfkZgs4r1BM7TfR/k1zvI6imAXnj4
 uA4HVTWmJ/tbPShvpcVErh7VIttA2tBzgu91m3+8lGTdY+62qhpgRkWX2qkPjBOMa07QfWn
 8FyVCR4VFJmIcPusfyhB628Op/Pk+tSXfMYoSvnB3W+jrULhlnJZ7aANarusSNXliKRzlR+
 CHUkUqF5sMwXtFXHPKcZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OFLthYALQlo=;fqIubKda0+tjLd+whcy1dKyi47t
 C3NjjKxNOwjSkybVFD5iBC7zoiw0GoXgVbTOPwHgFUVmH6z2/pd7oDffy5LWeAf+9qDXHzx1r
 Zq6Y5mhR+mewez0zaVQxG/GzrLVGIoxmssl7ESL2FedEK7xMdXhUOKnnIr1O8ZHegX87u1rVH
 CR7t2k65sCcGbePIbFhQ2ZpLQShpzLULiiR616iS6oTbSgV+K/2jm0McGnOSIKkx6u9u9lUcG
 JxVc5W/BnZZZH79Lt+UXgjTdmHCgE3ydreZRuTjxEIth8FWrGGYZEk7Kmj5tCUN3orRJ77/Ov
 CJxqzF0BAQzMl98cpexQjYDAbEa6AlMK/qNRoxO8wMOPOymsQU5b3zepBpBiXqJFMip4d8X1k
 qeuZe9D/WpTwZMwuMnyXCtkyrubiVTu8/zIiqScenKgbwWDx3RqnNGP4wVIVPDpmoa+Fc3lFR
 MLQdHy9qtA14WhOtLChzDLS9vltnXwOP61WKvmH1NgAuCO4kQcW1nSEGwktj0pcffkrb/Ao8u
 0HgvUswYHgkJQy4Ff2iswoVmSUMgwfsuU93TUhzxhCrRoJWY4peJsEOwVOsRHi+7Jx9dpi27B
 a3OwcA9cDaQJYwpg+2HaTQSy/0Up/p4eVaqWP+5/GFG8pqQQfryctnxLfYIThkmtxhmMYq1Ud
 lVVd2//RAFsr+uoYElqMDyXMa2uClQOlpY9Z6eg7TbySkBTS1D6pRv1BExI695MTQsQeskZ2c
 maIKXRvIap8I+6teeEozbOLgRl9arG8sONcEnzWB1IFZ9IMb+Ac/5d657Xbwj+owzZZrqet1a
 zUsc6Ow82CmH38Z0q8JfzZB+Q9MCD8znrxdn6rMr5KIjid+pHeQ7Xx9cxpYu1sXVOdgpZ2eKN
 2XahGwDEhRZ0IS597NShA8YnVobSEyfe37UCSQH8Imehv0Fdp22n+JnpZQ6fe4dIQTkbRHelE
 2aijL30DFm9nYz/HpD/AwdsJSdkZSGO1iejqSmNR/IJJM5HnijiUNMDQFAC8K1iJmc5/1M2Xg
 xOHAQmEBydnyAmYlSYHOPON81Vkk8NO+U7NuBW2PZXWVpzPqvT54BRT/SmuyLsUDwrUaeK4mV
 RsKZzDZP6RI4Uoub1wJRqGY0kk/ooWc2oPuvfHy2oLVMJPSK9Yr1lRwzXFo8c8q7M6MrTc7BS
 OQkQhe+PYAilbzOzzVfarZe1enU2TEYqB5m+wR0kTrIvvfkTf1HRZb0+qRg2d06tUo+5rz/Fp
 y3G3fFHvStgJQpTuvEvEODdiu63gcFco70ekMZEt/T1tvUTfA+gXokQMRZSywhRNLylp3A4rD
 POEcz7k5iSC/Pva1jHN77gyfnICv5cOQbzmzNtJ+TgKvDnD1mPghF6OB98GJtkzPs9lGDPc0+
 tnhsCZi1AtTDF429467Y10M3SExRq6tGRPUJEBDigIyXyg+LdiiBfQa/oLu1+iRQgDimixA27
 Pw5Rl9o1kzcWVDdUubuBBuC7GQv40Go2ou0eTn31h6Xs1Ah7Mi7eQ3UXrRlfZnlfBajqi8Wtb
 8l2MY7JAsH425AMrp1b0oNcLIdEtIJlF6pmKcBh9IFVNVIdFDivw3WZKqlCQNVgT0wcszRMCe
 muK/zgMN6FImqG3BZVjw5wRf+QFVkY1afXcEAqsgWyddkn+KlJoFUEMt23rcItv7V5ovi2zGF
 zxfQqhVOi1PonH1l/TAni2OjrBbPJvV11ijWMyVXsBLiL9tdrXVxwmGX269qmvuEFjNoDKLhU
 jiOiUuN4PtzKi+sGhsaor2/5ZEJw+Y9fA4aQODTA5knVTr/kV7Z1vB5WILEqpEUbyzKHJBrDS
 gni1OOJCx/WMChMfgQ8evj/8+6RwFm/KKUNjRm2hdYgeCe8oyLP1jLasJFvibnFy82SMOh8ly
 e8S8lGeaYqILtrCBui7HUWsgQsZID9bKgazK6XQI+MFO9lY8YpqA9dy9pQ8tvOKiS6+bNpnS+
 k9hWeTDFkoHsORAyluXwgbY7Cbt2LlgCtecoWnhqdASRLLO1xVaV6BHMSRJbWKg97guxaYu5v
 COPPs+j4I2cwQWRI0vfQGqaV+FAlkX+7GFEtbD7uYpDc42N4yGgJrqchdVgSyslbhdrB2Y1vN
 YKfGuowawR0qSo/YFxhTSDInBdFz8AW4S9y4qVAqO5p3IGJLoZwm75yMeKJdbKbuyYdm/O5zp
 ceR1c7X8W0p+iFG78aTgDhnpH95oE5ZoK4EXbTNX2/NbLiPmess7xYjZEeVDno3c0jvHFo+DH
 YrTLXO4DpSVRuPyFO8sfyOFsMPtCJj72IgtumNwlSS/o0M3hrKhJwMjl//G3SS0fQUAkE7sCq
 WkcLMje0V4tIp9hQSEYUnEKARrg4YvYsK+3e9SnvuvfjLjN8hUck54yUU/4Jyr17T8wUFkIME
 MeG0iTVt1b0PWGWTsKGggdkUeHtcs7DeCgCcYc100oqJmsP8KwHty0zGxIljBscMkqgLTpVt1
 tvNYlBsxU0I4A+9HpKZl8TQpCidV27llUqa/8qENLYRTBylf9jKqWIdXEy1qaVXOuLISQERV6
 F8Gx4kfVttqM8oisg4ZSg5xeg/be6pYo/hO0lRdLI2kG6IFh8lQf/MNIGzsQzopFxlO4euCzE
 0ExoPTdzr/7NtIaV+D659HF5VAc27z3uKUsIgESKSGybGnBcgvnL+8ZV3IcsW7i9/6E3l2V73
 4NJwgvv1on4gyYJgC9t+BJh3S6vQCjybeDm+WRYWnxjTU0DElBFWoOI4kYdw3pd7KzRx43/ox
 zm3zUpdZBqCLRmRG34Kpavz1zLZlOLwWs8PxCbB/2S70ySL1rf4koogZZRcXafcLQx7Yx6KAQ
 RjzgdZ1utUQuhQyapBxJD+ip1kzhy/b2jl/8uRVFYzK/LZZHPuvYnG4S0dgx1c83XOfuDu/9o
 VcLLjhrOD0yahlpHxkOhs50n/FrZ7E5Hkxk+6W4IM+UCB2k36caIt448/TgKkhnepLZPdEdtd
 RliWMq8Y1V8GqdIX/ntl2MP/nEwvACR9qsm+TZAVJ/aALzzgLXAG992axdmkqSgToY+WjyO3K
 yPus0UpIKZnbhPNq0eVBll8x4bDNgccgHGCB1/hgDvfrxYrqbX9++tGqdp9JJSll+rtC0qqfu
 q8z+Yv6lM8VU8BA8Xvsg5r4KJmDIzfFjrkDO3C/TCKZfTvZKHzTMXPTXIkH9CVAuqqvLI7uHS
 BA6N9BRysLKJ8eAjCugy2BGph2ILNBwkM+8HBRuG9gGGyIFVn8GpaSBsWRHPYRrRhdv6CFe7w
 RBARSeTjmep13IRZ

Dear Git users,

I hereby announce that Git for Windows 2.50.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.50.0-rc0.windows.1

Changes since Git for Windows v2.49.0 (March 17th 2025)

New Features

  * Comes with Git v2.50.0-rc0.
  * Comes with MinTTY v3.7.8.
  * Comes with OpenSSH v10.0.P1.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.2.
  * Comes with cURL v8.14.0.

Bug Fixes

  * On Windows Server 2022, Git v2.48.1 introduced a regression where
    it failed to write files on ReFS drives, which was fixed.
  * Git for Windows 2.48.1 introduced a regression when fetching long
    branches under core.longPaths = true, which was fixed.
  * Git for Windows' installer used a non-writable file for testing
    custom editors, which was fixed.

Git-2.50.0-rc0-64-bit.exe | c74f734df962a4d8d93249eec41a24e268308b435a5684be895c1da27481f0be
Git-2.50.0-rc0-arm64.exe | 43d64ca229db256b16857dff62d3ab51b795fed6417385f25b290c974d19bfad
PortableGit-2.50.0-rc0-64-bit.7z.exe | e7c2a8f2b49457284d18ba9bc4d26550571eadc968d374c52d538c57406d1cc9
PortableGit-2.50.0-rc0-arm64.7z.exe | 9bda976464d6ff373a7b323a10b9809f578a79cddd6fca3dbbc8f5bd051379db
MinGit-2.50.0-rc0-64-bit.zip | b90dbbaaf16fd63e123a36a2ecfdefabe4858fea94ff3b5d0a3c649b520e60ca
MinGit-2.50.0-rc0-arm64.zip | 8528cc9ebe197415b8671dd476e30bf8088a48b8372fc1324ad389c8ba07371a
MinGit-2.50.0-rc0-32-bit.zip | 706e1693ab991c111f2b9102fc56d8b1a3e2f0cd4452b63e036118f959938422
MinGit-2.50.0-rc0-busybox-64-bit.zip | d5dc9ab2d3c42d7b9b128430f92f4e72d31724370b1315cb991082a594d7d4df
MinGit-2.50.0-rc0-busybox-32-bit.zip | aabca99604c5deb02e6c9fc09ccc871203a83ffab2a920dcda12d5e182f01f30
Git-2.50.0-rc0-64-bit.tar.bz2 | 547764a8911c613eebbcc628aa213d5ccdf5dce31de560a723dd8da12258b04a
Git-2.50.0-rc0-arm64.tar.bz2 | 8a4c227bfda34f7eb764992f9472acf88eb51fd01a8723ebdb740adb9eecff9d

Ciao,
Johannes

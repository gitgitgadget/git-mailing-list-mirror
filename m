Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1715E5BB
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198914; cv=none; b=b9rM+L5DloJBz9stKUcHIljclbIONXKF60QKBMexiUvv2pzbwQggaDUlHYBD1XH1llCtTKFZ176qnO9hp9KDVKktoOZxPigI34kEJwCRr1lCCoV1YBJBa7k07Mu7xQJVWFWTUQO8bfp6rLcQohPv964NlZaPDOVvbh8CithpFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198914; c=relaxed/simple;
	bh=8qJO718KhxaK5C0C/39OqHY0oKm4Wu0w58644YVJrcQ=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=JfkQjL6Ncm34+YPk0e6DkBMJYoVNWk/RHMopByced1wwEe/VV0MpNGo47WXf+nftoAcuTXob4g82PNgGXwB7udHW/szQ5dBQ4+Z2j2MQkYkZpLlcxeYA7ZBk3HzE6Pda60dPvKCT57kL5XbiwEmxrTdCeXeJc9G8llmm6tySReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=UuM5kShw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="UuM5kShw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776198910; x=1776803710;
	i=johannes.schindelin@gmx.de;
	bh=9VnFkfL/OIS34x0FD7DacUuYb+s05H0S4Xn0GQcsIBY=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=UuM5kShw38xAYCLhgno0+JnUZTjxbaPo3qCvwydHmJT4jiduTc4ZdAmPJLp9cvL6
	 VzsIF8BOT5vRivK3YQsfXT1HxsrP6BtiWEPqxqfii3xXJ17IFoAEQjhlZLkGhLOO3
	 glOOi2hlEds8niyn/iNnJPX7iqjZkKPba9Hhal0jMUU0LtFHGuKBCFxYhkl8DuO7V
	 M1ujZCjT0SGd6uhRQXd12Ix7dNBe9TENIOSVUGv66scJv/9qFAkc40/4FLLX11wKv
	 WpTsoeAFKFaEe0mbhPCUM3ceb8Td6vpdmgoPV7HtwYUyH/QKkRjHhPLC/A+Lxps9o
	 eb0hV+zxmI3oPFMi+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCbB-1vzsPX29tB-00U7rX; Tue, 14
 Apr 2026 22:35:10 +0200
Date: Tue, 14 Apr 2026 22:35:08 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.54.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1Ml6qC-1visl82M1c-00mU8M@mail.gmx.net>
X-Provags-ID: V03:K1:Hz7JJMZ5pcnTbG+Pe2LPmV6kEIWb2YoraHNUIXlu4MiMwZnBvc+
 x45o1SmbYQ/hcW6p+aEQkP7xkyShzXJf/yf1sgQLvj5uTl6PC9aFJypBruVcilu1+bkIFqy
 ClIoYd2ibNQq5HRaBgG5OM1xa15NQZkmUPEBCyKtw+mGoYJbxrcAL9Y/eeMlzDgGKws0ibM
 JbSO+NlIyjoR+2432OfQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PjMVGftdiAw=;R8sBy1HebM6ktnmcUwBSHx3BmUw
 iNN9LbiUnIVb1kQctJhLOtqfyAXX7L5kaN+K/RMvOMSCuClEKgqjFPFikZGZ1NFJ6zDZKeOOG
 PqCDlc2vHzXrMts668cPPWiarZufkuS3ySik4VIvM4TgRqJoCL/9SL2Eajkej5ivGFxZB5wCK
 XM8nbwF/a5vMbXSrJPSbLZ/5Zv1LuzRVMu6nZXVE3EY5bdYVmBd6I3kOtCQ50dDXa+sVGP8GB
 ixccBqOTbczywQLzXavcIG3nlfyl4E0F6UELgdLMcsKhU1zIxQ6tbEJi8Qfkh5QjeFNctLVtg
 jHy8+izWxVKYMcprs/1f096cdf5TU9RVNQVjyOFdBLRfz2sxcjJgAHcig+3frWpJ03lrrfhnw
 nU95vSnmfllb2N5qPc6M6WyUrTJ3pD8k0qr8L+3CdoO8PHOUHMHenY/KTZpM+PLZqbhEI46R8
 GoFMdbfb3Y6OPmvX6fVLkqdHnRB1/6ea4C6dgyktR4JA4KBbhL7nwaVqCQWbQZunI5gr+3/Rt
 AmmydUEiTWXJOj7zMvC/H4f7AB7VG3SDGY/U96Db6nLPbJ+z3U9MDSYhmAQuKwoNKnlLI+DwZ
 ndkT4GYHMHroIm/F+2HCD7K2dFHuKfRA5rtn1/DfBguVvSh7rfyikCCuLv245sbDwML4qZqpW
 kUdeLpLTqZ5krzkq21ZpkTYMceDeIhG3IiEuGR82ngz4koPciu5Gr0KaPuZCgAbV0CPji4yJE
 puyha6DmgQ3ws1uD4bdpo3ChPZPyUL0aWzAuynuwBL5VjyltQWVisKCGhOPacpGgqXMxAQ7Nn
 Eqy6eMmrCyhjjjBsqklw3vU4nlrCVdI79be28801o6875xvlV5gu/rGfqXFOpM8EJJ8Zh+Mnl
 geOK4NF1WLfkmp3d+JFHJ3IYaGDz0TuwXpNwWDHo0VGtGrx80RZDGh2IZNKw5WikW+puKA89W
 xg17dhVy4BF25il0rxkNWCZomUwv+NGB89Tx5o40zDRpvWJJwsqSyHFR5fLesAQzDkDRN4/HZ
 ChXVZpR4F8mhNa/T2b3MqNxGtcS1+u+nStOimVzYrFKWbnXbj5X2jWHVl56XvC8fFRyN7GSZH
 EOvzpoZg79akcGBBKv1KooZ2KO/Jqlg05+6xlcvl3s/MxEV4ht9iuXCrICc3Eq4G2cmVxb9ZF
 IgXUUu+w7UoZ//oxHNcFWRpCnAAOD5QnNkPcrlH1C5cWojiz1k7GE/VIMkcEKj+qYUjzW117o
 N+bktMk5Q0sqIojUEXec7tflB3CBn3q3LXyj9EWhlv8pMEtFH3auTQIk2hH3s4fx1wy4LZ5RP
 9KCMvnV00OYA6tu4GdYN33vQDHRpe2z2e+BNTXuHRJowfJIeBkaFulcZQk/tEEdfEGxqmF3p1
 /Bbyl2lqnyUdj1SkHrPGpZRjW+zyKLHSLFIPu/ls4GXypfqrfGiYXviDiFC0DfhfzvegnLX1p
 a7Mmz4GeS/texw4e1JCJZvaPHhLgavD8S8YK7vPZInOndD3X56ddcGmBhyZEleMvLn+8A93q6
 LJJSJ/I54RuMeOXM8V3ZoZh9oFqFTAkUvZRnmtpvFnmM5aLiV790WsZP9xM8pkv3aGDh87Acf
 BxkNP58ziuojuroK3ODWSRwMytfZ52hSjlPxkI50vQIR1hObQsVh5SoeUzSXVeTKf6iysLwtI
 gHTNMROsdp/5gO/zUzPLCyWCxerSpC5ybLg9xFqOheM0RTZAwIDc7KOIaxlSDHSScaRtGPJlr
 7PV8OvAls5X/YKs5V2/IT8SfdNm99tafrWlenVVcTdVSmy4LfoPLBzjSuaWyLspBSSYUqPAma
 H13yMbaJS/gRcgD6Ia6x9U8aAcyQxU9CFrszObjklapr+W0YKZhqsDU/0FZEWAll7HRMeLL7I
 GSlSCwN8CtDdxIvkNDqMxvaUy6u+d2KWZMBDuO5BydbvZ5ik7ZSiFQpHGrmOyINqhPU9atzY5
 3/yp+Lgq+pCsd6tzdtJN2fIXERxEAYN45y2VQ+Q7fLrKDuoFAewCbXZl+LcYkOnKi1BhZOcoZ
 txQA9BUbcmT8PaRqEGhtf/hf4XRQsbheRuHDVLEQYvYKdfzBj8v9Yvzf0a4LKUTlh3enS21Vx
 56MROC6YPBsxKFWIcguEHBA7YWQiRH40hgaPvUT/AKrtBHv+qxtHaF4oUk1XZ/3sZUTAh4Sol
 Up+VX89A9mzYIlrlay5mOq2yVKb1jigex/bVd6j5XLvsMmhqm+SsxPL7beZrNoSwTwUwHLIl9
 Vwr+w/skn1nqjudEXlO7nU4yybDRy/Nw+Qtca40ZveRyFeNidvioBy8qTGbM5bVC3EkrfNc5M
 1KQhq7p6tzL0w+a/IvsOT8zA59zuUMCqHoXJDZ/C1dnMgZIaZhDDNQFZBXYAkUg3T9Xs31NF4
 x6yJ4al+13l412qq1VMgpT20dvgTJf5zDxWlZ98TkcjeMLO6og9YdKNnFYuG77fHOzlDhKVfV
 eyVMtgSX0eptfUU5FqUN1NlEcwX99r3EZg+am/o/N6IHedZOwhsEtozQ3TjeJzcRXErxa11vZ
 4h0XZFwp3Cu7Xs58rpovNLMxLnauug/ybetrowFQ2EBodHSiYypbt1TstTDIK43XdBCk22eVg
 yd+LnwQe8vpo8I/sW7HIHlaxhy0Y/8teCnL5Amm/JNZKusMI65SRzMPYwktlWttwhDH51YVqn
 x1EQ2Z/QuLhODKBKx+dKSEMDk732I4OR0/VQrF6cBQRTBSXJ5I+XLayW+ceWlrFlgciugTuZx
 wlRyGQierQJ358qXLI/YUX/zgI4++fCllThI8Y9++2ZasB8p8s1z+/88jd7S4hrHOoffpkOc6
 mA8g6ChirAf8PGtCM8Z7w/aw0NqqehmudSOBmNtorFszYuZ/iTeyUiqALhdcF5EdZF5pcF5sh
 oidWlYx2kNARmxStkgij5ywtR+2o2qAh8LKnHHLcUB7VCijUkmC8bpHBgMRUSh9Fyag4g3BbU
 Mu9Uon9JqajDurfgkg9xV18AHAerTFI1E6Oa0V55KOrsbddEwv+Cu0xByR1pDl5uhl+O0yci8
 X07m1XC4IQB6vW3bz04nto5QIRTfe/pGMivzW3ROVhm4LdeIpGIE8QaITSvqWwxAteba8WqBz
 xKhYS9vo0bz6CchDj7XTy2/4T3ZVujB4g+V+htLOiL6N1Nok4JGqeUSJm6Pntseoa6nsLqauu
 0dyHbG6VGVTShPMW8C6UQV8yHaky6ISfCqlBlpOqzKfDnLLjF1yKB7/wX874b0diCudTNU0gq
 THVjAArp7o/TcHKEiEKNfjixhqubIlrlRcPfuDIIFZBKzYj0NzNWvGbaZztDK+3100iP9Q87A
 zw1XXnlfNq9bKjKsXhZgMeN9NR5rZnNTuwIC9u0rcvZtnp3RyJfwZloGq3SkA5mgExBxUxyx8
 A6da/UIoNak6yyRYQjw2TIRRgeVw/QRpZPhevf4JqkNqcPg9i+ZjF58wLW0lA009GlHJy9leC
 Lq7cQ+RSjolKV0HxCaInT/uxry3mfku9kDNeiRNDxM1LNP52M7R/fUokViMkKyEKZICxLkRrG
 sMj0v1KUtddBrZ82oO8o9TNCYgEQoZSsanoU02Cjq77EYji0i5bSL7A3AmY7r4Le/Iw8e5Yvi
 FgR5BJ1RiiH2Hk+SqTSqRcW/ezPnKx8Kmga3LtTty5j5bjYpks8YKpWfwkXiHkD73D9RK1vq/
 Bj1hiFj6svjXrVh/gqR+eUNF1iVj8qqF28ZnSxz1m4dMX/sjniv2b5F6PFqqn1PsCr/cXR9O6
 3U9eHchE5rTJuL/euIsRWRjzxXzKXRnRp7wF/VPH/I17M5r5kfLQLfp2wS3po2G5Z55VU9txP
 jnMQEVLNmQGk/+VluRU/BZnGx0WjblcexM4p7+lv3dMdhasE9naqm79F4tE1xg6j+sRO9WCMH
 3iNuocGLCEV0UECIo37OyYVb00SfZuyOOZfrLNqUYFKSOMKszMj2ac4YoQ/Tk7fnIZOsy3/vr
 G/Ua/Sf3YP0Ak2MtvnQge96kRVTmZMWACJRYxjLbQpYw14S2VGzA1RJWc8i10HiuImxrsTu/M
 Gg6lIj4d/FDHFzSWke/HOxJV3M86pwrVb08xYtElJ1LFQPlWG12TFlSL1DvWTV/PKTZJWRUNs
 QZ20cnt4ohJb/FJ73qkXwehKoI/eMOZC/txvDP2/vOT5rY/zQbpG74SQOCZlmH7BjcaSQb4W5
 vnxGlsmeRMtYT5wrQVDJ43u44CKBwjtWp04kvRV4T7fn0zcEDGlsDGSSH01/7vp9mA4k5ptbG
 W+xO5N6cslPnqrCQjNtxf3ps2xbjazLP6WICeHvZlxBZNMzW4d+N4DOf3PRhddUL3xDMU6KiY
 nPYW3VEs4blLHVFG00KktXcabCo1JAuiK1OqExiRqneOI6SRsOejb7BzwON/1TvQnwZwy30xy
 bJPp2Y3wZ/vKQ0OQ50lZAmjgvJ3pDUqBdSxEnGqrscM/TOA926QZXlGCunFtWDMrxbZoGH5vG
 o79EX3TdXEz+ZF2XEl+QWwldxjRjbdVDs+HGsn6ed+5+J4+D4uuq2m7EeNvhNvDaUu7fQTNpD
 G6EMNZQbE62yg9GoKt6CbD5QM8e6BN+qR4W1zq0GDuMi23qMYx28uujgBcGnRDVfHtJ753QYz
 2cuz5a5ezBeRPXSTqqIdFA83jZ9dxcBiuhTVHujGV3r4DiH6gmODT0bT/zlo/DogTDtgz3eTD
 R/jXvtUnDoiLWDrdmCi/rjUu9E4UQwbIg2aAPi6u1Ex27K/s2rX8wB4fjmRecugRnO1UTv74s
 omswCY3t/Qd9TmdygfwMFEV/Y4c8PgniTGvBth2z6bo4m9X9T4jVhPasT52I6DSJNKXMiTUVW
 gw7w2kvmvaiRhJ+eELZ+hgk4MpwVOQ1PzlXWfJlnP1ToQcYSrRZah2pL78v1fUmUJNp16KFWd
 fLfeBmZHWZokxtMD/7YU45/pG+/fCnR6L63tJecditAhBcizN1B/tQtzquJ8HKRJFhAVHCYse
 DE6rV+9+lA7tc3b7QuJqJz8Cod/9MQSmh8XO+DrQh3xCCC8neaUjkq5P37XYgDkkRjsIdli2m
 7c8egnQCXnBBggKzWdwpdqzyCzslO+4fUPgtBRy06mIFDmmleJI+xe6MlOgXpti1q5xxuZcul
 uurIXCxAttamACxpgbAyqfJLkiaAJEQ168XzHsU0zvgTdunAVNqzp1DamgwNfGyZlUnsgF3xy
 EJgKNst1gKwPLS0YSm0jna5WUh6rhHvXbfSjjFZdd/s3nwdFAAL2/v5U2z3uU6k2uAKQYGUlP
 5IxZ0mpL+/tWaQ5GGuO6Twj0dUtE/bOlLe7maK6zI1mkZGnhZk2liAMIr0mu6+bt+UxCXaJMp
 9RHJVqx4N3DzcFw9CZ7YLn2Sfp3TdGYv5ULPLS2pJFQ/18AU4oIVC4w3KbVZrf4C4q/RCY2y9
 BW

Dear Git users,

I hereby announce that Git for Windows 2.54.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.54.0-rc2.windows.1

Changes since Git for Windows v2.53.0(3) (April 14th 2026)

Due to persistent maintenance challenges, git svn is no longer included
in Git for Windows. Users who still need this command are highly
encouraged to use a Linux version of git svn via the Windows Subsystem
for Linux instead, or switch to a regular MSYS2 setup: install MSYS2,
then run the following command in the MSYS2 UCRT64 Bash: pacman -Sy
mingw-w64-ucrt-x86_64-git-svn. After that, the git svn command will be
available in that Bash. On Windows/ARM64, you will want to use the
CLANGARM64 variant instead (and install
mingw-w64-clang-aarch64-git-svn).

New Features

  * Comes with Git v2.54.0-rc2.
  * Comes with Bash v5.3.9.
  * Comes with Git Credential Manager v2.7.2.
  * Comes with MinTTY v3.8.2.
  * The shell aliases in Git Bash that ensured that interpreters such
    as Python and Node.JS are executed via winpty are no longer
    necessary, and have therefore been dropped.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.7.
  * Comes with cURL v8.19.0.
  * Comes with OpenSSH v10.3.P1.
  * Comes with OpenSSL v3.5.6.

Bug Fixes

  * The iconv executable, which was inadvertently dropped from Git for
    Windows v2.53.0's installer, is now included again.
  * In some circumstances, when typing while a still-running program is
    about to terminate, the typed characters could arrive out of order
    in Git Bash. This bug was fixed.
  * Similar to how git clean already avoids traversing NTFS junctions,
    git worktree remove now does the same.
  * The number of CPU cores is now detected correctly on multi-socket
    systems.
  * When fetching/pushing via Secure Channel (the default TLS/SSL
    method), the timeout to renegotiate (e.g. using client
    certificates) was recently reduced to 7 seconds, which was too
    short. It has been extended to 60 seconds.
  * The recent security bug fix that disables NTLM by default missed
    the NTLM fallback in the Kerberos protocol. This fallback is now
    disabled, following the cURL project's guidance.
  * A really old bug which prevented Kerberos authentication from
    working with the default http.emptyAuth ("auto"), was fixed.

Git-2.54.0-rc2-64-bit.exe | de00b78d1a95511c5e80368fcf7b8ceeee487f9b00afc2fb44c05856343f9cdf
Git-2.54.0-rc2-arm64.exe | 8ec8e9b4dbe94517e7356e1f204c12564681a7edf9f315f5ffd52841036cf136
PortableGit-2.54.0-rc2-64-bit.7z.exe | d0109858c7da928c3251a01201a433722882809148045786dc4cddf092cd20e9
PortableGit-2.54.0-rc2-arm64.7z.exe | 66c613f18d190eee833a7a5e40d38ed95ac032a716fb3f094e0765cfe85b742a
MinGit-2.54.0-rc2-64-bit.zip | 684e11c6972b2c4718f4aa38cbfd420b635e0d0e52734ddb7da6e92862f04a67
MinGit-2.54.0-rc2-arm64.zip | e75b603b5627cc053497ac268b97d8caa21b2b7d2f7bb0121f7b64b183c41b73
MinGit-2.54.0-rc2-32-bit.zip | f3538df09a79dc005169225a65e80f8278052ffe4b4de97addbbecae61dd0969
MinGit-2.54.0-rc2-busybox-64-bit.zip | b1b9bcb9448a9815a01f0bca620223ad5d6f64654433f6062cbe1a8af84a59f6
MinGit-2.54.0-rc2-busybox-32-bit.zip | 752a774cace37345597ba6b4126e5c64a859f4b0f2eaf9a8c0edb08634c592e0
Git-2.54.0-rc2-64-bit.tar.bz2 | 8cb1d6f22563eb1b16ea8ad88525bdf9c4d700cc58cd8da6e7171dce694fa8b4
Git-2.54.0-rc2-arm64.tar.bz2 | 58ac72aa2c7d3d4c3535c8ffe61d139a0a795c348a0f11a7d80e5d39218b328a

Ciao,
Johannes

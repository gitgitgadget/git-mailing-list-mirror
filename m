Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F992F0C7E
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766480; cv=none; b=FgTz6BGE8xsgbgJMZHetYz5DehaT6gmQMm16ukNFx/a6vAyw36qPSS6WXne4t68J6CHf1vh8TMsHAikllugA8uOb4HTTgyUazEU56W7RxJNaudQUmOt2vfKlP6JgHE3Ismb+Wo8KEw9EOxZI+HulEOznBTlTB7avzU2RX9wAlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766480; c=relaxed/simple;
	bh=+6mHGz26xcAWNEhtvm+68bNI/6YoQvA7D/mG4Xz0Nho=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=nEvvfToFUM/55Wgf7AQrqJCsa454A2tBIk4yaFUqh+owOJIOkRLr7HPXW//K8kE44qzZKLdkXv6tjPlioZY4w+Nii2m/hygV43mBOi1d2PQHv2A6B4axDyN8zoCUi4EYx4B6PPt5Yg+CcySrogFKMq0g9/9ZuFib8KFe05pJhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=K91bSITO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="K91bSITO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781766474; x=1782371274;
	i=johannes.schindelin@gmx.de;
	bh=nJjXiUvOY0K1ytOgfIIQ20JpxMxDCJphn7i+bmlGAmE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=K91bSITOqLsU57gd0rpO6r+KSDX2eGcZUbOA9Cg0d9EMhvwcdO0/dXQFJtDcLGly
	 yO4bjTtFp+VrKPCPk2NGByYdPWt2LVHAyG1E8JqYRBiy+pFh6Vo33yV01JroBAP0P
	 Oal6j3HW5R1JXdqfYolDIy950xrMSphTL9voZm0UNfn1YxIBYEnoLmlLPr6U2kbhg
	 IawA6tlm6JX5vrrgmTpPPlcpZrauUVK4n6a+UC7yhkDDreY/Yj3beOFv6B+6iF7tE
	 /ntrnl7zf/sq5/gWY9OxD1j4nEFHt1W/qjzdV4eDXc0KZd53hE1g9VsttaLaP/nOy
	 X5j2id/Zz/UFtvxzdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1weJqN1udd-00My3N; Thu, 18
 Jun 2026 09:07:54 +0200
Date: Thu, 18 Jun 2026 09:07:55 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.55.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MXp5Q-1whtHK2dGG-00PznI@mail.gmx.net>
X-Provags-ID: V03:K1:uY/32aV5PrmiPcxbmaZeK7gdoyxcvr8ayhojQzsaDndu9bNXvsL
 se9aaCaKQjS1S/kro/LEcwqu1ANlvoHcaAA9RSUWBd/ofzHU4lApCNsvWsxB7/6X0GIjTgb
 OOk+TQtr+UAeboWdwNfX1x031n3qmPDs3Hx6AMa5EmqT+3WBiBhaBhKqjOpaZDXAeBrr3/d
 1oQpMflwVLzEg5mcXK65Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bI/cWpLHP40=;VxSF0ntzAnOwrMmo2OvKBUGLHJz
 NIhb3fu5tQd9alJjkUcWVc09Wm2jt61uxeaRaLAQ+jstAIYHYa/V4jH4d3CQwzApe653qwOC0
 Oa3BZ/P5mIDOt+RbyOqr9zDwLCyaMn9/lbDVX1zar1HzWhl2UFvAGoCpcEQiw22sJY0CAR9bw
 q3M8Trkro1K6caUnb+OMiOgCijqShhuPXdRnfaeNo2UGaSI61PNktx2H9miTGSWNPZp0uGnke
 FT5L1d20MsPEiEI2C/hYyDIqSH1XTkH2tx7dTByenlCBVWCAxfuRFmCQ/I367vbNGYTiTWZSn
 00qLe6L4TO4/5SUFhXWWHp3DFeq4DOK0vO30j3z6rUVUAmd1vMeRwBV2Z/3tZnVGzyuEXSIP0
 dGI5fsvPuhOqYGXBRKrZS37WszYhR3knGspW+immmNN3Ygm/QdZPdKg/sXy+PPYs6cOnTvips
 b9TRHzjraggi3KtG2+qlPduafKY7M8ZhAIqrnT1TkXhBPfvWXSOCilFsxRWaLU6W0YpuQu1fT
 nKdUzAlut0s4r7vFgMBnNZ9G8uD2ONJ9CiRyPYkl06rw7VojNShTD+5so3QNqxlZpcIAHJ4jo
 iJ/kY7yqfthoNEwFLKu5leiA07MhCUvWiReJ5XZ/GP6sDGr7Kt3LUwe2ny1oGX6DLdBZvWDNo
 ExRWwH421CCziB6yxKIkdFM0WVLUtMpa3yv8xhq4xjgm0QshvCewTkzxSEcRpvnj96bzc+Ipc
 eF93hKojwVPZcXFIrhSwmLXDczffqErMJkZkCreAfzoC7L6QQl0sUt2x2SoCa3O8mxj7N1kZR
 Ie3QLiXekuGWub4EmMqUkQafwUKeO9p8E21AnLewW3PGYXamBXtbDax4EbZJy0d5yMCjJqx2G
 +GeQYmt32WvUVqRcsZtViVKLCj32fH8yzE/ktQ+Hqtz7TElMrPdD+N81J8fJDGHscm0FlcNjQ
 Z/5hZJHSPX6+hShly8sAIaqYR221/q3ccDVGi4YCMUJXxChLmESysD8jn4LiaiH4IILY0qWah
 McvvHYgaJOczqKK79OC5QOqj9O+LLRFK03IvCpmxHouvu06OozKNJMQPkSsp3wFEVty7CaXnx
 b+a8rMbO/svVpJIgVY57ADv0ntwR9DEjUDe0e2/r55GAkywgnU3VB+N4+6P7UPKnrBeT71TXV
 Z9BxFExgfjY+iSkXp48iZogY4gQCXvB/D43T3b8zGSs7qDoBXx+ABWTEuq5ORousfWYwJIgjW
 mHPvzNgbyE5dKcOg+XXQyHNnzjRAT+0apdWpOXLWZpUSA4Qp12/9sVkkNlr5zlKSAtjszF7/q
 ICrJDETELNaNpTkoFf9Pc+M3CESI9jpW6xZyhx6iwy5QF+BBelNWVep9BpsOy9O7/ZfImB2x8
 65bkY9yT4ObqI5SFFUPGsyhrFF+4cotogMhe6rGNRHckNNHxVd2WzjvUtUjIz/dnz7hHLYY1o
 ZbHo+u34m3udXrbPPgFn6qUhuhuQCP9wRLYMFlS0rzIKfE+cq99HMUGoEIPc7TKWBZWMiPlMt
 QtklZZi0Okz/rSoCF1nlNEsqkYWMmumogTvfoqMQ0Sli53QiV1ja1KuniLlZgQnS18CoC7cwG
 bYFgVjq6lCzJCz2BSKgOH4NUvN3cHWkEUCXihBAxnq489kk2PdhiNG621YthpL6NdBW37li3H
 qB2Y/mrwdF03jyN9AXbUizY9tYQqCKURpyU3ikjKVRgwdCZ3bnqLod3r5Bdwbkb62Dfwc+dee
 0BbD5VBw6CGpk0epkUiA5i5sZTJQBJhwaFxqE7skNYDIih6wQFLTJOc7yvO0YGBDemXJWASIt
 qIgoWVLW5ScAWVcmbx378WknZPYrOLZRcXuWAuJGoTTRnm+tGj2CRyzxGnM5hWs+h/Fh+u3/X
 TO9GpTy4iIsRPGnqn0JO7BB+i7DEgBCvkqh7wYY1Vj1HkMX4A564QsN/LUiMbuG78hXSWTq97
 AiBrCB/4t5Y8DK0bm4tjlgF+jB5/xXnpdHlj2WqQ0pKg7skrsVp2+xTywwVgUtdZYVpTHIaof
 xwfghMOFg45nToTPpS3zfSO9W0s0RMjfSTCN4YDaRPG5lVMAaKDYE93Ch1a9/+UVwHX01QAUg
 lqVscTPVHUpZvmJ6eY4kYm/Cj3ZgoWHWm1tJuuyGMwY3YM+8S9fwDMzTq9RGgnkVydIzb7oUO
 Kju86ljZx1sIVoajCqjbgy94CRWsJQ3R11tReNmDsL7kpOSc/mkuYGd0BsRB2+9LQXlGeQIG7
 sn5AdVUaeVyk0rHQEG5BR0GhI9VXqe0MttqgSYfVPVQpTWkaNg2eNnK6CcZpTh+gu7LiDHvZi
 FnU70Eir8p7Ots+AmMlHndg+U9wyOHsv5qCxhjhcjUsnDbwLNZjPuLMJjy1OIhtMgpSgF5MpQ
 IbS1iJ53FEMWIgL9X64+kyWYucBetdoYj+L2k5hvnGso7W08o0yV6X1guZJlBTKMGH5GVcsWC
 9uLNeTEA2rCgl3Zx1ng/BsCqIEvWCtG2+MFXmJ8/omo4bqILVBVmzbi0C5bwKlsbAx+GyHR2Q
 WeKgX/TIl06IFn8LdxPuC56cI7Hx5h9xzNGCOe8F+VonoXRdd72NJyXH5Bh0CVpKZvxrPiX8y
 JQpYJYrKCwHWvKBzli6P4Bpuud5f30q1Cx18qsVYg39BtH7wBLGgLEepBVx7F9mon3A4wnX4k
 uFG3HCkic7104dxq+igqN8Smdna4r7It/VDqpX0PCxAuu7SG7y2iD8A8aVpfW8/YLMMjsMnlu
 HXH24qrTkLzXpEutsE5BKFnnGd4wiqQcpfhsGX7Umn0lFyR0HZNalBGOE0fxhyjqo75CYgZJ1
 IvLIzuGxRqWNGDmdwK4IbPDZV9U2vMc3EWAk6UL046TYW5Ta8qwQ+j6iuB314qg4bqQeY/o2R
 IjR7S64gM4Rvn0AmyQWXxYvhgnB7r0iCL3QfHuM4EfzUYv2Qwv9y7EO+lx4hNDg36NU93Nk2q
 ESXiPirldifzggWMCvyjOWkxuD8jrSTzRDUOU7SR+LsH/UVXSG27U/s89ZhuABnqu6HLdPXIo
 IDX1AY5KNrodlhBGNIdE2DUwbYvl5CV+nHA5KMQChG8tCDJN4FZEpT43w7m3e3qE40QL5GW/w
 7kcevpO0XrQJqj66a/XmrGHcolNqQKmbndywbFlzkD0G/svACXGGXWhjvBwxFr2fk0wRMPKdO
 NbzKj2a4ioNCryc1G/rJfwjadQnIulD0j3sHQuBvZAVUuYrGX0up9jwQQ1jJW/h2ETJDYAOqz
 w+/crW3YbZyRneXNcbATmm5jRpl75dO5RPNZ5pgJi+TjlWPoDBn+8NCmmXF+Wwq3CiS4TcQTj
 20EBdu+RgDjI/QBSlVb8lY6SAty0B8MFZVs5P0lMoi6szYp+WA+Th9Fi2Lxbhlpm0ML1yVIAV
 9IqOKQrTcj9fz4WKN1x1nE09OKpfBeeewzZXT2ovKurxRyjSisGwaZXOg4v7axqEOi36FpAG+
 Wq8q5O9j1tH4EJQ7fM91BKrN6d4n/Fa8dcBUHROUiJ/ei2zaAlsP56ffaRCgSA0icTi6R8pw/
 S7apr9EWkkhFkG6xwztw/LrNl12bjoRD1QOCOMO7xkYf7SreNzFDkS2zOUXMbnUo5IgFo+w0H
 GyKp7PPMXtV2HlKN8id6lTkyyjKF3ZbYPIt8fJp4UtnqqU+IjvtVlwAHNojRwANhOxntesKy4
 KuET7nmxQZwOFjqleubN4/A6BknJ8wECBdOMfDJP1QavGqprlkfcsyreoZfkefCqMJOVhatcX
 d/9jCBEnKFuB1TXnnOGZQ5g5eqtYh0OXY2w8xrwjK0or7KWWLEzLhzp5l6pL7NQHH/asw+CSA
 YCuUC9+m9w53BQN9m0y+f0THdWNUtCiupblYqCKLCHQsGX8cbZrpIsPD73MpYVJnrYuONxyqk
 IiyciQ/vcUNrzyN5Y4K7KtncgnSQ45N3UazVJlNsD8esI+rsyjHDHLvz+uwTzLVq9aC+XeETm
 YwvZ6uHH8VERIEpVbZGEZCm6coCgrgUERf7f/j2el/LpWMulbP5/jweShw0Q0FuNWJU/EBlc9
 ywZklZsuJ/wfIdbDk99Q01ey7Vhk/eZVNQgg5etGGMAchmd8E6ntC3vTO30wQFF84edMk3y3x
 CSq8TiXzPjkMii7udv0z2gYymHQMYGJmHfTQnzEazBqD+o6VCt2LRETjeqIHs1SrQxWRn2m0G
 F2jdvcmdG3OR7/YRU9WU6VGkqfCsa0ZN4ps5X+6imkRhA2aD1YthunGRzhlqxNIUfGWs7gxQ2
 jHnVwz7M51tskqWU1qnCEWPLyUxpBhRTahWDMj0obx0vFgzJ31etcnFwZqKwsGFDmq8HXiSxf
 L7BST8pMkT/ZDRzMjhPIB+71XN4/ANPiPwU3w3P3Wh3ZtlYzutdk72BhjupUEMg1r55O1ifv1
 9kM0WE5x6j0RqMHtu8nprTJ/dLBgLRcFfnJqSc55H4ui6+CT4yLw9iwNFmbgzAryIPItuysMV
 WFg+nFrNwcRvMNo/I1Y47sXdvmGkSb8VfSg+6DCYW16/kXLwdImPAJWJuDg9NKEZaSSklXQGT
 UucRpzxPp3vc/g5pljeAvoqgmJdJD9RN9+weGKr6n0XH8vw1sAYu8pqllXGAA14k4bNedwWco
 MSnW6c6jLy1FncQ10tKOIgshe1ImsjEaIWSDVWAoRyEd9BmYGp9gsuxMhbTSZEjTkxi2REscq
 WMEhUKUbLYCdeRbUKobA/sEA2Bgh1AlxXn7QIKUwfvXQ6b9S/CxGzzJliSCURp23bRi5QOu6v
 8o6/8L5XOWX20HgaoaQ8A9mZ81/Hv71MHaBB9OeWFct86SmgUDrsR/srAEnpqbowsGIKHsQea
 ICV2Bgs7mJAG/fAErrPc5JJMVcFJ5/WtuLSYgqNbJqJ8OalF5MiCFztxmzyCWauOv6laB4eng
 bt21cAR2mXO7HH2Y5NRNN0bgSKZgDXomN7EQnftrzuD0VLwUT43MVgE+H1dWPKDzdUgMAkWQm
 kxkD8WOYDO8diMX4hUHvjHHfWytj6Vc6C2omF8W0YuE3cEbFxrHlFwi7j9rrh8XuvEZElNpwY
 sRmNU9xIghiCvnEip+b468cxlgL7CTByxPeScwvWdenz7y/wvxlXlEOYFmt2TDW6ZDQV7Ovgn
 oCrt5x5mywE31WChaRi5bdCjbxJHEBzqLC+Ty1j9li4s7T0eS5tveSQCe0XN6ojpKk6MiA/xo
 rAoIu7DO1HJMURTdIikvEM9+sATUmtdX5uU0sEedgjwXXOxzN6tIhLCySTMSHTov65cjGptM+
 mVP+mm4DWGL4Y9hwgmGbrcHF4Ja80AlwF4oiYU8nWu/g3LHERdBdaX+RyQ0jTTpAmyYP/YoZQ
 jdFnrl/gMymqoOY2KAdCHVL7QIe/qBbdA2k/AoGK2D8FEufQ/nXjHS2woi1iObPwutIFpreTS
 tUJUOpRC5ta7+c0So0Lc0Yob/2tm276A3A2umbod6J07UmQsFvBwhrFh6QqcqV7oa4Z1bJ36j
 70xFz8Bk8z6NM03XNJl2t4wZNm+3t3i7nms0=

Dear Git users,

I hereby announce that Git for Windows 2.55.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.55.0-rc1.windows.1

Changes since Git for Windows v2.54.0 (April 20th 2026)

Following the MSYS2 project, on which Git for Windows is based, Windows
8.1 support will be dropped after Git for Windows v2.55.

New Features

  * Comes with Git v2.55.0-rc1.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.9.
  * Comes with Git Credential Manager v2.8.0.
  * Comes with cURL v8.20.0.
  * Comes with less 702.
  * The FSCache now accelerates more git add scenarios.
  * Comes with OpenSSL v3.5.7.
  * The diff helper handling Word documents was ported from Perl to
    Rust.
  * Comes with Bash v5.3.15.

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

Git-2.55.0-rc1-64-bit.exe | 40ccf96f6cb90e1c1e987108d339bf59cf883f4f62fe1d811bf7f453f216a3c2
Git-2.55.0-rc1-arm64.exe | 32ea9f89ebdcb4b5386bb8d91ac09bddca05f97aab2bb97f3a30e4a2ee13dfd7
PortableGit-2.55.0-rc1-64-bit.7z.exe | cea2707ee1a25ef33d9db4235c1b4ae33d22c2fe618dd3d4ec8574b34ec6f3d9
PortableGit-2.55.0-rc1-arm64.7z.exe | 70da0c29b0c60d7417d698c0d1850a2c409ab89cf9d5431ab75ff203356f5132
MinGit-2.55.0-rc1-64-bit.zip | bb7d17aa2e1cf1b015b7fe2f0312465fa0e035699b0970a5898c07595a61985f
MinGit-2.55.0-rc1-arm64.zip | 49df32406f57d2886c93acf8ce2fcb9640a1b73c1829fdbb36ea069c41d216c7
MinGit-2.55.0-rc1-32-bit.zip | 7d8c7828ee2490d406a4a9132a6a2e61f955c26c0a9cdebaf05ccde9bf156ebb
MinGit-2.55.0-rc1-busybox-64-bit.zip | 22abdf14fceaa1172a3416df33fb535a790faab7584a8ba903f3f88d4d0c45af
MinGit-2.55.0-rc1-busybox-32-bit.zip | 0139489b7baae8c9738cd3ea8dcbaf946c4f758716e9d64a6b2491db0c0cc229
Git-2.55.0-rc1-64-bit.tar.bz2 | 87be9bf3d21a53b6e415e0650b4c4632e4226ae9c148a6d5b090e3521d5cfa6e
Git-2.55.0-rc1-arm64.tar.bz2 | 9d7786f3dfb29d1715ff2a73a0f08abcd298fe610c70d1117dcffdb0d15e43ce

Ciao,
Johannes

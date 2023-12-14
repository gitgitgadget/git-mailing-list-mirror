Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010F671F7
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=lightsparkle@gmx.com header.b="swlAYhGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702591012; x=1703195812; i=lightsparkle@gmx.com;
	bh=ijUUTwxDjEhPvvQcO3SuyGHFVJOVR77A+Bu++f/1Kws=;
	h=X-UI-Sender-Class:From:To:Subject:Date;
	b=swlAYhGH0vam048BHjTTH8KShp4t7JCDjkzUsUfXKwzmKzrrY5Bc3rxBqOPlgIcZ
	 9ZYsdXIC6/oAGzE7brcaxKjEBenwCnTvrTqB7HYI3+nsd1Xp1cJxPEOt6gj+ImiMb
	 N+dUXW3hlP8hbpmtUVs9Cw0FrZok+Bz8ovcEpz8Hal/GJtfnxrPornCNmE9q1degx
	 /ibVmYXcC2Gt8bg04JDiDA8Yc32RxG23q9d+BG3xdPtoLwpqPO/3Jbys/7kZrhYl3
	 WGZRxILbvN4Ftgal2Mzh3iZShcjHqul/XHfllzibHVdmbJc4Aovnyhv08uIZCuZRD
	 BQUUTzEvCV/MFK93ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.11.4] ([10.236.11.4]) by msvc-mesg-gmx001.server.lan
 (via HTTP); Thu, 14 Dec 2023 22:56:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-03cfdffb-8cdf-4da0-a050-dbf7b6590b4d-1702591012663@msvc-mesg-gmx026>
From: luigi cerbai <lightsparkle@gmx.com>
To: git@vger.kernel.org
Subject: Serving an .html web page from inside a git repository
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Date: Thu, 14 Dec 2023 22:56:52 +0100
X-Priority: 3
X-Provags-ID: V03:K1:tSblAP82eCQFkpSnfpIimoQw6obPmZI1Pa6jtGMHou6tAsHchjGVWzXlYRY4hjcENbTnP
 TQfe3qTi9KcseyiRZ0+GuMbdIj3+YDSn5ASBi+QYZ2YDpDoZEEwqz/VSoDcBLrHVWQgLzgWyJl5b
 H9E3mNIS6fkHmAlxCI05S/JB/KQdJXbf7CeevT7E0kRNvxfxqkKIp4HbfZIOllQx2ZCpM2M8moXw
 vjEh+LYWyR4TfuO3sOSupoFOtLKFRgKpcFhorflKg6Bokwj8IA6g5X6sWbmvIi+JSaek/eZ1b/af
 Ns=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jTSy3Adrow0=;yXIKS3cVxlhjtORdATDnDbFmjfa
 zydbC7spJws1WO/t7SnkeDi9AKXue5Ek8kM+rz2sYzolrRmrdbyFK4xunc682bG51vkh9Nmup
 uBESZsUfIv1VRPwS34f1Pg1klXwHpduVIJ4lL/E2zUUKadmw3PANhyDJSkCi3CvRPhtpFc4b+
 6I2cWZl4zaVxSBLIbEoma1hkx8vzbQc2t54QhqlbJMoMr51tztLTJ36dld/23jWEHT5wJTQFI
 mqFBJSIxrh5xZLXho4XAKFxMh5s0w55vEm1YPJLM7ob47RXu8I/pY0DWNOF959r46NJpptx9i
 adLkTPBTjZYb/VdNQ/Ls1RARmnZV7bXFF36CQaazFLSMCG+HMuTpdyM2Qra1IWf5EJZlYH8YJ
 +gbqAnkOAMjmeTrlqnppbCLYGsMnM/EvHYjd1a3g0U99UGzg2vXa5vGNPp5buM5a7QgS7/+7g
 XdUPvXbokPHQoznmI2/K4p2iY1WJTQj3SX8rUbT7cU2b0sBr1JoRjYZu+5jZxEs/87HtXToXh
 J92rxxmJPljVPbkuZk4LuQkdFqxhfz2OJ2zYLSBKAtm7gsNlALRoosPxGUA3BW5j/xTgw4YsR
 1tdwJ2z9XXeQA4OCCJi+DEKyttGoZRqaDT2+FcEP6NZEgqPoYlFXcDhMtzPcnBg9b4dXsPMQr
 1/96D+nKDu20e8gizidRKUzqxPvLmZkVGNwbQZlrvvX2cHv5O2XkkTIOQXP5iJM3Hn8nx6QnI
 w4taFOtJJUUbiLOMDWqSNcZUIQQTPOopJaRXpW8/RHrSfjBCPdrrzuf2Jf1RwngXhL+mANg9b
 RtS/RQx/xmj74tMFUXeyctPA==
Content-Transfer-Encoding: quoted-printable

Hello, I have a technical question to ask regarding serving an .html webpa=
ge from inside a git repository.
In this setup, I have to make the .html page contents viewable on a browse=
r open to outside traffic without
using web server programs hosted on my local machine. The role of my local=
 machine is to push newer files
to the git repository while the software located inside that directory ser=
ves the content to the outside world
that can be accessed by clicking or typing their own co-respective URLs on=
 their browser.

I want to test this setup in order to learn how websites works but I have =
no idea how to pull this off, do you
have any directions to provide in order to help me build this setup?

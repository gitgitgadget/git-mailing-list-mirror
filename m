Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA62E626
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603378; cv=none; b=KDQk4KAh2J0NBXxHrzRncfr/BPDYs33WeswijdgirmimDMS8chwBry51liI7IZKW153DIs4j3DxmTrv6DNHiG7kQknOOJs/EO2pyDaf2JE5nyv5d/tbt3gONMzmwXRN8rlGeNNuiQsNBktvRSW9p491+LdNRFyf9bn3UrlDJ6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603378; c=relaxed/simple;
	bh=bGyfH/MnVOqwgFpfoCVLIb+0N4Vyc/1cZhBnR/C0HiQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bzail/j5ZpuX93nnVsR2PW702KWEZ0s/JOTjyKitKH5w51m+OCvGs4kbE7pdU2+KrQP1PJ5wtq27cYIy4MTmioRahSQwGwhyHTA4B9uojqQZnSUHGd0MYRc9ttTV6UtSgsxpWorx6xH+bz5zq4avVcbEadESDNHwkN2dvJky9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=peter.hunkeler@gmx.net header.b=Wb89WMnT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=peter.hunkeler@gmx.net header.b="Wb89WMnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1705603374; x=1706208174; i=peter.hunkeler@gmx.net;
	bh=bGyfH/MnVOqwgFpfoCVLIb+0N4Vyc/1cZhBnR/C0HiQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=Wb89WMnTs27NvrtFdG3Yyiubmg2laBT2FLcoQt6M+I42VW8GePqUxU8O5diYHYvS
	 Xt8zyS0qFNyExz1ZXzY2xMk12plsv3x+PCpw6i/FoCh+l7SjyuDkIbnYPX1+cKzh6
	 bPrn6NNsdKys2o/4rBmg0Uhy02aM+TFp2iyNGpglB9YdQJq+cjU4VlNp8Mu2Ff/Yc
	 YDSoMKW8LPQdXynwvCa5/85oHnhJo4ufQBcXC6UT9jO+xDaXQ0sYIbglMYlkA0mBd
	 cXnCZwAdfNw0d7fDkjDAUhzgdRNpK9HAJ12YyfbpUwN5WTmf6Dx/UFOh4FBz6l3TU
	 vj3luC0G1Q1lgAsURg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.9.46] ([62.202.181.104]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1rTYYa4Bjh-0081Ao for
 <git@vger.kernel.org>; Thu, 18 Jan 2024 19:42:54 +0100
Message-ID: <54482cec-88de-4e88-a153-f699c2c087d9@gmx.net>
Date: Thu, 18 Jan 2024 19:42:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: de-CH
From: Peter Hunkeler <peter.hunkeler@gmx.net>
Subject: Suggestion for Git docummntation Book, Chapter "7.7 Git Tools - Reset
 Demystified"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FZRKI8u0wBIfcLOw84eNDdCNVe4/NubXrdfII+PDu3TMqcGbEQU
 OuxpDfbz0tN8vB+wGFWW/w90XsjsNP0il81yXio0GDpfjjlfODnbEKwrd/OQPuKF591fXpn
 WIe0cZsViHBP1bYH4LVDlln29Tr5LzgBzfKR/du7nJlDd+cDB9vp03jjr/07aKdxAYhuk5l
 3Kmu5+dfnJpxGEitaiwFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ABeelmCp1q8=;VdwjGoJ2hU+65lVg9Fx8xVC68AF
 XF6ZvpnIoo/yl0WY2Repat4i7EBCSejBhanDk7XZnST8WUhhYQ+F67q8qsCU1DYu9o/Najmhy
 S+Iv8SGxtXVVRqNQL3OQgcz4/xXqKv/9XE8itKumm2XhXxwYE59BJQnPSVIk8gSmPtAolFXOY
 suSbNSkGDyeXEXlGpED7d7pcO55TlBqJyXsSDWiupGfmm2ghMlCepmPSkAt0vIyJHPQYXtIGL
 /VGWnVY33KUheb1T7f6qDjZY1y5FaM8STsqx7LpDwWxFghbNXbgNCiSnZ98qk1EWz679bp1n9
 LSpYJ4XJjlCmyNQEQbOx4GgDVgPM68NYwvkO5lpoSFlFDtduOI/1E9hAFHYILMIe93GUosUMS
 sNkvWwyhDXTJDDSSqmfzebvUvdURnov2x9MMi9/q6c97GLBCIGPMsUWOofIP5IMUB41TTuqAL
 nfvQ8pRlPdjYJkgeoqvk3bIATrJhzEZHBlxvOlrC72kF2er0yAWfgydn4fcX8gDOMBOle8ISC
 w7lit38gGVgwVVEFbcaoARDrbv5NUuPwyw4NKqPnqpSwIgeW/HiLzJmUsFwTyCo9kmf+Po2Ju
 oDEqGvp+4qnaA7cQIPy31gm951isiW86iaWPZ6vqQZBG1Hsf7/Sw/UZattET2IsnXwVq6WhMg
 Szy9FL9NbOgt4nyQKwDLCyWn00Lbk/X8sGdzgHEjV8E337hkMr2QY7svw/zB9IiK33dtu8NUh
 ETp2Rh9wSd7PMpA8t9IMTtYZZ19OPooeqji7NrGP3LUxPB1kZ2289r0lc3DLp21Qrz8mqRLyB
 NBhpS81NSg/Y5K74mUTN+e0F/SRCs5NrvUsC0kVJoKRZZjie0ULIovEt6kwQXaRrVw3tP+eQF
 5qaQ0y2O9BfSerW5E65USkmXXAcEXposjW7FmQo9Ve6/izysHL27Jyact8J3Se1ccw05tAHVR
 BwabHQ==

Hi,

I appreciate all the work that has been done to give us Git users good
documentation.

As a rather-newbie I have to lookup the commands I need for rarely used,
specific tasks. <git reset ...> being one of them. If find chapter "7.7
Git Tools - Reset Demystified" very helpful. There is however one point
that newbies might not (yet) clearly understand: The git reset does
*not* do anything to new, untracked files that might exist in the
working tree. To cleanup, the advice from various places on the internet
is to issue a "git clean -f -d" after the reset.

Maybe it would be helpful if said chapter had a short discussion about
non tracked files, how to clean with "git clean -f -d"

Thanks
Peter

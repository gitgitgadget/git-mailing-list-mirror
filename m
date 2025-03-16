Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182F2E337A
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742096081; cv=none; b=oOFjaon6ud91Eu4yrbKUFtAGm2CBTJWkKun4TI4FG0YoBwCg/k0LUJtjssXJDkij60KgVxjhhL5ZDU0qhyFx46UW35cMxbwHj2WsITOF9oDOMaEimpza7Dh3DdOSEhsOv2nGDI4YCIvBWXFcHs/z3m9W66Me3lTmSr6z+VtZmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742096081; c=relaxed/simple;
	bh=UohHwNPl9AcZe0B+IhYbfyrQSyA0432PyAoMoepgZGE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=moSFOcgW9GFBOKkNdO+ySrHYBs1kWu0fvMgI5dvkEtaDhXwZAwCDfW69KRTwStojBM5mjxtW4J3dSkMnKDvnofa4NWS9xvOGgaPpPAefEIU1mTq+6ULTCJm4bZT1N08MjoEIaMiAnOU1OrBY1pXLQWqrZ0ijzYL9ocbFBx8XcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=a/xTk1Vz; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="a/xTk1Vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742096076; x=1742700876;
	i=johannes.schindelin@gmx.de;
	bh=UohHwNPl9AcZe0B+IhYbfyrQSyA0432PyAoMoepgZGE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a/xTk1VzmP3mmwR1b2ki4ReBi1r8D+/4IoqHIMnhzKKuzibVvW4rGkWXmJy8errQ
	 xObo+hSLYwftrEwOAeEatrkako8iqFr+MVYpZUrcZrMy/W1hYFI/ZkAqUlfqFnJy3
	 LEAIrkm7D3nE8xt2sTCBbPvfN79u4LIjohQxciW60rL5Z6yCgTUFBhV9BRcxgM4CV
	 99UjVl3XxDFM271HLuOUufaFdhGGvLCex3K2YlmYj2nxy44MnoczDEAGUWEQujnl1
	 2Jjy25Eaq4IUFmeKrlUe7vhB8FaEDRZ2u5jMuuwUG0MnIG+0mm+s6Cbh+LCzumoE/
	 CHKf6XVY89+oucLdjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.73]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1tspQH2q9N-008Loe; Sun, 16
 Mar 2025 04:34:36 +0100
Date: Sun, 16 Mar 2025 04:34:36 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dan Demp <drdemp@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Git Bug Report: git add --patch > "e" makes keyboard
 unresponsive
In-Reply-To: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
Message-ID: <84c3ccdb-2aaf-9b34-91c5-cf5c27f53dcb@gmx.de>
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KbuoCvfbCZutLgcCdl/MthGRO03dwOZx9qCupTeGeU6pT3x/Ews
 z4wgQ+ZqDdeV0P0bD9PSqqCAAogl/Xf68XJ3KDDigz2aJPEREMxZ2EVXHigYiPEzWBLohTA
 yL68cnjVFnG5fAgCxIUOGIls44jrYK39MIE/m7hxdmZufRBDFyP5JP6tu2K/Tmr/XB2xr91
 PT2Wzr4YBVEFFR9RSJQZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ataoxTR7q1E=;ClzwSvR9CpjcoLAHclyWMj+wqfK
 z8DA3acmg/A947mFSdaA0MU3yk7TeLCxdMqEZlVT8bkOvEpWKAwFKa0+7RNEddbpErthM+ZP0
 2PD2ivIB06JmBYBoloaDemYiunV+efbwpTYB/BUG43ai7HgMC8gceJDZlJ2aD90ZCcNelV3V6
 SMwMDdKRRE+2KRFsUi5lnk5nqfKE0fpzFqKP+P7JXAyQb9JMKVDGrly7Yj23QejfsS1uvLgA+
 YHZfmYMGb5VLgO3tZ6Rm6pWbIv4sAVbDPiNTj+2t19pPzVxs0IK3xd8a1+XVJHTcDboeWPl8+
 +qlat6Bl7gakGAQ3QOsix5aUHNs6uo87+UoGkNw1NyKBfHrXp0Mkk2Z/omHDsnChL+Q+zqcMl
 3XRoPToSbcRCVgZaW36AyUE9ExJ96gTj0N8cpXW4a3Yx66WIvmhR0fYv0VigJDBxVR7crG6js
 b7/Zyj2IO6TVRkMgRpCQxf/brx1MKSu1ig7mcFZiYIe7IinlvMzzg4F8dJXMcXLvqdADErsba
 L2wq70DMLrK/Jcip9ApLUMOVP1+fYCeQJfkVhfcGjIP9U8wXb5TBCjgSrUCpvp4peO3207XoE
 RQqtNz5hnZTeGq+CzG82G0RcEvgf7CL8yWmxTTi9+JtKS36NuwFezQKjgs5nzWFYouBEMvG/u
 KNkhwu9ERrSkynDaPao7fSntO07aoQSnbwNgMaK4zYYanVTDTX6XDYUgNBb1e0PtPmbn5gqCd
 pnJJfjz2fER8dqcGAxGLtu+IyYZHa3aJ8BcvThgIpOJLgPKSKH2V52MN+3vFxOcYcjfIJLdxf
 fwAt+WuPdEeFQebTEhLJBhgOTaFRqlDRBmFpEsiHMhC3nvhiGZEb6Zueuydpjn9sFkkfapi2O
 SOXmouoBCw9TZ5/E7ZiIMij3do2Gv2qkNy81xl7dGDi+74OZAGGD9rQ/kSxx1YaD6OFLuKfTD
 +QcVRbi6ToXD1TuVFP0sLU00jJbxTMepgowByxx0Ir3t2HEm6Stb3cO3E9FR0DmmzMUTB54fu
 A4du372n19XQxyVDR8SgRzUA2mx+wm/F52JXZNwBVwyHt6LOUisj31ydT9E0A1brwmVidmE5g
 SQR+KdUoAYrKxzVc/6BPckjN7HlnS/NS1WVtrVYeK9sN2m/TPTsNpVYiIaOPFYDSMF0J94++4
 m5lkISkdkJ9sWSmvkhsfQFtz7B35tDjVEecb4+WBGK3+kosAh1r+kkrMPLyZfgdc03s4ZRDAz
 VwWJSGdGyszymaIxCLiwDrBKgR+b/t85WyEMlLctphCKbqG21Ffe1/b/LCC0L+TATUVbYgkFW
 cKdraxDIWQfitVbsqFiHB0hAjz5Z8wWQ+T75+mdeXLeuSgGC3UEwE7rkqPaJtValkpbdEO63H
 jTtseUvn7kxE5F+RFYnpg1mMNUAH5Imh+FDh9SEiaFPxIKLyOnWdeXOp+6pzxeH6DasJJdZvi
 ur7nwgHZhZKprA1XFJdpDRbR6QnzBc+/DZT9Tf2Mjo7wIqZGxnSWpxynsN7GR885LRY0jWCqG
 edsg9X41FDgazVCAIAanZKLaaBunE7eeQ9ny7+Qx
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, 24 Apr 2024, Dan Demp wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> When doing a git add --patch, I used the "e" option to edit a diff I
> couldn't split sufficiently. This worked, however when it moved on to
> the next diff, my keyboard became unresponsive.

It is likely that this is related to
https://github.com/git-for-windows/git/issues/4776 (but I can't be sure
because your bug report did not mention overriding the editor), and will
be fixed in Git for Windows v2.49.0.

I refused to release on a Friday (absent any good reason) which is why
this version is scheduled to appear this coming Monday.

Ciao,
Johannes

>
> What did you expect to happen? (Expected behavior)
>
> Not make my keyboard unresponsive.
>
> What happened instead? (Actual behavior)
>
> I was unable to enter any option to proceed with the patch, and even
> Ctrl+C failed to kill the git command. I ended up having to close my
> Git Bash process and open a new one.
>
> What's different between what you expected and what actually happened?
>
> Keyboard unresponsive.
>
> Anything else you want to add:
>
> I've reproduced this every subsequent time I've tried this, and it's
> specific to using the "e" option with --patch.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.42.0.windows.2
> cpu: x86_64
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19045
> compiler info: gnuc: 13.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash=
.exe
>
>
> [Enabled Hooks]
>
>

Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402741D101
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493490; cv=none; b=NpvbukKpZ+sYXDic5JzpTX3g+T4fE4EJI9cl4G5qy6hB+nMQQ/WHRB0llFFZlufuvf2ZgzJwNL4jnjdREyK4HWH5+T1+Gs/td6mFvEp19xmcHt037oicUUWKDnMNBVFQlLYznTsnoEBfXqP9azKc2qefsxqkJH1A1GAwjVv89Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493490; c=relaxed/simple;
	bh=Hkxy+fNoLRacB0wLLUSueW0VxgQpcnnm69f6bkLQGj0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+kWveoH84EOaIMjl4WBT06lNq/sKH67LNRiFseTkOnbZqZsH6nFp16xqEnoDpj4lvgystwbqZxsaeaW7y5xAos7YYyzmYknsxO0RlKyz5Xpe6yKUal7cdlgA1Dr996T1w7OEcgSzzvaG7dACySmepSB7oPkdoDvkpk6jPSrnB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=EiIyPSvg; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="EiIyPSvg"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 7A3E94CB73
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:19:17 +0200 (CEST)
Received: from cixi.localnet (unknown [IPv6:2a01:e0a:b3f:5350:b6e:bf81:919d:c0f3])
	(Authenticated sender: tnemeth@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 413D413F89C
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785493150;
	bh=Hkxy+fNoLRacB0wLLUSueW0VxgQpcnnm69f6bkLQGj0=;
	h=From:To:Subject:Date:From;
	b=EiIyPSvgVzdFUqlxM3eP3yI7akHy35ZWfxOH5SgyusrsjOU5mppRY2XsWiMj7dG20
	 bLOFPs2tHIpD7nvLuU9d8XAC+31SgWExGeaBur4Jmbl8A6H/JuuqPGnsPvty2uhIX+
	 a4WiQVoVe+UogQTR6ZZHzF00yKrLIGZwIQ136w50INxbTT6sb8w22Rkgf18b19mVpq
	 twiMg+vTxCVcD6WLyK+YWHy92g0Rvv6a64OQXVtHT80gvJOvSAAWGbyWQKNA9pQj8N
	 knHi/YdP7nrcDDxaxbSylqT7Fm4H5ph/udKk8o5/seL4VuHmH0NyoN08KYTlX1swcJ
	 yRw81N1PQvRTg==
From: Thomas Nemeth <tnemeth@free.fr>
To: git@vger.kernel.org
Subject: Git trailing blank lines feature configuration
Date: Fri, 31 Jul 2026 12:19:09 +0200
Message-ID: <6022080.DvuYhMxLoT@cixi>
Organization: =?UTF-8?B?ZMOpc29yZ2FuaXPDqWU=?=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

    Hi !

    I have the habit to keep 1 blank line at the end of my files. To me,
    it eases the EOF modifications (selecting code blocks, pasting them)
    in vim.

    Note that I still want to remove blanks at EOL. But I'd like to keep
    1 blank trailing line. I still can, of course, but the diff still
    shows me a red "+"...

    Would it be possible to have a configuration option to avoid warnings
    (because I see that as a warning) about trailing blank lines ?

    Thanks

Thomas.



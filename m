Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D4221552
	for <git@vger.kernel.org>; Thu,  8 May 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726015; cv=none; b=C4mtLPtxvl+AsXsAMuH167gbsUWiMZ9KiGDAdvmzHp9U8lvoYEgJUvEjmdjlnmq/IXkP6AOhJm207cJ7TLHDwD+6OQ5RpuWFyoBhmnMG+rv4Fy8xlxL7nsziLvgrGWZIV9bCOVslnrtXhLeVFD4/918TEnH/fdAysNPau8pdDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726015; c=relaxed/simple;
	bh=9ExSnV7NCbK7ljHqLJOZE5u20iyWhYoFrk13R4CYCvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTJBVxf0hjW93rFWVq7H61+MMru/1AXsUbaqYTgoe+bVOdA93VMTFAD+VpREo1F2qbgm/C8Wfek3KvGRfX/mD4yK/qDNv9JYqtgDtpdYrg8pK6PcttevKp579lPxj4Vkv3AWvo3CfR7ZPnhBAIp6OIaKhQTs/QwoujMTKuM+3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Ci8vvMFQ; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Ci8vvMFQ"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id D5B3upVSrSSpfD5B5uBjYu; Thu, 08 May 2025 18:37:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746725823; bh=WRLjgLUvJDmyJ1dh/643iLXhu2bVi2AvQyIw9Y2kch8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ci8vvMFQPcTYaXExoDwY3TzMG/5QzurQrgrZBWnf1QQSEmMh9GaQkvFT6XS61CboE
	 o5/VUR/NeQ8jEgPhImZ7m3P2ZWLLIBLiLFF+LpxUBH9ZqzTBlkNaD0+1As+dKUlukF
	 PmB2vC1EvQHj6aXvqHcGdbUCe61s05qiOb4/rcHqF/cAmpnJO+6eMcdArk3GMEhXzR
	 SpwE/lzTy+dBknVmzZkC0fihdIlwOj0SjbCeSJK/mHQWFaifiU2QBiTw2+uiujp8a2
	 jENRw44Yvu1eh3wKbvKbS9uoiRYgzQLz35Y/oq1HlBcsoEgM9VSqcE3AvJv9C0LtTb
	 DTd0tuwkW8KzA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9re0vni c=1 sm=1 tr=0 ts=681cebbf
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=oCIE9s--p_-iXHk1q-EA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <e961ef56-f39e-40ea-85fe-964b66b9bcce@ramsayjones.plus.com>
Date: Thu, 8 May 2025 18:36:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] miscellaneous build mods (part 2)
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Eli Schwartz <eschwartz@gentoo.org>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfC2DtyDSBUlZpx0w+8EKXPeYXPIkqtoQaQdnsAi1ltSKJg4ju8Ep9sa9kLLujlH/pSwyfaa1AUkLGzkNB1dbkN8oC+f6Fx1h7wh4AT9HI3lMsttxBoP8
 1PUkBkgQOPQxZQtfF8L48vci9XhTiWI3OeL5YFLKJ3EimUxbEmolf7xaDXxo/Hwi2jCUsK1PvQMZjtVGUUaoPa3YabjSTWTVFUQ=

Hmm, I seem to have misunderstood the '--chain-reply-to' documentation
on the 'git send-email' man page! :( Sorry about that.

[I had intended a shallow threading].

On 08/05/2025 17:44, Ramsay Jones wrote:
> This series (part 2) continues the miscellaneous changes to the make,
> meson and autoconf build systems. I am sending this part a little
> earlier than I expected, so there will now be a part 3!
> 
> The reason for the early posting is to try and avoid an regression in
> the autoconf build system (see patch #5). Hopefully, we still have time
> in this cycle to get patch #5 included.

Note that I cannot test the new autoconf check in patch #5 (I don't have
access to a Solaris system). I _think_ it will correctly unset HAVE_SYSINFO
on Solaris, but I cannot confirm that. (I can only test on Linux and cygwin).

> 
> This series is based on commit 6f84262c44 ("The eleventh batch", 2025-05-05)
> 
> I did a test merge to 'next'@629a3ecd64 without issue, but 'seen'@71cfd25022
> had a small conflict with commit 1a2929c851 ("meson: allow customize perl
> installation path", 2025-04-24) on the 'dd/meson-perl-custom-path' branch.
> (I note that a new version of that patch was posted to the list today).

Note that it is patch #2 "meson: correct install location of YAML.pm" that
conflicts with the 'seen' branch.

> 
> The fixup looks like:
> 
>     diff --cc perl/Git/SVN/Memoize/meson.build
>     index 4c589b30c3,8c2e80d2d2..d6209dc3bf
>     --- a/perl/Git/SVN/Memoize/meson.build
>     +++ b/perl/Git/SVN/Memoize/meson.build
>     @@@ -3,6 -3,6 +3,6 @@@ test_dependencies += custom_target
>         output: 'YAML.pm',
>         command: generate_perl_command,
>         install: true,
>     -   install_dir: perllibdir / 'Git/SVN',
>      -  install_dir: get_option('datadir') / 'perl5/Git/SVN/Memoize',
>     ++  install_dir: perllibdir / 'Git/SVN/Memoize',
>         depends: [git_version_file],
>       )
> 
> ATB,
> Ramsay Jones
> 
> 
> Ramsay Jones (5):
>   meson.build: quote the GITWEBDIR build configuration
>   meson: correct install location of YAML.pm
>   meson: correct path to system config/attribute files
>   meson.build: correct setting of GIT_EXEC_PATH
>   configure.ac: upgrade to a compilation check for sysinfo
> 
>  configure.ac                     | 25 ++++++++++++++++++++++---
>  meson.build                      | 28 +++++++++++++++++++++++-----
>  meson_options.txt                |  4 ++--
>  perl/Git/SVN/Memoize/meson.build |  2 +-
>  4 files changed, 48 insertions(+), 11 deletions(-)
> 


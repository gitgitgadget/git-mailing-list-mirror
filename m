Received: from mail-108-mta169.mxroute.com (mail-108-mta169.mxroute.com [136.175.108.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503E6BB5D
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454492; cv=none; b=Si82ve9V41xzmevjaxDzlhoUZjZJarD0iGy3owlsej1t66iT7fHd1cH2NCXAvdncB/xxXyE1wMiuL8q4hpphtkyGuikIOnHukAHNfyegVoKlqedWfutYAE9xfCihb9h2/78a0biv4IYC98w9PTfUXPaTlsxRmP5oCeRloTsaDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454492; c=relaxed/simple;
	bh=yNEWTAMfuZLQVMO7VhVG49dkb/BgRpf9wSjlTiOLVxA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D3Zjuaeciix4aV/ZsBAYrS1695ZBTGqhQrW3i9k2H/z0jqJWIFNmGeIsiznm6Ikv3ayGO5oj8XyQ92qcPdeBKxggYFGrRYnKtNReEuaijwlMOhOgcQi46LA+RgEjysMSWfUW+hGLZkzO4Xc0GuakT6d8mcHr/ZLe1mNbnip7uP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me; spf=pass smtp.mailfrom=vkabc.me; dkim=fail (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b=Bd0SiqHe reason="signature verification failed"; arc=none smtp.client-ip=136.175.108.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vkabc.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b="Bd0SiqHe"
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta169.mxroute.com (ZoneMTA) with ESMTPSA id 18e7a9e54280003bea.002
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 26 Mar 2024 11:56:20 +0000
X-Zone-Loop: 9f2bb3b3838c06eec19e18bd33702872b511fa89b054
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=vkabc.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SSCmh6Pz3UrD2VxHrOufhSGHPeIBSu4wrK1T405H3Mk=; b=Bd0SiqHe/YgLHnA/fmFjypKNrs
	AsPJFX0NMYcoqtub10FtLvu32c0LsYv6J+HR6oU/fiPdku09tx7WinLq/3/CGOpTGYtD0P6p4zutM
	0JIG3bz8eD9OlT04S67KUm+8mZMpqgHzNZ+TRy5BvGl4dVUOlmlUbTLyBigcDTD3EXUtKtvVLw64R
	OqvWFKEu95VYfDOkvsHoy3Oylry7dQg+4Z1S13m8cPm5csnC21ukJw/VyOJz5mTS+0KJbUTsfeW7+
	wrGr7Xd5Pxs46uHOY6Sy+eDT+Po8caduL14sNpgyNlhR/heoTSTFnztuhou6BlSlTScrFiTtYMdJ+
	PCDpbntw==;
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Mar 2024 19:56:19 +0800
From: vk <g@vkabc.me>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC] Microproject help
In-Reply-To: <CAOLa=ZRrmyZ48C5r8MWioyjySWdKtLxhtDBg5F2tRsExHaR-fg@mail.gmail.com>
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
 <CAOLa=ZRrmyZ48C5r8MWioyjySWdKtLxhtDBg5F2tRsExHaR-fg@mail.gmail.com>
Message-ID: <a344deea98bdd2daa7671fae45c0bf11@vkabc.me>
X-Sender: g@vkabc.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: g@vkabc.me

On 2024-03-26 02:25, Karthik Nayak wrote:
> vk <g@vkabc.me> writes:
> 
> Hello!
> 
>> Hello all,
>> 
>> I'm Vk and I work as a software engineer. I am interested in
>> contributing to git repository. Apologies for the late start as I only
>> stumbled upon GSoC recently and git project interested me as I use it
>> everyday at work and it would be meaningful for me to contribute to 
>> it.
>> Even if I am not chosen, it will be great if I can start learning to
>> contribute to git open source.
>> 
>> For the microproject, I have looked into the lists for 2024 and it 
>> seems
>> that all the projects have been taken except for `Replace a
>> run_command*() call by direct calls to C functions`. However, it seems
>> that the issue has been solved. The command I ran to search throughout
>> the repo is `git grep 'run_command*('` and the search result returns
>> run_command functions which I assume are essential.
>> 
> 
> When I ran the same, I saw around 135 results. Are you saying that
> they're all essential?
> 
> For e.g. In `builtin/gc.c:maintenance_task_pack_refs`, shouldn't you be
> able to replace the `run_command`?
> 

My bad as the example uses `run_command_v_opt` and upon further 
inspection it seems that there might be similar situations like the 
example that can save an external process. However, for the 
maintenance_task_pack_refs, the command being run is `git pack-refs` 
which is a write process unlike the example which is a simple read only 
process of `git show-branch` to get the current commit? I will be 
searching the codebase for similar read only `run_command` and see if I 
can replace them.

Thank you

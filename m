Received: from mail-108-mta247.mxroute.com (mail-108-mta247.mxroute.com [136.175.108.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC7381AD
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684660; cv=none; b=E4vM+mmDmQvx0XnoxPvhMxbpU4k84QR7gGQ+KD+dIK1udK9MhHZQ3b4J5RAj3VoR7QtrVbQE+7uz47pC8HCLqoj1V8yQ8Eqcyh/h/yvsg8BEUopSAWs4wj11dI2W0CroXuD5F8La7svhrcC1IvpNTilWUZJhvW5/S2Ly+1Ke2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684660; c=relaxed/simple;
	bh=evDCHhaNUJLUmfoGBASYd+4iuJbcBYAe/t2PVQHEiw0=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M4EeXkKYMYThM529uRazf8WmrA20aXhiFlsLm72yplhs+bXzRAff3gW4Xk1GPAdEOhvEYfNzvqvOMvPOh7hQBp1+TlcFBsRCKQzOew5+39Qs/3UGct8JBGzDabneigarAVJ4w95VV+n9oRLguRWpgGO0L7jY1XGWFXava2OSblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me; spf=pass smtp.mailfrom=vkabc.me; dkim=fail (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b=bizsaDOQ reason="signature verification failed"; arc=none smtp.client-ip=136.175.108.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vkabc.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b="bizsaDOQ"
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta247.mxroute.com (ZoneMTA) with ESMTPSA id 18e885b0e7e0003bea.001
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 29 Mar 2024 03:57:32 +0000
X-Zone-Loop: e4a5741850f28a75eae2390c8efd395b72f157d39eeb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=vkabc.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+K2SoX1t+o8+lhlFkIzvkqLpAG+5wNqkke3fWuZLNOc=; b=bizsaDOQT0u3Hw5xZJ9e2/2Uy1
	QvNF1Q/VJC6TJMvlmV/hGc9rDRaovZq93t0ww2q+znohjWtlqQ9W5OCRHLWUhsMybWvf02Z1jFiPn
	uZo1CNb8nxfzT6utbpZCHoRxAXF14JNbqIz8wv2tT8JD7fR50KM+YdfCviOBr87HgVQjgq9p5clfk
	m1dO5cveEELO66awvbLWf9oJq+z310nBhEcPXkjECEGej+WQjQLWZXU981JOMKLcHUkHREHhWZ3BV
	hgyZofcbQGEXKW88z6F4pDx+y+6BGPS+k3zhBRxpxevWqViN+DTgrpF/otpq1BOMrUQ4Lz7EE1MWl
	9lX8t0uA==;
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Mar 2024 11:57:31 +0800
From: vk <g@vkabc.me>
To: Git <git@vger.kernel.org>
Subject: Re: [GSoC] Microproject help
In-Reply-To: <ZgO-W3E-CeT3n7vl@tanuki>
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
 <CAOLa=ZRrmyZ48C5r8MWioyjySWdKtLxhtDBg5F2tRsExHaR-fg@mail.gmail.com>
 <a344deea98bdd2daa7671fae45c0bf11@vkabc.me> <ZgO-W3E-CeT3n7vl@tanuki>
Message-ID: <80f0bb12243eedbc4ad6580cb06abeb2@vkabc.me>
X-Sender: g@vkabc.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: g@vkabc.me

On 2024-03-27 14:36, Patrick Steinhardt wrote:
> On Tue, Mar 26, 2024 at 07:56:19PM +0800, vk wrote:
>> On 2024-03-26 02:25, Karthik Nayak wrote:
>> > vk <g@vkabc.me> writes:
>> >
>> > Hello!
>> >
>> > > Hello all,
>> > >
>> > > I'm Vk and I work as a software engineer. I am interested in
>> > > contributing to git repository. Apologies for the late start as I only
>> > > stumbled upon GSoC recently and git project interested me as I use it
>> > > everyday at work and it would be meaningful for me to contribute to
>> > > it.
>> > > Even if I am not chosen, it will be great if I can start learning to
>> > > contribute to git open source.
>> > >
>> > > For the microproject, I have looked into the lists for 2024 and it
>> > > seems
>> > > that all the projects have been taken except for `Replace a
>> > > run_command*() call by direct calls to C functions`. However, it seems
>> > > that the issue has been solved. The command I ran to search throughout
>> > > the repo is `git grep 'run_command*('` and the search result returns
>> > > run_command functions which I assume are essential.
>> > >
>> >
>> > When I ran the same, I saw around 135 results. Are you saying that
>> > they're all essential?
>> >
>> > For e.g. In `builtin/gc.c:maintenance_task_pack_refs`, shouldn't you be
>> > able to replace the `run_command`?
>> >
>> 
>> My bad as the example uses `run_command_v_opt` and upon further 
>> inspection
>> it seems that there might be similar situations like the example that 
>> can
>> save an external process. However, for the maintenance_task_pack_refs, 
>> the
>> command being run is `git pack-refs` which is a write process unlike 
>> the
>> example which is a simple read only process of `git show-branch` to 
>> get the
>> current commit? I will be searching the codebase for similar read only
>> `run_command` and see if I can replace them.
> 
> Hint: the `maintenance_task_pack_refs()` can in fact be converted to 
> use
> `refs_pack_refs()` instead. I was briefly considering doing that in 
> [1],
> but then didn't want to do such an unrelated refactoring in an already
> long patch series.
> 
> So if you decide to do that you should probably build on top of my 
> patch
> series to avoid conflicts. The patch series is available e.g. at [2],
> branch "ps/pack-refs-auto". So if you decide to give it a try you 
> should
> build on top of that branch.


Hello all,

For the build on top of ps/pack-refs-auto, do I commit to this branch 
locally and get the diff for submitting the patch?

Thank you


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056B347534
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673118; cv=none; b=l6/ybivA2o7LZdxJLw4z/TYgCiSxhn6tP5huO+XLJwaly/bOn0h1rGFPTjg3oY/F3uxOuYnkmoSf36tZjKhJ5OZ1CTDSBQoGmthODhPU2wZyBN4JklGY6h5vhen1qTgGR0xwob082Q3/JOqDMZKlwp/crC/jBfD2ve2gKcdefnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673118; c=relaxed/simple;
	bh=i7LoLDMogBp6Qq49kvvdrto5enkWhs+1XQy/C80FMRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwPShBsuChsnQF2byuitSalZU+SwNpgJe9eotpTmdcw8P7Gyu6DbYYRFueqSqTnsHSEDTBJxRK7HZlK36qpmwIPjDgEwke8hAzS8gT8rMJcak+rltJBsLY3O609IstvOCuBVbBko+zYgl0t6oOHmBsA8eRQINS+aQhVmu5NHsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xJbwLdRY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xJbwLdRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71974C19421;
	Mon, 16 Mar 2026 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773673117;
	bh=i7LoLDMogBp6Qq49kvvdrto5enkWhs+1XQy/C80FMRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xJbwLdRYtqMOg2xyA+NBnnbUIFRDOq61OtTXLRfa80l3AWbk5ecgDqoCHBO+1WR99
	 drczeSeSrwOyBO4ZMqSQgi4d1Uc4s8LCjTPPxNiGp06JbC+/WEmfs44/cDEB1pKR0L
	 vp0QmDi64CdDSpJQxqpUbQPnG0FBZ18UFpAkSYMk=
Date: Mon, 16 Mar 2026 10:58:36 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Rito Rhymes <rito@ritovision.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
Message-ID: <20260316-abiding-cuckoo-of-chemistry-ff2eeb@lemur>
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
 <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
 <20260313-adventurous-lemon-unicorn-278ccc@lemur>
 <xmqqtsuj7mcf.fsf@gitster.g>
 <DH2ADSKXNCXG.2DM7T0NF5NH59@ritovision.com>
 <xmqqv7eywe4t.fsf@gitster.g>
 <DH2QEESY177X.15A2VGNLZ6EIC@ritovision.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DH2QEESY177X.15A2VGNLZ6EIC@ritovision.com>

On Sat, Mar 14, 2026 at 02:54:01PM -0400, Rito Rhymes wrote:
> I see where you're coming from, Junio. I don't want to distract people,
> and I guess there's also the matter of review fit, where not many people
> here are inclined to contribute to websites, so there may be more
> suitable venues for this elsewhere.
> 
> Konstantin, whatever venue you decide is cool with me.

I've added CONTRIBUTING.md to the website, which describes how to submit
contributions to the website. Apologies that it didn't exist before -- this is
literally the second time in the past 15 years that someone's contributed any
code to it. :)

Please review, rebase on the latest master, and submit to the right list.

Thank you!

Best wishes,
-- 
KR

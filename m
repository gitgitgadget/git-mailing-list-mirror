Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA74317153
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196033; cv=none; b=aBG9L9haCr4V+MiPH8OlXtyjFYf7r0WhFNNSe412zhJ3RdUYK7luQ5AltHToxf8hqaVW26UL1+8fXyC5Rq5S5ecaXyuHTqJB+NfCuTSmj7Vq0kWkEl8NGUGlvXzRJuvusJ+z2kbicnmLJTqFWnx82imGWTeQXu+tlfQKLofc/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196033; c=relaxed/simple;
	bh=czTc1jxwTL8YPPOcHGSgJsGOZ0UZgqMWNEPW+lDxQhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHWUyDF+yQF0j7cwoHe49vvuFalhcATzhllvBvwdyD8YWoTCoer7BMuaPWD+HNGL9p7cke19Bq5mzkmLnDa4O0pYVe4NGjc9oonY3n4QhOHStZVrdkwxwtpQU/nF/q9UMXlRn+lrbDhAh5xc2YdqoKpc88un0HCsl+rc2UXV4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=gVoVDJMp; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="gVoVDJMp"
Date: Thu, 11 Jun 2026 18:40:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1781196022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hIxAWQ9dYswl7GAhSQ/aO8Yc+60lLvtAqnX+bS7YBiE=;
	b=gVoVDJMpA7OrvORSzS8DXM2NXCLqrxE1VYTL6r5+NlGPHtSd5VvZfUp7b/6J9gFNScW4l3
	mZnxSVVTXQ6rmleOSW2yETjXXIJq0OYzzWL1jxBtzCv7QvXTxfCSmJzhk8njhSAFp1f2Kg
	yAv3btmRYA8tSH9aShwraU8HyieiShglbClARGbaI1CXpOXkCOiX5WJJVpPGn3lSiMjBAS
	vrWY1CHToooopmUQG1DEkqGeoMkSa2fPfk2IoCswRkOdbqkCtu0pXO7q+JVmRYfrlMTKsf
	joMd2CvJmrjElvGYDBXeYtH15aSYM7aJTZU/yF/sGDehUoHAlKq4m97u+U2HZg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: What's cooking in git.git (Jun 2026, #04)
Message-ID: <airkGWlc69uVsVa8@exploit>
References: <xmqqmrx1oy9y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrx1oy9y.fsf@gitster.g>
X-Spamd-Bar: --

On Thu, Jun 11, 2026 at 09:08:25AM -0700, Junio C Hamano wrote:
> * mf/revision-max-count-oldest (2026-05-18) 1 commit
>   (merged to 'next' on 2026-06-09 at 076600fa21)
>  + revision.c: implement --max-count-oldest
> 
>  "git rev-list" (and "git log" family of commands) learned a new "--max-count-oldest"
>  that picks oldest N commits in the range instead of the usual newest.
> 
>  Will merge to 'master'.
>  source: <xmqq4ijm3p2x.fsf@gitster.g>

Might want to wait and merge it in with [1].

[1] https://lore.kernel.org/git/a804828a046d8f12ef0d03eaf014807b079bb707.1781102091.git.mroik@delayed.space/

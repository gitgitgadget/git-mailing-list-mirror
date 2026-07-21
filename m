Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAE32694E
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597615; cv=none; b=cM0PgV0BJlFKhcTNL0FPV3WFRvmKV5jbVsEM/ObFsDQbghmOoff4Fxel1YlJxR6eTVcUMfnDk8I7hJAMyfS69c2XAZtIJVcNdNUVKjXt306v7crjR5dEpzbQXUI7tXcDFH5I3XbwkeZHoz2sar7d0c/MqyHlRc+2BQDPr9v3O0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597615; c=relaxed/simple;
	bh=ggUTT2OkWJXf7Rt6VhLx1HbBXuIdSTqA4kqVc9mgCTw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=iMYTUOtLmQrPdLzfZEKgwqjwYhNEqNGXz/QUH62LdVbTL7i4cBsT/+iV/nu765qUJU0TyR72mGKodGU+At29jxQSYagduD7nSWK66qZ7K/N+kx23vC/83757jQfbQ0IQMJONn286NQnVUbF2cAwz4K9Hc4nOrgusNG+1iWDVUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=VoXHTGRy; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="VoXHTGRy"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 2C19C60122;
	Tue, 21 Jul 2026 01:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1784597606; bh=ggUTT2OkWJXf7Rt6VhLx1HbBXuIdSTqA4kqVc9mgCTw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=VoXHTGRycMbr4GuAZ2fiuirU0KCeO7FTF8zSq6dYlEWBylS7/kMN1mriTvvtuGicS
	 5jHmUey1cBusNn5jP35RBWrLMAF/y0M/jm0GMYN/nnrEE/gtR7csbJOqQD1XhW/44b
	 dwS0RTosF8cZM+0dzD5rBcR9mzidoW5NB8XL45HA=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 21:33:25 -0400
Message-Id: <DK3V1Y7PRASL.2UPWZ8I2MZA1N@lfurio.us>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH v10 0/5] history: add squash subcommand to fold a range
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>, "Harald Nordgren"
 <haraldnordgren@gmail.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
 <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>

On Mon Jul 20, 2026 at 4:26 AM EDT, Harald Nordgren via GitGitGadget wrote:
> Adds git history squash <revision-range> to fold a range of commits.
>
> Changes in v10:
>
>  * Record the full revision expression in squash reflog.
>  * Preserve the boundary-walk invariant when sanitizing rev-list options.
>  * Clarify amend! and --reedit-message documentation.
>

v10 looks good to me!
Thanks!

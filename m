Received: from mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92633311C1B
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727327; cv=none; b=En+RZvkphrxp9+28QzNzNsaUF+hYIon/qwp5iSsDawYuv0wwyRfmXSWu5OqMQjgrGFYL1KfIeSEmoBxq5FflVYCb6X+zDNlIEo2XzTL6AVd1ZuftK9QZkq2uDzBdbWVeMozpZ+1t22fUMY8ISmErALnQSQT0BgUiNTZ/AgxnP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727327; c=relaxed/simple;
	bh=ncJfoC+FPp5nhMYxI8NjI9FoMSBZiX6Y5uGJXsHvipE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raTnJ0Bj2iPmXvey/vX4/RUn4moDxfOJztDKLQnLFjv5RhXTWkoWg22qpUCEY9RgxE2GCphqOqMtDxG/GL2UUGUTM9vGdttqu37BVdGvIjgRprWa3/iUSVhoecbqxVPQxAoSxFEFrZ0jXOCj3buyjXxfGHBoiMnTRsyf/9+Vcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=VGHNyu09; arc=none smtp.client-ip=95.215.58.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="VGHNyu09"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ncJfoC+FPp5nhMYxI8NjI9FoMSBZiX6Y5uGJXsHvipE=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787727322; v=1; x=1788332122;
 b=VGHNyu09+t5yBpZzkaJWW1iM7VFOi/ZgnQUxa3PQjqs2XvAuXVOnzEu05C5pa8agZiexM5/9
 mdzhn/CrmlcFatpfNxP6/Xq4IfYe3EZqcRtyMvoJdwzjS0rzP0lAvkVwlmWCr+XgU56xk8aX4+M
 URPt2IJKLGYjFNWHnKt70CezL/nTBK3SfDb/7NCaOaUnqIzvu/BG2QUJM0gsWWmqwylOrpUkseW
 /jn03Y7r4Q+8iOdUdrbjwMmwMF/hZvXVtbju8kKkmDmC44gsDvu/xavtT+s1SMKruFXkkZ8q89b
 NvTWT+pgeLwKlf/s/XgTlxLM2K5gmEb87oV+QrE+sdWYw==
X-Envelope-To: git@vger.kernel.org
Received: from localhost (117.176.242.37)
	by smtp.migadu.com with ESMTPS id e3aaeefc2ca7b9d0;
	Wed, 26 Aug 2026 06:55:20 +0000
X-Mizu-Trace-ID: e3aaeefc2ca7b9d0
X-Migadu-Flow: FLOW_OUT
Date: Wed, 26 Aug 2026 14:55:12 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] gitk: discourage AI contributions
Message-ID: <ao6N0O2wmPgXwM9n@wyuan.org>
References: <b4ce8b09-5faa-4e6e-af38-5384a71ae699@kdbg.org>
 <aorxVo_6_U1ceaKm@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aorxVo_6_U1ceaKm@wyuan.org>

On Sun, Aug 23, 2026 at 09:10:54PM +0800, Weijie Yuan wrote:
> [+cc Johannes Schindelin]

Please directly ignore my previous reply. Sorry for the noise.

Thanks.

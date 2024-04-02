Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF01F5FA
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089865; cv=none; b=ZQ+J7f/IqR5YXKtjhiFnlPW9lU2fSzdBO9UQ0dCo/Sy28JY//tqBIdoyFlTvk5u16ejzRhGU60S0oubmppOFdbW+rYnrBa8Z5beKObkfAzbaA9oGTvpMUaysJqeQMLTrZ8FIAkH2nGD11lenW2oTa4h+sN+uyUWfguh1xeFGuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089865; c=relaxed/simple;
	bh=5bBSdEleiwxZ6GWAnyGZ457QxDXK7wz6HV2ZDwItNYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pajdWU4lvb0FD9E5SOPMSKnHtUH2pigLxPLcOHXHPcKD1EQgV3ubT0alkNwB+hEH3ys3qnHawayVMzOt/LGxjdOA54rhXFRut/W1ISzE4Y1FTcfKi22TvY7KzNQS7Hh5WPKLpnMur+sTJR+VqfpxVwxELbQhrfLUktTBSo5705M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7386 invoked by uid 109); 2 Apr 2024 20:31:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Apr 2024 20:31:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1373 invoked by uid 111); 2 Apr 2024 20:31:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 16:31:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 16:31:01 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org, 'Daniel Stenberg' <daniel@haxx.se>
Subject: Re: [PATCH 0/2] git+curl 8.7.0 workaround
Message-ID: <20240402203101.GD875182@coredump.intra.peff.net>
References: <20240330000212.GA1261238@coredump.intra.peff.net>
 <2n7sn76-p413-5632-4o2s-o5n2p1rqnr5@unkk.fr>
 <20240402200254.GA874754@coredump.intra.peff.net>
 <08c401da853b$6c0b8570$44229050$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08c401da853b$6c0b8570$44229050$@nexbridge.com>

On Tue, Apr 02, 2024 at 04:21:56PM -0400, rsbecker@nexbridge.com wrote:

> Do we have an ETA for this fix? That or do we know when curl is
> planning on resolving this?

The fix is in curl's master branch already. According to their
docs/RELEASE-PROCEDURE.md, the next release would be May 22. But Daniel
is the more authoritative word. ;)

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732979D0
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089557; cv=none; b=fQ0MQGJkXxiuCZtdSfgo8QKmqnJ+H+PSygTtsmNRsDLQubc1QGdL5aQRKJVVax62rAYf61Au685QajRVaYB70N3MJO2mRhA1Bc1Pdp8TKiAbr/qKfSdO1rA9HUS7+SrumiJ/uiAIG+Onb/R79QbiWcPhYtRB/koXfBopBs2g2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089557; c=relaxed/simple;
	bh=wL+SLSm66gDF33In68Idkx1QwToUPqL1k+Xtiz6yPsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UILHbYDWY3Ar2sw5+gDX1PRhsDkFMfqxHnczQ+0YMHuzOpqQdhAsM0OuNK7ZrUOhDhosvvCK5FP7JSx/NjGz0LTNtyVcgxgceS+VO3US2Piskdtun480luxwiM0+V2Y1frMl5QU9SgLSql8hfiK68rKz+o/5YXRp4//Ys3ARN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4379 invoked by uid 109); 22 Mar 2024 06:39:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Mar 2024 06:39:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4624 invoked by uid 111); 22 Mar 2024 06:39:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Mar 2024 02:39:12 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Mar 2024 02:39:07 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
Message-ID: <20240322063907.GA11682@coredump.intra.peff.net>
References: <20240320091748.GA2444639@coredump.intra.peff.net>
 <519698f1-1daf-4085-9aec-380f44492e72@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <519698f1-1daf-4085-9aec-380f44492e72@gmail.com>

On Thu, Mar 21, 2024 at 11:28:01AM +0100, Jean-Noël Avila wrote:

> > -'option deepen-relative {'true'|'false'}::
> > +'option deepen-relative' {'true'|'false'}::
> >  	Deepens the history of a shallow repository relative to
> >  	current boundary. Only valid when used with "option depth".
> 
> The syntax for describing alternatives is specified as (true|false).
> 
> Also, in my reworks of syntax, I chose to remove all formatting from the
> term parts of the description lists.

I don't have an opinion on the typesetting of true/false here, but this
does match the rest of the document. If you have another series fixing
them all up, I'm happy if it overrides this patch (as long as the
rendering error is fixed one way or the other).

-Peff

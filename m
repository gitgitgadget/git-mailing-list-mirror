Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0C64A8D
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324846; cv=none; b=EjXP3r6yyz0DSo2MQnWyz4FwQnoXoVVfgAuHhPM2l7ojCtuOiqtgr7MJ36ihzURWqeCaDQuxFECa1Tqv+lfO76FYjT9CQx5kUxAvUNKzgIY3fi5Ox/Tu7BZio3da+wnvqzPVedgZD+gE3OJdYLsjlKVwyOZtTXKinliDH/tklJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324846; c=relaxed/simple;
	bh=S7/tWfE/sOw2G9uTYW8E/9ShDv0o8xculLuzq70bU7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEq7NjpRuWBKrbXEigEAKs1cbe2D75GBIVzwVWMe4zVIwQcpMGlJmxJJfJkADt4Inwp8Jsi2obks/qb9iCdKHsZoHbu/TrY9ZTmTRKdeSmyynlvoFvdBy6e9V7Bbl1e4WCC6bGdYG3imMpzaZxtr3trQ/b6KPWkuDq1W+hmLUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fmliqXia; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fmliqXia"
Received: (qmail 50799 invoked by uid 106); 25 Sep 2026 08:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S7/tWfE/sOw2G9uTYW8E/9ShDv0o8xculLuzq70bU7c=; b=fmliqXiaLarP2JXg5jrJhSzP2LUSF7JNunWv0zRLYrFivb5p3lzxAJmbgMgpCMMmAP+8i3ib6TwE5vKSlimYSq2t1DCgE0ltj3Ttx/tfGdr/SAi5xyBli1nTT8CxGpcPfSuXpk3xSzmcJ9gNNpb/fMHcKUjEw1fnFIE3xdqNQAABXaRB2h7NAfvOtVrpfysYMOZsSEqLK06wJluOuFlCiU/ROtHOs1ZvJAHKO+tMZPvipVqlPm7F3XC6R+HBcCDJk08OK0BNzoIndCARFmTYXEbojL3y6Txdsrw2/XEzpNbgF1hR/zIpX7+jK9xUFWNVtrwhl4ql/3weXvauvEc3ag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2026 08:27:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 202804 invoked by uid 111); 25 Sep 2026 08:27:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2026 04:27:24 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Sep 2026 04:27:23 -0400
From: Jeff King <peff@peff.net>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: add more AsciiDoc cross-references
Message-ID: <20260925082723.GB1493716@coredump.intra.peff.net>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>

On Fri, Sep 25, 2026 at 12:52:26AM +0000, Julia Evans via GitGitGadget wrote:

>     This version rewrites the commit message to be more accurate. The
>     original message said that the problem was to do with included pages
>     which wasn't true.

Thanks, it looks good to me.

-Peff

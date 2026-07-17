Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60633E348
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304812; cv=none; b=EDSGodrPbc8m4tBRbHSg2pmJLpADRZTCkUUsk4fGvzegBYJ6GRpVnZNR8V9xohYvolF45Wn7lJpc9QU5LsHnIl98/Ouzuu618WdBKisiuk4zKH0sox3CbAvT3eHmpij2nRdSVC/F8Q1kj90NUOuKP00+uquDiHX3bwautrk5l+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304812; c=relaxed/simple;
	bh=SjJAxSee1YEZaE/cgXwIlbUEgPSBNTLuOjg3UgJnhmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWHLeEwlL/Pc6so1OI3kb4+1HzdGtN6IBqj7jr0vdOWSktMpNaymkGmGl9HxiEN3SOWRA7rmgwQr1Xf+PJEEVlC0mGzLPZZy+tN3quFlvolr7Y29bEEuIdzEQPPxggRu/g9Vhz92L+VyB1tpK/6063GfBUs6A/BomRwdy2gPv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=QNDPMEx+; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="QNDPMEx+"
Date: Sat, 18 Jul 2026 00:12:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1784304800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Odmhkgr8ScQRVPi0uN0U19Pf5E1STyuBra9oNPmYmTo=;
	b=QNDPMEx+V7BwB7MAjsB1vQr86XYPjIPDUOHncEoKtiyQhwfeRFs0RtQkCgCHSxkWBiKwjb
	ndrcqTCA3F+WMPtlnlaecEGVvabKKwJ1g0v3EqoubS4HohrcCd1+G15avQw++Mc6MrQSPF
	5afo/qFFNL3sHMR+hF6NbU6QcFEe6DnRwtzbh1+UYlmpNguiDfct/8YLk+XLx55PZrWZs8
	imRy2r3Fti/JGmbZd2r5OvhuOWFRT+cO0b5Nqws9+i5q6vJu7WThUsS3pXEPYN0pdK4+FM
	4IrjN+qkX8V1BX2RTJ3B/5YIg1hDlAMXn7FgKjcYRc/KEbL9MY3D9HeXYyrDUg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Randy Kroeger <kroegerr@cseasy.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Please provide help with how to fix
Message-ID: <alpUg89NbGWijZCe@wyuan.org>
References: <BY5PR06MB6548F18EA532E3EF021AA93DBAC72@BY5PR06MB6548.namprd06.prod.outlook.com>
 <CALnO6CDGkAzu4Xz2o=VaCfwsF1WEcBw2k3-JqmkGqj1+ZpRQyA@mail.gmail.com>
 <BY5PR06MB6548A6BD9BFC90367098FC6EBAC62@BY5PR06MB6548.namprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR06MB6548A6BD9BFC90367098FC6EBAC62@BY5PR06MB6548.namprd06.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 17, 2026 at 03:40:56PM +0000, Randy Kroeger wrote:
> HI Ben,
> 
> I have been a software developer for 30 years and in the last seven,
> have been an independent contractor.  Trust me.  You read too much
> into my intro in giving advice.   However, I can offer advice when it
> comes to emails in the old fashioned text format, please avoid
> interleaving your responses.   Depending on the device today, it is as
> confusing as what you mentioned my diagram being... haha...  

Hi Randy,

I highly respect your experience. But interleaving is how Git operates,
and it surely includes the Linux kernel as well.

There are many online resources explaining this. Here's one, please take
a look ;-)

  https://useplaintext.email/#etiquette

And by the way, you didn't wrap your text. This is another established
rule that has become conventional over time.

Thanks.

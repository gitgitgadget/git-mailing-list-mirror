Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1F2F0661
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712274; cv=none; b=aduPDdxj3QhvMjxK/+LPNdhAhCbU9NgzM8LTREwTITkYrNbkXHiHjM04a+VdE4XJyMsqATLsxE4OIVmfAuWrNRMra6RLbCD/s1xdix+VVxLWLg4KV7fgHE8LL5hkiQhs/FLvlu9VQAAVtq/+c4rvIB/flc88F5Rsxp8J9mx29/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712274; c=relaxed/simple;
	bh=KwBaGbc7/6+epohG65MRg+Vex0ZOVQ4TLnk1PD6KdPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyBErMnvdN+kQHVRbClHDQMQI/w0ysu8Dl8YMco6KoHW7U7WPnDvQtI3yyidoYk8pYdc/+tYb0RPon85BTR/XkkX5p+fHGWhO/veKDCqLyHTn/pjOFlvidHsEtsxdU6fVFjGqQQsjpK01yFB2G9jaOiKu44kdmNZP/MyuOOOpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=qXN5abgw; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="qXN5abgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770712248; x=1771317048; i=tboegi@web.de;
	bh=KwBaGbc7/6+epohG65MRg+Vex0ZOVQ4TLnk1PD6KdPA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qXN5abgwN0KNCJXaTQPfa29bKilc1Xggtnfqol2WsjkIJMOAimi1Hou/vrnJgAQt
	 cegRUMreYk5J1lvummdD0Y4DFWOggPt0z1mrY8CNNJqHXRvZI9POLZP4vBwU2i+HG
	 iX7k1MtouXIJFmHnJ+s0o84E/m5IGFzuxDqBK8O4F3PZQ9f8DJgzthXcLmZYlif6z
	 SJR4o4dFjMxzoZ8yE++jdu6MSEFEJcBn8O+yOeO4cTsn83Mfa0gS5kPB5ZdJCY4jZ
	 rd/H+0MY/XT0HmlR+Kt1w5QOJOX6WSu/JVtulx2RYHa3Q9FWw2h96EtTlW5R6PGJE
	 FeWJhWxWrYkpcrYg8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO9K-1vGOKG2XCa-00lXgw; Tue, 10
 Feb 2026 09:30:48 +0100
Date: Tue, 10 Feb 2026 09:30:47 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v1] alias: support UTF-8 characters via subsection syntax
Message-ID: <20260210083047.GA23958@tb-raspi4>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260209220115.461109-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209220115.461109-1-jonatan@jontes.page>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:vkt/oPiX1rWSkCeNbjno2VBrsI97IoGex4+F3OECR56+q3lrqLI
 Nt9GuPrxRBCipJ1azOrEM32Xrupr0/y2UXi1jgDPDV15jwWu2DT4rMOiZWY4TlD7pKn7r+O
 ILqppnhYoCHCND9QR301a+ExzGhfqFVXCkxzdKJW6ZIlPUaHZHl1wpoQ1sLCkXri3YW1ejM
 VqcQrhHglbsTkhjMIaMhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aFHfT9lGBVU=;d+Tpi9gZ0Ne4yHHd1thB1AYpVnV
 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

[]
Thanks for working on this.
Trying to review it: Is there a chance to split it into
2 workpackages/commits/ ?

For me it seems as if the introduction of the new subsection is
one big thing. With documentation, code review, tests.

And handling UTF-8 is another big thing, opening questions like
Do we need to set a locale ?
Does mingw handle UTF-8 on the command line, or why is it exlcuded ?

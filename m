Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7B39B95B
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410176; cv=pass; b=Qp9QeEOgo6S1bgorUi8vtfpfpTOxb31sctdowEXOQU85svn+xzGzhmFXiorfTv/2iOpJCzT8CdN544aJ7KTMSxy0QiqI+QCCHzRb38F8ZyJdIeGu/ISnHLVprEwwOQxtHHX/vHn+hJ+hsiIAxoT0JyxdlT0E7SJUu2lKujOZaAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410176; c=relaxed/simple;
	bh=uPTFQspQdAzoYGEdXqa3r5vUpi7AMJc42Sg7j42eWss=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=d9Q4Mcu1hcu/asEKawedemC/fCJsw2JEBpAvZ5p5mgV1HAV3cNafJdQd/v4PbFwD4dYxtQpProxdvjiwpAkLaP8MlsxaxLlkR7B6n63nRvGeHRb3okAu7+zAGDTW2lZgzUdWSVUiUQD3Pd2OPETaOvhgQq21EjYdVfyC34f41mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
ARC-Seal: i=1; a=rsa-sha256; t=1773410168; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jJU7xMkcJSvdeGUKkh6sTGBSeOPNmUWYUDeAzQvUOYeR8m/Jzrc1iayazSy4OVGoDrp9cCBsLQYBa15Q6M4kSXG/pTl+4KNwY8vI0+PBwaEwMlZGvsa9Rnte5vp0k9L1uh8Wle3WSf+16xpKQndOXmPvP/LtSHfNFG8xUvnpUqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773410168; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uPTFQspQdAzoYGEdXqa3r5vUpi7AMJc42Sg7j42eWss=; 
	b=jrq+ov8kPDZ0p9M2FF9N/uLjSBsYavsUpZXqy13VMBamlEbJhnEF/MhPKAnc7LJmcR208zfM4fejGCFSfC2Syh9VCFHlJfqiemFyYmYO7/Q8Lre6JDxDhnt2oR91RdHywx7SWOP3ZJwBqHrKqal1BNYqANy/YssuNHmmh7Xq3JI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
Received: by mx.zohomail.com with SMTPS id 1773410167061615.8942063233083;
	Fri, 13 Mar 2026 06:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 09:56:04 -0400
Message-Id: <DH1PFQMH1ARY.3M5EECQAPU95@ritovision.com>
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 <git@vger.kernel.org>
From: "Rito Rhymes" <rito@ritovision.com>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>, "Rito Rhymes"
 <rito@ritovision.com>
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
X-Mailer: aerc 0.21.0
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
 <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
 <20260313-adventurous-lemon-unicorn-278ccc@lemur>
In-Reply-To: <20260313-adventurous-lemon-unicorn-278ccc@lemur>
X-ZohoMailClient: External

Yikes! I'll have to take a look at that.

I just sent the first patch series.

I also have a follow-up patch ready that adds a clean mobile nav header
to complete the UI, if the first series merges.

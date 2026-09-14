Received: from mta0.migadu.com (out-56.mta0.migadu.com [91.218.175.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE837F32F
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 05:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364936; cv=none; b=tjb69kWSQIeWznz/vvGjMY021geiUpaKHHVfkDTtySAnJbBHvlyO9otlBWaWCkKieA/Ul8s/7E5eH+7rZ/YLgtIcBlErfnXJ3Jmr2NM8PALD5e6gnecnNqeGWjrm3zJbi6P1iyboU8WLTWSsZLBVcv3xafkLpJMm6MSdAm45n+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364936; c=relaxed/simple;
	bh=CK2M0LvO6dulsGlrTtSrtH+OuQcBdSwhCw8FK00bdtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWcDKuXAVVXcyYlFj9t77COF/hb8byYYlykajyR82ZssicJfwSYBxHeQgcbCPIzrmPuFP4O4tJCC66rAl9iW803cPMCOdyM1o8EndFUUmQK6hKfCBPv2S0823yXlAmnAwaX1XTfJX87XCkT51AGcDTAEzki1w04LVAAeCweoT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=Lk5Ze6X1; arc=none smtp.client-ip=91.218.175.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="Lk5Ze6X1"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CK2M0LvO6dulsGlrTtSrtH+OuQcBdSwhCw8FK00bdtA=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789364931; v=1; x=1789969731;
 b=Lk5Ze6X1dlaz/eG6Qw7ExmtU8CWlhDcCD517mxS9IZlE33nlh/GKtuATLadTwIk0TH2cFRVT
 rD+7MivL3B5YTjn0Yo57bFa7PvW7ADZ31ptWq0Cc88/nH/nLAySu+nlcUCu4EBqYAxWMk8t7QTI
 rnpvlfQ2QWfgdHi7E27TOtCo9IB2lezw4AEDHyVMbj9MqYwQlyRrd3C710t+eB+7WsR8WnPQymH
 VfgQny1d6iddisBWRT4UuUt6fOMMAH5qu61er+Sqr4Smj81BSFly3+N9iA3l9B7DF1dy8BW9+NW
 xJlZPheOt2eqIrML/vh/GcEy7RTe1e5ePok4y0mhae87Q==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fe13e396e00eeed1;
	Mon, 14 Sep 2026 05:48:40 +0000
X-Mizu-Trace-ID: fe13e396e00eeed1
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 13:48:32 +0800
From: Weijie Yuan <wy@wyuan.org>
To: 15935225213 <15935225213@163.com>
Cc: git@vger.kernel.org
Subject: Re: =?utf-8?B?5Zue5aSN77yaUmU6IOWbnuWkjQ==?=
 =?utf-8?B?77yaUmU6IGdpdOWuieijheaKpemUmQ==?=
Message-ID: <aqeKsMxMqdWiCecS@wyuan.org>
References: <abe5f52.3f36.1a09e09e7c8.Coremail.15935225213@163.com>
 <aqd_pkajmGGNPxnb@wyuan.org>
 <6f88fc6.92c3.1a09e4d1b91.Coremail.15935225213@163.com>
 <aqeBi4qFurY9Pfww@wyuan.org>
 <649ce454.9429.1a09e540c00.Coremail.15935225213@163.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <649ce454.9429.1a09e540c00.Coremail.15935225213@163.com>

On Mon, Sep 14, 2026 at 01:11:43PM +0800, 15935225213 wrote:
> 我想知道解决办法

.. means: I want to know the solution.

---

Please click "Reply All"/"回复全部" to keep our discussion on the list.

Also, if possible, please use English.

The thing is I'm a just volunteer translator, I'm here to help you
clarify your situation, although your description of the problem is a
little brief.

Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02196332601
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362105; cv=none; b=IXJiDVL3PzfaiLhsfc67JENtJGXnglVzRP8ycqFf2yzeOcQYYmRhHZiuXA9up9/x7ifPMq7Cz2WxKtIs9rbbIvBbNzQAFqRGenYhRhqkacI/m8cfT3bkHIKqvRSe9JgjDz6zG2RMSE2O6LOgQsaI5yXv0j45p1F9HBGnbwZz8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362105; c=relaxed/simple;
	bh=msOldb2hnfef+uU2IdG0B5h//XSaPaiG52VXCXveKT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6INvaIw/loc+0mEtKPxeuHA0/Gt8xcSMyzJbPzJmktauUKXBP6+khHbC3zS0P3xvQww0b/yO1HYteLPd83qMjx+MVl6VWLoR2w0EYyTQRQWPdI2Vbiiv0+K8jqKWbwRkyvsXzgvl2XYDwg8Yn4AaI0mlOI+synP042hgN6bnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=eBCfNPaV; arc=none smtp.client-ip=91.218.175.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="eBCfNPaV"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=msOldb2hnfef+uU2IdG0B5h//XSaPaiG52VXCXveKT0=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789362100; v=1; x=1789966900;
 b=eBCfNPaVdDgX2EU6k5NHjWXyfTD7ylg0c1++gfP4fKKE441GtGettd8K5Mcp9qilMkjLL83d
 yG0VM4rDjANlChCOOsbdoTbW6/FW86TFMYgKQYUUq8Dsu7yGzlyPU53FEQ1207geW+HbmcISMxA
 e8FaJT2zQKcqobeLprz3b0GrzlzpdA0xyME6LzWhbj7txAmivkXYvxacnJzc4RQ9jEFMwPhzkNQ
 BpqQcgvcvzE4mL2V3x/l+XTNMN1dSUWiI3g7sY543ytZD8SvOuedsfVf0GWVxJaFE5ePPUi0t1j
 9ugnpboNJO8tWuoM5LK28+rD9W88yphlxkrc++XlrdT5A==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1948113763ba879a;
	Mon, 14 Sep 2026 05:01:30 +0000
X-Mizu-Trace-ID: 1948113763ba879a
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 13:01:26 +0800
From: Weijie Yuan <wy@wyuan.org>
To: 15935225213 <15935225213@163.com>
Cc: git@vger.kernel.org
Subject: Re: =?utf-8?B?Z2l05a6J6KOF5oql6ZSZ?=
Message-ID: <aqd_pkajmGGNPxnb@wyuan.org>
References: <abe5f52.3f36.1a09e09e7c8.Coremail.15935225213@163.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abe5f52.3f36.1a09e09e7c8.Coremail.15935225213@163.com>


On Mon, Sep 14, 2026 at 11:50:44AM +0800, 15935225213 wrote:
> 安装git 2.55.0.3版本报错 直接报错Runtime error 255 at 00D658B7,
> 请问一下是什么原因

... approximately means:

When installing version 2.55.0.3 of Git, an error occurred. The error
message was "Runtime error 255 at 00D658B7". I wonder what the cause of
this error is?

And, the image in the attachment shows a window, displaying "Error:
Runtime error 255 at 00D658B7"

---

I guess it's Git for Windows? I'm not sure if this is just a
Windows-related issue. If so, a better place to address it might be on
its GitHub issue page? Or you can use git-bugreport to provide more
information.

Thanks.

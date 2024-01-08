Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17B54BC7
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="F2POp6BU"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704736293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLTd2BDEtzdd6O96ZMmrKbPSzMishRdR/+IyurATH7k=;
	b=F2POp6BUDdPNmpZ4Tyat+0FXAtNZGcEWu5rPrVlckos7mITVZMcY8bZJOqhcBcEnTP8SA8
	oHh30sYnMZQ2qRNgvWEKdb69vEXdTw1UWbrnyxlb2bcFikjWLgTV9tjOcI1ccSCfuysF+R
	0M/qu/G+torQ4aQ1GocGXDjn9veyLM2AHHbK4beOGO9H9EXyMZYp60Ihpio3TdzLOe0ox9
	UNnKGPEJRXRuKRv3lIdsnKLp/UPyMdTtNBJxwk94568gfBdoqgTFKvRQ7p911IqBWZF4TO
	hTy626G8m3QCH4jJEjI8vImwhJDH5+S8wb9HqLbFto4KzbryYl9KxLzF8kiCLQ==
Date: Mon, 08 Jan 2024 18:51:32 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, j6t@kdbg.org
Subject: Re: [PATCH v6 0/1] mingw: give more details about unsafe directory's
In-Reply-To: <20240108173837.20480-1-soekkle@freenet.de>
References: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
 <20240108173837.20480-1-soekkle@freenet.de>
Message-ID: <c0604d0bb667e0ab872021eee2747e3e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-08 18:38, Sören Krecker wrote:
> I have processed the points raised.

If I may suggest, there's no need for a cover letter for a single patch. 
  If you want to include some notes in the patch submission, which aren't 
supposed to be part of the commit summary, you can do that in the patch 
itself.

> Sören Krecker (1):
>   mingw: give more details about unsafe directory's ownership
> 
>  compat/mingw.c | 70 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 13 deletions(-)
> 
> 
> base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa

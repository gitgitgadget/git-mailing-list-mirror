Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B0328B5B
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433150; cv=none; b=GXHSrw9OO8TmVa58D8FIvky5kjkstAwEjXT1+qLM1FRqR9GEqhm/2OqTXVe7cmSQ025FmqiSIMmQ1wWyIJLf7zX4AcL7wcgiZ6u9DyW263cooRYiHzENhu5TltwBhax4LSlvesxfkdXjQlCWcXVSHCSvJy4PAaU4FAOvKUEW4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433150; c=relaxed/simple;
	bh=/ziGy/15g8VX/z/Jwithx5NqaO51btjw8rxZAdn8Jcg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EwES9Dz6vD6/919o+GoWyApTj9IjR3TOeGcgHp25pklJt6Hy9Sy1B21YgV+OunEKrvtEcn+hs0DZuiSyVogQ22kdqiwuElr82W7Rw/HYAR4BGkczt5YbQDu4ICrHWw1Z7+ugiSwP/Ms50lrYavG6PHqa01V2ui/ZIuUXXe/M64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=2/+/cixQ; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="2/+/cixQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:
	References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UsaIY4Q8NaL8hbjF1iS8Q1mfMzNdb473cZQjZTxicyU=; b=2/+/cixQYLmMAWr0AxGLsaLf/i
	YDehlpNOf4rFtAXq//os5YIR9tcHHAlpOM0f4KoC4ZXXlrk2aFMQEDW304pVdQeKGN5A8F/0WgvsQ
	09ZszvdMjruct3m/YR01pwBkDPXtg+PXxbXvvYhnBQXtZoQTrciyZQTq+vGUogNCM94g7RbeztBBJ
	y96OrmnwSJaMPAGVWWQxmspwllJ/LiIlNTxGpEuO3th/V20jo8JYAiepANC9tMKys2GNkRlCNgMdT
	T/ozFPix2JexUexD+O3vM2An/+QNNCoCY//IVlr/VUBdNkdhGRpyBWyTSJDws9b2+GpikA5z/Ke7g
	Ql5G/UPQ==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50] helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <peter@softwolves.pp.se>)
	id 1vGzN1-000000017vh-31Fg;
	Thu, 06 Nov 2025 13:45:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 06 Nov 2025 13:45:37 +0100
From: Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs: Add missing space in message
In-Reply-To: <xmqqikfokrq0.fsf@gitster.g>
References: <a8220721-3260-15cb-6960-ca8b6433d7b5@softwolves.pp.se>
 <xmqqikfokrq0.fsf@gitster.g>
Message-ID: <2013e26e02fe07c1908ed8ce09359d57@softwolves.pp.se>
X-Sender: peter@softwolves.pp.se
Organization: /universe/earth/europe/norway/oslo
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: peter@softwolves.pp.se

2025-11-06 00:03 skrev Junio C Hamano:

> Good eyes.

They are easy to spot when doing the localization, as gettext only wraps 
the generated PO template at whitespace.

In case someone wants to spellcheck the user interface, I would 
recommend starting from the PO template (make po/git.pot).

-- 
\\// Peter - http://www.softwolves.pp.se/

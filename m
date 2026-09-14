Received: from mta0.migadu.com (out-218.mta0.migadu.com [91.218.175.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149337F01B
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365152; cv=none; b=Go1FKitI7FuiPVB689sYVcjTTI268oDgcVljvFyyrvDB52uCT3cKJ2X9Ll+dshn15rGHaUITfgdiapIqqPoKMCE0GlntWc/7ebLGphXm+LnmAJFzZOqgnE++5c3MPCD0M0TVfq2/w4U5NFXlrYULuzdT3fm0Fm8BL8FXk74CNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365152; c=relaxed/simple;
	bh=qSDjdmeYmIWtmPRgLGfbb7wNzHUPV+Zdett/bY0vx3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQULSGkOjvG09e1ZpUzL7AOJk28yWmKb1wlHFLq5HTPQ0zdSKcR4wN3XMppbuMco+xNEFTqZGpsHUGcR0OOIs4AQp3pOvHLsnLEqPBJNs/Ft6C2xPP6TUD2x+4dp6Nt8b/9el9p68FrwyZMN2IfzLgY8pheAuzXbiKrrox6EXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=wT+U0rdS; arc=none smtp.client-ip=91.218.175.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="wT+U0rdS"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qSDjdmeYmIWtmPRgLGfbb7wNzHUPV+Zdett/bY0vx3Q=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789365144; v=1; x=1789969944;
 b=wT+U0rdS5uqWvftceNzdzYJHVrLUefyBwolukhmrt++PJ7cJCTnMkg0g1vhQwp/qVg64HlhW
 n8dp4ikYOKutf3ZuHxV8TebOHPtBp7WrSoaw8MS0KPau5Eud4Pfr5t9B/e0Fcqz1JvXanlGVqLm
 VO4shQGBUUgO7kMbJqwBd8GwN1Gq1+VR3V+Mdu6xqrag+90YTCYJIFOWvatWydGHk4j76jmInaT
 bXO5anoCw0GLgx7Q3PJW0k0+WBUm2fCeOBFb5CKh48BjR7HSJv5XCSjDBW8xKtfByjUp6XSKj2f
 VJ0DjgLQwa5DMc2Y4WoNWehQtRk1ElW1+sWI7AmxYb7dg==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 027762fa50e63eb1;
	Mon, 14 Sep 2026 05:52:24 +0000
X-Mizu-Trace-ID: 027762fa50e63eb1
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 13:52:17 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: 15935225213 <15935225213@163.com>, git <git@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaUmU6IGdpdOWuiQ==?= =?utf-8?B?6KOF5oql6ZSZ?=
Message-ID: <aqeLkedxye4JTveJ@wyuan.org>
References: <abe5f52.3f36.1a09e09e7c8.Coremail.15935225213@163.com>
 <aqd_pkajmGGNPxnb@wyuan.org>
 <6f88fc6.92c3.1a09e4d1b91.Coremail.15935225213@163.com>
 <aqeBi4qFurY9Pfww@wyuan.org>
 <5C238277-7E0D-4F8B-8AAD-E881B9FBAC5C@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C238277-7E0D-4F8B-8AAD-E881B9FBAC5C@gmx.de>

On Mon, Sep 14, 2026 at 07:28:01AM +0200, Johannes Schindelin wrote:
> Please understand that I don't accept bug reports via private email.
> You may want to open an Issue on the repository instead.

Sorry about that. His bug report is on the list. But some discussions
are not because our reporter didn't know to click "Reply All".

Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017F2BD00C
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362589; cv=none; b=iXZDsDfFB+J9V/gTSJb1+5dU8b5HfHvD1KRufOluFt+M5wqPfcsv/HeVLDre0yq/v9LiuASe2AfMcjZDUHseBjtKBAhOWg8tW+oZjFXe05KXBfMbzB6oC1rGtn08Otb2Cv+Ctg6gP3kcsUchqsEumAtq/JtpK3QjWDbsb7T8+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362589; c=relaxed/simple;
	bh=LlVcnkrKZGxb5u3fRTx7O0ob9DaPzO4u/zIdkampXVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbKGkEXspP5+Vafgbx1rNVuV486mq+ECsfPbplg/zmh5iCN95ivgKN23IbZiM1sM0zKRaEOcg3bcpquuQ5knrsADK7pL8B2hufy37fg9ibO4sUbkMnfj02QuAmSuiR0Zo3OaalY8kbdNgEAKlNbmidaWcVc/6y5zMCY7OmkiQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=xUdyW1yC; arc=none smtp.client-ip=91.218.175.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="xUdyW1yC"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LlVcnkrKZGxb5u3fRTx7O0ob9DaPzO4u/zIdkampXVY=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789362584; v=1; x=1789967384;
 b=xUdyW1yCV5rN5esTts+w7CrK44TqEaC4pfbLMuubQr/3SZY/nB6fKSx09Xj0jYipKj/0dBO2
 ft846aJa1PSHwvFVa0411rv74TutIopxr+WqLYFmlu/z32mOM5XfPp+TFHcJlGJTLkhi+3rIJnz
 oQ5mAhE9tRYDG4+bqueK8ftkXwTIZs4vYqieUMNkE5l/nlpHoZRvsctT/p/QqUa+UdgZ4M8IXSF
 1xdbbVhvR7Nddm4zk/So1ryMv7puC+o+v8S+8AnibgLLBbuGnGiodU6uUedaBCi2AKsvjH3/l0g
 0g3bDPbigIwvpAYHzzuOKUfatAj8NJH4/s79lpNqSepxA==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a347d1cca9ce4fa9;
	Mon, 14 Sep 2026 05:09:34 +0000
X-Mizu-Trace-ID: a347d1cca9ce4fa9
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 13:09:31 +0800
From: Weijie Yuan <wy@wyuan.org>
To: 15935225213 <15935225213@163.com>
Cc: git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: =?utf-8?B?5Zue5aSN77yaUmU6IGdpdOWuiQ==?= =?utf-8?B?6KOF5oql6ZSZ?=
Message-ID: <aqeBi4qFurY9Pfww@wyuan.org>
References: <abe5f52.3f36.1a09e09e7c8.Coremail.15935225213@163.com>
 <aqd_pkajmGGNPxnb@wyuan.org>
 <6f88fc6.92c3.1a09e4d1b91.Coremail.15935225213@163.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f88fc6.92c3.1a09e4d1b91.Coremail.15935225213@163.com>

On Mon, Sep 14, 2026 at 01:04:08PM +0800, 15935225213 wrote:
> git安装不上也能使用这个命令吗

Oops, I don't know. But I guess you can not. Sorry for the useless info,
as I actually didn't use it before.

Hmm, should I Cc Johannes? Then I'm sorry to disturb you. :)

Thanks!

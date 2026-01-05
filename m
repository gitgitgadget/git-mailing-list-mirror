Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08102F25FD
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607841; cv=none; b=mxtkItpUuqU69aCP8f1kdvcq5r+aTOQN6nIzE7Pz5iUqxq1mwyW4Mdz8Vx89Z2hOvFBppwD1Ey6wSTYI7s9JCGFQnYL6HP1HpYTNHtYq3U1W143Xy+AjhBOuDnMIWAaDxYz7r/ZHIBM0UnkX5FFEGObgX3FUYmdwoLHOoiJnNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607841; c=relaxed/simple;
	bh=5eJS0zY9xgpWsb9p7gkqoeoDk5QhZj2nwviuspUu2BE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YYGKVk4Pua0OEye7tNr+8IotoKttu+G8UON9+fuXFEdniWaHGAirXTFR5XX24/vWhxJD1PE+Bl6tV6JUXuJeRUrmdNW1M9RJrf9ZhNe38oVp9BZfHFTKb9L+Q1a1R5E3k62eaVNLiDeAXDqZXx9mOFjXkOYyW4EUihHbNFC+Jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=VTnyos9Y; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="VTnyos9Y"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 706C74D203
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 11:01:16 +0100 (CET)
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 0089B5FFC0;
	Mon,  5 Jan 2026 11:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1767607269;
	bh=5eJS0zY9xgpWsb9p7gkqoeoDk5QhZj2nwviuspUu2BE=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To:From;
	b=VTnyos9YFpdJmxsiW5j6kx0dvuLu0QH9DSMl/9HnSvw2f/Lb/IlGBeoTW2JVAK3yH
	 4EyxiHtwbsnCvIz/BfTWGDhpJGeX1Mum4MQxMvoiqXUohshzxnvs6oJMZ6tUrmu+fY
	 aoHlePSiBJLUQxxyicGc6yFKAmmcKhZfC7nmb4I/jRgGGLWzTBFnScf0WyPX2virMd
	 /4dOe5b4E9rxhs13lpEeTFJvENfQDi3+TcuZcn7Pdk6TkkM+AN4N5+U6BmkWaopNPh
	 79ahbGriC3oeOmrhR4G01ndytvKNhV4JZEE0mXcyPOEUgI/XCv01/N5SORZ9Q/msdC
	 69wWKpDz/PCkw==
Message-ID: <eaf31f3d-83ab-4afc-8b78-0d017de6b580@free.fr>
Date: Mon, 5 Jan 2026 11:01:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@michael.lyo.nz
Cc: git@vger.kernel.org
References: <2076768.usQuhbGJ8B@debian-mbp>
Subject: Re: Documentation options: Code or not?
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <2076768.usQuhbGJ8B@debian-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The process of converting all the manpages to the `synopsis` style

is ongoing.

The aim is to use the "smart" synopsis format (using backticks for

 inline code), for which a parser makes the special formatting for

 keywords, placeholders and grammatical marks.


I took the path of converting the pages in the order of appearance

on git-scm.com.

For a good idea of the final rendering, you can check git-commit or

git-add. I'm always open to a helping hand in this task, with enough

communication to not duplicate work. To be honest, the conversion process

is far from being completely formalized, so you may need a couple

iterations before the rules are completely clear.


Let me know if you are interested.


JN



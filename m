Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA416234984
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765546095; cv=none; b=YziiL3Adsjw1RxlbCpmiWQM0QZkPn2DBIUm3ODXRpgD+k4n+r+z8HdRn1Jv0/XTwTwXm6X0eXDHcs2mwHUfaEpcVzDaPlOheno1rnjb4aHd32+cm3gY0eAz66e30byjMWnOvAw/PCFUArrPXT+lobfQlvyCLjSZsqMpNspK+RtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765546095; c=relaxed/simple;
	bh=gsj6bWC7RIsCnKZoK3grRYIDaFeuwW9NYxwb5l+QwcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iZrOfbkdC1nysZLTlznRCnOepPwdOTyps+ftyVGg0P6fLLVSlpccgbQnvROlQtvs477tur3o4tFkAQalsGWcvav2F7k8kgKtm64bj7F8rNZems8VCZa6/8lSaMHh4y7F7AMxRny8eyGkVzsoA4CuzSIpeOrvvaJK2TtvdDxxQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=NEokUM8M; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="NEokUM8M"
Received: from localhost ([47.65.176.65])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.1/8.17.1.9) with ESMTPSA id 5BCDS8Vw006033
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 12 Dec 2025 14:28:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1765546089; bh=gsj6bWC7RIsCnKZoK3grRYIDaFeuwW9NYxwb5l+QwcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NEokUM8MW9kBR0LbYDr87AZXok9Wu4q3qfdmkNx6UyEs0dT/HBOorq1aHsk7KTVfC
	 1PKvaCzBYmydSdP8dhmeqcnAi3DMy9h2OJ9bnjAIan6BCEkMsJhi0MQwfyzacZSIjw
	 5bjFUMDw6RA7I40oKead6ukzNzIV00Ip9JDGDMEg=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Possible problem in --pretty=reference?
In-Reply-To: <ghfr9fbznh.fsf@gouders.net> (Dirk Gouders's message of "Fri, 12
	Dec 2025 14:25:22 +0100")
References: <ghfr9fbznh.fsf@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 12 Dec 2025 14:28:08 +0100
Message-ID: <ghbjk3bziv.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Please ignore the previous mail, seems I am overworked.

Sorry for the noise.

Dirk

Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D9176ADB
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735041360; cv=none; b=t2J0MhBZ+DMNhrScwurmOPRChwER8HbH7CGxPLdQqQTj/PWtSylt+R8wibxK9zb4XqVn6EDRB8WMVRDR1D8JUMkVY0gns4tSXNSzDe6TRQuda4xle9Xx2SQ5diXYnnTafJVefAl7htwrdcwxGXQjTA1HPTB8D30Q2Hft2kmg9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735041360; c=relaxed/simple;
	bh=vTSBedA6sVXGz4jn6FJOtTc/DPiJICRBWnQIJ0L8g5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=UsJXuxDmPBiu298delhV/2MXGtsg77vgnS6lYcOfxS3RHUjh1K14O6uFuE1H5KhpKTerEd0qEGBMDIovEqiqpwhHP/eAjasW3Cd8Z+8jkrR7vygdF9qJhPEHbWVdaodBsvCfjmh4HPhg15jKvXiIMDRWHDHpBaQAx6qPCayR2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4YHYHw5T4DzRnmF;
	Tue, 24 Dec 2024 12:55:56 +0100 (CET)
Message-ID: <edd2807e-4b2b-48d3-97e0-19b3a0dcab8f@kdbg.org>
Date: Tue, 24 Dec 2024 12:55:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Dec 2024, #08; Mon, 23)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
References: <xmqq8qs6yzbm.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <xmqq8qs6yzbm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.12.24 um 20:27 schrieb Junio C Hamano:
> Let's wait for git-gui, gitk, and possibly po/ and delay the tagging
> of the -rc1.

I've just sent a pull request for Git GUI to make the current master
better visible for translators. Gitk is already up-to-date.

I'll wait a week or so for translations to trickle in and then send
another round of pull requests. Is this a practical workflow?

-- Hannes


Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7D8BE2
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519035; cv=none; b=B0ysutukrA5d00lY5uyx71rNwHokqteIjAWeHz/8ao4wuVzPONlgAWn3QYd6IaTqXNFOLKVPyNXo4Z7VCl50ETJDD+SXDKgDxowF0M9JdVdQipP4naIdFMO5/SDn2ABNF19hEeywmgLu3DahrOlXMkfIY1v6kd2OyDR1pvCfd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519035; c=relaxed/simple;
	bh=KIA6JqdJ/K6xRVkaVly9EDWFWd5BhS5EmRWj/wUsQHM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KsYALb6dux/iX10rVJZcVs6GHm/nZHOwoqr03PgRY0tAcnad3iHX4z2OAakmp6R7NlKjIekHjnFDL4uAkH+qJAHUzndaqEyETtEhKbqC3Vj/ASLQFGl6C4Dsyx84GUspiqM1gW+ns00m/SwFnC7FN8qj5o4Nd0z0ZVlyJYHwp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UOIefF1l; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UOIefF1l"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713519027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIA6JqdJ/K6xRVkaVly9EDWFWd5BhS5EmRWj/wUsQHM=;
	b=UOIefF1lQERvvTGm1fwUDT3UqAop8HYcp7xp7Nf9P5YVeYGjB77t/OrX3pc3HLoe3ToVLW
	2WO0e/Ml8cQnrTCLOmezi2LqOwPwYaz9qq6H1RrYdAupSwtr+RrNOO4NL/igfbdY0ZOg8a
	v4il7MV7rTRmaVnkVGkz9QIV9l014Un1q6WgNDulosQFCD/zuXR3Uxh/dBwIszQBE9uAFw
	o+CbL9r2zCsokgMpV+Mg2FwhwfZsFmZkiGPAKSAu4J0G+ZpipRSI1VqnHhL3Xjt/X0Lxoi
	KYVS21BCd974RZ5GLTPA6dTibSivk242vH/lHW9o4nI+HZ6HaPDY9new0HMp/Q==
Date: Fri, 19 Apr 2024 11:30:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Drew DeVault <sir@cmpwn.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
 code@khaugsbakk.name, phillip.wood123@gmail.com, ps@pks.im
Subject: Re: [PATCH] format-patch: ensure that --rfc and -k are mutually
 exclusive
In-Reply-To: <D0NYZ4A0TV6M.CF19YB1PFRSB@cmpwn.com>
References: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
 <b4c6cbf5f3246ecd0cf27c7e87bf6dfc@manjaro.org>
 <D0NYZ4A0TV6M.CF19YB1PFRSB@cmpwn.com>
Message-ID: <37e983e1b272f2cce31821c03510f8aa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-19 10:51, Drew DeVault wrote:
> Reviewed-by: Drew DeVault <sir@cmpwn.com>

Thanks!

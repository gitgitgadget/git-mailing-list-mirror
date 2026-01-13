Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11805369961
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317758; cv=none; b=fuQ0KY/CZeuKWGtTVNGb9xFtaYrS491yn9raYvVJxCjMpYzTA24zWPcYeuvDCyaymByrbyVzhpvuR+zsjnNr1JVc0pE4z6bNNW2S8p/yvkQs0jXmdN0HrIPNYYmmqOKgvPD4INPCs2H2dk80ZGamn5kzvKZtoHyzdwOwKfOMvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317758; c=relaxed/simple;
	bh=o5lIBpKcfpuTtQ+thQ2YGhC5RlSvwMuaGIXoJiVFuZo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pirk7WFdk1DgNG97IJ2YMy4VyKs8OkQMpQurS0c7RDFhKHWWe3Zfo4jClt7qwqMxGJDKn6F4aRH03qGj3cOHj7aYdk9mTcKuZh40DzmtCoqO/Z7k0pvXh5xi1XQjWouaFki/owVW4vU2LuMyc+uGqjraVxcZpSUHAKci8PvZm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=k96tRIpK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="k96tRIpK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3arrCiVlda5LlrSnmnWMWpTHFzyuiVw0RCGqRNJOed4=; b=k96tRIpKUTU5AfPfwk+mw9Eq6U
	o/PWDVENwdCWmlm77rJLaCFk+pmCNze3diXi1i6FUWHxgwvnExVhFA1uULH3UBDRbi+I8ridGZ5su
	T5gJehEVYaiHIG5vx/utm4huruSfgzITWwA/f25xQzXTLHs/coWIq86/iSyPPbP30BnfoYFAZ7N1T
	0olLQND/SSqesuEFMl4rRm/TTpCe2hGiKKSiVvbk5AIVIOWIxIfItNh5M6rnA9ZU318kDDvQWuc1t
	bZR/XfMw2YglxbCDKAcK4EBptA6kaScpvc8lyAB7cjki0Cbpa96Zaoo37W4ENmMoVywU2AH6hh2aH
	tnqBEhwg==;
Received: from [91.117.234.156] (helo=[10.109.1.198])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vfgE3-004tfY-QB
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 16:22:31 +0100
Message-ID: <e2733434-f632-4be5-a9e0-28412b4043c4@igalia.com>
Date: Tue, 13 Jan 2026 16:22:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Manuel Rego Casasnovas <rego@igalia.com>
Subject: git shortlog --committer vs --committer=<pattern>
Autocrypt: addr=rego@igalia.com; keydata=
 xsDiBEYc4gQRBAD6S9aR6ogtR9ZiuMGGdbPSo68o2tZ4XvZ/1mSL88ESb0e8RBjRGJKB5yv5
 vBgYDwxAC5J1hbsKCviTfSjpGbfRvp6oq3+pG24YmRvMzPcNV9K7eg/WuNo4XE70kqjvHCCC
 7R09FW01sllZpzHcjmJC4wfT+OYWXW9uEGSpxuVA/wCgzFt15SPaNhd4YyQ/IerU0VMQsEED
 /1QeKwa+V2gS9n4p7h9DTLrKWR31WU+2BRnpVMwvAAQ3P2pAGSmndbJONmmlK4AO7u3Mzs0V
 roqnh0oggBXadIk0rsGA4ZEtFDV+p/YBqHW7iOPkfE9k4kTBQGMsBEEIyIeFuyCjILTZte2p
 9+J2VM8WTuAENG4+FtRZNuu9yDVzA/sHZc8SpjPId7Gke1522Vdy431PPWBJ2+ttqlGDBppf
 Y64MwuIfPfUTWjIJYIfkOij3nIe5BUk0nRpqKCWzC5aVup/G54lo1uakPM42vJZuJG0nw9Aa
 +6+ic29wzpTUpkIfvJUwPSGY+ucdaa/9SnUGRmTse8igO7o5TEUaWerKQs0oTWFudWVsIFJl
 Z28gQ2FzYXNub3ZhcyA8cmVnb0BpZ2FsaWEuY29tPsJiBBMRAgAiBQJNvpdkAhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRA/kOoZu/4XsbOrAJ9uFnRXSHNoXef9zeQ8U133QanF
 sQCfTsUj/b3FhSBblkHdScqgl8rybqXOwU0ERhziChAIAMGH0qEWBDxgLkJlVGC1suuBpPR+
 mg0r6Q9pGq7kPIbdLfhdBWrif8zFxxBlxeCkWmm5jNVxgjCUqdhjqcBP5iHQqrIWsiTTLylf
 9Ia5tIODlLKzdt5IR2fe60NAN5Rb03qFeAB3lZ6nHvlONtGUMX3ynN5li9P+xNlLrzNMeNL3
 GWzfghpQKwbPJ5lKVjIuEOpGQIB9rBkMyzIteW+onNGvijV79G6tsUc0rrdGrLI5Ye+Xh0L6
 QOWk2XjrOFPlZ2knSatM8H4Ruf4RWJA0twfdu4FIT5MVsbrtdnnsFhT0IIZWEVZJ4Tk0p4iE
 yztIh3uIBpAOTXH8ppY8fYeTiQ8AAwUH/il9ljhBJzf6rQL14yrr5fzgDELBd5tsxFWafWtt
 m81eYOjBALnzESVeGExZsRaCgQqpaQ7tjeWDmTuqVpTL+uz/zXc1Pfor4B/z4ketBJAmu5g4
 3dL6A5dN8BuLVvrHZ2/JWxEZx6b2na04UWi2Ay+gXexWrWo7GZHmXKAmF1g2i70/80Y/nrU8
 UhpVWE2/N0VbWW83vW4fC6mEKTeAKwWAr3sUHWwcJTYt0MYWhS2Sfv2J9nELxidEEw9jdjVo
 lpz4uQGHybr4tzO3K0X2Oj2ssG/rBnqNMH/MWjPxLWTGHmKgNhNvgIXsKjXyFjEnYTdu3GAZ
 PK0KmigjIO6vNeLCSQQYEQIACQUCRhziCgIbDAAKCRA/kOoZu/4XsceqAKClWYd6nQaNi4pe
 hcHuws05uNGSFwCgp44iSe1rXhLTsU07h6MTrQ1uQIc=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Doing something like this in a Git repository returns an error (git 
version 2.51.0):
$ git shortlog --committer=foo
error: option `committer' takes no value

However the option "--committer=<pattern>" is in the documentation:
https://git-scm.com/docs/git-shortlog#Documentation/git-shortlog.txt---committerpattern

But it seems to be in conflict with "--committer":
https://git-scm.com/docs/git-shortlog#Documentation/git-shortlog.txt---committer

It would be nice to either allow using "--committer=<pattern>" for 
shortlog, or if that's not possible fix the documentation.

Thanks,
   Rego


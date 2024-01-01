Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DA3C17
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="iJyxf5TB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1704108220;
	bh=lHTcUquGnOMHdftppa9Il7RQo02uR6IPhHGmhHca+wE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iJyxf5TB4l/cmYmA0+Un/zbQJfhN5ORNXRN3TxQVazBRu0PYCc8qJvkt0lxf6PMQL
	 6v/UZbzwN1FbnACz7haiMT9A7dJrDoM35KGRbwx1VAKu+pohZCjZNa8zxkynzDIUfc
	 +vWPkwvBGX8knpsE3c7LNYTV1dfiXYF+mjzO9fN3citDs2wta4yfvQdNg0bMbJuGnL
	 EpYEi48ilnR1gbi2PdI7Ug30c5+LTHqVla2T0JNmc4JqLVnL4g8J8Wmvwdw4DBmfHf
	 af2MLY9zjebv9UNazzlLaXgx3vfmntQxnjPGnnHURVo0A/vlSi44D6QSFw7DmBV2W9
	 45wDAerKy8e8g==
Received: from [192.168.42.22] (195-97-142-46.pool.kielnet.net [46.142.97.195])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id F091F3C0078;
	Mon,  1 Jan 2024 12:23:39 +0100 (CET)
Message-ID: <55620f4f-80f9-4e9a-8947-dce5d2a5113d@haller-berlin.de>
Date: Mon, 1 Jan 2024 12:23:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concurrent fetch commands
Content-Language: de-DE, en-US
To: Konstantin Tokarev <annulen@yandex.ru>
Cc: git@vger.kernel.org
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <20231231165042.1d934927@RedEyes>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <20231231165042.1d934927@RedEyes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

On 31.12.23 14:50, Konstantin Tokarev wrote:
> В Sun, 31 Dec 2023 14:30:05 +0100
> Stefan Haller <lists@haller-berlin.de> пишет:
> 
>> ... it is common for git clients to run git fetch
>> periodically in the background.
> 
> I think it's a really weird idea which makes a disservice both to human
> git users and git servers. IMO clients doing this should be fixed to
> avoid such behavior, at least by default.

I disagree pretty strongly. Users expect this, and I do find it very
convenient myself.

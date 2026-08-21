Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D093C1F22
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311114; cv=none; b=pW4ZHN0NLtMIDCqzIPrOWGH0t+NqPbFwFlXQCw+5/GJ0jUn0hFq0M3h+FeEOfJm2qsXToK3/vzSdKGiQ3ibfFxh/VWoRv/WxnFSxNaqu/1+4CWQSutMA6xAfFH3dfr8pO8PKVFkZIn2YyhtmJYBwq/uaskwwQI/4HNf7nQXsnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311114; c=relaxed/simple;
	bh=OzyWugHxaLQlNzzNNnLznTY5/+ZovlkYkhWDyxe0d18=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=d12bvKlvLNaaXkqJsdevM+LS3hW4NYQ6wxOF6GmJb6++USisZeGVJzoiJQATi5Hmo1pvY94vxFDOY9W1ChpoF0iEghxn1Xpp9g5dbNxPybjCJeNQnq/4Rd9ff9hW0bJCXLYP2qycHardU7sNWnBGtOGFBYp47BlTqtYuq9AbY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MYeV1-1xT0nq2JLX-00KW7Z for
 <git@vger.kernel.org>; Fri, 21 Aug 2026 13:13:13 +0200
Message-ID: <1c1567ec-c81a-45be-8b92-2c995dd34c16@anselmschueler.com>
Date: Fri, 21 Aug 2026 13:13:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Questions about --ext-diff
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kPvwcpRxWkCTwXGz2MV5Dm7ISes6E7WkXYGuc4HTR7n4DPM4RKR
 WKSG+zVJxpAcPHh64172pgtMtdjvktJqfXU3WZKjcrhbhMCaRshJEDkB6Z7wItWEaW0hWNT
 6IuILI21W/7Dud9BYWcCC0y3UgDiAwrwUaX9V4hwLmBFPBpUPTRRyNszYF8imLqG65mhHrP
 unaHsu+WtEsAKXvz+dCMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6jx8i65/xHI=;w6J09nKXGkaN6qSl9wC80kQRCy8
 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

I’m unsure what the purpose of --ext-diff is. It seems to me that custom 
diff filters should just always be executed.

Is --ext-diff a security feature? It seems like it isn’t, since git-diff 
will happily execute the diff filter.

Maybe I don’t correctly understand what a diff filter is intended to be 
used for. What situation would you want a diff filter to be run by 
git-diff, but not by e.g. git-show?

~Anselm Schüler <mail@anselmschueler.com>


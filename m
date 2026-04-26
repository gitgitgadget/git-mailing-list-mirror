Received: from www610.your-server.de (www610.your-server.de [162.55.254.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514C262FF8
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.254.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777186043; cv=none; b=D86MD3BjrdlADsdl/xVZrnSkeSFwjgDODBBz+NGRVG1mlh+BSyLR/bXL6otPqK6Cr1guRiEV8fc10imJHGFV4IRxDLyiYX1jc2vylauuwDWc5m3LIfo4F/GQYel15zFm2pe5h9pBXoVLuYQCT5xCZ3fURwd5qjh3FIySel/rpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777186043; c=relaxed/simple;
	bh=b5sqR1yeY18xxlRwTWAL1R6py7JT4Wg9CAyLPq/w3PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFbWtUva8bDGiFJszPM4oQvcvt287v4C94cpAwfo00tAYxW3Fy5TTf2d5IzS0tfZf7CcmecNjrWg+pGbMzmsVCFpVZwJJYiEkBDQq5/nZnJ5aAv03BF7HZ2bCLc1sDz2D7ejc+sIR9+24ycMIc3pRMsDs2Hc60WtRaVB98ir75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beniamino.eu; spf=pass smtp.mailfrom=beniamino.eu; dkim=pass (2048-bit key) header.d=beniamino.eu header.i=@beniamino.eu header.b=xAFPuT6c; arc=none smtp.client-ip=162.55.254.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beniamino.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beniamino.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beniamino.eu header.i=@beniamino.eu header.b="xAFPuT6c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=beniamino.eu; s=default2503; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kdfrqeg5fTfWI4Z90O7bzHbDEbU5JCpUNVChq5HiG0Y=; b=xAFPuT6cZbT0Z7gBj83tL8iNB8
	ofch+YYJ84Hb2kEyBbMuLbNFBqtGOUK2ss3uOM2gg0f/VP53fZNn5JPPVIe8xxl/pL5CzkIYK0eFd
	9f3Yc1s/NdhLdKq7FHApY8YjIuXz7jd7Rr2J++w2GEv7/JMv9mlnjX//qogNjgexUErWEJQAdKN5n
	jpFPxMr5QMgExDxMHfVqExWzxToBmAplzYeXGm7iZV26KoXuqhWqXz/GdNYwzoHajKN/Yu/iY5dex
	fO0psI6u91SIDOIIega9RIH72AuBIvvqb4Iia+YNd7WCTzlkHkJY+NEcG8eIfagWzbzKe7gHKmcl6
	qEIGmXiQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www610.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <m.beniamino@beniamino.eu>)
	id 1wGtGq-000GRH-1W;
	Sun, 26 Apr 2026 08:47:12 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.beniamino@beniamino.eu>)
	id 1wGtGI-0003wQ-2i;
	Sun, 26 Apr 2026 08:47:12 +0200
Message-ID: <d7ec16d9-2707-4c1c-ac64-ac3dde3e0946@beniamino.eu>
Date: Sun, 26 Apr 2026 08:47:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] l10n: it.po: fix italian usage messages alignment
To: Jiang Xin <worldhello.net@gmail.com>,
 Matteo Beniamino <beniamino@beniamino.eu>
Cc: git@vger.kernel.org,
 Alessandro Menti <alessandro.menti@alessandromenti.it>
References: <20260422182516.26667-1-beniamino@beniamino.eu>
 <20260422182516.26667-2-beniamino@beniamino.eu>
 <CANYiYbE1qTFYLEyhAR3SEyXozFnEMPxyj=3dAh-vmHkpXZnMpw@mail.gmail.com>
Content-Language: en-US
From: Matteo Beniamino <m.beniamino@beniamino.eu>
In-Reply-To: <CANYiYbE1qTFYLEyhAR3SEyXozFnEMPxyj=3dAh-vmHkpXZnMpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27982/Sat Apr 25 08:24:36 2026)

Thanks for your answer. The italian repository found in the TEAMS files
hasn't received an update for more than 5 years. I've opened a PR on the
git-l10n repo, but it doesn't pass all the checks due to many obsolete
entries.

Maybe Alessandro can shed some light on the current status of
the italian translation.

Also, notice that when creating a PR the default PR
message tells the user that the correct way to post a patch is via the
mailing list: I assume this behaviour is inherited by the main git repo, 
but still can be a bit misleading.

Thanks again for your work.

Il 26/04/26 05:01, Jiang Xin ha scritto:
> On Thu, Apr 23, 2026 at 2:25 AM Matteo Beniamino
> <beniamino@beniamino.eu> wrote:
>> 
>> Fixed a misalignment in the "usage:" and "   or:" lines in the
>> italian help messages.
>> 
>> Signed-off-by: Matteo Beniamino <beniamino@beniamino.eu> --- po/
>> it.po | 2 +- 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/po/it.po b/po/it.po index 20fd8bb28d..b5ccd8c731
>> 100644 --- a/po/it.po +++ b/po/it.po @@ -5400,7 +5400,7 @@ msgstr
>> "uso: %s" #: parse-options.c:915 #, c-format msgid "   or: %s" -
>> msgstr "  oppure: %s" +msgstr "  o: %s"
> 
> An example of the original English output for a command with
> multiple usage lines:
> 
> $ LC_ALL=C git checkout -h | head -2 usage: git checkout [<options>]
> <branch> or: git checkout [<options>] [<branch>] -- <file>...
> 
> The current Italian translation does not achieve colon alignment:
> 
> $ LC_ALL=it  git checkout -h | head -2 uso: git checkout [<opzioni>]
> <branch> oppure: git checkout [<opzioni>] [<branch>] -- <file>...
> 
> Your change fixes the alignment issue, producing the following
> output:
> 
> $ LC_ALL=it  git checkout -h | head -2 uso: git checkout [<opzioni>]
> <branch> o: git checkout [<opzioni>] [<branch>] -- <file>...
> 
> Another possible alignment solution for the Italian output would be:
> 
> $ LC_ALL=it  git checkout -h | head -2 uso: git checkout [<opzioni>]
> <branch> oppure: git checkout [<opzioni>] [<branch>] -- <file>...
> 
> Obviously, your solution is better, because for commands with only a 
> single usage line, such as "git clone -h", no leading spaces will be 
> shown — i.e., it displays "uso: ..." instead of "   uso: ...".
> 
> Git localization follows a GitHub-based workflow; please refer to
> the "po/README.md" file for details. This change can be submitted as
> a Pull Request to the "git-l10n/git-po" repository, and will be
> merged once the next Git localization window opens. If you have
> additional changes to the Italian translation, please refer to the
> "po/TEAMS file", contact the Italian localization leader Alessandro
> Menti, and submit a pull request to his repository.
> 
> -- Jiang Xin

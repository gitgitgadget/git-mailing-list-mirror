Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A382D8E
	for <git@vger.kernel.org>; Wed, 22 May 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375181; cv=none; b=mBhSoruTMqoftL2dnqnBKD2mhdVW1/S2m0gkfv/aTQEZrkteqbDkNVWocx+Kh2zAVKAuBj7v1h+RSF18tmt41v+3QHrTPUI0DAfmj0WsFURNWDkD+fFJSwPn8wbyv19A+y3XKiXJJW91R6H4J7eFWU/U1BDYDB1PHXQrHw6E1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375181; c=relaxed/simple;
	bh=TzUUnUDvAPnoIJyXCvoXPrEbJBBooAaSD/xFGzvLVVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGmdGRjHrp4Y9gLMYLvD6tO3lZMyv0Q7KQrJ87kFLIVEh3ARu7ACrzIXm5j4BLyD8Gm7VvZT1HFCV7l/IJQmL5iznd6clW27p6CE2jnI2jJ4XXM84O1gk5UkxkJFOVC3G09f0yijVamje+QGURejFS+CTaM2F5Yh++iQoFA0ftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 863 invoked from network); 22 May 2024 10:52:47 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 22 May 2024 10:52:47 -0000
Date: Wed, 22 May 2024 12:52:46 +0200
From: Marcel Telka <marcel@telka.sk>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] Switch grep from non-portable BRE to portable ERE
Message-ID: <Zk3OfqglVgPYlvXU@telcontar>
References: <ZkepnZhGEhSveN00@telcontar>
 <Zkw0ty8gOMS3Opzk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zkw0ty8gOMS3Opzk@tanuki>

On Tue, May 21, 2024 at 07:44:23AM +0200, Patrick Steinhardt wrote:
> On Fri, May 17, 2024 at 09:01:49PM +0200, Marcel Telka wrote:
> > This makes the grep usage fully POSIX compliant.  The ability to
> 
> Nit: we typically don't say "This commit", of which "This" is another
> version. Instead, we use imperative style as if instructing the code to
> change. Also, we typically first explain what the problem is before we
> say how we fix it.
> 
> I don't think this is worth a reroll though, it's only a hint for the
> next patch you may be sending :)
> 
> > enable ERE features in BRE using backslash is a GNU extension.
> > 
> > Signed-off-by: Marcel Telka <marcel@telka.sk>
> 
> It would have been nice if this thread was connected to the thread of
> your first version so that it's easier to follow the discussion, e.g. by
> using `--in-reply-to=` in git-send-email(1) or git-format-patch(1).

Thank you for hints.  Really appreciated.  This was my first attempt to
use the `git send-email` workflow so it is not surprising I missed the
--in-reply-to= option :-).


Best regards.

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+

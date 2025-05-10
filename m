Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239F219E4
	for <git@vger.kernel.org>; Sat, 10 May 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746881707; cv=none; b=Psz4RmUkwTXADlCTO19iFOheipob0ghZZRy8AygAZRQaF0++qTKqsj1rWwGA2nZQziHGVuO0rkoRDqQWwlYklmyB4pwb9WjG+sxNFi2RkllNs8ftSPdv9DtQ9p25TuF9jZitHSwNAOFKjPIfav6FQ6PtXjZiWGmtOxOyQ59UuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746881707; c=relaxed/simple;
	bh=uOGuWaNoLML77wTpMaoTWJdicf2PiEv/3v2ZH4TPKxs=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KX9hserzR2Qkp83ZlcYe9mRSfBaZ/rS8JyPiGbBbNgC2miLNGoKh0tru3NGq81fW42JdQlnJFF/ZHbhnok/63xvS7rGKYJm8TVBuUEER8bg8J0LecYvpE09mO93kOQosfzY0aRkF05OVvOK+KoOQKV7GbFpbFjiuvmLxanMD/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=QL9VVyyd; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="QL9VVyyd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:
	References:In-Reply-To:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JloAQNMu4SBJHWCTv51uM6vTiV36X/qAyW+YT9qxHX4=; b=QL9VVyydX7tGgRNdOmr5dDLcuY
	+85PoS87If2NjHtUC6n11rvQ0EJyOnTWhJnYJOs6kiFwnL8x3F0ApcKB82h2Ar/3Eh+ftUUgxdOFj
	DnGmChmTt2X+Jad8JnEt+mSw1ACAnCbnelbWML24D5Olxx0W6IwOxNz/yl1NhcUZdyYxwm9RBJexs
	pvIP9YxwTVZksW2mJDO2X0EOU/5S3aL96aUw8DobJ9sbU55wN1uFCrZn1v6wLYbrCQY4eiyZfittQ
	uTEmyVdHnWxRc/Kfcf3b96tQOpJDIf53VFjG2nPwJz0G5pBM12V+LQz+h+WfWO7RCSicQOcbpqCPk
	9PevryYQ==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50] helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1uDjLQ-000000080WV-1cgn
	for git@vger.kernel.org;
	Sat, 10 May 2025 14:30:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 10 May 2025 14:30:16 +0200
From: Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
Subject: Re: [PATCH 00/10] Spring cleanup of "contrib/"
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
Message-ID: <1a09f4cf68e9f4955aaaf2c58c7e7649@softwolves.pp.se>
X-Sender: peter@softwolves.pp.se
Organization: /universe/earth/europe/norway/oslo
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: peter@softwolves.pp.se

2025-05-06 16:12 skrev Patrick Steinhardt:

> Another subsequent step would be to split out some parts of "contrib/"
> to be hosted in their own hierarchy.

Author of contrib/fast-import/import-directories.perl here; I use this 
every now and then to import old tools I wrote back before I learned 
about version control (1990s, mostly).

The tool works as it is in the Git repository, but if there is interest 
in having it moved out of there, I can publish it somewhere else. I am a 
bit worried about the discoverability of the tools, though, but that can 
be fixed in documentation.

-- 
\\// Peter - http://www.softwolves.pp.se/

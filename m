Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F910547059
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748059; cv=none; b=O+vd5J6euY2IDu/4LdQJGU4nb6AU32DKyQUx20Lx9CluE34RCfgPBzjwHk1tow5ayddKK39yZRnBl7gOHELnm/JVF+EELc2QT2aQFKkGW/nFfBYxIke7T+v/UDLnwT10eVhjp7oR/cbNJC0jmuGUtmMb+vuQkd2XgE7YkjK+GLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748059; c=relaxed/simple;
	bh=jxNonLEphyBEyHzlfDXUolQDdW+1mA0ICQCuT34k6Ac=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hN/38uyCZsJwxvkeq33FP4KxEjvmHLM5rprY8fJj90j/nJ2VYQ/7Y0R1HOXAJan8uMtwakYgRaEY6KulVOie6rnBW04+hwpvTXGC+wvUCz4pjjp7H6x3iqcIzD7Ss9ampve2icmi/e8CnrOwA4JlfiNnbBNbzqQFca2mqtr/75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=aO/lTjns; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="aO/lTjns"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68U60dZg006555-68U60dZi006555
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 30 Sep 2026 09:00:39 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xBnMt-004bPN-Mj;
	Wed, 30 Sep 2026 09:00:39 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 09:00:39 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id f87f2257;
	Wed, 30 Sep 2026 06:00:38 +0000 (UTC)
Date: Wed, 30 Sep 2026 09:00:38 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
CC: <git@vger.kernel.org>, Julia Evans <julia@jvns.ca>, Junio C Hamano
	<gitster@pobox.com>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
Message-ID: <20260930060038.mY0JV%taahol@utu.fi>
In-Reply-To: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-06.utu.fi (130.232.247.46) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gCHQQBCSgCHgYbRgsJSFhI
 WkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhcSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhaWkgPARwPARwPCQwPDRwoDwUJAQRGCwcFSFhIWV9IDwEcGxwN
 GigYBwoHEEYLBwVIWEhZW0gCHQQBCSgCHgYbRgsJSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=ngLrUSyAZmUDPBxrDqJVEQswM4w/WGDNKwjCer+MbYQ=;
 b=aO/lTjnslHWhVVAHAnvAFnzUud4plovhTOAGBzPJetMQGaM5tKnP8czF9/h+WJaYG5YrSLLQxb+w
	tXgBaqm1kyPxSnWaCHbevQI9qegKD+/gi6anc4RmAmxSpEDGigKul2eZmLsLB69GN8UvuxTJHMcp
	FG/PASsKDS5ULCC3HUWBj6NSk/ubF12bDzHgccIgAw7kQIBeKbAASF+PRQmn3mRk1dIbDas6tF8J
	R+BB8UlyOzgzEHozT35EOtZ00qND/paZXkSe4GQ4mdj4vp/LRkh7+zYiXvwl2wf8paDjDHqKJO5D
	BbARDgl5ZspQBDhqjj1vEPntWg4J3YC8WukpNA==

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> wrote:

> This patch series removes gittutorial-2 and all references to it, leaving a
> stub behind to help out any users who might be looking for this
> documentation.
> 
> The goal is to remove obsolete documentation and make it easier to improve
> our tutorial material in the future.
> 

Thanks, that sounds great.

> I tested that the docs are staying internally consistent by running git grep
> tutorial-2 and making sure that the only remaining references are in the
> Makefiles, the document itself, and some example output in user-manual.adoc
> which isn't relevant to the actual manual.
> 
> Here's a pointer to a past discussion:
> 
> https://lore.kernel.org/git/7004c3b1-2100-4a90-9815-2a679ceb25b2@app.fastmail.com/T/#mf600063180d6239916e3fa6e9d33da86969547ec
> 
> Julia Evans (3):
>   [doc] Remove gittutorial-2
>   [doc] Remove references to gittutorial-2
>   [doc] Delete translations of gittutorial-2 description

Hmm, the normal format would be more like this:

	doc: remove gittutorial-2

Please note that the words in square brackets are dropped by git-am(1).  For
example, another patch series of yours is currently represented like this:

	$ git fetch https://github.com/gitster/git je/doc-merge-conflicts:je/doc-merge-conflicts 
	$ git shortlog origin/seen..je/doc-merge-conflicts 
	Julia Evans (7):
	      Add new gitmergeconflicts man page
	      git-merge: link to new merge conflicts guide
	      git-rebase: link to new merge conflicts guide
	      git-revert: link to new merge conflicts guide
	      git-cherry-pick: link to new merge conflicts guide
	      git-pull: link to new merge conflicts guide
	      ignore conflict markers in gitmergeconflicts.adoc

(And the fact that these are documentation patches is indeed something we would
like to preserve in the shortlog.)

--Tuomas

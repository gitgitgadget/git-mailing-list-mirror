Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C83B994F
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748936; cv=none; b=H8wglxZnyo+WALmSQJzK4Hx094mpJGcyDbZgvDMYgkPzaksBl3KTr+XFziz+UtlI3TnHKtTnAbsQ9O6xIUtVqBUpau0FGMjIqMT9t5M7/kzfODTnaNfX/z6NULxwn9dzL7zPj6UJ3UYo12+UwIfCr9oMNySHsTcdjNdVdPU9+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748936; c=relaxed/simple;
	bh=wit4Xk/9NzM7gOACl6jDqq67tHSdB0/Ue5GsEZb7kuY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRKM8PSGNS8zGDI63iphB1RBeUjgz5z0kafDhhjNuzPjpM/9SPydRQWkk1HtTKVwF5Y+asTo5VtMmGJjy1T35RPPlAcl20aWEKLIVNSv03XtNvEzPMpRPJD1ExozjAPShVNRsz0U+g5s/+gePWT4pOieXZr6ij8ZeSSGB4WGhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=bbesXqJd; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="bbesXqJd"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68U6FOJf022644-68U6FOJh022644
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 30 Sep 2026 09:15:24 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xBnbA-004dGt-MP;
	Wed, 30 Sep 2026 09:15:24 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 09:15:24 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 660b0d36;
	Wed, 30 Sep 2026 06:15:24 +0000 (UTC)
Date: Wed, 30 Sep 2026 09:15:24 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
Message-ID: <20260930061524.GNkIK%taahol@utu.fi>
In-Reply-To: <xmqq8q4jelvp.fsf@gitster.g>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <xmqqcxtven3u.fsf@gitster.g> <xmqq8q4jelvp.fsf@gitster.g>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWlpIDwEcDwEcDwkMDw0cKA8FCQEERgsHBUhYSFlfSA8B
 HBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=11d6FONagg5MTqxdxLF4tuF8uQX2wFe9pXK89csnnJA=;
 b=bbesXqJdomIkpEGUcKdcXvAZORD7s6wuj1de4QTBNPeFWiszH91H9Rh3c3h5vgI+tSu/zjXqEY7N
	SRaLlhwBXwicGbibNo4LEcobjYQXNBvtQccgtl8QebIVNzVhWRWZ7+QIfeMc11ON0ZJqNPs9NEnP
	aAEclkwbTCHbuVnAsl5POae4jWFR7/lW0dY1z1ZaWFkI3plGSG4j629gaKioB0eClKhSTPchNMWM
	CVcS9tYjdGuGvXUF9+FsU1uljQ8+n8V3OHXD984ExAX8+8AWAaBzqEeZjX3wUUC5e/gmBsetIZHv
	VnJdrXWZq4M6BDp8yMlJyBI62xZTBJXZXCV8ew==

Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >
> > One thing I forgot to mention.
> 
> Sorry, but there was another.  With this merged, doc-lint seems to
> fail and breaks 'seen'.
> 
>             ...
>             LINT DOCSTYLE includes/cmd-config-section-all.adoc
>         no link: gittutorial-2
>         gmake[1]: *** [Makefile:537: lint-docs-manpages] Error 1
>         gmake[1]: Leaving directory '/home/gitster/w/buildfarm/seen/Documentation'
>         gmake: *** [Makefile:4003: check-docs] Error 2
> 

If we want to build gittutorial-2(7) as a manpage stub but to hide it in `git
help --guides`, we can squelch that linter error with a merge-fix:

diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index d4a1977ba6..db2a54116d 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -32,6 +32,7 @@ check_missing_docs () (
 		git-legacy-*) continue;;
 		git-?*--?* ) continue ;;
 		gitweb.conf) continue ;;
+		gittutorial-2) continue ;;
 		esac
 
 		if ! test -f "$v.adoc"

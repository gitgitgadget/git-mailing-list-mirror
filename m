Received: from mail.dgfip.finances.gouv.fr (bdmprod002-2.dgfip.finances.gouv.fr [145.242.11.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AD471D05
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.242.11.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837048; cv=none; b=koGLqvUEBHcBkh9YAvA3SQ32dWPwxrpfsiLMxhjq5hUUm6Fzx9vxr9aG6/+w9lGqtkm92SiXbOvetOQerOXRPt5N3XT1mT8oAl+JHZ+DZ9CaTsaMEiTQMdMr/07cmE5SAm7JpzKQldr8vjUXTRJLhRr93y8hn7gBvHKrIrTuuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837048; c=relaxed/simple;
	bh=NP6Fy1J0vyp/2uXrW+BSmRqnuaz+LXWBk20lNu8RYCU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bYAOzH3LzZdp5v0AxQ9BNd2rSkGH8i+8S2dFjrMa+llZwvw8Nh9GIlyoe5LT0Zq7xVOm1zGisJGSwuPGHKY7qKakDbp2KFdC4ZzM6ZajJdebkRUZEZ1R6q65XyfBNHKaulrlT+p0CNR8N6C4e5ykY9aLQlx87fBJWIbiS/Px4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dgfip.finances.gouv.fr; spf=pass smtp.mailfrom=dgfip.finances.gouv.fr; dkim=pass (2048-bit key) header.d=dgfip.finances.gouv.fr header.i=@dgfip.finances.gouv.fr header.b=TGXoPLDR; dkim=pass (2048-bit key) header.d=dgfip.finances.gouv.fr header.i=@dgfip.finances.gouv.fr header.b=ho5jM+09; arc=none smtp.client-ip=145.242.11.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dgfip.finances.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dgfip.finances.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dgfip.finances.gouv.fr header.i=@dgfip.finances.gouv.fr header.b="TGXoPLDR";
	dkim=pass (2048-bit key) header.d=dgfip.finances.gouv.fr header.i=@dgfip.finances.gouv.fr header.b="ho5jM+09"
DKIM-Filter: OpenDKIM Filter v2.11.0 pf3pgsi002-a.pfz3 4hW1dp62DXzMygpf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=dgfip.finances.gouv.fr; s=pf3; t=1787835182;
	bh=NP6Fy1J0vyp/2uXrW+BSmRqnuaz+LXWBk20lNu8RYCU=;
	h=Date:To:From:Subject:From;
	b=TGXoPLDRmjV9eyUynJRRjJ18Xv+5cpPdl5zVT/FC0inXUijnnmSFEPFQvX6/N/VXB
	 Doj/RFANL7wX1yiVjsIsqC+cM2ZNCd1DFAkqpMM4v6slgK/daYo92a225Zi58KQlrX
	 79WJ+3aJmauo7mRzHmCyRuZHNiNS+iFhrEJr8qqHzHm/ixzsKWx05AdqqMF5KJFzwb
	 WOsR1HdDGOAdMTSURagEtE4NLFqDFRt0ZBFrY/bt1BqhbtYze1O1QrTXqNBKU1naaX
	 f/6ODFSf8dBJMUCaFIcyKd6lihahGW7Mp80U5/Szd6ZdGngrLZYL4jonzS8XhEPZgy
	 RsXH+x5IncgYw==
DKIM-Filter: OpenDKIM Filter v2.11.0 mespgsa031.dgfip.finances.gouv.fr 988751400041A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=dgfip.finances.gouv.fr; s=mes-appli; t=1787835182;
	bh=NP6Fy1J0vyp/2uXrW+BSmRqnuaz+LXWBk20lNu8RYCU=;
	h=Date:To:From:Subject:From;
	b=ho5jM+096ui2d/mmHT/RrIHx+5YxhbEaiTVNg9eKWtlx2PEPS6z5Ky8JJPfg6gAzO
	 22Af0+CrvU9iwSnEOLT+fynzgawTmyzMWH/6VuOSYLzF+RbTCoDVq0zmKP2brs+hij
	 ForTaNbR489K39KZIeuNd80H01JhLZyoinvtqFCJWYl8YadXQM3BsLDjdNeK5+pI/H
	 ighaUoeUURUrLrPTRDzJ3sG79u/psLaVfAjzZRCC9LuuCCdKbZ4l2NnvVurk63hdRK
	 8M9m169RO/8NQhYShI6l0GmGRNy/qU+9FzfbrufdcmasMtTVDrs8r7uaoAF/mUZQVX
	 PTBQ3nesaH28w==
Message-ID: <d928fd6d-bc80-45f6-b8ff-d21d9a55e18f@dgfip.finances.gouv.fr>
Date: Thu, 27 Aug 2026 14:53:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: fr
To: git@vger.kernel.org
From: Eric Gautier <eric.gautier@dgfip.finances.gouv.fr>
Subject: Translation issue in git checkout explanation (french)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVFYWC48UVpaWFhYWFldSFtdSA0aAQtGDwkdHAENGigMDw4BGEYOAQYJBgsNG0YPBx0eRg4aSFlI
 WVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFpIWVlIWVhGWV1cRl9ZRlpIUEhYSFhIWUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFg=


Bonjour,

Je suis tombé, sur cette page de votre site : 
https://git-scm.com/docs/git-checkout/fr.html (que je vois en français, 
sans demande particulière) sur cette phrase dans l'article git checkout :
L’extraction échouera s’il n’y a des changements non validés dans les 
fichiers où < branche> et votre commit actuel ont un contenu différent.

Cette phrase est mal construite à mon avis, ce type de construction est 
très rare en français, le" n' "dans s'il n'y a ne peut avoir qu'une 
fonction explétive c'est à dire neutre au point de vue du sens de la 
phrase : bref, il faut comprendre la phrase comme si ce " n' "était 
absent, ce qui donne :
L’extraction échouera s’il y a des changements non validés dans les 
fichiers où < branche> et votre commit actuel ont un contenu différent.

Est-ce bien le sens voulu? Dans ce cas, je vous conseille hautement de 
retirer le n' qui, non seulement  complique inutilement  la phrase et 
mais en outre produit un risque de confusion avec l'habituel ne...pas ou 
n'....pas qui est une négation ; ainsi, on pourrait comprendre à tort :
L’extraction échouera s’il n'y a pas de changements non validés dans les 
fichiers où < branche> et votre commit actuel ont un contenu différent.
Il me semble douteux que ce soit le sens voulu et il vaut mieux éviter 
d'embrouiller les débutants.

A toutes fins utiles!

Cordialement,
-- 
Eric GAUTIER
Contrôleur Programmeur
DISI Nord - ESI Amiens
Division Développement

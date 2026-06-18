Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0735202A
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783334; cv=none; b=grHORjxpboC1S90V0aClARXjdekdo3yWMBZSBXkmsGOZrmXS/HnSstcswHrrADVaUZNdUbARYkBhqy14Tk52ft7ZEaI8NoVHgy7Fs2Pr9kaPz28aJ08/dqTqG5S6Z1t7R495xPpLyfxZRXlrWHeGM+qADViUDqJr1MGptgEtzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783334; c=relaxed/simple;
	bh=8CQqcolbvX9JR0j1zUdvQ1Rcmd/lcm9tS440UgooxQU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWhi1x47pbyloRizkJJO90tKO6Co57FMFO3CZPhms0rKPKHXag0ApRZJSxxYAPQ7aQfLD9QH4tQlzBH5WOBaqVpVeSJbPnoDOmA19JYt4e9nw18yA1fHKdkeFLIf40zOAOv6YmJpZiSHs0Ct99FF5OE+zW5JSE+BVGJkFlmb4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Uj4DBxc5; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Uj4DBxc5"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65IBmcFV024278-65IBmcFX024278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 18 Jun 2026 14:48:38 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1waBEc-004Ow7-7s;
	Thu, 18 Jun 2026 14:48:38 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 14:48:37 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 95e8e22b;
	Thu, 18 Jun 2026 11:48:37 +0000 (UTC)
Date: Thu, 18 Jun 2026 14:48:37 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Silas Poulson <silas@dyalog.com>, <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>
Subject: Re: [PATCH] Fix typo in MaintNotes regarding versioning scheme
Message-ID: <20260618114837.0_RVf%taahol@utu.fi>
In-Reply-To: <xmqqfr6czmye.fsf@gitster.g>
References: <pull.2209.git.git.1771774770368.gitgitgadget@gmail.com>
 <882432fe-30f5-46c5-9efa-5b8a047283b6@dyalog.com>
 <xmqqfr6czmye.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWlpIDwEcDwEcDwkMDw0cKA8FCQEERgsHBUhYSFlfSA8B
 HBscDRooGAcKBxBGCwcFSFhIWV5IGwEECRsoDBEJBAcPRgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=fu+ovZzqXODDq/Gd78V+MRZJPuFhiCeRUm9y/7Dld8c=;
 b=Uj4DBxc5PI0Bv+dBQbcayo0TDiLozspItG5W7vZSBFqSOv+1KTe9C31wv2299UXAnkw+i4aHQdlK
	RWCZNPuvkI/sCYm3qg5Xwo4rABmxLAmalrIst5bKbOGFbeHK7aHT+C5eZ58I+n8wMFz61t5qbcxB
	6aUc9MTo76D0+2sc7IbJCBK+AlM/vNTToyPSsg8VSbVDlcxNiUTLt76R9d+CgLJteZJNRK+98PNz
	pbR2xS1rY29VjPdX9xU+H+My++TVUpVOKJ3Cfl3rfXq0C5cYDUKuUgRcfQJ+GkomCCRsRJHML9Ts
	Y6fpyxjY5L5tMNC93koefAYRuunPl/AfF/BPng==

Junio C Hamano <gitster@pobox.com> wrote:

> Silas Poulson <silas@dyalog.com> writes:
> 
> > I'm aware this is a very minor change, but it would be good to not let 
> > this fall through the cracks.
> 
> Thanks for noticing a typo.
> 
> Will update before the next issue is sent to the mailing list.  No
> point in changing it before that.

On that occasion, please consider also these fixes:
-----8<-----
Subject: [PATCH] MaintNotes: fix typos and grammar

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 MaintNotes | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MaintNotes b/MaintNotes
index 12ba677c36..44b29c9e10 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -82,7 +82,7 @@ available at:
 There is a volunteer-run newsletter to serve our community ("Git Rev
 News" https://git.github.io/rev_news/).
 
-Git is a member project of software freedom conservancy, a non-profit
+Git is a member project of Software Freedom Conservancy, a non-profit
 organization (https://sfconservancy.org/).  To reach a committee of
 liaisons to the conservancy, contact them at <git@sfconservancy.org>.
 
@@ -245,7 +245,7 @@ by others may cause conflicts with their own work, and find people who
 are working on these topics to talk to before the potential conflicts
 get out of control.  It would be a good idea to fork your work from
 maint or master and to (1) test it by itself, (2) test a temporary
-merge of it to "next" and (3) test a temporary merge to it to "seen",
+merge of it to "next" and (3) test a temporary merge of it to "seen",
 before sending it to the list (or asking GitGitGadget to send it to
 the list).
 
@@ -262,10 +262,10 @@ using the topics that didn't make the cut in the feature release.
 Some topics that used to be in "next" during the previous cycle may
 get ejected from "next" when this happens.
 
-A natural consequence of how "next" and "seen" bundles topics together
-is that until a topic is merged to "next", updates to it is expected
+A natural consequence of how "next" and "seen" bundle topics together
+is that until a topic is merged to "next", updates to it are expected
 by replacing the patch(es) in the topic with an improved version, and
-once a topic is merged to "next", updates to it needs to come as
+once a topic is merged to "next", updates to it need to come as
 incremental patches, pointing out what was wrong in the previous
 patches and how the problem was corrected.  The idea is that if many
 reviewers thought it has seen enough eyeballs and is good enough for

base-commit: f9b08c9b285c9154e41b9f5fce7506018b83dfcb
-- 
2.30.2


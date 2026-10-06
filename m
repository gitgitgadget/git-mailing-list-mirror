Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688230ACF0
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265824; cv=none; b=YP9IgE3ZvGZaTVl8mCTdc+WIi2PjyYfgIbcjZxebufkEalwLPEbDKhurASYSTYu/gcofsZIG+sdNiIHAAaFryFeaPGVsV7KZPY8ZvWm/8ki5Svj/e33ylcdCzGELEI2nORuwGXzRRIcwfQtNd4lLUDnW3kx/rB4jBbgSJ3eDs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265824; c=relaxed/simple;
	bh=Knlte3bTrQq3x2Iqp/RUH+E8sJAasUTe5mFKSpMEVWE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFc+qQXJG5X/Dcu4clAlPGHCMEsDCOceYHWVuMRxg/lbPiDKyqiPZrA+qzm0S8kNCXPHsCYKQUGcNOfZ36zDsaBUbvIm7yOJPebpPE9pr4PJL54AsNPEPFE7GiL38sLqKgEMt8FbbW0Zb2qaKm+VZ9PSG3ob+YpDW8eWVrJhPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=TxhKGDZe; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="TxhKGDZe"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6965o3VT012730-6965o3VV012730
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 6 Oct 2026 08:50:03 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xDy3v-00CWG7-Ez;
	Tue, 06 Oct 2026 08:50:03 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 08:50:03 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id ac4fd5aa;
	Tue, 6 Oct 2026 05:50:02 +0000 (UTC)
Date: Tue, 6 Oct 2026 08:50:02 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
CC: <git@vger.kernel.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Message-ID: <20261006055002.M9X9O%taahol@utu.fi>
In-Reply-To: <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhcSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhaWkgPARwPARwPCQwPDRwoDwUJAQRGCwcFSFhIWVtI
 Ah0EAQkoAh4GG0YLCUhYSFtaSAMaARscBw4ODRoACR0PGwoJAwMoDgkbHAUJAQRGCwcFSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=UK1F6K4rWLoLPFoEGxDhox/Bx0iLfHjdFLq0c3EcrPk=;
 b=TxhKGDZerayr+Ue1LImr6l8mcphE7aGOgtI6QegMHkfOv5bA4OokYv2U2x6DTsQSSHRsnj0sdIkQ
	NQUfA18Pq8LZ4ukTGm307q/YJ4kjGXNvveqD9sG2h/o7i8vsQfAuvHTriODq9cMM1NmwAK75PYvg
	LWvj7caLwpxvb2xQCMGG80Cq3PNZlulo2XGtqd8gdwXtBoLRSaNvcjZJkx9yfTXcxJNMd5XZd/HA
	G2x5EME7j654GL80E48fX98r3U0yR2ZW2wgOlgNBkWQ+dREkSz01QrnU725vTZFU5d1ZeMv8ROH+
	0Zjy0O/5ThKHz3yPs35ZDe1c6tCA+KSp2hRk3w==

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> wrote:

> This patch series removes gittutorial-2 and all references to it, leaving a
> stub behind to help out any users who might be looking for this
> documentation.
> 
> The goal is to remove obsolete documentation and make it easier to improve
> our tutorial material in the future.
> 
> I tested that the docs are staying internally consistent by running git grep
> tutorial-2 and making sure that the only remaining references are in the
> Makefiles, the document itself, and some example output in user-manual.adoc
> which isn't relevant to the actual manual.
> 
> Changes in v2:
> 
>  * Remove changes to .po files (thanks to Junio)
>  * Reword commit messages to doc: ... (thanks to Tuomas)
> 
> To deal with the conflict with 4ce144a1 (which requires that all guides be
> listed in command-list.txt) I think we need to add another exception to
> lint-manpages.sh (like Tuomas said).
> 

Excluding the po/ stuff, the v1->v2 interdiff looks like this:

$ git diff je/doc-remove-gittutorial-2@{1} je/doc-remove-gittutorial-2 -- ':!po/'
diff --git a/command-list.txt b/command-list.txt
index 5c649c882e..63ae2a67c9 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -244,6 +244,7 @@ gitrepository-layout                    userinterfaces
 gitrevisions                            userinterfaces
 gitsubmodules                           guide
 gittutorial                             guide
+gittutorial-2                           guide
 gitweb                                  ancillaryinterrogators
 gitworkflows                            guide
 scalar                                  mainporcelain


That, as can be guessed, causes git(1) to advertize this "obsolete tutorial".
Perhaps we would like to avoid that.

$ (cd Documentation/ && ./doc-diff je/doc-remove-gittutorial-2@{1} je/doc-remove-gittutorial-2)
diff --git a/7da429d7fb86fe400c48984ea1506a9e0477e80e/home/taahol/share/man/man1/git.1 b/0bf477ce01b45853195f5f3da63642712dc35579/home/taahol/share/man/man1/git.1
index efc100186b..57a7f270c8 100644
--- a/7da429d7fb86fe400c48984ea1506a9e0477e80e/home/taahol/share/man/man1/git.1
+++ b/0bf477ce01b45853195f5f3da63642712dc35579/home/taahol/share/man/man1/git.1
@@ -800,6 +800,9 @@ GUIDES
        gittutorial(7)
            A tutorial introduction to Git.
 
+       gittutorial-2(7)
+           Obsolete tutorial.
+
        gitworkflows(7)
            An overview of recommended workflows with Git.
 

And let's not worry about that exception you mentioned.  After this topic hits
'next', I can rebase mine on top on of this, and deal with all necessary
integration work.

Thanks!

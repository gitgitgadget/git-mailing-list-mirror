Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795775637;
	b=TchneFhx66rUBC2Ki54Nb+6lOP3QQm77hA1x1eR+7TqjSmR4qsGLNVV/MmdpJeFKyTcb
	 hDTx5xAgyoq3jQuRj+1spdwgfT31+Pj2q2IqgJ5ULMhWx78i/7JY0pNEF9oj1RuHsYrFX
	 YjrYxM2mhUmd51xqP7e8Mc52YPaP6Z8LYcBN4o7NTX9y8FhJF0TTzhX89s/ddMtjjhrzN
	 iwmV+6nNAYW121srizQmgVMzoHHLgFpPyvXTWKJpvnGi29FCR5k7JSQKgpE250sggR8ee
	 4Bn5E1qhJ5Bv2xmdalWv0rjzMNhLq57RJe+NWc7EdmCD3XAEn3YelKzwL+2SX0VJqoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775637;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=C4rNM7JA2ykr2daseTjO8tNkBBvI4sKLOjJXvXjD884=;
	b=wmRfzbx1hA8IPs/ONP2E2BgKicBxnMfrrqMatN1HND3IxJS8tWNsK6MPUrQ9WSGdhTLB
	 J0xUyRsMb5Jb7iW2a8yQCTbRb6Y5aAINyzc5F4yWsZUHHWQIx8j1RJS7YCa0nV6t3/Jya
	 9G51sdOpjoUqujqH/3PSujTCP4RJaA2iqy5USTCk1wu/WlLEOwA0dSz6jIWcY6jjjUQ3e
	 TT44cYczts9q4BL4TtNqsQeCc6CXZ3m88g5wnLys6D04lCAeTZ9F91ICeMD0i7jSm83eE
	 CdE2/ytgh5addwUFRb3Zj8HTZchbz2DbJHlE9JXSqtYV0D7TG0QkOTnD1ACGd9/QpMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="fN17+1r/";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8F606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 10:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=fN17+1r/
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6ARAXlwB019742-6ARAXlwD019742
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 27 Nov 2026 12:33:47 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xWtH1-00DfY7-7P;
	Fri, 27 Nov 2026 12:33:47 +0200
Received: from localhost (130.232.225.154) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 12:33:46 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id f0e572b9;
	Fri, 27 Nov 2026 10:33:46 +0000 (UTC)
Date: Fri, 27 Nov 2026 12:33:46 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Tuomas Ahola <taahol@utu.fi>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Julia Evans
	<julia@jvns.ca>
Subject: Re: [PATCH v4 2/2] lint-docs: ensure command-list.txt lists all
 guides
Message-ID: <20261127103346.vPrBT%taahol@utu.fi>
In-Reply-To: <20261126201110.9046-3-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261126201110.9046-1-taahol@utu.fi> <20261126201110.9046-3-taahol@utu.fi>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-13.utu.fi (130.232.247.53) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSAIdBAEJ
 KAIeBhtGCwlIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=C4rNM7JA2ykr2daseTjO8tNkBBvI4sKLOjJXvXjD884=;
 b=fN17+1r/uBaOdozLerpo2G6s+XF8JRD/XTRPQOj2Gh8NiSOHHYskDdGoP0Q9p08GluI7LIvLc+We
	dL0o5+L0fVbGK/9j2kzbCEcREzEtKFOYO/E2wehuiR/1QEwuOxjyDwQPt0JNp5ObmK4+IVQVOpbU
	xYPaxi/DGY1VQ5S0ms/eSV8jvO7TBPMrtqaqxtKbrUPLi7YV9vGjEHSUQcn89bEZtZTjet4MVUni
	vM2Lx1XMVHdYF5qsxjT/08RHRg0EaQ/IzD6o/aps1P7UYI2EctQtLqNhOIW5h9Mp58Un+IBjCztv
	ewedTQvMFYc6CEX/5PBbzXL4O5qCFf6agTvKuQ==

Tuomas Ahola <taahol@utu.fi> wrote:

> Since 2135e1ad70 (command-list.txt: add missing 'gitcredentials' and
> 'gitremote-helpers', 2020-08-05) there has been a comment in
> Documentation/Makefile reminding developers to add new guides also to
> command-list.txt.  However, there is no linter script to enforce that.
> 
> Adapt Documentation/lint-manpages.sh to fill that role.  Extract
> MAN5_TXT and MAN7_TXT from the docs Makefile and check command-list.txt
> against them.  Exempt gitweb.conf(5) and gittutorial-2(7) from the
> new linter routine as deliberate omissions.
> 
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  Documentation/lint-manpages.sh | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
> index a0ea572382..87a652bd22 100755
> --- a/Documentation/lint-manpages.sh
> +++ b/Documentation/lint-manpages.sh
> @@ -1,21 +1,27 @@
>  #!/bin/sh
>  
>  extract_variable () {
> -	(
> -		cat ../Makefile
> -		cat <<EOF
> +	file="$1"
> +	directory="$(dirname "$file")"
> +	shift
> +	for i in "$@"
> +	do
> +		(
> +			cat "$file"
> +			cat <<EOF
>  print_variable:
>  	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
>  EOF

Well, that is obviously incorrect.  Sorry.  Besides, $i isn't a very eloquent
name for the iterator...

Junio, could you please squash this locally?

-----8<-----
Subject: [PATCH] fixup! lint-docs: ensure command-list.txt lists all guides

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/lint-manpages.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index 87a652bd22..0b123f487c 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -4,13 +4,13 @@ extract_variable () {
 	file="$1"
 	directory="$(dirname "$file")"
 	shift
-	for i in "$@"
+	for v in "$@"
 	do
 		(
 			cat "$file"
 			cat <<EOF
 print_variable:
-	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
+	@\$(foreach b,\$($v),echo XXX \$(b:\$X=) YYY;)
 EOF
 		) |
 		make -C "$directory" -f - print_variable 2>/dev/null |

base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
prerequisite-patch-id: 55e8c49f2de1f1bbd117386712fd07a30f2641c7
prerequisite-patch-id: d5b07233f2f991f22c53c1a177690660f8f463ab
-- 
fixup/ta/command-list-guides-sync-lint

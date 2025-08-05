Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94B12DDA1
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754426511; cv=none; b=ixNw3/H6/jp+4hFTrfL59+QHgMNZ0dix9AMGNFXdjLlMBliO7XE5RhMdK4KDPQNCckEAplTJKyEkIQ34Gm4+miSlgphvbrPPNWTmjjSscwkv/oATJH0a8zwvbQeXsj2KY+1k0n03jmy/adg/YdVAyKicOFuYQJ34rhOchgIGJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754426511; c=relaxed/simple;
	bh=+O2dcDOeA19I3Vc1on+jYpCB6iQqDIGTBBaTTDaVWdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCQkNmXezaGeqMaTlSC/xFo5L17YcYO5R6HC04B516nZ+nnNn755dBWE6c5bM7OJ1Kao+g3ZgJsCNyIJV9MiUX9LHbHSRHRTDM5En8HGvsK099KrsXQkyLM5LRSsqUoGySPiFla4HXO9SZEWOxZQWfb3hsl41Hco+Davm3M1CHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=pD5KwzCf; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="pD5KwzCf"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id jOIhuAR2vQUSmjOIjuQP3L; Tue, 05 Aug 2025 21:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1754425825; bh=gt2sIUEYHDUM1u+HLT2C9p9MyKzykT8BQMEqqtTs3L0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pD5KwzCfu3+3EU6X8Ay0WmSG7Jo1hx9phI2f7kT+jcwWYPJ0VGRUpT41v/Gl5w8ND
	 rrtq+VCxbEHKWdtgELYAguhA/syVrQGUKxLNnj3MyAvg1tuI9uZf/j7HKZl0lJssoJ
	 hcBPzsosieoy3PZWphG5PCvsFoVMv3SxBztd2ULco50ugKmooCJFTRI88b/7IO7/ts
	 v1GEYuUR7HvTRKVLTNl7es1gOe8Vusx4xOt0y+zPCEP2WlfUTv+72orcC7wvlkBaYI
	 u3f2hQOl/39gqf3XRpPbby6tOvWnEchzRuBI6MkhHpZ/p+MaX4F1FNbhWFW0ivF9Rp
	 I7BCyN1yzEZlQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Ss4z6+O0 c=1 sm=1 tr=0 ts=689269e1
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=K-hsmWo6nKHj03m_:21 a=IkcTkHD0fZMA:10 a=gfIp93Ddu173_CkbvlkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <0b6e4b7d-e294-4721-9ae1-3d10f5898276@ramsayjones.plus.com>
Date: Tue, 5 Aug 2025 21:30:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] [PATCH v2 3/6] doc: check for absence of multiple terms
 in each entry of desc list
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
 <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
 <5806390052b7a7cbdb8dc843bfcc24102604e2f6.1754421046.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <5806390052b7a7cbdb8dc843bfcc24102604e2f6.1754421046.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCZBAflc009dw+RiEEKk6lnRT+TZGb0s6g51leaMg04FjfpkOR8dzRIdECO9xnkJ/RVS6DGNt+/7qtzNxT7526tT4HqSbY4kyaX0hgahO76Jdh50CKPx
 cApqotmfbA9+/4NftrqVc9cxuL3ZIl3wpZ/Cuq+oRWwWhxra7V6lb5U8n3tCw987ivkcuqw1F85jdWlGQJjvUKMi692fd9CZM/M=



On 05/08/2025 20:10, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> Due to portability issues, the script generate-configlist.sh was fixed to
> not use carriage returns in the output. However, the result is that it no
> longer correctly handles multiple terms in a single entry of the definition
> list.
> 
> We now check that these entries do not exist in the documentation.
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/Makefile                      | 10 +++++++++
>  Documentation/git-check-attr.adoc           |  3 ++-
>  Documentation/git-check-ignore.adoc         |  9 +++++---
>  Documentation/git-http-fetch.adoc           |  4 +++-
>  Documentation/lint-documentation-style.perl | 24 +++++++++++++++++++++
>  Documentation/technical/api-path-walk.adoc  |  5 ++++-
>  shared.mak                                  |  1 +
>  7 files changed, 50 insertions(+), 6 deletions(-)
>  create mode 100755 Documentation/lint-documentation-style.perl
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 76a9e1d02b26..ac8a21e3015c 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -508,6 +508,15 @@ $(LINT_DOCS_DELIMITED_SECTIONS): .build/lint-docs/delimited-sections/%.ok: %.ado
>  .PHONY: lint-docs-delimited-sections
>  lint-docs-delimited-sections: $(LINT_DOCS_DELIMITED_SECTIONS)
>  
> +## Lint: Documentation style
> +LINT_DOCS_DOC_STYLE = $(patsubst %.adoc,.build/lint-docs/doc-style/%.ok,$(MAN_TXT))
> +$(LINT_DOCS_DOC_STYLE): lint-documentation-style.perl
> +$(LINT_DOCS_DOC_STYLE): .build/lint-docs/doc-style/%.ok: %.adoc
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_LINT_DOCSTYLE)$(PERL_PATH) lint-documentation-style.perl $< >$@
> +.PHONY: lint-docs-doc-style
> +lint-docs-doc-style: $(LINT_DOCS_DOC_STYLE)
> +
>  lint-docs-manpages:
>  	$(QUIET_GEN)./lint-manpages.sh
>  
> @@ -537,6 +546,7 @@ lint-docs: lint-docs-gitlink
>  lint-docs: lint-docs-man-end-blurb
>  lint-docs: lint-docs-man-section-order
>  lint-docs: lint-docs-delimited-sections
> +lint-docs: lint-docs-doc-style
>  lint-docs: lint-docs-manpages
>  lint-docs: lint-docs-meson
>  
> diff --git a/Documentation/git-check-attr.adoc b/Documentation/git-check-attr.adoc
> index 503b6446574d..15a37a38e3f7 100644
> --- a/Documentation/git-check-attr.adoc
> +++ b/Documentation/git-check-attr.adoc
> @@ -19,7 +19,8 @@ For every pathname, this command will list if each attribute is 'unspecified',
>  
>  OPTIONS
>  -------
> --a, --all::
> +-a::
> +--all::
>  	List all attributes that are associated with the specified
>  	paths.  If this option is used, then 'unspecified' attributes
>  	will not be included in the output.
> diff --git a/Documentation/git-check-ignore.adoc b/Documentation/git-check-ignore.adoc
> index 3e3b4e344629..a6c6c1b6e5be 100644
> --- a/Documentation/git-check-ignore.adoc
> +++ b/Documentation/git-check-ignore.adoc
> @@ -25,11 +25,13 @@ subject to exclude rules; but see `--no-index'.
>  
>  OPTIONS
>  -------
> --q, --quiet::
> +-q::
> +--quiet::
>  	Don't output anything, just set exit status.  This is only
>  	valid with a single pathname.
>  
> --v, --verbose::
> +-v::
> +--verbose::
>  	Instead of printing the paths that are excluded, for each path
>  	that matches an exclude pattern, print the exclude pattern
>  	together with the path.  (Matching an exclude pattern usually
> @@ -49,7 +51,8 @@ linkgit:gitignore[5].
>  	below).  If `--stdin` is also given, input paths are separated
>  	with a NUL character instead of a linefeed character.
>  
> --n, --non-matching::
> +-n::
> +--non-matching::
>  	Show given paths which don't match any pattern.  This only
>  	makes sense when `--verbose` is enabled, otherwise it would
>  	not be possible to distinguish between paths which match a
> diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
> index 4ec7c68d3b9e..dcb05890aefd 100644
> --- a/Documentation/git-http-fetch.adoc
> +++ b/Documentation/git-http-fetch.adoc
> @@ -25,8 +25,10 @@ commit-id::
>          Either the hash or the filename under [URL]/refs/ to
>          pull.
>  
> --a, -c, -t::
> +-a::-c::
> +-t::

s/-a::-c::/-a::
-c::/ ?

ATB,
Ramsay Jones



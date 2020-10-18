Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9A7C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9F3208B8
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 15:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJRPNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 11:13:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55827 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725776AbgJRPNV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 11:13:21 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09IFDFYv017842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Oct 2020 11:13:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BF32C420107; Sun, 18 Oct 2020 11:13:15 -0400 (EDT)
Date:   Sun, 18 Oct 2020 11:13:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: Clarify and expand description of
 --signoff
Message-ID: <20201018151315.GJ181507@mit.edu>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
 <20201015215933.96425-2-bkuhn@sfconservancy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015215933.96425-2-bkuhn@sfconservancy.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 02:59:33PM -0700, Bradley M. Kuhn wrote:
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index a3baea32ae..93bbae4ded 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -166,11 +166,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>  -s::
>  --signoff::
>  	Add Signed-off-by line by the committer at the end of the commit

While we're editing this, how about changing the above to read:

	Add a Signed-off-by line...

to fix a grammer nit.  We do use a similar formulation later the git
merge-options man page:

>  With --no-signoff do not add a Signed-off-by line.


> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 80d4831662..c9df9cc0f4 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -80,11 +80,14 @@ actual commits being merged.
>  --signoff::
>  --no-signoff::
>  	Add Signed-off-by line by the committer at the end of the commit

... and again here.

Thanks!

					- Ted

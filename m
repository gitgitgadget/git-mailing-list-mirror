Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94E15E94
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONKwR+pF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33770772136so4089821f8f.3
        for <git@vger.kernel.org>; Sat, 13 Jan 2024 15:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705189296; x=1705794096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E71jYIsx2cnu+/0lPEJ+QeFR/VgnKrtyuzARBIgXzr0=;
        b=ONKwR+pFHLn+rjswUU8Mh69HmV480VMs1YE3plAYmhRfFIiRvvasPcDw33Ii9h47OM
         hmmOg4fNdLt5EIyq8P171bSv/McV0Hve/U/et1xXaOvONGVfhWtfWwvW1QCkJspssKh4
         zTGQEeDYwZNmBnlw4Wi1GgYNivF48D0sHK1Pv+VLb+1CtVm4L+qT5feJM52kV50EBcsg
         gNPCYkdbleEqqOQlgNRQEJEmxkiMwqlOFnKdiab0S7j2mxfX/anWkCMA7y/Qjpsuryar
         u79LqmpEOv9ZzuC3rmcrs542uoDihLShXX5QBlVscXdt3K1NTMwjkVozNfyvNcS2KgYE
         y0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705189296; x=1705794096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E71jYIsx2cnu+/0lPEJ+QeFR/VgnKrtyuzARBIgXzr0=;
        b=gnR2ADSHc2DOrAybHMwDeTz3hga85gafU86kvJae9zl92knOmYXQzrmtBZpa+pz3Do
         7QfSe/iQwKze2I9WiUfE2zEj2m7evD1WI39rJ7GOoQ7BwQokWIhaxmu2EZ4FBeeLmxjU
         fiteWqN+eJDfSqxZva1OuYfF61ymkRaCJVyV9xYOdjq6TxqGvkzdGWOaznWBowf2smdr
         iQDQiARKJJYIAEZT2ePn31j9QLrwxsck7cfcnKcOYn32uTqvgmiESfxWNLChqwIsTTS0
         aW8RTPaZRle0nuCe1x2+vCp3SWaeoZwH+yiF+O+wuN5D0dFvoQ7SJfwTQy9kYOV6ZTOp
         4nMw==
X-Gm-Message-State: AOJu0YxIAlAbRlclQkuI8NkDurmTTSWUvdrvpYPRf+QVgJc7ND92vSt+
	GV5GeXrTUZC5oLAZDEz8rGgeKVeTfB4=
X-Google-Smtp-Source: AGHT+IGZFE3ITxZdL1OuEeRiRyrjATvbvNgQstkmeBswsVAyWve38v9OBbXCbQSHrgBo2vRIdkhO+w==
X-Received: by 2002:adf:ef50:0:b0:336:5b14:525f with SMTP id c16-20020adfef50000000b003365b14525fmr2114029wrp.132.1705189296051;
        Sat, 13 Jan 2024 15:41:36 -0800 (PST)
Received: from localhost (84-236-78-166.pool.digikabel.hu. [84.236.78.166])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b00337876596d1sm7760100wrd.111.2024.01.13.15.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 15:41:35 -0800 (PST)
Date: Sun, 14 Jan 2024 00:41:34 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <20240113234134.GE3000857@szeder.dev>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <ZZWOtnP2IHNldcy6@nand.local>
 <xmqqa5pm9tnx.fsf@gitster.g>
 <20240113183544.GA3000857@szeder.dev>
 <ZaMJU6MJ5wZxyLeM@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaMJU6MJ5wZxyLeM@nand.local>

On Sat, Jan 13, 2024 at 05:06:11PM -0500, Taylor Blau wrote:
> Hi Gábor,
> 
> Thanks very much for your patience while I figure all of this out. I'm
> confident that with the fixup! below that your test passes in the next
> round of this series.
> 
> On Sat, Jan 13, 2024 at 07:35:44PM +0100, SZEDER Gábor wrote:
> > On Wed, Jan 03, 2024 at 10:08:18AM -0800, Junio C Hamano wrote:
> > > Taylor Blau <me@ttaylorr.com> writes:
> > >
> > > >> * tb/path-filter-fix (2023-10-18) 17 commits
> > > >>  - bloom: introduce `deinit_bloom_filters()`
> > > >>  ...
> > > >>  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
> > > >>
> > > >>  The Bloom filter used for path limited history traversal was broken
> > > >>  on systems whose "char" is unsigned; update the implementation and
> > > >>  bump the format version to 2.
> > > >>
> > > >>  Expecting a reroll.
> > > >>  cf. <20231023202212.GA5470@szeder.dev>
> > > >>  source: <cover.1697653929.git.me@ttaylorr.com>
> > > >
> > > > I was confused by this one, since I couldn't figure out which tests
> > > > Gábor was referring to here. I responded in [1], but haven't heard back
> > > > since the end of October.
> > > > ...
> > > > [1]: https://lore.kernel.org/git/ZUARCJ1MmqgXfS4i@nand.local/
> >
> > I keep referring to the test in:
> >
> >   https://public-inbox.org/git/20230830200218.GA5147@szeder.dev/
> >
> > which, rather disappointingly, is still the only test out there
> > exercising the interaction between split commit graphs and different
> > modified path Bloom filter versions.  Note that in that message I
> > mentioned that merging layers with differenet Bloom filter versions
> > seemed to work, but that, alas, is no longer the case, because it's
> > now broken in Taylor's recent iterations of the patch series.
> 
> Thanks for clarifying. With all of the different versions of this series
> and the couple of tests that you and I were talking about, I think that
> I got confused and thought you were referring to a different test.
> 
> Indeed, the current version of this series (v4) does not pass the test
> in <20230830200218.GA5147@szeder.dev>, but the fix in order for it to
> pass is relatively straightforward.
> 
> I have this on top of my local branch as a fixup! and I'll squash it
> down on Tuesday[^1] and send a reroll after double-checking that the fix
> is correct and doesn't conflict with any other parts of the series.
> 
> Since it's been so long since I've looked at this, I'll re-read the
> series as a whole with fresh eyes to make sure that everything still
> makes sense.
> 
> In any case, here's the patch on top (with a lightly modified version of
> the test you wrote in <20230830200218.GA5147@szeder.dev>:

I certainly hope that I'm just misunderstanding, and you don't
actually imply that this one test in its current form would qualify as
thorough testing... :)


> Subject: [PATCH] fixup! commit-graph: ensure Bloom filters are read with
>  consistent settings
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit-graph.c       |  3 ++-
>  t/t4216-log-bloom.sh | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 60fa64d956..82a4632c4e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -507,7 +507,8 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
>  		}
> 
>  		if (g->bloom_filter_settings->bits_per_entry != settings->bits_per_entry ||
> -		    g->bloom_filter_settings->num_hashes != settings->num_hashes) {
> +		    g->bloom_filter_settings->num_hashes != settings->num_hashes ||
> +		    g->bloom_filter_settings->hash_version != settings->hash_version) {
>  			g->chunk_bloom_indexes = NULL;
>  			g->chunk_bloom_data = NULL;
>  			FREE_AND_NULL(g->bloom_filter_settings);
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 569f2b6f8b..d8c42e2e27 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -438,7 +438,7 @@ test_expect_success 'setup for mixed Bloom setting tests' '
>  	done
>  '
> 
> -test_expect_success 'ensure incompatible Bloom filters are ignored' '
> +test_expect_success 'ensure Bloom filters with incompatible settings are ignored' '
>  	# Compute Bloom filters with "unusual" settings.
>  	git -C $repo rev-parse one >in &&
>  	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
> @@ -488,6 +488,33 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
>  	test_must_be_empty err
>  '
> 
> +test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
> +	rm "$repo/$graph" &&
> +
> +	git -C $repo log --oneline --no-decorate -- $CENT >expect &&
> +
> +	# Compute v1 Bloom filters for commits at the bottom.
> +	git -C $repo rev-parse HEAD^ >in &&
> +	git -C $repo commit-graph write --stdin-commits --changed-paths \
> +		--split <in &&
> +
> +	# Compute v2 Bloomfilters for the rest of the commits at the top.
> +	git -C $repo rev-parse HEAD >in &&
> +	git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write \
> +		--stdin-commits --changed-paths --split=no-merge <in &&
> +
> +	test_line_count = 2 $repo/$chain &&
> +
> +	git -C $repo log --oneline --no-decorate -- $CENT >actual 2>err &&
> +	test_cmp expect actual &&
> +
> +	layer="$(head -n 1 $repo/$chain)" &&
> +	cat >expect.err <<-EOF &&
> +	warning: disabling Bloom filters for commit-graph layer $SQ$layer$SQ due to incompatible settings
> +	EOF
> +	test_cmp expect.err err
> +'
> +
>  get_first_changed_path_filter () {
>  	test-tool read-graph bloom-filters >filters.dat &&
>  	head -n 1 filters.dat
> 
> --
> 2.38.0.16.g393fd4c6db
> 
> (Excuse the old version of Git here, I'm in the middle of a long-running
> process which checks out older versions of the tree to count the number
> of unused-parameters over time.)
> 
> Thanks,
> Taylor
> 
> [^1]: Monday is a US holiday, so I likely won't be at my computer.

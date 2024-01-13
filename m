Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406317733
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izqw9uHb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3373a30af67so6668153f8f.0
        for <git@vger.kernel.org>; Sat, 13 Jan 2024 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705186318; x=1705791118; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3fgBlc36J0j65Lm7cO4la/aIWr/ApXkfA1CFhfAvqxU=;
        b=Izqw9uHbBHcRdDeakdP2GE8d4Ds8yNIHtkzU4fBHd8/u7LtUBpPeFGrpzdLG+ewUHX
         FqOjIFIE85sDuczlPymK0M9RD1IcGhSPZWwpW/qYxttONhNGS1JeGTI3ffS3KkFZy/P0
         OAcWSxmf+fRdLP2SWsfe/lfJU2zglhL2bHKpOG2eIht7Dx34r4Sg2A6s2Jj4taL8/APe
         opY6HiVlf8/NrU2AjJDtTK64hzukOrWBtVEyo169FsGfjY3M5R06N/1r7SiE2VrCswPN
         X2zq2iHyMInUF4UINS8/9dYQXTZM+hBx08xQuGlQagLpmYwezXE2XkrQW00y6djeN/aB
         36pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186318; x=1705791118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fgBlc36J0j65Lm7cO4la/aIWr/ApXkfA1CFhfAvqxU=;
        b=BaoiYrHo62378rmG+N75VsqFDjfO1OQlLK8ehwN3ZxK/H8JOR9/dhduS13/P0Z6EeO
         x863bJiO+W85wQ/GoUAPxtKn1o9xDwGmjCDHYsTRmVywOPOgGCbD2xEfJloBKNNs7lnl
         c6jh5j2Zg2j6Khfi4gANuhUmzC584wOm34WvnlX0Aojtv5aoDg6HqBrt5Zr1TrwX+x5t
         B4agfTUp/ENsezotOKE8wwp8hLPRQdfziy6+i2JvQyHwcN/Hno4P2LJ+xDafgQyzNvC9
         UPdQ8M4F+LzjeCIIRhC3iDbZdfZ8PXqSe8+53KZRFZzlmrPna92WRSmtY+t2Hh7Vyj0w
         BBkQ==
X-Gm-Message-State: AOJu0YyT+K2l2v8Ql4oeCDPZQe6sGYRYjEB/dgkqFn0IIx64pwsWxMHh
	mcnLXKa6G5+/+Gl85ue9YYAcbO44Rjw=
X-Google-Smtp-Source: AGHT+IGYmzZafrhZLJMnLBCby9oOdFi2ubcGNH5Vr98AzM0CgFBwp71WxUdIe1eoAdnlwzlwZeEY7Q==
X-Received: by 2002:a7b:cbc8:0:b0:40d:5fcc:3a65 with SMTP id n8-20020a7bcbc8000000b0040d5fcc3a65mr1171601wmi.113.1705186318350;
        Sat, 13 Jan 2024 14:51:58 -0800 (PST)
Received: from localhost (84-236-78-166.pool.digikabel.hu. [84.236.78.166])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b0040e3635ca65sm14543471wmb.2.2024.01.13.14.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 14:51:57 -0800 (PST)
Date: Sat, 13 Jan 2024 23:51:57 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <20240113225157.GD3000857@szeder.dev>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <ZZWOtnP2IHNldcy6@nand.local>
 <xmqqa5pm9tnx.fsf@gitster.g>
 <20240113183544.GA3000857@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240113183544.GA3000857@szeder.dev>

On Sat, Jan 13, 2024 at 07:35:44PM +0100, SZEDER Gábor wrote:
> On Wed, Jan 03, 2024 at 10:08:18AM -0800, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> > 
> > >> * tb/path-filter-fix (2023-10-18) 17 commits
> > >>  - bloom: introduce `deinit_bloom_filters()`
> > >>  ...
> > >>  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
> > >>
> > >>  The Bloom filter used for path limited history traversal was broken
> > >>  on systems whose "char" is unsigned; update the implementation and
> > >>  bump the format version to 2.
> > >>
> > >>  Expecting a reroll.
> > >>  cf. <20231023202212.GA5470@szeder.dev>
> > >>  source: <cover.1697653929.git.me@ttaylorr.com>
> > >
> > > I was confused by this one, since I couldn't figure out which tests
> > > Gábor was referring to here. I responded in [1], but haven't heard back
> > > since the end of October.
> > > ...
> > > [1]: https://lore.kernel.org/git/ZUARCJ1MmqgXfS4i@nand.local/
> 
> I keep referring to the test in:
> 
>   https://public-inbox.org/git/20230830200218.GA5147@szeder.dev/
> 
> which, rather disappointingly, is still the only test out there
> exercising the interaction between split commit graphs and different
> modified path Bloom filter versions.  Note that in that message I
> mentioned that merging layers with differenet Bloom filter versions
> seemed to work, but that, alas, is no longer the case, because it's
> now broken in Taylor's recent iterations of the patch series.
> 
> At the risk of sounding like a broken record: the interaction of split
> commit graphs and different Bloom filter versions should be thoroughly
> tested.

On a related note, if current git (I tried current master and v2.43.0)
encounters a commit graph layer containing v2 Bloom filters (created
by current seen) while writing a new commit graph, then it segfaults
dereferencing a NULL 'settings' pointer in
get_or_compute_bloom_filter().

The test below demonstrates this, but it's quite hacky using two
different git versions: it has to be run by an old git version not yet
supporting v2 Bloom filters, and a new git version already supporting
them should be installed at /tmp/git-new/.


diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 2ba0324a69..0464dd68d5 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -454,4 +454,33 @@ test_expect_success 'Bloom reader notices out-of-order index offsets' '
 	test_cmp expect.err err
 '
 
+CENT=$(printf "\302\242")
+test_expect_success 'split commit graph vs changed paths Bloom filter v2 vs old git' '
+	git init split-v2-old &&
+	(
+		cd split-v2-old &&
+		git commit --allow-empty -m "Bloom filters are written but still ignored for root commits :(" &&
+		for i in 1 2 3
+		do
+			echo $i >$CENT &&
+			git add $CENT &&
+			git commit -m "$i" || return 1
+		done &&
+		git log --oneline -- $CENT >expect &&
+
+		# Here we write a commit graph layer containing v2 changed
+		# path Bloom filters using a git binary built from current
+		# 'seen' branch.
+		git rev-parse HEAD^ |
+		/tmp/git-new/bin/git -c commitgraph.changedPathsVersion=2 \
+			commit-graph write --stdin-commits --changed-paths --split &&
+
+		# This is current master, and segfaults.
+		git commit-graph write --reachable --changed-paths &&
+
+		git log --oneline -- $CENT >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done



(gdb) r
Starting program: /home/szeder/src/git/git commit-graph write --reachable --changed-paths
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x00005555556b8714 in get_or_compute_bloom_filter (r=0x555555a0e5a0 <the_repo>, c=0x555555a1cdd0, compute_if_not_present=1, settings=0x0, computed=0x7fffffffd634) at bloom.c:253
253		diffopt.max_changes = settings->max_changed_paths;
(gdb) l
248			return NULL;
249	
250		repo_diff_setup(r, &diffopt);
251		diffopt.flags.recursive = 1;
252		diffopt.detect_rename = 0;
253		diffopt.max_changes = settings->max_changed_paths;
254		diff_setup_done(&diffopt);
255	
256		/* ensure commit is parsed so we have parent information */
257		repo_parse_commit(r, c);
(gdb) bt
#0  0x00005555556b8714 in get_or_compute_bloom_filter (
    r=0x555555a0e5a0 <the_repo>, c=0x555555a1cdd0, compute_if_not_present=1, 
    settings=0x0, computed=0x7fffffffd634) at bloom.c:253
#1  0x00005555556d16d5 in compute_bloom_filters (ctx=0x555555a1c200)
    at commit-graph.c:1783
#2  0x00005555556d4329 in write_commit_graph (odb=0x555555a19210, 
    pack_indexes=0x0, commits=0x7fffffffd7c0, 
    flags=(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_BLOOM_FILTERS), 
    opts=0x5555559ef8d0 <write_opts>) at commit-graph.c:2603
#3  0x00005555556d19ab in write_commit_graph_reachable (odb=0x555555a19210, 
    flags=(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_BLOOM_FILTERS), 
    opts=0x5555559ef8d0 <write_opts>) at commit-graph.c:1849
#4  0x00005555555a63c2 in graph_write (argc=0, argv=0x7fffffffde20, prefix=0x0)
    at builtin/commit-graph.c:294
#5  0x00005555555a66f4 in cmd_commit_graph (argc=3, argv=0x7fffffffde20, 
    prefix=0x0) at builtin/commit-graph.c:353
#6  0x0000555555575b43 in run_builtin (p=0x5555559da260 <commands+576>, 
    argc=4, argv=0x7fffffffde20) at git.c:469
#7  0x0000555555575fcb in handle_builtin (argc=4, argv=0x7fffffffde20)
    at git.c:724
#8  0x0000555555576272 in run_argv (argcp=0x7fffffffdc7c, argv=0x7fffffffdc70)
    at git.c:788
#9  0x000055555557685d in cmd_main (argc=4, argv=0x7fffffffde20) at git.c:923
#10 0x000055555568ad55 in main (argc=5, argv=0x7fffffffde18)
    at common-main.c:62



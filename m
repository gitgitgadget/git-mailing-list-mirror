Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F48C433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 16:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357800AbiDBQNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357789AbiDBQMw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 12:12:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B35275FF
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 09:10:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a1c440a000000b0038ccb70e239so136519wma.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+ABR2IUOcA9JxfSZn840tW3s/Bw2W1BGiZhChM2VdCs=;
        b=XPxXgnmStUInx4Gp/A7bUj8tQ3COIVi0GA/+9nmi+2UB9DjJ6PLw5VT79vX6AVUZPU
         eGQDBVzdGRy+IXxroT3QNhbR1a54EJViQhV6FyslxYozCWqaU3vYE1c22sz18eKBYPfX
         ru9EezrchvAQCtSAQjYRNedi/aAYKjySDYGCx3v3g1c/U1OcTL5dXzsf7iTbJVGaFfMo
         tFjCBrb7ghHNeltauzn2HDwR1C0+wfv/ImOB5xYZDVPL5by4tt6to+xzHAmfxGoQaQ7m
         9WyM1FlIbA6rVq6zk/ZX/dw7FN+GsnK+Grl1jYUu7DU55GkY3oXpqfA9DljrmQAx6wjW
         BRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+ABR2IUOcA9JxfSZn840tW3s/Bw2W1BGiZhChM2VdCs=;
        b=yR7ovrkSXKAnyr/x0QA8chwxaJhiWcmH0Em/mvXypTeziTIMLt9M7xaFbwHVjLZtgQ
         VkAKmREuCx/v32X+6v8YjeAdWNL8K4FA1HtzZThni+pC+HKUEE+eV2Hu9dmZPMCoJNRV
         z4fP2AC0kAlomXDM4GFCzKGqdhovARs76YILbBBJZD7JuDuadtk3RjbScslYWgq0vusL
         ctMzRwRyy0wjpoXTXPG30KfVAbbelPEXrccD62B0CuyMgyg53LFVlPoSG5buKEQuHl28
         laO5PZ+SfaEA3rknYuzbBbTz6/CdsqCUA0BTp+GlR0VOvjkeOXVzAHHIDkFRddnS5AXf
         bqSQ==
X-Gm-Message-State: AOAM532zbOrp0ngEps357dy5Y69+k+ujXD4p9+DvWeptS7o2RZ17DGvG
        Rl9jF8oKKI5omYHk5e3e9SjHBGnbmK8=
X-Google-Smtp-Source: ABdhPJw/MxM5iETU7vZeI3aSTZq1f7Nln++bfrjTZmAXTk7XNmdntH3vMymhtftFHmRDx3+Muq1pDg==
X-Received: by 2002:a7b:cc17:0:b0:38d:af7:3848 with SMTP id f23-20020a7bcc17000000b0038d0af73848mr13073959wmh.41.1648915854727;
        Sat, 02 Apr 2022 09:10:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m127-20020a1ca385000000b0038e6e7ac0b5sm173159wme.38.2022.04.02.09.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:10:54 -0700 (PDT)
Message-Id: <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 02 Apr 2022 16:10:47 +0000
Subject: [PATCH v2 0/6] More i18n fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another i18n PR (and hopefully the last for a while).

As usual, the intent is kept the same: curbing the number of strings to
translate, remove constant, error prone parts out of the way, trying in some
sense to "put a precedent" so that the template strings can be reused later.

Changes in v2:

 * Make the messages clearer as to what the placeholders are.
 * Generalize the quoting of placeholders
 * Merge the messages with bad arguments to one

Bagas Sanjaya (1):
  sequencer: factor GIT_AUTHOR_* from message strings

Jean-Noël Avila (5):
  i18n: factorize generic failure messages
  i18n: factorize server support messages in fetch-pack
  i18n: factorize "foo does not take arguments" messages
  i18n: factorize read-cache error messages
  i18n: factorize "bad argument" messages

 add-patch.c                     |  4 ++--
 builtin/am.c                    |  2 +-
 builtin/bisect--helper.c        |  2 +-
 builtin/commit-graph.c          |  2 +-
 builtin/config.c                |  2 +-
 builtin/env--helper.c           |  2 +-
 builtin/gc.c                    |  8 +++----
 builtin/merge.c                 |  6 ++---
 builtin/revert.c                |  4 ++--
 contrib/scalar/scalar.c         |  2 +-
 diff.c                          |  4 ++--
 fetch-pack.c                    | 40 ++++++++++++++++-----------------
 grep.c                          |  2 +-
 read-cache.c                    |  8 +++----
 ref-filter.c                    |  8 +++----
 remote-curl.c                   |  2 +-
 send-pack.c                     |  2 +-
 sequencer.c                     | 12 +++++-----
 setup.c                         |  4 ++--
 submodule-config.c              |  8 +++----
 submodule.c                     |  2 +-
 t/t1300-config.sh               |  2 +-
 t/t1600-index.sh                |  6 ++---
 t/t3510-cherry-pick-sequence.sh |  8 +++----
 t/t6436-merge-overwrite.sh      |  2 +-
 t/t7900-maintenance.sh          |  4 ++--
 26 files changed, 74 insertions(+), 74 deletions(-)


base-commit: 74cc1aa55f30ed76424a0e7226ab519aa6265061
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1181%2Fjnavila%2Fmore_i18n_fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1181/jnavila/more_i18n_fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1181

Range-diff vs v1:

 1:  73a3a8d7d97 ! 1:  4bba3e1f6cb i18n: factorize generic failure messages
     @@ Metadata
       ## Commit message ##
          i18n: factorize generic failure messages
      
     -    In these message the command that failed should not be translated. So
     -    it is simpler to just remove these parts from the message.
     +    In these message the command or the function that failed should not be
     +    translated. So it is simpler to just remove these parts from the
     +    message.
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     @@ add-patch.c: static int run_apply_check(struct add_p_state *s,
       	strvec_pushv(&cp.args, s->mode->apply_check_args);
       	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
      -		return error(_("'git apply --cached' failed"));
     -+		return error(_("'%s' failed"), "git apply --cached");
     ++		return error(_("the command '%s' failed"), "git apply --cached");
       
       	return 0;
       }
     @@ add-patch.c: soft_increment:
       			if (pipe_command(&cp, s->buf.buf, s->buf.len,
       					 NULL, 0, NULL, 0))
      -				error(_("'git apply' failed"));
     -+				error(_("'%s' failed"), "git apply");
     ++				error(_("the command '%s' failed"), "git apply");
       		}
       		if (repo_read_index(s->s.r) >= 0)
       			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
     @@ builtin/am.c: static int is_mail(FILE *fp)
       
       	if (fseek(fp, 0L, SEEK_SET))
      -		die_errno(_("fseek failed"));
     -+		die_errno(_("'%s' failed"), "fseek");
     ++		die_errno(_("the function '%s' failed"), "fseek");
       
       	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
       		die("invalid pattern: %s", header_regex);
     @@ builtin/gc.c: static int multi_pack_index_expire(struct maintenance_run_opts *op
       
       	if (run_command(&child))
      -		return error(_("'git multi-pack-index expire' failed"));
     -+		return error(_("'%s' failed"), "git multi-pack-index expire");
     ++		return error(_("the command '%s' failed"), "git multi-pack-index expire");
       
       	return 0;
       }
     @@ builtin/gc.c: static int multi_pack_index_repack(struct maintenance_run_opts *op
       
       	if (run_command(&child))
      -		return error(_("'git multi-pack-index repack' failed"));
     -+		return error(_("'%s' failed"), "git multi-pack-index repack");
     ++		return error(_("the command '%s' failed"), "git multi-pack-index repack");
       
       	return 0;
       }
     @@ builtin/merge.c: static int save_state(struct object_id *stash)
       
       	if (finish_command(&cp) || len < 0)
      -		die(_("stash failed"));
     -+		die(_("'%s' failed"), "stash");
     ++		die(_("the command '%s' failed"), "stash");
       	else if (!len)		/* no changes */
       		goto out;
       	strbuf_setlen(&buffer, buffer.len-1);
     @@ builtin/merge.c: static void read_empty(const struct object_id *oid, int verbose
       
       	if (run_command_v_opt(args, RUN_GIT_CMD))
      -		die(_("read-tree failed"));
     -+		die(_("'%s' failed"), "read-tree");
     ++		die(_("the command '%s' failed"), "read-tree");
       }
       
       static void reset_hard(const struct object_id *oid, int verbose)
     @@ builtin/merge.c: static void reset_hard(const struct object_id *oid, int verbose
       
       	if (run_command_v_opt(args, RUN_GIT_CMD))
      -		die(_("read-tree failed"));
     -+		die(_("'%s' failed"), "read-tree");
     ++		die(_("the command '%s' failed"), "read-tree");
       }
       
       static void restore_state(const struct object_id *head,
     @@ builtin/revert.c: int cmd_revert(int argc, const char **argv, const char *prefix
       	res = run_sequencer(argc, argv, &opts);
       	if (res < 0)
      -		die(_("revert failed"));
     -+		die(_("'%s' failed"), "revert");
     ++		die(_("the command '%s' failed"), "revert");
       	return res;
       }
       
     @@ builtin/revert.c: int cmd_cherry_pick(int argc, const char **argv, const char *p
       	res = run_sequencer(argc, argv, &opts);
       	if (res < 0)
      -		die(_("cherry-pick failed"));
     -+		die(_("'%s' failed"), "cherry-pick");
     ++		die(_("the command '%s' failed"), "cherry-pick");
       	return res;
       }
      
     @@ fetch-pack.c: static int get_pack(struct fetch_pack_args *args,
       			ret == 0;
       	else
      -		die(_("%s failed"), cmd_name);
     -+		die(_("'%s' failed"), cmd_name);
     ++		die(_("the command '%s' failed"), cmd_name);
       	if (use_sideband && finish_async(&demux))
       		die(_("error in sideband demultiplexer"));
       
     @@ remote-curl.c: static int push_dav(int nr_spec, const char **specs)
       
       	if (run_command(&child))
      -		die(_("git-http-push failed"));
     -+		die(_("'%s' failed"), "git-http-push");
     ++		die(_("the command '%s' failed"), "git-http-push");
       	return 0;
       }
       
     @@ setup.c: int daemonize(void)
       			break;
       		case -1:
      -			die_errno(_("fork failed"));
     -+			die_errno(_("'%s' failed"), "fork");
     ++			die_errno(_("the function '%s' failed"), "fork");
       		default:
       			exit(0);
       	}
       	if (setsid() == -1)
      -		die_errno(_("setsid failed"));
     -+		die_errno(_("'%s' failed"), "setsid");
     ++		die_errno(_("the function '%s' failed"), "setsid");
       	close(0);
       	close(1);
       	close(2);
     @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'check advice when we move
       	hint: have you committed already?
       	hint: try "git cherry-pick --continue"
      -	fatal: cherry-pick failed
     -+	fatal: '\''cherry-pick'\'' failed
     ++	fatal: the command '\''cherry-pick'\'' failed
       	EOF
       	test_must_fail git cherry-pick base..yetanotherpick &&
       	echo c >foo &&
     @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'selectively advise --skip
       	error: cherry-pick is already in progress
       	hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
      -	fatal: cherry-pick failed
     -+	fatal: '\''cherry-pick'\'' failed
     ++	fatal: the command '\''cherry-pick'\'' failed
       	EOF
       	test_must_fail git cherry-pick picked..yetanotherpick &&
       	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
     @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'selectively advise --skip
       	error: cherry-pick is already in progress
       	hint: try "git cherry-pick (--continue | --abort | --quit)"
      -	fatal: cherry-pick failed
     -+	fatal: '\''cherry-pick'\'' failed
     ++	fatal: the command '\''cherry-pick'\'' failed
       	EOF
       	git reset --merge &&
       	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
     @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'allow skipping commit but
       	cat >expect <<-EOF &&
       	error: cannot abort from a branch yet to be born
      -	fatal: cherry-pick failed
     -+	fatal: '\''cherry-pick'\'' failed
     ++	fatal: the command '\''cherry-pick'\'' failed
       	EOF
       	git checkout --orphan new_disconnected &&
       	git reset --hard &&
     @@ t/t6436-merge-overwrite.sh: test_expect_success 'will not be confused by symlink
       cat >expect <<\EOF
       error: Untracked working tree file 'c0.c' would be overwritten by merge.
      -fatal: read-tree failed
     -+fatal: 'read-tree' failed
     ++fatal: the command 'read-tree' failed
       EOF
       
       test_expect_success 'will not overwrite untracked file on unborn branch' '
 2:  8bdbb32f544 = 2:  03022a2fcd1 sequencer: factor GIT_AUTHOR_* from message strings
 3:  c94d5c932f4 < -:  ----------- i18n: factorize "bad argument" messages
 4:  bf23e1ebe65 ! 3:  b06b7670516 i18n: factorize "Server does not support foo" messages
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    i18n: factorize "Server does not support foo" messages
     +    i18n: factorize server support messages in fetch-pack
     +
     +    The messages "Server supports foo" and "Server does not support bar"
     +    are uniformized and options are quoted.
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## fetch-pack.c ##
      @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     - 		print_verbose(args, _("Server supports %s"), "deepen-since");
     + 		advertise_sid = 0;
     + 
     + 	if (server_supports("shallow"))
     +-		print_verbose(args, _("Server supports %s"), "shallow");
     ++		print_verbose(args, _("Server supports '%s'"), "shallow");
     + 	else if (args->depth > 0 || is_repository_shallow(r))
     + 		die(_("Server does not support shallow clients"));
     + 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
     + 		args->deepen = 1;
     + 	if (server_supports("multi_ack_detailed")) {
     +-		print_verbose(args, _("Server supports %s"), "multi_ack_detailed");
     ++		print_verbose(args, _("Server supports '%s'"), "multi_ack_detailed");
     + 		multi_ack = 2;
     + 		if (server_supports("no-done")) {
     +-			print_verbose(args, _("Server supports %s"), "no-done");
     ++			print_verbose(args, _("Server supports '%s'"), "no-done");
     + 			if (args->stateless_rpc)
     + 				no_done = 1;
     + 		}
     + 	}
     + 	else if (server_supports("multi_ack")) {
     +-		print_verbose(args, _("Server supports %s"), "multi_ack");
     ++		print_verbose(args, _("Server supports '%s'"), "multi_ack");
     + 		multi_ack = 1;
     + 	}
     + 	if (server_supports("side-band-64k")) {
     +-		print_verbose(args, _("Server supports %s"), "side-band-64k");
     ++		print_verbose(args, _("Server supports '%s'"), "side-band-64k");
     + 		use_sideband = 2;
     + 	}
     + 	else if (server_supports("side-band")) {
     +-		print_verbose(args, _("Server supports %s"), "side-band");
     ++		print_verbose(args, _("Server supports '%s'"), "side-band");
     + 		use_sideband = 1;
     + 	}
     + 	if (server_supports("allow-tip-sha1-in-want")) {
     +-		print_verbose(args, _("Server supports %s"), "allow-tip-sha1-in-want");
     ++		print_verbose(args, _("Server supports '%s'"), "allow-tip-sha1-in-want");
     + 		allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
     + 	}
     + 	if (server_supports("allow-reachable-sha1-in-want")) {
     +-		print_verbose(args, _("Server supports %s"), "allow-reachable-sha1-in-want");
     ++		print_verbose(args, _("Server supports '%s'"), "allow-reachable-sha1-in-want");
     + 		allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
     + 	}
     + 	if (server_supports("thin-pack"))
     +-		print_verbose(args, _("Server supports %s"), "thin-pack");
     ++		print_verbose(args, _("Server supports '%s'"), "thin-pack");
     + 	else
     + 		args->use_thin_pack = 0;
     + 	if (server_supports("no-progress"))
     +-		print_verbose(args, _("Server supports %s"), "no-progress");
     ++		print_verbose(args, _("Server supports '%s'"), "no-progress");
     + 	else
     + 		args->no_progress = 0;
     + 	if (server_supports("include-tag"))
     +-		print_verbose(args, _("Server supports %s"), "include-tag");
     ++		print_verbose(args, _("Server supports '%s'"), "include-tag");
     + 	else
     + 		args->include_tag = 0;
     + 	if (server_supports("ofs-delta"))
     +-		print_verbose(args, _("Server supports %s"), "ofs-delta");
     ++		print_verbose(args, _("Server supports '%s'"), "ofs-delta");
     + 	else
     + 		prefer_ofs_delta = 0;
     + 
     + 	if (server_supports("filter")) {
     + 		server_supports_filtering = 1;
     +-		print_verbose(args, _("Server supports %s"), "filter");
     ++		print_verbose(args, _("Server supports '%s'"), "filter");
     + 	} else if (args->filter_options.choice) {
     + 		warning("filtering not recognized by server, ignoring");
     + 	}
     + 
     + 	if (server_supports("deepen-since")) {
     +-		print_verbose(args, _("Server supports %s"), "deepen-since");
     ++		print_verbose(args, _("Server supports '%s'"), "deepen-since");
       		deepen_since_ok = 1;
       	} else if (args->deepen_since)
      -		die(_("Server does not support --shallow-since"));
     -+		die(_("Server does not support %s"), "--shallow-since");
     ++		die(_("Server does not support '%s'"), "--shallow-since");
       	if (server_supports("deepen-not")) {
     - 		print_verbose(args, _("Server supports %s"), "deepen-not");
     +-		print_verbose(args, _("Server supports %s"), "deepen-not");
     ++		print_verbose(args, _("Server supports '%s'"), "deepen-not");
       		deepen_not_ok = 1;
       	} else if (args->deepen_not)
      -		die(_("Server does not support --shallow-exclude"));
     -+		die(_("Server does not support %s"), "--shallow-exclude");
     ++		die(_("Server does not support '%s'"), "--shallow-exclude");
       	if (server_supports("deepen-relative"))
     - 		print_verbose(args, _("Server supports %s"), "deepen-relative");
     +-		print_verbose(args, _("Server supports %s"), "deepen-relative");
     ++		print_verbose(args, _("Server supports '%s'"), "deepen-relative");
       	else if (args->deepen_relative)
      -		die(_("Server does not support --deepen"));
     -+		die(_("Server does not support %s"), "--deepen");
     ++		die(_("Server does not support '%s'"), "--deepen");
       	if (!server_supports_hash(the_hash_algo->name, NULL))
       		die(_("Server does not support this repository's object format"));
       
 5:  2e1bd504673 ! 4:  6221c37145c i18n: factorize "foo does not take arguments" messages
     @@ Metadata
       ## Commit message ##
          i18n: factorize "foo does not take arguments" messages
      
     +    The messages are split into the ones for ref-filter which deal with
     +    atoms and scalar which has an option.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## contrib/scalar/scalar.c ##
     @@ contrib/scalar/scalar.c: cleanup:
       {
       	if (argc != 1)
      -		die(_("`scalar list` does not take arguments"));
     -+		die(_("%s does not take arguments"), "`scalar list`");
     ++		die(_("the '%s' command does not take arguments"), "scalar list");
       
       	if (run_git("config", "--global", "--get-all", "scalar.repo", NULL) < 0)
       		return -1;
     @@ ref-filter.c: static int objecttype_atom_parser(struct ref_format *format, struc
       {
       	if (arg)
      -		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arguments"));
     -+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(objecttype)");
     ++		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take arguments"), "%(objecttype)");
       	if (*atom->name == '*')
       		oi_deref.info.typep = &oi_deref.type;
       	else
     @@ ref-filter.c: static int deltabase_atom_parser(struct ref_format *format, struct
       {
       	if (arg)
      -		return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
     -+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(deltabase)");
     ++		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take arguments"), "%(deltabase)");
       	if (*atom->name == '*')
       		oi_deref.info.delta_base_oid = &oi_deref.delta_base_oid;
       	else
     @@ ref-filter.c: static int body_atom_parser(struct ref_format *format, struct used
       {
       	if (arg)
      -		return strbuf_addf_ret(err, -1, _("%%(body) does not take arguments"));
     -+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(body)");
     ++		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take arguments"), "%(body)");
       	atom->u.contents.option = C_BODY_DEP;
       	return 0;
       }
     @@ ref-filter.c: static int rest_atom_parser(struct ref_format *format, struct used
       {
       	if (arg)
      -		return strbuf_addf_ret(err, -1, _("%%(rest) does not take arguments"));
     -+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(rest)");
     ++		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take arguments"), "%(rest)");
       	format->use_rest = 1;
       	return 0;
       }
 6:  b8f97e6fde8 ! 5:  1888778902a i18n: factorize read-cache error messages
     @@ read-cache.c: static unsigned int get_index_format_default(struct repository *r)
       		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
      -			warning(_("index.version set, but the value is invalid.\n"
      -				  "Using version %i"), INDEX_FORMAT_DEFAULT);
     -+			warning(_("%s set, but the value is invalid.\n"
     ++			warning(_("'%s' set, but the value is invalid.\n"
      +				  "Using version %i"), "index.version", INDEX_FORMAT_DEFAULT);
       			return INDEX_FORMAT_DEFAULT;
       		}
     @@ read-cache.c: static unsigned int get_index_format_default(struct repository *r)
       	    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
      -		warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
      -			  "Using version %i"), INDEX_FORMAT_DEFAULT);
     -+		warning(_("%s set, but the value is invalid.\n"
     ++		warning(_("'%s' set, but the value is invalid.\n"
      +			  "Using version %i"), "GIT_INDEX_VERSION", INDEX_FORMAT_DEFAULT);
       		version = INDEX_FORMAT_DEFAULT;
       	}
       	return version;
     +
     + ## t/t1600-index.sh ##
     +@@ t/t1600-index.sh: test_expect_success 'bogus GIT_INDEX_VERSION issues warning' '
     + 		git add a 2>err &&
     + 		sed "s/[0-9]//" err >actual.err &&
     + 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
     +-			warning: GIT_INDEX_VERSION set, but the value is invalid.
     ++			warning: '\''GIT_INDEX_VERSION'\'' set, but the value is invalid.
     + 			Using version Z
     + 		EOF
     + 		test_cmp expect.err actual.err
     +@@ t/t1600-index.sh: test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
     + 		git add a 2>err &&
     + 		sed "s/[0-9]//" err >actual.err &&
     + 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
     +-			warning: GIT_INDEX_VERSION set, but the value is invalid.
     ++			warning: '\''GIT_INDEX_VERSION'\'' set, but the value is invalid.
     + 			Using version Z
     + 		EOF
     + 		test_cmp expect.err actual.err
     +@@ t/t1600-index.sh: test_expect_success 'out of bounds index.version issues warning' '
     + 		git add a 2>err &&
     + 		sed "s/[0-9]//" err >actual.err &&
     + 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
     +-			warning: index.version set, but the value is invalid.
     ++			warning: '\''index.version'\'' set, but the value is invalid.
     + 			Using version Z
     + 		EOF
     + 		test_cmp expect.err actual.err
 7:  ca52567b201 ! 6:  febe64a8a06 i18n: factorize unrecognized options arguments messages
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    i18n: factorize unrecognized options arguments messages
     +    i18n: factorize "bad argument" messages
     +
     +    We also quote the placeholders as they replace constant strings.
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     + ## builtin/bisect--helper.c ##
     +@@ builtin/bisect--helper.c: static int bisect_write(const char *state, const char *rev,
     + 	} else if (one_of(state, terms->term_good, "skip", NULL)) {
     + 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
     + 	} else {
     +-		res = error(_("Bad bisect_write argument: %s"), state);
     ++		res = error(_("bad '%s' argument: '%s'"), "bisect_write", state);
     + 		goto finish;
     + 	}
     + 
     +
       ## builtin/commit-graph.c ##
      @@ builtin/commit-graph.c: static int write_option_parse_split(const struct option *opt, const char *arg,
       	else if (!strcmp(arg, "replace"))
       		*flags = COMMIT_GRAPH_SPLIT_REPLACE;
       	else
      -		die(_("unrecognized --split argument, %s"), arg);
     -+		die(_("unrecognized %s argument '%s'"), "--split", arg);
     ++		die(_("bad '%s' argument: '%s'"), "--split", arg);
       
       	return 0;
       }
     @@ builtin/config.c: static int option_parse_type(const struct option *opt, const c
       			new_type = TYPE_COLOR;
       		else
      -			die(_("unrecognized --type argument, %s"), arg);
     -+			die(_("unrecognized %s argument '%s'"), "--type", arg);
     ++			die(_("bad '%s' argument: '%s'"), "--type", arg);
       	}
       
       	to_type = opt->value;
     @@ builtin/env--helper.c: static int option_parse_type(const struct option *opt, co
       		*cmdmode = ENV_HELPER_TYPE_ULONG;
       	else
      -		die(_("unrecognized --type argument, %s"), arg);
     -+		die(_("unrecognized %s argument '%s'"), "--type", arg);
     ++		die(_("bad '%s' argument: '%s'"), "--type", arg);
       
       	return 0;
       }
     @@ builtin/gc.c: static int maintenance_opt_schedule(const struct option *opt, cons
       
       	if (!*priority)
      -		die(_("unrecognized --schedule argument '%s'"), arg);
     -+		die(_("unrecognized %s argument '%s'"), "--schedule", arg);
     ++		die(_("bad '%s' argument: '%s'"), "--schedule", arg);
       
       	return 0;
       }
     @@ builtin/gc.c: static int maintenance_opt_scheduler(const struct option *opt, con
       	*scheduler = parse_scheduler(arg);
       	if (*scheduler == SCHEDULER_INVALID)
      -		return error(_("unrecognized --scheduler argument '%s'"), arg);
     -+		return error(_("unrecognized %s argument '%s'"), "--scheduler", arg);
     ++		return error(_("bad '%s' argument: '%s'"), "--scheduler", arg);
     + 	return 0;
     + }
     + 
     +
     + ## diff.c ##
     +@@ diff.c: static int diff_opt_color_moved(const struct option *opt,
     + 	} else {
     + 		int cm = parse_color_moved(arg);
     + 		if (cm < 0)
     +-			return error(_("bad --color-moved argument: %s"), arg);
     ++			return error(_("bad '%s' argument: '%s'"), "--color-moved", arg);
     + 		options->color_moved = cm;
     + 	}
       	return 0;
     +@@ diff.c: static int diff_opt_word_diff(const struct option *opt,
     + 		else if (!strcmp(arg, "none"))
     + 			options->word_diff = DIFF_WORDS_NONE;
     + 		else
     +-			return error(_("bad --word-diff argument: %s"), arg);
     ++			return error(_("bad '%s' argument: '%s'"), "--word-diff", arg);
     + 	} else {
     + 		if (options->word_diff == DIFF_WORDS_NONE)
     + 			options->word_diff = DIFF_WORDS_PLAIN;
     +
     + ## grep.c ##
     +@@ grep.c: static int parse_pattern_type_arg(const char *opt, const char *arg)
     + 		return GREP_PATTERN_TYPE_FIXED;
     + 	else if (!strcmp(arg, "perl"))
     + 		return GREP_PATTERN_TYPE_PCRE;
     +-	die("bad %s argument: %s", opt, arg);
     ++	die("bad '%s' argument: '%s'", opt, arg);
     + }
     + 
     + define_list_config_array_extra(color_grep_slots, {"match"});
     +
     + ## send-pack.c ##
     +@@ send-pack.c: int option_parse_push_signed(const struct option *opt,
     + 		*(int *)(opt->value) = SEND_PACK_PUSH_CERT_IF_ASKED;
     + 		return 0;
     + 	}
     +-	die("bad %s argument: %s", opt->long_name, arg);
     ++	die("bad '%s' argument: '%s'", opt->long_name, arg);
     + }
     + 
     + static void feed_object(const struct object_id *oid, FILE *fh, int negative)
     +
     + ## submodule-config.c ##
     +@@ submodule-config.c: static int parse_fetch_recurse(const char *opt, const char *arg,
     + 		 * git-completion.bash when you add new options.
     + 		 */
     + 		if (die_on_error)
     +-			die("bad %s argument: %s", opt, arg);
     ++			die("bad '%s' argument: '%s'", opt, arg);
     + 		else
     + 			return RECURSE_SUBMODULES_ERROR;
     + 	}
     +@@ submodule-config.c: static int parse_update_recurse(const char *opt, const char *arg,
     + 		return RECURSE_SUBMODULES_OFF;
     + 	default:
     + 		if (die_on_error)
     +-			die("bad %s argument: %s", opt, arg);
     ++			die("bad '%s' argument: '%s'", opt, arg);
     + 		return RECURSE_SUBMODULES_ERROR;
     + 	}
       }
     +@@ submodule-config.c: static int parse_push_recurse(const char *opt, const char *arg,
     + 	case 1:
     + 		/* There's no simple "on" value when pushing */
     + 		if (die_on_error)
     +-			die("bad %s argument: %s", opt, arg);
     ++			die("bad '%s' argument: '%s'", opt, arg);
     + 		else
     + 			return RECURSE_SUBMODULES_ERROR;
     + 	case 0:
     +@@ submodule-config.c: static int parse_push_recurse(const char *opt, const char *arg,
     + 		 * git-completion.bash when you add new modes.
     + 		 */
     + 		else if (die_on_error)
     +-			die("bad %s argument: %s", opt, arg);
     ++			die("bad '%s' argument: '%s'", opt, arg);
     + 		else
     + 			return RECURSE_SUBMODULES_ERROR;
     + 	}
     +
     + ## submodule.c ##
     +@@ submodule.c: void handle_ignore_submodules_arg(struct diff_options *diffopt,
     + 	else if (!strcmp(arg, "dirty"))
     + 		diffopt->flags.ignore_dirty_submodules = 1;
     + 	else if (strcmp(arg, "none"))
     +-		die(_("bad --ignore-submodules argument: %s"), arg);
     ++		die(_("bad '%s' argument: '%s'"), "--ignore-submodules", arg);
     + 	/*
     + 	 * Please update _git_status() in git-completion.bash when you
     + 	 * add new options
     +
     + ## t/t1300-config.sh ##
     +@@ t/t1300-config.sh: test_expect_success 'unset type specifiers may be reset to conflicting ones' '
     + 
     + test_expect_success '--type rejects unknown specifiers' '
     + 	test_must_fail git config --type=nonsense section.foo 2>error &&
     +-	test_i18ngrep "unrecognized --type argument" error
     ++	test_i18ngrep "bad '\''--type'\'' argument" error
     + '
     + 
     + test_expect_success '--replace-all does not invent newlines' '
     +
     + ## t/t7900-maintenance.sh ##
     +@@ t/t7900-maintenance.sh: test_expect_success '--auto and --schedule incompatible' '
     + 
     + test_expect_success 'invalid --schedule value' '
     + 	test_must_fail git maintenance run --schedule=annually 2>err &&
     +-	test_i18ngrep "unrecognized --schedule" err
     ++	test_i18ngrep "bad '\''--schedule'\''" err
     + '
     + 
     + test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
     +@@ t/t7900-maintenance.sh: test_expect_success !MINGW 'register and unregister with regex metacharacters' '
     + 
     + test_expect_success 'start --scheduler=<scheduler>' '
     + 	test_expect_code 129 git maintenance start --scheduler=foo 2>err &&
     +-	test_i18ngrep "unrecognized --scheduler argument" err &&
     ++	test_i18ngrep "bad '\''--scheduler'\'' argument" err &&
       
     + 	test_expect_code 129 git maintenance start --no-scheduler 2>err &&
     + 	test_i18ngrep "unknown option" err &&

-- 
gitgitgadget

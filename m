From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 18:54:29 -0500
Message-ID: <CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
	<7vfvxm6biv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:54:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud80Z-00030U-Bq
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab3EPXyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:54:36 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:45453 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab3EPXyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:54:32 -0400
Received: by mail-lb0-f180.google.com with SMTP id r10so77656lbi.25
        for <git@vger.kernel.org>; Thu, 16 May 2013 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DD0jLrvKH4eww3TJOe7F6Yt7GfZns7dfps+wUrtNiUo=;
        b=roPACvkff6k1PKZOUyZHRDe3GqPCvbVuBeAKC4eajNEaPn2jrany7lFrySn0CAUpw4
         7sdT9XVREuSwcUG/F7Duzr9vpobWfpsjDdfUUGFJ1sv9tGJo6PvOJSmPudWjDwyDrj9f
         aOn5FZou6WySpSj0Q2HaJjjT6bX/hFimcFcsczN3OaEm3WF7ZESCh2WQ9s1TzJjJN1yN
         9jOOOoUBKgozutinS7WL+/S1ZKDytzzGXWr0jet9u8sZ0EY9HkNR7cYz2GNOFJIwvhSI
         eR6nc3dVKrY8vhd/st34FX5qCM/lxJ3FBQa6UVPP2q/Mng2g0/jyE2ipKGySfBYjDm2j
         s4Tg==
X-Received: by 10.112.135.70 with SMTP id pq6mr21238667lbb.82.1368748469617;
 Thu, 16 May 2013 16:54:29 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 16:54:29 -0700 (PDT)
In-Reply-To: <7vfvxm6biv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224639>

On Thu, May 16, 2013 at 1:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> You find it sensible, I don't. And when people disagree, that's what
>> the guideline is for.
>
> If you really need it to be spelled out, I would say it would be
> something like this:
>
>     (defun linux-style ()
>       "C mode with adjusted defaults for use with the Linux kernel."
>       (interactive)
>       (c-set-style "K&R")
>       (setq tab-width 8)
>       (setq indent-tabs-mode t)
>       (setq c-basic-offset 8))
>
>     (add-hook 'c-mode-hook 'linux-style)

*You* are telling my that; it's *your* opinion and nothing else. It's
not the opinion of the *project*, and it's not the guideline of the
*project*.

Who says that maybe next week you won't change your opinion? Well,
that's what Documentation/CodingGuidelines is for.

Keep rejecting patches arbitrarily on your whims, rather than
established guidelines.

This is what Linux's checkpatch throws:

---
% ~/dev/linux/scripts/checkpatch.pl patch
WARNING: line over 80 characters
#108: FILE: builtin/fast-export.c:470:
+					die("Can't find replacement commit for tag %s\n",

total: 0 errors, 1 warnings, 92 lines checked

patch has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
--

But no, it's good enough for Linux, but it's not good enough for
Junio? Why? Because he says so.

Surely it cannot be an exercise in authoritarianism, if Junio says so,
the project does clearly have this guideline, it's just that is not
explicitly stated, and this style is violated, it should be in very
few places.

So lets run 'checkpatch --strict' for the whole project and lets see
how many places "violate" this style;

---
CHECK: Alignment should match open parenthesis
#653: FILE: setup.c:653:
+		die_errno("failed to stat '%*s%s%s'",
+				prefix_len,

CHECK: Alignment should match open parenthesis
#248: FILE: commit.c:248:
+		memmove(commit_graft + pos, commit_graft + pos + 1,
+				sizeof(struct commit_graft *)

CHECK: Alignment should match open parenthesis
#112: FILE: remote-testsvn.c:112:
+	if (!(msg = read_sha1_file(note_sha1, &type, &msglen)) ||
+			!msglen || type != OBJ_BLOB) {

CHECK: Alignment should match open parenthesis
#276: FILE: remote-testsvn.c:276:
+		if (!prefixcmp(line->buf, p->name) && (strlen(p->name) == line->len ||
+				line->buf[strlen(p->name)] == ' ')) {

CHECK: Alignment should match open parenthesis
#323: FILE: remote-testsvn.c:323:
+	strbuf_addf(&marksfilename_sb, "%s/info/fast-import/remote-svn/%s.marks",
+		get_git_dir(), remote->name);

CHECK: Alignment should match open parenthesis
#61: FILE: levenshtein.c:61:
+			if (i > 0 && j > 0 && string1[i - 1] == string2[j] &&
+					string1[i] == string2[j - 1] &&

CHECK: Alignment should match open parenthesis
#1105: FILE: config.c:1105:
+			if (strrchr(key, '.') - key == store.baselen &&
+			      !strncmp(key, store.key, store.baselen)) {

CHECK: Alignment should match open parenthesis
#1397: FILE: config.c:1397:
+			if (regcomp(store.value_regex, value_regex,
+					REG_EXTENDED)) {

CHECK: Alignment should match open parenthesis
#1434: FILE: config.c:1434:
+		if ((store.seen == 0 && value == NULL) ||
+				(store.seen > 1 && multi_replace == 0)) {

CHECK: Alignment should match open parenthesis
#214: FILE: read-cache.c:214:
+		if (ce->ce_uid != (unsigned int) st->st_uid ||
+			ce->ce_gid != (unsigned int) st->st_gid)

CHECK: Alignment should match open parenthesis
#522: FILE: read-cache.c:522:
+	if (pos >= istate->cache_nr ||
+			compare_name((ce = istate->cache[pos]), path, namelen))

CHECK: Alignment should match open parenthesis
#527: FILE: read-cache.c:527:
+	if (ce_stage(ce) == 1 && pos + 1 < istate->cache_nr &&
+			ce_stage((ce = istate->cache[pos + 1])) == 2 &&

CHECK: Alignment should match open parenthesis
#834: FILE: imap-send.c:834:
+				fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
+					 memcmp(cmdp->cmd, "LOGIN", 5) ?

CHECK: Alignment should match open parenthesis
#28: FILE: test-svn-fe.c:28:
+	if (svndiff0_apply(&delta, (off_t) strtoumax(argv[4], NULL, 0),
+					&preimage_view, stdout))

CHECK: Alignment should match open parenthesis
#162: FILE: daemon.c:162:
+		strbuf_expand(&expanded_path, interpolated_path,
+				strbuf_expand_dict_cb, &dict);

CHECK: Alignment should match open parenthesis
#759: FILE: daemon.c:759:
+		inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf + 12,
+		    sizeof(addrbuf) - 12);

CHECK: Alignment should match open parenthesis
#761: FILE: daemon.c:761:
+		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
+		    ntohs(sin_addr->sin_port));

CHECK: Alignment should match open parenthesis
#769: FILE: daemon.c:769:
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf,
+		    sizeof(addrbuf) - 13);

CHECK: Alignment should match open parenthesis
#773: FILE: daemon.c:773:
+		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
+		    ntohs(sin6_addr->sin6_port));

CHECK: Alignment should match open parenthesis
#1017: FILE: daemon.c:1017:
+				logerror("Poll failed, resuming: %s",
+				      strerror(errno));

CHECK: Alignment should match open parenthesis
#1092: FILE: daemon.c:1092:
+	if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
+	    setgid (cred->gid) || setuid(cred->pass->pw_uid)))

CHECK: Alignment should match open parenthesis
#103: FILE: vcs-svn/fast_export.c:103:
+		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN,
+				"\n\ngit-svn-id: %s@%"PRIu32" %s\n",

CHECK: Alignment should match open parenthesis
#111: FILE: vcs-svn/fast_export.c:111:
+	printf("committer %s <%s@%s> %ld +0000\n",
+		   *author ? author : "nobody",

CHECK: Alignment should match open parenthesis
#115: FILE: vcs-svn/fast_export.c:115:
+	printf("data %"PRIuMAX"\n",
+		(uintmax_t) (log->len + strlen(gitsvnline)));

CHECK: Alignment should match open parenthesis
#300: FILE: vcs-svn/svndump.c:300:
+	fast_export_blob_delta(node_ctx.type, old_mode, old_data,
+				node_ctx.text_length, &input);

CHECK: Alignment should match open parenthesis
#308: FILE: vcs-svn/svndump.c:308:
+	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author.buf,
+		&rev_ctx.log, dump_ctx.uuid.buf, dump_ctx.url.buf,

CHECK: Alignment should match open parenthesis
#318: FILE: vcs-svn/svndump.c:318:
+		fast_export_begin_note(rev_ctx.revision, "remote-svn",
+				"Note created by remote-svn.", rev_ctx.timestamp, note_ref);

CHECK: Alignment should match open parenthesis
#238: FILE: wrapper.c:238:
+		die_errno("Unable to create temporary file '%s'",
+			nonrelative_template);

CHECK: Alignment should match open parenthesis
#373: FILE: wrapper.c:373:
+		die_errno("Unable to create temporary file '%s'",
+			nonrelative_template);

CHECK: Alignment should match open parenthesis
#239: FILE: ws.c:239:
+			fwrite(line + written,
+			    trailing_whitespace - written, 1, stream);

CHECK: Alignment should match open parenthesis
#247: FILE: ws.c:247:
+			fwrite(line + trailing_whitespace,
+			    len - trailing_whitespace, 1, stream);

CHECK: Alignment should match open parenthesis
#14: FILE: contrib/svn-fe/svn-fe.c:14:
+	svndump_read((argc > 1) ? argv[1] : NULL, "refs/heads/master",
+			"refs/notes/svn/revs");

CHECK: Alignment should match open parenthesis
#167: FILE: contrib/credential/wincred/git-credential-wincred.c:167:
+			write_item("username", creds[i]->UserName,
+				wcslen(creds[i]->UserName));

CHECK: Alignment should match open parenthesis
#169: FILE: contrib/credential/wincred/git-credential-wincred.c:169:
+			write_item("password",
+				(LPCWSTR)creds[i]->CredentialBlob,

CHECK: Alignment should match open parenthesis
#680: FILE: upload-pack.c:680:
+				packet_write(1, "shallow %s",
+						sha1_to_hex(object->sha1));

CHECK: Alignment should match open parenthesis
#692: FILE: upload-pack.c:692:
+				packet_write(1, "unshallow %s",
+					sha1_to_hex(object->sha1));

CHECK: Alignment should match open parenthesis
#702: FILE: upload-pack.c:702:
+					add_object_array(&parents->item->object,
+							NULL, &want_obj);

CHECK: Alignment should match open parenthesis
#556: FILE: transport-helper.c:556:
+		die("Unknown response to connect: %s",
+			cmdbuf.buf);

CHECK: Alignment should match open parenthesis
#1038: FILE: transport-helper.c:1038:
+	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		errno != EINTR) {

CHECK: Alignment should match open parenthesis
#1043: FILE: transport-helper.c:1043:
+		transfer_debug("%s EOF (with %i bytes in buffer)",
+			t->src_name, t->bufuse);

CHECK: Alignment should match open parenthesis
#1048: FILE: transport-helper.c:1048:
+		transfer_debug("Read %i bytes from %s (buffer now at %i)",
+			(int)bytes, t->src_name, (int)t->bufuse);

CHECK: Alignment should match open parenthesis
#1066: FILE: transport-helper.c:1066:
+	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		errno != EINTR) {

CHECK: Alignment should match open parenthesis
#1074: FILE: transport-helper.c:1074:
+		transfer_debug("Wrote %i bytes to %s (buffer now at %i)",
+			(int)bytes, t->dest_name, (int)t->bufuse);

CHECK: Alignment should match open parenthesis
#142: FILE: send-pack.c:142:
+			warning("remote reported status on unknown ref: %s",
+					refname);

CHECK: Alignment should match open parenthesis
#147: FILE: send-pack.c:147:
+			warning("remote reported status on unexpected ref: %s",
+					refname);

CHECK: Alignment should match open parenthesis
#87: FILE: http-fetch.c:87:
+		fprintf(stderr,
+"Some loose object were found to be corrupt, but they might be just\n"

CHECK: Alignment should match open parenthesis
#335: FILE: sha1_file.c:335:
+		error("%s: ignoring alternate object stores, nesting too deep.",
+				relative_base);

CHECK: Alignment should match open parenthesis
#347: FILE: sha1_file.c:347:
+			error("%s: ignoring relative alternate object store %s",
+					relative_base, entry);

CHECK: Alignment should match open parenthesis
#900: FILE: sha1_file.c:900:
+				die("packfile %s cannot be mapped: %s",
+					p->pack_name,

CHECK: Alignment should match open parenthesis
#778: FILE: combine-diff.c:778:
+				printf("%s%s %s%s", c_reset,
+						    c_plain, c_reset,

CHECK: Alignment should match open parenthesis
#444: FILE: pretty.c:444:
+			strbuf_add_wrapped_bytes(sb, quoted.buf, quoted.len,
+							-6, 1, max_length);

CHECK: Alignment should match open parenthesis
#581: FILE: pretty.c:581:
+		strbuf_splice(&tmp, start + strlen("encoding "),
+					  len - strlen("encoding \n"),

CHECK: Alignment should match open parenthesis
#1596: FILE: pretty.c:1596:
+			add_rfc2047(sb, title.buf, title.len,
+						encoding, RFC2047_SUBJECT);

CHECK: Alignment should match open parenthesis
#1599: FILE: pretty.c:1599:
+			strbuf_add_wrapped_bytes(sb, title.buf, title.len,
+					 -last_line_length(sb), 1, max_length);

CHECK: Alignment should match open parenthesis
#202: FILE: rerere.c:202:
+				git_SHA1_Update(&ctx, one.buf ? one.buf : "",
+					    one.len + 1);

CHECK: Alignment should match open parenthesis
#204: FILE: rerere.c:204:
+				git_SHA1_Update(&ctx, two.buf ? two.buf : "",
+					    two.len + 1);

CHECK: Alignment should match open parenthesis
#443: FILE: rerere.c:443:
+	if (read_mmfile(&cur, rerere_path(name, "thisimage")) ||
+			read_mmfile(&base, rerere_path(name, "preimage")) ||

CHECK: Alignment should match open parenthesis
#454: FILE: rerere.c:454:
+			warning("failed utime() on %s: %s",
+					rerere_path(name, "postimage"),

CHECK: Alignment should match open parenthesis
#97: FILE: shallow.c:97:
+					add_object_array(&p->item->object,
+							NULL, &stack);

CHECK: Alignment should match open parenthesis
#250: FILE: diff.c:250:
+	if (!strcmp(var, "diff.suppressblankempty") ||
+			/* for backwards compatibility */

CHECK: Alignment should match open parenthesis
#826: FILE: diff.c:826:
+	if ((diff_words->last_minus == 0 &&
+		diff_words->current_plus == diff_words->plus.text.ptr) ||

CHECK: Alignment should match open parenthesis
#845: FILE: diff.c:845:
+	if (line[0] != '@' || parse_hunk_header(line, len,
+			&minus_first, &minus_len, &plus_first, &plus_len))

CHECK: Alignment should match open parenthesis
#871: FILE: diff.c:871:
+		fn_out_diff_words_write_helper(diff_words->opt->file,
+				&style->ctx, style->newline,

CHECK: Alignment should match open parenthesis
#879: FILE: diff.c:879:
+		fn_out_diff_words_write_helper(diff_words->opt->file,
+				&style->old, style->newline,

CHECK: Alignment should match open parenthesis
#885: FILE: diff.c:885:
+		fn_out_diff_words_write_helper(diff_words->opt->file,
+				&style->new, style->newline,

CHECK: Alignment should match open parenthesis
#949: FILE: diff.c:949:
+		ALLOC_GROW(buffer->orig, buffer->orig_nr + 1,
+				buffer->orig_alloc);

CHECK: Alignment should match open parenthesis
#982: FILE: diff.c:982:
+		fn_out_diff_words_write_helper(diff_words->opt->file,
+			&style->old, style->newline,

CHECK: Alignment should match open parenthesis
#1008: FILE: diff.c:1008:
+		fn_out_diff_words_write_helper(diff_words->opt->file,
+			&style->ctx, style->newline,

CHECK: Alignment should match open parenthesis
#2253: FILE: diff.c:2253:
+	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
+			(!one->mode || S_ISGITLINK(one->mode)) &&

CHECK: Alignment should match open parenthesis
#2258: FILE: diff.c:2258:
+		show_submodule_summary(o->file, one ? one->path : two->path,
+				line_prefix,

CHECK: Alignment should match open parenthesis
#2321: FILE: diff.c:2321:
+			emit_rewrite_diff(name_a, name_b, one, two,
+						textconv_one, textconv_two, o);

CHECK: Alignment should match open parenthesis
#2801: FILE: diff.c:2801:
+	if (convert_to_working_tree(path,
+			(const char *)blob, (size_t)size, &buf)) {

CHECK: Alignment should match open parenthesis
#3496: FILE: diff.c:3496:
+		die(_("Failed to parse --submodule option parameter: '%s'"),
+			value);

CHECK: Alignment should match open parenthesis
#4272: FILE: diff.c:4272:
+		if (fill_mmfile(&mf1, p->one) < 0 ||
+				fill_mmfile(&mf2, p->two) < 0)

CHECK: Alignment should match open parenthesis
#196: FILE: remote-curl.c:196:
+	if ((!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) &&
+	     git_env_bool("GIT_SMART_HTTP", 1)) {

CHECK: Alignment should match open parenthesis
#1420: FILE: remote.c:1420:
+		if (!ref->deletion &&
+			!hashcmp(ref->old_sha1, ref->new_sha1)) {

CHECK: Alignment should match open parenthesis
#1781: FILE: remote.c:1781:
+		strbuf_addf(sb,
+			Q_("Your branch is ahead of '%s' by %d commit.\n",

CHECK: Alignment should match open parenthesis
#1787: FILE: remote.c:1787:
+			strbuf_addf(sb,
+				_("  (use \"git push\" to publish your local commits)\n"));

CHECK: Alignment should match open parenthesis
#1790: FILE: remote.c:1790:
+		strbuf_addf(sb,
+			Q_("Your branch is behind '%s' by %d commit, "

CHECK: Alignment should match open parenthesis
#1798: FILE: remote.c:1798:
+			strbuf_addf(sb,
+				_("  (use \"git pull\" to update your local branch)\n"));

CHECK: Alignment should match open parenthesis
#1801: FILE: remote.c:1801:
+		strbuf_addf(sb,
+			Q_("Your branch and '%s' have diverged,\n"

CHECK: Alignment should match open parenthesis
#1811: FILE: remote.c:1811:
+			strbuf_addf(sb,
+				_("  (use \"git pull\" to merge the remote branch into yours)\n"));

CHECK: Alignment should match open parenthesis
#395: FILE: http-backend.c:395:
+		strbuf_addf(&buf, "application/x-git-%s-advertisement",
+			svc->name);

CHECK: Alignment should match open parenthesis
#479: FILE: http-backend.c:479:
+		format_write(1,
+			"Expected POST with Content-Type '%s',"

CHECK: Alignment should match open parenthesis
#92: FILE: test-chmtime.c:92:
+		if (!(sb.st_mode & S_IWUSR) &&
+				chmod(argv[i], sb.st_mode | S_IWUSR)) {

CHECK: Alignment should match open parenthesis
#806: FILE: wt-status.c:806:
+			status_printf_ln(s, color,
+				_("  (fix conflicts and run \"git commit\")"));

CHECK: Alignment should match open parenthesis
#809: FILE: wt-status.c:809:
+		status_printf_ln(s, color,
+			_("All conflicts fixed but you are still merging."));

CHECK: Alignment should match open parenthesis
#812: FILE: wt-status.c:812:
+			status_printf_ln(s, color,
+				_("  (use \"git commit\" to conclude merge)"));

CHECK: Alignment should match open parenthesis
#822: FILE: wt-status.c:822:
+	status_printf_ln(s, color,
+		_("You are in the middle of an am session."));

CHECK: Alignment should match open parenthesis
#825: FILE: wt-status.c:825:
+		status_printf_ln(s, color,
+			_("The current patch is empty."));

CHECK: Alignment should match open parenthesis
#829: FILE: wt-status.c:829:
+			status_printf_ln(s, color,
+				_("  (fix conflicts and then run \"git am --resolved\")"));

CHECK: Alignment should match open parenthesis
#831: FILE: wt-status.c:831:
+		status_printf_ln(s, color,
+			_("  (use \"git am --skip\" to skip this patch)"));

CHECK: Alignment should match open parenthesis
#833: FILE: wt-status.c:833:
+		status_printf_ln(s, color,
+			_("  (use \"git am --abort\" to restore the original branch)"));

CHECK: Alignment should match open parenthesis
#901: FILE: wt-status.c:901:
+			status_printf_ln(s, color,
+				_("  (fix conflicts and then run \"git rebase --continue\")"));

CHECK: Alignment should match open parenthesis
#903: FILE: wt-status.c:903:
+			status_printf_ln(s, color,
+				_("  (use \"git rebase --skip\" to skip this patch)"));

CHECK: Alignment should match open parenthesis
#905: FILE: wt-status.c:905:
+			status_printf_ln(s, color,
+				_("  (use \"git rebase --abort\" to check out the original branch)"));

CHECK: Alignment should match open parenthesis
#918: FILE: wt-status.c:918:
+			status_printf_ln(s, color,
+				_("  (all conflicts fixed: run \"git rebase --continue\")"));

CHECK: Alignment should match open parenthesis
#930: FILE: wt-status.c:930:
+			status_printf_ln(s, color,
+				_("  (Once your working directory is clean, run \"git rebase
--continue\")"));

CHECK: Alignment should match open parenthesis
#942: FILE: wt-status.c:942:
+			status_printf_ln(s, color,
+				_("  (use \"git commit --amend\" to amend the current commit)"));

CHECK: Alignment should match open parenthesis
#944: FILE: wt-status.c:944:
+			status_printf_ln(s, color,
+				_("  (use \"git rebase --continue\" once you are satisfied with
your changes)"));

CHECK: Alignment should match open parenthesis
#958: FILE: wt-status.c:958:
+			status_printf_ln(s, color,
+				_("  (fix conflicts and run \"git commit\")"));

CHECK: Alignment should match open parenthesis
#961: FILE: wt-status.c:961:
+			status_printf_ln(s, color,
+				_("  (all conflicts fixed: run \"git commit\")"));

CHECK: Alignment should match open parenthesis
#975: FILE: wt-status.c:975:
+			status_printf_ln(s, color,
+				_("  (fix conflicts and run \"git revert --continue\")"));

CHECK: Alignment should match open parenthesis
#978: FILE: wt-status.c:978:
+			status_printf_ln(s, color,
+				_("  (all conflicts fixed: run \"git revert --continue\")"));

CHECK: Alignment should match open parenthesis
#980: FILE: wt-status.c:980:
+		status_printf_ln(s, color,
+			_("  (use \"git revert --abort\" to cancel the revert operation)"));

CHECK: Alignment should match open parenthesis
#998: FILE: wt-status.c:998:
+		status_printf_ln(s, color,
+			_("  (use \"git bisect reset\" to get back to the original branch)"));

CHECK: Alignment should match open parenthesis
#1233: FILE: wt-status.c:1233:
+		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
+			advice_status_hints

CHECK: Alignment should match open parenthesis
#98: FILE: xdiff/xhistogram.c:98:
+		xdl_recmatch(r1->ptr, r1->size, r2->ptr, r2->size,
+			    xpp->flags);

CHECK: Alignment should match open parenthesis
#75: FILE: xdiff/xemit.c:75:
+	if (len > 0 &&
+			(isalpha((unsigned char)*rec) || /* identifier? */

CHECK: Alignment should match open parenthesis
#94: FILE: xdiff/xpatience.c:94:
+		if (map->entries[index].hash != record->ha ||
+				!xdl_recmatch(record->ptr, record->size,

CHECK: Alignment should match open parenthesis
#266: FILE: xdiff/xpatience.c:266:
+			if (patience_diff(map->file1, map->file2,
+					map->xpp, map->env,

CHECK: Alignment should match open parenthesis
#324: FILE: xdiff/xpatience.c:324:
+	if (fill_hashmap(file1, file2, xpp, env, &map,
+			line1, count1, line2, count2))

CHECK: Alignment should match open parenthesis
#348: FILE: xdiff/xmerge.c:348:
+		if (line_contains_alnum(xe->xdf2.recs[i]->ptr,
+				xe->xdf2.recs[i]->size))

CHECK: Alignment should match open parenthesis
#468: FILE: xdiff/xmerge.c:468:
+		if (level == XDL_MERGE_MINIMAL || xscr1->i1 != xscr2->i1 ||
+				xscr1->chg1 != xscr2->chg1 ||

CHECK: Alignment should match open parenthesis
#471: FILE: xdiff/xmerge.c:471:
+				xdl_merge_cmp_lines(xe1, xscr1->i2,
+					xe2, xscr2->i2,

CHECK: Alignment should match open parenthesis
#583: FILE: xdiff/xmerge.c:583:
+	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0 ||
+			xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {

CHECK: Alignment should match open parenthesis
#121: FILE: xdiff/xprepare.c:121:
+		if (rcrec->ha == rec->ha &&
+				xdl_recmatch(rcrec->line, rcrec->size,

CHECK: Alignment should match open parenthesis
#122: FILE: xdiff/xprepare.c:122:
+				xdl_recmatch(rcrec->line, rcrec->size,
+					rec->ptr, rec->size, cf->flags))

CHECK: Alignment should match open parenthesis
#325: FILE: archive.c:325:
+		OPT_STRING(0, "prefix", &base, N_("prefix"),
+			N_("prepend prefix to each pathname in the archive")),

CHECK: Alignment should match open parenthesis
#327: FILE: archive.c:327:
+		OPT_STRING('o', "output", &output, N_("file"),
+			N_("write the archive to this file")),

CHECK: Alignment should match open parenthesis
#329: FILE: archive.c:329:
+		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
+			N_("read .gitattributes in working directory")),

CHECK: Alignment should match open parenthesis
#343: FILE: archive.c:343:
+		OPT_BOOL('l', "list", &list,
+			N_("list supported archive formats")),

CHECK: Alignment should match open parenthesis
#346: FILE: archive.c:346:
+		OPT_STRING(0, "remote", &remote, N_("repo"),
+			N_("retrieve the archive from remote repository <repo>")),

CHECK: Alignment should match open parenthesis
#348: FILE: archive.c:348:
+		OPT_STRING(0, "exec", &exec, N_("command"),
+			N_("path to the remote git-upload-archive command")),

CHECK: Alignment should match open parenthesis
#389: FILE: archive.c:389:
+			die("Argument not supported for format '%s': -%d",
+					format, compression_level);

CHECK: Alignment should match open parenthesis
#160: FILE: diffcore-delta.c:160:
+	qsort(hash->data,
+		1ul << hash->alloc_log2,

CHECK: Alignment should match open parenthesis
#109: FILE: merge.c:109:
+	if (write_cache(fd, active_cache, active_nr) ||
+		commit_locked_index(lock_file))

CHECK: Alignment should match open parenthesis
#377: FILE: help.c:377:
+			fprintf_ln(stderr, _("in %0.1f seconds automatically..."),
+				(float)autocorrect/10.0);

CHECK: Alignment should match open parenthesis
#298: FILE: diff-lib.c:298:
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
+	    &dirty_submodule, &revs->diffopt) < 0)

CHECK: Alignment should match open parenthesis
#961: FILE: fast-import.c:961:
+		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
+				    pack_data->pack_name, object_count,

CHECK: Alignment should match open parenthesis
#1413: FILE: fast-import.c:1413:
+		strbuf_addf(b, "%o %s%c",
+			(unsigned int)(e->versions[v].mode & ~NO_DELTA),

CHECK: Alignment should match open parenthesis
#1742: FILE: fast-import.c:1742:
+				dump_marks_helper(f, base + (k << m->shift),
+					m->data.sets[k]);

CHECK: Alignment should match open parenthesis
#1950: FILE: fast-import.c:1950:
+				die("EOF in data (%lu bytes remaining)",
+					(unsigned long)(length - n));

CHECK: Alignment should match open parenthesis
#2185: FILE: fast-import.c:2185:
+			tree_content_set(orig_root, realpath,
+				leaf.versions[1].sha1,

CHECK: Alignment should match open parenthesis
#2324: FILE: fast-import.c:2324:
+			die("Git links cannot be specified 'inline': %s",
+				command_buf.buf);

CHECK: Alignment should match open parenthesis
#2328: FILE: fast-import.c:2328:
+				die("Not a commit (actually a %s): %s",
+					typename(oe->type), command_buf.buf);

CHECK: Alignment should match open parenthesis
#2337: FILE: fast-import.c:2337:
+			die("Directories cannot be specified 'inline': %s",
+				command_buf.buf);

CHECK: Alignment should match open parenthesis
#2351: FILE: fast-import.c:2351:
+			die("%s not found: %s",
+					S_ISDIR(mode) ?  "Tree" : "Blob",

CHECK: Alignment should match open parenthesis
#2355: FILE: fast-import.c:2355:
+			die("Not a %s (actually a %s): %s",
+				typename(expected), typename(type),

CHECK: Alignment should match open parenthesis
#2423: FILE: fast-import.c:2423:
+		tree_content_replace(&b->branch_tree,
+			leaf.versions[1].sha1,

CHECK: Alignment should match open parenthesis
#2429: FILE: fast-import.c:2429:
+	tree_content_set(&b->branch_tree, d,
+		leaf.versions[1].sha1,

CHECK: Alignment should match open parenthesis
#2513: FILE: fast-import.c:2513:
+			die("Not a blob (actually a %s): %s",
+				typename(oe->type), command_buf.buf);

CHECK: Alignment should match open parenthesis
#2732: FILE: fast-import.c:2732:
+	strbuf_addf(&new_data, "tree %s\n",
+		sha1_to_hex(b->branch_tree.versions[1].sha1));

CHECK: Alignment should match open parenthesis
#2742: FILE: fast-import.c:2742:
+	strbuf_addf(&new_data,
+		"author %s\n"

CHECK: Alignment should match open parenthesis
#2901: FILE: fast-import.c:2901:
+	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
+						typename(type), size);

CHECK: Alignment should match open parenthesis
#3031: FILE: fast-import.c:3031:
+		strbuf_addf(&line, "%06o %s %s\t",
+				mode & ~NO_DELTA, type, sha1_to_hex(sha1));

CHECK: Alignment should match open parenthesis
#3236: FILE: fast-import.c:3236:
+		option_import_marks(feature + strlen("import-marks-if-exists="),
+					from_stream, 1);

CHECK: Alignment should match open parenthesis
#169: FILE: strbuf.c:169:
+	memmove(sb->buf + pos + dlen,
+			sb->buf + pos + len,

CHECK: Alignment should match open parenthesis
#310: FILE: fetch-pack.c:310:
+		if (((o = lookup_object(remote)) != NULL) &&
+				(o->flags & COMPLETE)) {

CHECK: Alignment should match open parenthesis
#413: FILE: fetch-pack.c:413:
+					fprintf(stderr, "got ack %d %s\n", ack,
+							sha1_to_hex(result_sha1));

CHECK: Alignment should match open parenthesis
#439: FILE: path.c:439:
+	if (((old_mode ^ new_mode) & ~S_IFMT) &&
+			chmod(path, (new_mode & ~S_IFMT)) < 0)

CHECK: Alignment should match open parenthesis
#318: FILE: merge-recursive.c:318:
+	get_tree_entry(o->object.sha1, path,
+			e->stages[1].sha, &e->stages[1].mode);

CHECK: Alignment should match open parenthesis
#320: FILE: merge-recursive.c:320:
+	get_tree_entry(a->object.sha1, path,
+			e->stages[2].sha, &e->stages[2].mode);

CHECK: Alignment should match open parenthesis
#322: FILE: merge-recursive.c:322:
+	get_tree_entry(b->object.sha1, path,
+			e->stages[3].sha, &e->stages[3].mode);

CHECK: Alignment should match open parenthesis
#1635: FILE: merge-recursive.c:1635:
+		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
+				reason, path);

CHECK: Alignment should match open parenthesis
#2007: FILE: merge-recursive.c:2007:
+	if (active_cache_changed &&
+			(write_cache(index_fd, active_cache, active_nr) ||

CHECK: Alignment should match open parenthesis
#370: FILE: sequencer.c:370:
+		if (cache_tree_update(active_cache_tree, active_cache,
+				  active_nr, 0))

CHECK: Alignment should match open parenthesis
#685: FILE: sequencer.c:685:
+		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
+			subject_len, subject);

CHECK: Alignment should match open parenthesis
#917: FILE: sequencer.c:917:
+		error(_("stored pre-cherry-pick HEAD file '%s' is corrupt"),
+			filename);

CHECK: Alignment should match open parenthesis
#990: FILE: sequencer.c:990:
+		assert(!(opts->signoff || opts->no_commit ||
+				opts->record_origin || opts->edit));

CHECK: Alignment should match open parenthesis
#1135: FILE: sequencer.c:1135:
+	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
+				getenv("GIT_COMMITTER_EMAIL")));

CHECK: Alignment should match open parenthesis
#1182: FILE: sequencer.c:1182:
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				append_newlines, strlen(append_newlines));

CHECK: Alignment should match open parenthesis
#1187: FILE: sequencer.c:1187:
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				sob.buf, sob.len);

CHECK: Alignment should match open parenthesis
#76: FILE: compat/win32/syslog.c:76:
+	ReportEventA(ms_eventlog, logtype, 0, 0, NULL, 1, 0,
+	    (const char **)&str, NULL);

CHECK: Alignment should match open parenthesis
#89: FILE: compat/winansi.c:89:
+	FillConsoleOutputCharacterA(console, ' ',
+		sbi.dwSize.X - sbi.dwCursorPosition.X, sbi.dwCursorPosition,

CHECK: Alignment should match open parenthesis
#453: FILE: compat/nedmalloc/nedmalloc.c:453:
+		printf("*** threadcache=%u, mallocs=%u (%f), free=%u (%f),
freeInCache=%u\n", (unsigned int) tc->threadid, tc->mallocs,
+			(float) tc->successes/tc->mallocs, tc->frees, (float)
tc->successes/tc->frees, (unsigned int) tc->freeInCache);

CHECK: Alignment should match open parenthesis
#701: FILE: compat/nedmalloc/nedmalloc.c:701:
+		printf("Threadcache utilisation: %lf%% in cache with %lf%% lost to
other threads\n",
+			100.0*tc->successes/tc->mallocs, 100.0*((double)
tc->mallocs-tc->frees)/tc->mallocs);

CHECK: Alignment should match open parenthesis
#947: FILE: compat/nedmalloc/nedmalloc.c:947:
+	GETMSPACE(m, p, tc, mymspace, 0,
+	      ret=mspace_independent_comalloc(m, elems, adjustedsizes, chunks));

CHECK: Alignment should match open parenthesis
#432: FILE: compat/mingw.c:432:
+				if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
+						(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {

CHECK: Alignment should match open parenthesis
#1342: FILE: compat/mingw.c:1342:
+		die("unable to initialize winsock subsystem, error %d",
+			WSAGetLastError());

CHECK: Alignment should match open parenthesis
#1538: FILE: compat/mingw.c:1538:
+	if (gle == ERROR_ACCESS_DENIED &&
+	       ask_yes_no_if_possible("Rename from '%s' to '%s' failed. "

CHECK: Alignment should match open parenthesis
#163: FILE: compat/precompose_utf8.c:163:
+			strlcpy(prec_dir->dirent_nfc->d_name, res->d_name,
+							prec_dir->dirent_nfc->max_name_len);

CHECK: Alignment should match open parenthesis
#54: FILE: submodule.c:54:
+		if (alt_odb->name - alt_odb->base == objects_directory.len &&
+				!strncmp(alt_odb->base, objects_directory.buf,

CHECK: Alignment should match open parenthesis
#213: FILE: submodule.c:213:
+		add_pending_object(rev, &list->item->object,
+			sha1_to_hex(list->item->object.sha1));

CHECK: Alignment should match open parenthesis
#298: FILE: submodule.c:298:
+	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
+			find_unique_abbrev(one, DEFAULT_ABBREV));

CHECK: Alignment should match open parenthesis
#349: FILE: submodule.c:349:
+			die("Could not run 'git rev-list %s --not --remotes -n 1' command
in submodule %s",
+				sha1_to_hex(sha1), path);

CHECK: Alignment should match open parenthesis
#865: FILE: submodule.c:865:
+	snprintf(merged_revision, sizeof(merged_revision), "^%s",
+			sha1_to_hex(a->object.sha1));

CHECK: Alignment should match open parenthesis
#124: FILE: notes-merge.c:124:
+	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
+	       sha1_to_hex(base), sha1_to_hex(remote));

CHECK: Alignment should match open parenthesis
#168: FILE: notes-merge.c:168:
+		trace_printf("\t\tStored remote change for %s: %.7s -> %.7s\n",
+		       sha1_to_hex(mp->obj), sha1_to_hex(mp->base),

CHECK: Alignment should match open parenthesis
#187: FILE: notes-merge.c:187:
+	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
+	       len, sha1_to_hex(base), sha1_to_hex(local));

CHECK: Alignment should match open parenthesis
#254: FILE: notes-merge.c:254:
+		trace_printf("\t\tStored local change for %s: %.7s -> %.7s\n",
+		       sha1_to_hex(mp->obj), sha1_to_hex(mp->base),

CHECK: Alignment should match open parenthesis
#440: FILE: notes-merge.c:440:
+			printf("Using local notes for %s\n",
+						sha1_to_hex(p->obj));

CHECK: Alignment should match open parenthesis
#446: FILE: notes-merge.c:446:
+			printf("Using remote notes for %s\n",
+						sha1_to_hex(p->obj));

CHECK: Alignment should match open parenthesis
#453: FILE: notes-merge.c:453:
+			printf("Concatenating local and remote notes for %s\n",
+							sha1_to_hex(p->obj));

CHECK: Alignment should match open parenthesis
#480: FILE: notes-merge.c:480:
+		trace_printf("\t\t%.7s: %.7s -> %.7s/%.7s\n",
+		       sha1_to_hex(p->obj), sha1_to_hex(p->base),

CHECK: Alignment should match open parenthesis
#574: FILE: notes-merge.c:574:
+	trace_printf("notes_merge(o->local_ref = %s, o->remote_ref = %s)\n",
+	       o->local_ref, o->remote_ref);

CHECK: Alignment should match open parenthesis
#633: FILE: notes-merge.c:633:
+			printf("One merge base found (%.7s)\n",
+				sha1_to_hex(base_sha1));

CHECK: Alignment should match open parenthesis
#680: FILE: notes-merge.c:680:
+	trace_printf("notes_merge(): result = %i, result_sha1 = %.7s\n",
+	       result, sha1_to_hex(result_sha1));

CHECK: Alignment should match open parenthesis
#706: FILE: notes-merge.c:706:
+		printf("Committing notes in notes merge worktree at %s\n",
+			path.buf);

CHECK: Alignment should match open parenthesis
#728: FILE: notes-merge.c:728:
+				printf("Skipping non-SHA1 entry '%s%s'\n",
+					path.buf, e->d_name);

CHECK: Alignment should match open parenthesis
#743: FILE: notes-merge.c:743:
+			printf("Added resolved note for object %s: %s\n",
+				sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));

CHECK: Alignment should match open parenthesis
#752: FILE: notes-merge.c:752:
+		printf("Finalized notes merge commit: %s\n",
+			sha1_to_hex(result_sha1));

CHECK: Alignment should match open parenthesis
#193: FILE: git.c:193:
+			die_errno("While expanding alias '%s': '%s'",
+			    alias_command, alias_string + 1);

CHECK: Alignment should match open parenthesis
#205: FILE: git.c:205:
+		memmove(new_argv - option_count, new_argv,
+				count * sizeof(char *));

CHECK: Alignment should match open parenthesis
#835: FILE: dir.c:835:
+			strcpy(dir->basebuf + stk->baselen,
+					dir->exclude_per_dir);

CHECK: Alignment should match open parenthesis
#846: FILE: dir.c:846:
+			add_excludes_from_file_to_list(dir->basebuf,
+					dir->basebuf, stk->baselen, el, 1);

CHECK: Alignment should match open parenthesis
#1283: FILE: dir.c:1283:
+				exclude_matches_pathspec(path.buf, path.len,
+					simplify)))

CHECK: Alignment should match open parenthesis
#309: FILE: http.c:309:
+	curl_easy_setopt(result, CURLOPT_USERAGENT,
+		user_agent ? user_agent : git_user_agent());

CHECK: Alignment should match open parenthesis
#1068: FILE: http.c:1068:
+				fetch_and_setup_pack_index(packs_head, sha1,
+						      base_url);

CHECK: Alignment should match open parenthesis
#1165: FILE: http.c:1165:
+	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
+		sha1_to_hex(target->sha1));

CHECK: Alignment should match open parenthesis
#1169: FILE: http.c:1169:
+	snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp",
+		sha1_pack_name(target->sha1));

CHECK: Alignment should match open parenthesis
#1182: FILE: http.c:1182:
+	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
+		no_pragma_header);

CHECK: Alignment should match open parenthesis
#1197: FILE: http.c:1197:
+		curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
+			preq->range_header);

CHECK: Alignment should match open parenthesis
#1331: FILE: http.c:1331:
+				error("Couldn't truncate temporary file %s: %s",
+					  freq->tmpfile, strerror(errno));

CHECK: Alignment should match open parenthesis
#121: FILE: bundle.c:121:
+		printf("%s %s\n", sha1_to_hex(r->list[i].sha1),
+				r->list[i].name);

CHECK: Alignment should match open parenthesis
#176: FILE: bundle.c:176:
+			error("%s %s", sha1_to_hex(refs.objects[i].item->sha1),
+				refs.objects[i].name);

CHECK: Alignment should match open parenthesis
#320: FILE: bundle.c:320:
+		if (e->item->type == OBJ_TAG &&
+				!is_tag_in_date_range(e->item, &revs)) {

CHECK: Alignment should match open parenthesis
#18: FILE: test-parse-options.c:18:
+	printf("Callback: \"%s\", %d\n",
+		(arg ? arg : "not set"), unset);

CHECK: Alignment should match open parenthesis
#54: FILE: test-parse-options.c:54:
+		OPT_CALLBACK('L', "length", &integer, "str",
+			"get length of <str>", length_callback),

CHECK: Alignment should match open parenthesis
#63: FILE: test-parse-options.c:63:
+		OPT_SET_PTR(0, "default-string", &string,
+			"set string to default", (unsigned long)"default"),

CHECK: Alignment should match open parenthesis
#68: FILE: test-parse-options.c:68:
+		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
+			number_callback),

CHECK: Alignment should match open parenthesis
#101: FILE: date.c:101:
+		strbuf_addf(timebuf,
+			 Q_("%lu second ago", "%lu seconds ago", diff), diff);

CHECK: Alignment should match open parenthesis
#108: FILE: date.c:108:
+		strbuf_addf(timebuf,
+			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);

CHECK: Alignment should match open parenthesis
#115: FILE: date.c:115:
+		strbuf_addf(timebuf,
+			 Q_("%lu hour ago", "%lu hours ago", diff), diff);

CHECK: Alignment should match open parenthesis
#122: FILE: date.c:122:
+		strbuf_addf(timebuf,
+			 Q_("%lu day ago", "%lu days ago", diff), diff);

CHECK: Alignment should match open parenthesis
#128: FILE: date.c:128:
+		strbuf_addf(timebuf,
+			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),

CHECK: Alignment should match open parenthesis
#135: FILE: date.c:135:
+		strbuf_addf(timebuf,
+			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),

CHECK: Alignment should match open parenthesis
#149: FILE: date.c:149:
+			strbuf_addf(timebuf,
+				 Q_("%s, %lu month ago", "%s, %lu months ago", months),

CHECK: Alignment should match open parenthesis
#154: FILE: date.c:154:
+			strbuf_addf(timebuf,
+				 Q_("%lu year ago", "%lu years ago", years), years);

CHECK: Alignment should match open parenthesis
#159: FILE: date.c:159:
+	strbuf_addf(timebuf,
+		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),

CHECK: Alignment should match open parenthesis
#193: FILE: date.c:193:
+		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
+				tm->tm_mon + 1, tm->tm_mday);

CHECK: Alignment should match open parenthesis
#196: FILE: date.c:196:
+		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
+				tm->tm_year + 1900,

CHECK: Alignment should match open parenthesis
#203: FILE: date.c:203:
+		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
+			weekday_names[tm->tm_wday], tm->tm_mday,

CHECK: Alignment should match open parenthesis
#208: FILE: date.c:208:
+		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
+				weekday_names[tm->tm_wday],

CHECK: Alignment should match open parenthesis
#79: FILE: transport.c:79:
+			if (read_in_full(fd, buffer, 40) != 40 ||
+					get_sha1_hex(buffer, next->old_sha1)) {

CHECK: Alignment should match open parenthesis
#158: FILE: transport.c:158:
+		if (ref->status != REF_STATUS_OK &&
+			ref->status != REF_STATUS_UPTODATE)

CHECK: Alignment should match open parenthesis
#170: FILE: transport.c:170:
+		if (tmp && flag & REF_ISSYMREF &&
+			!prefixcmp(tmp, "refs/heads/"))

CHECK: Alignment should match open parenthesis
#181: FILE: transport.c:181:
+			install_branch_config(BRANCH_CONFIG_VERBOSE,
+				localname + 11, transport->remote->name,

CHECK: Alignment should match open parenthesis
#185: FILE: transport.c:185:
+			printf("Would set upstream of '%s' to '%s' of '%s'\n",
+				localname + 11, remotename + 11,

CHECK: Alignment should match open parenthesis
#298: FILE: transport.c:298:
+	if (flags && prefixcmp(name, "refs/heads/") &&
+			prefixcmp(name, "refs/tags/"))

CHECK: Alignment should match open parenthesis
#303: FILE: transport.c:303:
+	if (safe_create_leading_directories(buf->buf) ||
+			!(f = fopen(buf->buf, "w")) ||

CHECK: Alignment should match open parenthesis
#607: FILE: transport.c:607:
+			update_ref("update by push", rs.dst,
+					ref->new_sha1, NULL, 0, 0);

CHECK: Alignment should match open parenthesis
#649: FILE: transport.c:649:
+		print_ref_status('*',
+			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :

CHECK: Alignment should match open parenthesis
#684: FILE: transport.c:684:
+		print_ref_status('!', "[rejected]", ref, NULL,
+						 "remote does not support deleting refs", porcelain);

CHECK: Alignment should match open parenthesis
#688: FILE: transport.c:688:
+		print_ref_status('=', "[up to date]", ref,
+						 ref->peer_ref, NULL, porcelain);

CHECK: Alignment should match open parenthesis
#692: FILE: transport.c:692:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "non-fast-forward", porcelain);

CHECK: Alignment should match open parenthesis
#696: FILE: transport.c:696:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "already exists", porcelain);

CHECK: Alignment should match open parenthesis
#700: FILE: transport.c:700:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "fetch first", porcelain);

CHECK: Alignment should match open parenthesis
#704: FILE: transport.c:704:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "needs force", porcelain);

CHECK: Alignment should match open parenthesis
#708: FILE: transport.c:708:
+		print_ref_status('!', "[remote rejected]", ref,
+						 ref->deletion ? NULL : ref->peer_ref,

CHECK: Alignment should match open parenthesis
#713: FILE: transport.c:713:
+		print_ref_status('!', "[remote failure]", ref,
+						 ref->deletion ? NULL : ref->peer_ref,

CHECK: Alignment should match open parenthesis
#782: FILE: transport.c:782:
+		if (check_refname_format(remote,
+				REFNAME_ALLOW_ONELEVEL|REFNAME_REFSPEC_PATTERN))

CHECK: Alignment should match open parenthesis
#784: FILE: transport.c:784:
+			die("remote part of refspec is not a valid name in %s",
+				heads[i]);

CHECK: Alignment should match open parenthesis
#1079: FILE: transport.c:1079:
+		strbuf_addf( &buf, "%s %s %s %s\n",
+			 r->peer_ref->name, sha1_to_hex(r->new_sha1),

CHECK: Alignment should match open parenthesis
#1140: FILE: transport.c:1140:
+		set_ref_status_for_push(remote_refs,
+			flags & TRANSPORT_PUSH_MIRROR,

CHECK: Alignment should match open parenthesis
#1176: FILE: transport.c:1176:
+			transport_print_push_status(transport->url, remote_refs,
+					verbose | porcelain, porcelain,

CHECK: Alignment should match open parenthesis
#724: FILE: builtin/update-index.c:724:
+		OPT_SET_INT(0, "add", &allow_add,
+			N_("do not ignore new files"), 1),

CHECK: Alignment should match open parenthesis
#726: FILE: builtin/update-index.c:726:
+		OPT_SET_INT(0, "replace", &allow_replace,
+			N_("let files replace directories and vice-versa"), 1),

CHECK: Alignment should match open parenthesis
#728: FILE: builtin/update-index.c:728:
+		OPT_SET_INT(0, "remove", &allow_remove,
+			N_("notice files missing from worktree"), 1),

CHECK: Alignment should match open parenthesis
#763: FILE: builtin/update-index.c:763:
+		OPT_SET_INT(0, "info-only", &info_only,
+			N_("add to index only; do not add content to object database"), 1),

CHECK: Alignment should match open parenthesis
#765: FILE: builtin/update-index.c:765:
+		OPT_SET_INT(0, "force-remove", &force_remove,
+			N_("remove named paths even if present in worktree"), 1),

CHECK: Alignment should match open parenthesis
#767: FILE: builtin/update-index.c:767:
+		OPT_SET_INT('z', NULL, &line_termination,
+			N_("with --stdin: input lines are terminated by null bytes"), '\0'),

CHECK: Alignment should match open parenthesis
#788: FILE: builtin/update-index.c:788:
+		OPT_SET_INT(0, "verbose", &verbose,
+			N_("report actions to standard output"), 1),

CHECK: Alignment should match open parenthesis
#794: FILE: builtin/update-index.c:794:
+		OPT_INTEGER(0, "index-version", &preferred_index_format,
+			N_("write index in this format")),

CHECK: Alignment should match open parenthesis
#719: FILE: builtin/commit.c:719:
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+			    whence == FROM_MERGE

CHECK: Alignment should match open parenthesis
#737: FILE: builtin/commit.c:737:
+			status_printf(s, GIT_COLOR_NORMAL,
+				_("Please enter the commit message for your changes."

CHECK: Alignment should match open parenthesis
#742: FILE: builtin/commit.c:742:
+			status_printf(s, GIT_COLOR_NORMAL,
+				_("Please enter the commit message for your changes."

CHECK: Alignment should match open parenthesis
#749: FILE: builtin/commit.c:749:
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+					"%s", only_include_assumed);

CHECK: Alignment should match open parenthesis
#755: FILE: builtin/commit.c:755:
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+				_("%s"

CHECK: Alignment should match open parenthesis
#762: FILE: builtin/commit.c:762:
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+				_("%s"

CHECK: Alignment should match open parenthesis
#834: FILE: builtin/commit.c:834:
+			fprintf(stderr,
+			_("Please supply the message using either -m or -F option.\n"));

CHECK: Alignment should match open parenthesis
#1288: FILE: builtin/commit.c:1288:
+	printf("[%s%s ",
+		!prefixcmp(head, "refs/heads/") ?

CHECK: Alignment should match open parenthesis
#40: FILE: builtin/symbolic-ref.c:40:
+		OPT__QUIET(&quiet,
+			N_("suppress error message for non-symbolic (detached) refs")),

CHECK: Alignment should match open parenthesis
#113: FILE: builtin/mktag.c:113:
+	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
+		strpbrk(tagger_line, "<>\n") != lb+1 ||

CHECK: Alignment should match open parenthesis
#492: FILE: builtin/fetch.c:492:
+					fprintf(stderr, _("From %.*s\n"),
+							url_len, url);

CHECK: Alignment should match open parenthesis
#677: FILE: builtin/fetch.c:677:
+		if (ref_map->peer_ref && !strcmp(current_branch->refname,
+					ref_map->peer_ref->name))

CHECK: Alignment should match open parenthesis
#790: FILE: builtin/fetch.c:790:
+		die(_("Option \"%s\" value \"%s\" is not valid for %s"),
+			name, value, transport->url);

CHECK: Alignment should match open parenthesis
#814: FILE: builtin/fetch.c:814:
+	if (!prefixcmp(key, "remotes.") &&
+			!strcmp(key + 8, g->name)) {

CHECK: Alignment should match open parenthesis
#92: FILE: builtin/stripspace.c:92:
+		if (!strcmp(argv[1], "-s") ||
+			!strcmp(argv[1], "--strip-comments")) {

CHECK: Alignment should match open parenthesis
#115: FILE: builtin/ls-tree.c:115:
+	write_name_quotedpfx(base + chomp_prefix, baselen - chomp_prefix,
+			  pathname, stdout, line_termination);

CHECK: Alignment should match open parenthesis
#165: FILE: builtin/mv.c:165:
+						prefix_path(dst, dst_len,
+							path + length + 1);

CHECK: Alignment should match open parenthesis
#214: FILE: builtin/mv.c:214:
+		if (!show_only && mode != INDEX &&
+				rename(src, dst) < 0 && !ignore_errors)

CHECK: Alignment should match open parenthesis
#57: FILE: builtin/clean.c:57:
+	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
+			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {

CHECK: Alignment should match open parenthesis
#61: FILE: builtin/clean.c:61:
+			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
+					quoted.buf);

CHECK: Alignment should match open parenthesis
#164: FILE: builtin/clean.c:164:
+		OPT_BOOLEAN('d', NULL, &remove_directories,
+				N_("remove whole directories")),

CHECK: Alignment should match open parenthesis
#169: FILE: builtin/clean.c:169:
+		OPT_BOOLEAN('X', NULL, &ignored_only,
+				N_("remove only ignored files")),

CHECK: Alignment should match open parenthesis
#68: FILE: builtin/checkout-index.c:68:
+		if (checkout_entry(ce, &state,
+		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)

CHECK: Alignment should match open parenthesis
#112: FILE: builtin/checkout-index.c:112:
+		if (checkout_entry(ce, &state,
+		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)

CHECK: Alignment should match open parenthesis
#187: FILE: builtin/checkout-index.c:187:
+		OPT_BOOLEAN('a', "all", &all,
+			N_("check out all files in the index")),

CHECK: Alignment should match open parenthesis
#190: FILE: builtin/checkout-index.c:190:
+		OPT__QUIET(&quiet,
+			N_("no warning for existing files and files not in index")),

CHECK: Alignment should match open parenthesis
#192: FILE: builtin/checkout-index.c:192:
+		OPT_BOOLEAN('n', "no-create", &not_new,
+			N_("don't checkout new files")),

CHECK: Alignment should match open parenthesis
#200: FILE: builtin/checkout-index.c:200:
+		OPT_BOOLEAN(0, "stdin", &read_from_stdin,
+			N_("read list of paths from the standard input")),

CHECK: Alignment should match open parenthesis
#202: FILE: builtin/checkout-index.c:202:
+		OPT_BOOLEAN(0, "temp", &to_tempfile,
+			N_("write the content to temporary files")),

CHECK: Alignment should match open parenthesis
#204: FILE: builtin/checkout-index.c:204:
+		OPT_CALLBACK(0, "prefix", NULL, N_("string"),
+			N_("when creating files, prepend <string>"),

CHECK: Alignment should match open parenthesis
#207: FILE: builtin/checkout-index.c:207:
+		OPT_CALLBACK(0, "stage", NULL, NULL,
+			N_("copy out the files from named stage"),

CHECK: Alignment should match open parenthesis
#307: FILE: builtin/index-pack.c:307:
+		die(_("pack version %"PRIu32" unsupported"),
+			ntohl(hdr->hdr_version));

CHECK: Alignment should match open parenthesis
#1037: FILE: builtin/index-pack.c:1037:
+	if (S_ISREG(st.st_mode) &&
+			lseek(input_fd, 0, SEEK_CUR) - input_len != st.st_size)

CHECK: Alignment should match open parenthesis
#1249: FILE: builtin/index-pack.c:1249:
+		if (check_sha1_signature(d->base.sha1, base_obj->data,
+				base_obj->size, typename(type)))

CHECK: Alignment should match open parenthesis
#1296: FILE: builtin/index-pack.c:1296:
+				die_errno(_("cannot close written keep file '%s'"),
+				    keep_name);

CHECK: Alignment should match open parenthesis
#433: FILE: builtin/branch.c:433:
+				strbuf_addf(stat, "[%s%s%s] ",
+						branch_get_color(BRANCH_COLOR_UPSTREAM),

CHECK: Alignment should match open parenthesis
#445: FILE: builtin/branch.c:445:
+			strbuf_addf(&fancy, "%s%s%s",
+					branch_get_color(BRANCH_COLOR_UPSTREAM),

CHECK: Alignment should match open parenthesis
#502: FILE: builtin/branch.c:502:
+	strbuf_addf(out, " %s %s%s",
+		find_unique_abbrev(item->commit->object.sha1, abbrev),

CHECK: Alignment should match open parenthesis
#704: FILE: builtin/branch.c:704:
+	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
+		 oldref.buf, newref.buf);

CHECK: Alignment should match open parenthesis
#754: FILE: builtin/branch.c:754:
+	strbuf_commented_addf(&buf,
+		    "Please edit the description for the branch\n"

CHECK: Alignment should match open parenthesis
#793: FILE: builtin/branch.c:793:
+		OPT__VERBOSE(&verbose,
+			N_("show hash and subject, give twice for upstream branch")),

CHECK: Alignment should match open parenthesis
#796: FILE: builtin/branch.c:796:
+		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see
git-pull(1))"),
+			BRANCH_TRACK_EXPLICIT),

CHECK: Alignment should match open parenthesis
#798: FILE: builtin/branch.c:798:
+		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
+			BRANCH_TRACK_OVERRIDE),

CHECK: Alignment should match open parenthesis
#803: FILE: builtin/branch.c:803:
+		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking
branches"),
+			REF_REMOTE_BRANCH),

CHECK: Alignment should match open parenthesis
#820: FILE: builtin/branch.c:820:
+		OPT_SET_INT('a', "all", &kinds, N_("list both remote-tracking and
local branches"),
+			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),

CHECK: Alignment should match open parenthesis
#256: FILE: builtin/fast-export.c:256:
+			die("Unexpected comparison status '%c' for %s, %s",
+				q->queue[i]->status,

CHECK: Alignment should match open parenthesis
#590: FILE: builtin/fast-export.c:590:
+			if (fprintf(f, ":%"PRIu32" %s\n", mark,
+				sha1_to_hex(deco->base->sha1)) < 0) {

CHECK: Alignment should match open parenthesis
#666: FILE: builtin/fast-export.c:666:
+		OPT_STRING(0, "export-marks", &export_filename, N_("file"),
+			     N_("Dump marks to this file")),

CHECK: Alignment should match open parenthesis
#668: FILE: builtin/fast-export.c:668:
+		OPT_STRING(0, "import-marks", &import_filename, N_("file"),
+			     N_("Import marks from this file")),

CHECK: Alignment should match open parenthesis
#670: FILE: builtin/fast-export.c:670:
+		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
+			     N_("Fake a tagger when tags lack one")),

CHECK: Alignment should match open parenthesis
#672: FILE: builtin/fast-export.c:672:
+		OPT_BOOLEAN(0, "full-tree", &full_tree,
+			     N_("Output full tree for each commit")),

CHECK: Alignment should match open parenthesis
#674: FILE: builtin/fast-export.c:674:
+		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
+			     N_("Use the done feature to terminate the stream")),

CHECK: Alignment should match open parenthesis
#228: FILE: builtin/send-pack.c:228:
+	set_ref_status_for_push(remote_refs, args.send_mirror,
+		args.force_update);

CHECK: Alignment should match open parenthesis
#90: FILE: builtin/fsck.c:90:
+		printf("broken link from %7s %s\n",
+			   typename(parent->type), sha1_to_hex(parent->sha1));

CHECK: Alignment should match open parenthesis
#92: FILE: builtin/fsck.c:92:
+		printf("broken link from %7s %s\n",
+			   (type == OBJ_ANY ? "unknown" : typename(type)), "unknown");

CHECK: Alignment should match open parenthesis
#107: FILE: builtin/fsck.c:107:
+			printf("broken link from %7s %s\n",
+				 typename(parent->type), sha1_to_hex(parent->sha1));

CHECK: Alignment should match open parenthesis
#109: FILE: builtin/fsck.c:109:
+			printf("              to %7s %s\n",
+				 typename(obj->type), sha1_to_hex(obj->sha1));

CHECK: Alignment should match open parenthesis
#623: FILE: builtin/fsck.c:623:
+	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
+				N_("write dangling objects in .git/lost-found")),

CHECK: Alignment should match open parenthesis
#307: FILE: builtin/rev-parse.c:307:
+		show_rev(parents_only ? NORMAL : REVERSED,
+				parents->item->object.sha1, arg);

CHECK: Alignment should match open parenthesis
#344: FILE: builtin/rev-parse.c:344:
+		OPT_BOOLEAN(0, "keep-dashdash", &keep_dashdash,
+					N_("keep the `--` passed as an arg")),

CHECK: Alignment should match open parenthesis
#346: FILE: builtin/rev-parse.c:346:
+		OPT_BOOLEAN(0, "stop-at-non-option", &stop_at_non_option,
+					N_("stop parsing after the "

CHECK: Alignment should match open parenthesis
#621: FILE: builtin/rev-parse.c:621:
+				for_each_glob_ref_in(show_reference, arg + 11,
+					"refs/heads/", NULL);

CHECK: Alignment should match open parenthesis
#630: FILE: builtin/rev-parse.c:630:
+				for_each_glob_ref_in(show_reference, arg + 7,
+					"refs/tags/", NULL);

CHECK: Alignment should match open parenthesis
#643: FILE: builtin/rev-parse.c:643:
+				for_each_glob_ref_in(show_reference, arg + 10,
+					"refs/remotes/", NULL);

CHECK: Alignment should match open parenthesis
#56: FILE: builtin/rerere.c:56:
+		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
+			N_("register clean resolutions in index"), 1),

CHECK: Alignment should match open parenthesis
#415: FILE: builtin/describe.c:415:
+		OPT_BOOLEAN(0, "always",     &always,
+			   N_("show abbreviated commit object as fallback")),

CHECK: Alignment should match open parenthesis
#294: FILE: builtin/shortlog.c:294:
+		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
+			compare_by_number);

CHECK: Alignment should match open parenthesis
#432: FILE: builtin/fmt-merge-msg.c:432:
+			print_joined("branch ", "branches ", &src_data->branch,
+					out);

CHECK: Alignment should match open parenthesis
#438: FILE: builtin/fmt-merge-msg.c:438:
+			print_joined("remote-tracking branch ", "remote-tracking branches ",
+					&src_data->r_branch, out);

CHECK: Alignment should match open parenthesis
#448: FILE: builtin/fmt-merge-msg.c:448:
+			print_joined("commit ", "commits ", &src_data->generic,
+					out);

CHECK: Alignment should match open parenthesis
#508: FILE: builtin/fmt-merge-msg.c:508:
+				strbuf_add_commented_lines(&tagline,
+						origins.items[first_tag].string,

CHECK: Alignment should match open parenthesis
#516: FILE: builtin/fmt-merge-msg.c:516:
+			strbuf_add_commented_lines(&tagbuf,
+					origins.items[i].string,

CHECK: Alignment should match open parenthesis
#671: FILE: builtin/fmt-merge-msg.c:671:
+		OPT_STRING('m', "message", &message, N_("text"),
+			N_("use <text> as start of message")),

CHECK: Alignment should match open parenthesis
#1006: FILE: builtin/for-each-ref.c:1006:
+		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
+			    N_("field name to sort on"), &opt_parse_sort),

CHECK: Alignment should match open parenthesis
#75: FILE: builtin/clone.c:75:
+	OPT_BOOL('l', "local", &option_local,
+		N_("to clone from a local repository")),

CHECK: Alignment should match open parenthesis
#95: FILE: builtin/clone.c:95:
+	OPT_STRING(0, "depth", &option_depth, N_("depth"),
+		    N_("create a shallow clone of that depth")),

CHECK: Alignment should match open parenthesis
#97: FILE: builtin/clone.c:97:
+	OPT_BOOL(0, "single-branch", &option_single_branch,
+		    N_("clone only one branch, HEAD or --branch")),

CHECK: Alignment should match open parenthesis
#684: FILE: builtin/clone.c:684:
+					strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
+						our_head_points_at->name);

CHECK: Alignment should match open parenthesis
#687: FILE: builtin/clone.c:687:
+					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
+						branch_top->buf, option_branch);

CHECK: Alignment should match open parenthesis
#690: FILE: builtin/clone.c:690:
+				strbuf_addf(&value, "+%s:%s%s", remote_head_points_at->name,
+						branch_top->buf,

CHECK: Alignment should match open parenthesis
#750: FILE: builtin/clone.c:750:
+		usage_msg_opt(_("Too many arguments."),
+			builtin_clone_usage, builtin_clone_options);

CHECK: Alignment should match open parenthesis
#754: FILE: builtin/clone.c:754:
+		usage_msg_opt(_("You must specify a repository to clone."),
+			builtin_clone_usage, builtin_clone_options);

CHECK: Alignment should match open parenthesis
#945: FILE: builtin/clone.c:945:
+	write_refspec_config(src_ref_prefix, our_head_points_at,
+			remote_head_points_at, &branch_top);

CHECK: Alignment should match open parenthesis
#479: FILE: builtin/unpack-objects.c:479:
+		die("unknown pack file version %"PRIu32,
+			ntohl(hdr->hdr_version));

CHECK: Alignment should match open parenthesis
#250: FILE: builtin/reset.c:250:
+		OPT_SET_INT(0, "mixed", &reset_type,
+						N_("reset HEAD and index"), MIXED),

CHECK: Alignment should match open parenthesis
#253: FILE: builtin/reset.c:253:
+		OPT_SET_INT(0, "hard", &reset_type,
+				N_("reset HEAD, index and working tree"), HARD),

CHECK: Alignment should match open parenthesis
#255: FILE: builtin/reset.c:255:
+		OPT_SET_INT(0, "merge", &reset_type,
+				N_("reset HEAD, index and working tree"), MERGE),

CHECK: Alignment should match open parenthesis
#257: FILE: builtin/reset.c:257:
+		OPT_SET_INT(0, "keep", &reset_type,
+				N_("reset HEAD but keep local changes"), KEEP),

CHECK: Alignment should match open parenthesis
#304: FILE: builtin/reset.c:304:
+			die(_("Cannot do %s reset with paths."),
+					_(reset_type_names[reset_type]));

CHECK: Alignment should match open parenthesis
#122: FILE: builtin/remote.c:122:
+		strbuf_addf(tmp, "refs/%s:refs/%s",
+				branchname, branchname);

CHECK: Alignment should match open parenthesis
#125: FILE: builtin/remote.c:125:
+		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
+				branchname, remotename, branchname);

CHECK: Alignment should match open parenthesis
#194: FILE: builtin/remote.c:194:
+	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
+			remote->fetch_refspec_nr))

CHECK: Alignment should match open parenthesis
#228: FILE: builtin/remote.c:228:
+		if (git_config_set(buf.buf,
+			fetch_tags == TAGS_SET ? "--tags" : "--no-tags"))

CHECK: Alignment should match open parenthesis
#340: FILE: builtin/remote.c:340:
+			die(_("Could not get fetch map for refspec %s"),
+				states->remote->fetch_refspec[i]);

CHECK: Alignment should match open parenthesis
#726: FILE: builtin/remote.c:726:
+		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
+				rename.new, strlen(rename.new));

CHECK: Alignment should match open parenthesis
#729: FILE: builtin/remote.c:729:
+		strbuf_addf(&buf2, "remote: renamed %s to %s",
+				item->string, buf.buf);

CHECK: Alignment should match open parenthesis
#741: FILE: builtin/remote.c:741:
+		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
+				rename.new, strlen(rename.new));

CHECK: Alignment should match open parenthesis
#745: FILE: builtin/remote.c:745:
+		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old),
+				rename.new, strlen(rename.new));

CHECK: Alignment should match open parenthesis
#748: FILE: builtin/remote.c:748:
+		strbuf_addf(&buf3, "remote: renamed %s to %s",
+				item->string, buf.buf);

CHECK: Alignment should match open parenthesis
#810: FILE: builtin/remote.c:810:
+				strbuf_addf(&buf, "branch.%s.%s",
+						item->string, *k);

CHECK: Alignment should match open parenthesis
#992: FILE: builtin/remote.c:992:
+		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
+			item->string);

CHECK: Alignment should match open parenthesis
#1072: FILE: builtin/remote.c:1072:
+			printf_ln(_("    %-*s forces to %-*s (%s)"), show_info->width, src,
+			       show_info->width2, push_info->dest, status);

CHECK: Alignment should match open parenthesis
#1075: FILE: builtin/remote.c:1075:
+			printf_ln(_("    %-*s pushes to %-*s (%s)"), show_info->width, src,
+			       show_info->width2, push_info->dest, status);

CHECK: Alignment should match open parenthesis
#1079: FILE: builtin/remote.c:1079:
+			printf_ln(_("    %-*s forces to %s"), show_info->width, src,
+			       push_info->dest);

CHECK: Alignment should match open parenthesis
#1082: FILE: builtin/remote.c:1082:
+			printf_ln(_("    %-*s pushes to %s"), show_info->width, src,
+			       push_info->dest);

CHECK: Alignment should match open parenthesis
#1176: FILE: builtin/remote.c:1176:
+		qsort(info.list->items, info.list->nr,
+			sizeof(*info.list->items), cmp_string_with_push);

CHECK: Alignment should match open parenthesis
#1283: FILE: builtin/remote.c:1283:
+		printf_ln(_("URL: %s"),
+		       states.remote->url_nr

CHECK: Alignment should match open parenthesis
#1296: FILE: builtin/remote.c:1296:
+			printf_ln(_(" * [would prune] %s"),
+			       abbrev_ref(refname, "refs/remotes/"));

CHECK: Alignment should match open parenthesis
#1299: FILE: builtin/remote.c:1299:
+			printf_ln(_(" * [pruned] %s"),
+			       abbrev_ref(refname, "refs/remotes/"));

CHECK: Alignment should match open parenthesis
#1478: FILE: builtin/remote.c:1478:
+			git_config_set_multivar(name_buf.buf, newurl,
+				"^$", 0);

CHECK: Alignment should match open parenthesis
#1554: FILE: builtin/remote.c:1554:
+				printf("%s\t%s\n", item->string,
+					item->util ? (const char *)item->util : "");

CHECK: Alignment should match open parenthesis
#2068: FILE: builtin/apply.c:2068:
+	printf("%5d %.*s%.*s\n", patch->lines_added + patch->lines_deleted,
+		add, pluses, del, minuses);

CHECK: Alignment should match open parenthesis
#2318: FILE: builtin/apply.c:2318:
+		update_pre_post_images(preimage, postimage,
+				fixed_buf, fixed_len, postlen);

CHECK: Alignment should match open parenthesis
#4366: FILE: builtin/apply.c:4366:
+		OPT_BOOLEAN(0, "no-add", &no_add,
+			N_("ignore additions made by the patch")),

CHECK: Alignment should match open parenthesis
#4368: FILE: builtin/apply.c:4368:
+		OPT_BOOLEAN(0, "stat", &diffstat,
+			N_("instead of applying the patch, output diffstat for the input")),

CHECK: Alignment should match open parenthesis
#4372: FILE: builtin/apply.c:4372:
+		OPT_BOOLEAN(0, "numstat", &numstat,
+			N_("show number of added and deleted lines in decimal notation")),

CHECK: Alignment should match open parenthesis
#4374: FILE: builtin/apply.c:4374:
+		OPT_BOOLEAN(0, "summary", &summary,
+			N_("instead of applying the patch, output a summary for the input")),

CHECK: Alignment should match open parenthesis
#4376: FILE: builtin/apply.c:4376:
+		OPT_BOOLEAN(0, "check", &check,
+			N_("instead of applying the patch, see if the patch is applicable")),

CHECK: Alignment should match open parenthesis
#4378: FILE: builtin/apply.c:4378:
+		OPT_BOOLEAN(0, "index", &check_index,
+			N_("make sure the patch is applicable to the current index")),

CHECK: Alignment should match open parenthesis
#4380: FILE: builtin/apply.c:4380:
+		OPT_BOOLEAN(0, "cached", &cached,
+			N_("apply a patch without touching the working tree")),

CHECK: Alignment should match open parenthesis
#4382: FILE: builtin/apply.c:4382:
+		OPT_BOOLEAN(0, "apply", &force_apply,
+			N_("also apply the patch (use with --stat/--summary/--check)")),

CHECK: Alignment should match open parenthesis
#4386: FILE: builtin/apply.c:4386:
+		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
+			N_("build a temporary index based on embedded index information")),

CHECK: Alignment should match open parenthesis
#4391: FILE: builtin/apply.c:4391:
+		OPT_INTEGER('C', NULL, &p_context,
+				N_("ensure at least <n> lines of context match")),

CHECK: Alignment should match open parenthesis
#4402: FILE: builtin/apply.c:4402:
+		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
+			N_("apply the patch in reverse")),

CHECK: Alignment should match open parenthesis
#4404: FILE: builtin/apply.c:4404:
+		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
+			N_("don't expect at least one line of context")),

CHECK: Alignment should match open parenthesis
#4406: FILE: builtin/apply.c:4406:
+		OPT_BOOLEAN(0, "reject", &apply_with_reject,
+			N_("leave the rejected hunks in corresponding *.rej files")),

CHECK: Alignment should match open parenthesis
#4408: FILE: builtin/apply.c:4408:
+		OPT_BOOLEAN(0, "allow-overlap", &allow_overlap,
+			N_("allow overlapping hunks")),

CHECK: Alignment should match open parenthesis
#406: FILE: builtin/push.c:406:
+		die("option %s needs an argument (check|on-demand)",
+				opt->long_name);

CHECK: Alignment should match open parenthesis
#422: FILE: builtin/push.c:422:
+		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
+			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),

CHECK: Alignment should match open parenthesis
#44: FILE: builtin/remote-fd.c:44:
+			if (bidirectional_transfer_loop(input_fd,
+				output_fd))

CHECK: Alignment should match open parenthesis
#52: FILE: builtin/ls-files.c:52:
+	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
+			line_terminator);

CHECK: Alignment should match open parenthesis
#459: FILE: builtin/ls-files.c:459:
+		OPT_BOOLEAN('t', NULL, &show_tag,
+			N_("identify the file status with tags")),

CHECK: Alignment should match open parenthesis
#461: FILE: builtin/ls-files.c:461:
+		OPT_BOOLEAN('v', NULL, &show_valid_bit,
+			N_("use lowercase letters for 'assume unchanged' files")),

CHECK: Alignment should match open parenthesis
#463: FILE: builtin/ls-files.c:463:
+		OPT_BOOLEAN('c', "cached", &show_cached,
+			N_("show cached files in the output (default)")),

CHECK: Alignment should match open parenthesis
#465: FILE: builtin/ls-files.c:465:
+		OPT_BOOLEAN('d', "deleted", &show_deleted,
+			N_("show deleted files in the output")),

CHECK: Alignment should match open parenthesis
#467: FILE: builtin/ls-files.c:467:
+		OPT_BOOLEAN('m', "modified", &show_modified,
+			N_("show modified files in the output")),

CHECK: Alignment should match open parenthesis
#469: FILE: builtin/ls-files.c:469:
+		OPT_BOOLEAN('o', "others", &show_others,
+			N_("show other files in the output")),

CHECK: Alignment should match open parenthesis
#474: FILE: builtin/ls-files.c:474:
+		OPT_BOOLEAN('s', "stage", &show_stage,
+			N_("show staged contents' object name in the output")),

CHECK: Alignment should match open parenthesis
#476: FILE: builtin/ls-files.c:476:
+		OPT_BOOLEAN('k', "killed", &show_killed,
+			N_("show files on the filesystem that need to be removed")),

CHECK: Alignment should match open parenthesis
#481: FILE: builtin/ls-files.c:481:
+		OPT_NEGBIT(0, "empty-directory", &dir.flags,
+			N_("don't show empty directories"),

CHECK: Alignment should match open parenthesis
#484: FILE: builtin/ls-files.c:484:
+		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
+			N_("show unmerged files in the output")),

CHECK: Alignment should match open parenthesis
#494: FILE: builtin/ls-files.c:494:
+		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("file"),
+			N_("read additional per-directory exclude patterns in <file>")),

CHECK: Alignment should match open parenthesis
#502: FILE: builtin/ls-files.c:502:
+		OPT_BOOLEAN(0, "error-unmatch", &error_unmatch,
+			N_("if any <file> is not in the index, treat this as an error")),

CHECK: Alignment should match open parenthesis
#504: FILE: builtin/ls-files.c:504:
+		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
+			N_("pretend that paths removed since <tree-ish> are still present")),

CHECK: Alignment should match open parenthesis
#505: FILE: builtin/log.c:505:
+			printf("%stag %s%s\n",
+					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),

CHECK: Alignment should match open parenthesis
#524: FILE: builtin/log.c:524:
+			printf("%stree %s%s\n\n",
+					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),

CHECK: Alignment should match open parenthesis
#528: FILE: builtin/log.c:528:
+			read_tree_recursive((struct tree *)o, "", 0, 0, &match_all,
+					show_tree_object, NULL);

CHECK: Alignment should match open parenthesis
#778: FILE: builtin/log.c:778:
+	clear_commit_marks((struct commit *)o1,
+			SEEN | UNINTERESTING | SHOWN | ADDED);

CHECK: Alignment should match open parenthesis
#780: FILE: builtin/log.c:780:
+	clear_commit_marks((struct commit *)o2,
+			SEEN | UNINTERESTING | SHOWN | ADDED);

CHECK: Alignment should match open parenthesis
#1115: FILE: builtin/log.c:1115:
+		OPT_BOOL(0, "stdout", &use_stdout,
+			    N_("print patches to standard out")),

CHECK: Alignment should match open parenthesis
#1117: FILE: builtin/log.c:1117:
+		OPT_BOOL(0, "cover-letter", &cover_letter,
+			    N_("generate a cover letter")),

CHECK: Alignment should match open parenthesis
#1119: FILE: builtin/log.c:1119:
+		OPT_BOOL(0, "numbered-files", &just_numbers,
+			    N_("use simple number sequence for output file names")),

CHECK: Alignment should match open parenthesis
#1121: FILE: builtin/log.c:1121:
+		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
+			    N_("use <sfx> instead of '.patch'")),

CHECK: Alignment should match open parenthesis
#1150: FILE: builtin/log.c:1150:
+		OPT_STRING(0, "in-reply-to", &in_reply_to, N_("message-id"),
+			    N_("make first mail a reply to <message-id>")),

CHECK: Alignment should match open parenthesis
#1162: FILE: builtin/log.c:1162:
+		OPT_STRING(0, "signature", &signature, N_("signature"),
+			    N_("add a signature")),

CHECK: Alignment should match open parenthesis
#1265: FILE: builtin/log.c:1265:
+	if (!use_patch_format &&
+		(!rev.diffopt.output_format ||

CHECK: Alignment should match open parenthesis
#1354: FILE: builtin/log.c:1354:
+		if (ignore_if_in_upstream &&
+				has_commit_patch_id(commit, &ids))

CHECK: Alignment should match open parenthesis
#222: FILE: builtin/gc.c:222:
+			fprintf(stderr,
+					_("Auto packing the repository for optimum performance. You may also\n"

CHECK: Alignment should match open parenthesis
#556: FILE: builtin/checkout.c:556:
+			merge_trees(&o, new->commit->tree, work,
+				old->commit->tree, &result);

CHECK: Alignment should match open parenthesis
#602: FILE: builtin/checkout.c:602:
+					fprintf(stderr, _("Can not do reflog for '%s'\n"),
+					    opts->new_orphan_branch);

CHECK: Alignment should match open parenthesis
#685: FILE: builtin/checkout.c:685:
+	strbuf_addstr(sb,
+		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));

CHECK: Alignment should match open parenthesis
#1052: FILE: builtin/checkout.c:1052:
+		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for
new branch"),
+			BRANCH_TRACK_EXPLICIT),

CHECK: Alignment should match open parenthesis
#89: FILE: builtin/archive.c:89:
+		OPT_STRING('o', "output", &output, N_("file"),
+			N_("write the archive to this file")),

CHECK: Alignment should match open parenthesis
#91: FILE: builtin/archive.c:91:
+		OPT_STRING(0, "remote", &remote, N_("repo"),
+			N_("retrieve the archive from remote repository <repo>")),

CHECK: Alignment should match open parenthesis
#93: FILE: builtin/archive.c:93:
+		OPT_STRING(0, "exec", &exec, N_("command"),
+			N_("path to the remote git-upload-archive command")),

CHECK: Alignment should match open parenthesis
#186: FILE: builtin/merge.c:186:
+	OPT_BOOLEAN(0, "stat", &show_diffstat,
+		N_("show a diffstat at the end of the merge")),

CHECK: Alignment should match open parenthesis
#192: FILE: builtin/merge.c:192:
+	OPT_BOOLEAN(0, "squash", &squash,
+		N_("create a single commit instead of doing a merge")),

CHECK: Alignment should match open parenthesis
#194: FILE: builtin/merge.c:194:
+	OPT_BOOLEAN(0, "commit", &option_commit,
+		N_("perform a commit if the merge succeeds (default)")),

CHECK: Alignment should match open parenthesis
#196: FILE: builtin/merge.c:196:
+	OPT_BOOL('e', "edit", &option_edit,
+		N_("edit message before committing")),

CHECK: Alignment should match open parenthesis
#198: FILE: builtin/merge.c:198:
+	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
+		N_("allow fast-forward (default)")),

CHECK: Alignment should match open parenthesis
#200: FILE: builtin/merge.c:200:
+	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
+		N_("abort if fast-forward is not possible")),

CHECK: Alignment should match open parenthesis
#203: FILE: builtin/merge.c:203:
+	OPT_BOOL(0, "verify-signatures", &verify_signatures,
+		N_("Verify that the named commit has a valid GPG signature")),

CHECK: Alignment should match open parenthesis
#205: FILE: builtin/merge.c:205:
+	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
+		N_("merge strategy to use"), option_parse_strategy),

CHECK: Alignment should match open parenthesis
#207: FILE: builtin/merge.c:207:
+	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=value"),
+		N_("option for selected merge strategy"), option_parse_x),

CHECK: Alignment should match open parenthesis
#209: FILE: builtin/merge.c:209:
+	OPT_CALLBACK('m', "message", &merge_msg, N_("message"),
+		N_("merge commit message (for a non-fast-forward merge)"),

CHECK: Alignment should match open parenthesis
#213: FILE: builtin/merge.c:213:
+	OPT_BOOLEAN(0, "abort", &abort_current_merge,
+		N_("abort the current in-progress merge")),

CHECK: Alignment should match open parenthesis
#359: FILE: builtin/merge.c:359:
+		strbuf_addf(&out, "commit %s\n",
+			sha1_to_hex(commit->object.sha1));

CHECK: Alignment should match open parenthesis
#382: FILE: builtin/merge.c:382:
+		strbuf_addf(&reflog_message, "%s: %s",
+			getenv("GIT_REFLOG_ACTION"), msg);

CHECK: Alignment should match open parenthesis
#392: FILE: builtin/merge.c:392:
+			update_ref(reflog_message.buf, "HEAD",
+				new_head, head, 0,

CHECK: Alignment should match open parenthesis
#501: FILE: builtin/merge.c:501:
+	if (!strcmp(remote, "FETCH_HEAD") &&
+			!access(git_path("FETCH_HEAD"), R_OK)) {

CHECK: Alignment should match open parenthesis
#535: FILE: builtin/merge.c:535:
+	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
+		sha1_to_hex(remote_head->object.sha1), remote);

CHECK: Alignment should match open parenthesis
#566: FILE: builtin/merge.c:566:
+	if (branch && !prefixcmp(k, "branch.") &&
+		!prefixcmp(k + 7, branch) &&

CHECK: Alignment should match open parenthesis
#656: FILE: builtin/merge.c:656:
+	if (active_cache_changed &&
+			(write_cache(index_fd, active_cache, active_nr) ||

CHECK: Alignment should match open parenthesis
#697: FILE: builtin/merge.c:697:
+		if (active_cache_changed &&
+				(write_cache(index_fd, active_cache, active_nr) ||

CHECK: Alignment should match open parenthesis
#1178: FILE: builtin/merge.c:1178:
+		usage_with_options(builtin_merge_usage,
+			builtin_merge_options);

CHECK: Alignment should match open parenthesis
#1249: FILE: builtin/merge.c:1249:
+		usage_with_options(builtin_merge_usage,
+			builtin_merge_options);

CHECK: Alignment should match open parenthesis
#1359: FILE: builtin/merge.c:1359:
+			printf(_("Updating %s..%s\n"),
+				hex,

CHECK: Alignment should match open parenthesis
#1361: FILE: builtin/merge.c:1361:
+				find_unique_abbrev(remoteheads->item->object.sha1,
+				DEFAULT_ABBREV));

CHECK: Alignment should match open parenthesis
#1365: FILE: builtin/merge.c:1365:
+			strbuf_addstr(&msg,
+				" (no commit created; -m option ignored)");

CHECK: Alignment should match open parenthesis
#1424: FILE: builtin/merge.c:1424:
+			if (hashcmp(common_one->item->object.sha1,
+				j->item->object.sha1)) {

CHECK: Alignment should match open parenthesis
#1464: FILE: builtin/merge.c:1464:
+			printf(_("Trying merge strategy %s...\n"),
+				use_strategies[i]->name);

CHECK: Alignment should match open parenthesis
#1541: FILE: builtin/merge.c:1541:
+		printf(_("Using the %s to prepare resolving by hand.\n"),
+			best_strategy);

CHECK: Alignment should match open parenthesis
#47: FILE: builtin/help.c:47:
+	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
+			HELP_FORMAT_WEB),

CHECK: Alignment should match open parenthesis
#49: FILE: builtin/help.c:49:
+	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
+			HELP_FORMAT_INFO),

CHECK: Alignment should match open parenthesis
#53: FILE: builtin/hash-object.c:53:
+		hash_object(buf.buf, type, write_objects,
+		    no_filters ? NULL : buf.buf);

CHECK: Alignment should match open parenthesis
#835: FILE: builtin/receive-pack.c:835:
+	snprintf(hdr_arg, sizeof(hdr_arg),
+			"--pack_header=%"PRIu32",%"PRIu32,

CHECK: Alignment should match open parenthesis
#114: FILE: builtin/revert.c:114:
+		OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
+			N_("option for merge strategy"), option_parse_x),

CHECK: Alignment should match open parenthesis
#142: FILE: builtin/revert.c:142:
+	verify_opt_mutually_compatible(me,
+				"--quit", remove_state,

CHECK: Alignment should match open parenthesis
#174: FILE: builtin/revert.c:174:
+		verify_opt_compatible(me, this_operation,
+				"--no-commit", opts->no_commit,

CHECK: Alignment should match open parenthesis
#186: FILE: builtin/revert.c:186:
+		verify_opt_compatible(me, "--ff",
+				"--signoff", opts->signoff,

CHECK: Alignment should match open parenthesis
#57: FILE: builtin/diff-tree.c:57:
+	printf("%s %s\n", sha1_to_hex(tree1->object.sha1),
+			  sha1_to_hex(tree2->object.sha1));

CHECK: Alignment should match open parenthesis
#486: FILE: builtin/init-db.c:486:
+		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
+				N_("directory from which templates will be used")),

CHECK: Alignment should match open parenthesis
#488: FILE: builtin/init-db.c:488:
+		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
+				N_("create a bare repository"), 1),

CHECK: Alignment should match open parenthesis
#542: FILE: builtin/init-db.c:542:
+		setenv(GIT_DIR_ENVIRONMENT,
+			getcwd(git_dir, sizeof(git_dir)), argc > 0);

CHECK: Alignment should match open parenthesis
#71: FILE: builtin/name-rev.c:71:
+				sprintf(new_name, "%.*s~%d^%d", len, tip_name,
+						generation, parent_number);

CHECK: Alignment should match open parenthesis
#74: FILE: builtin/name-rev.c:74:
+				sprintf(new_name, "%.*s^%d", len, tip_name,
+						parent_number);

CHECK: Alignment should match open parenthesis
#77: FILE: builtin/name-rev.c:77:
+			name_rev(parents->item, new_name, 0,
+				distance + MERGE_TRAVERSAL_WEIGHT, 0);

CHECK: Alignment should match open parenthesis
#80: FILE: builtin/name-rev.c:80:
+			name_rev(parents->item, tip_name, generation + 1,
+				distance + 1, 0);

CHECK: Alignment should match open parenthesis
#148: FILE: builtin/name-rev.c:148:
+		snprintf(buffer, sizeof(buffer), "%.*s~%d", len, n->tip_name,
+				n->generation);

CHECK: Alignment should match open parenthesis
#232: FILE: builtin/name-rev.c:232:
+		OPT_STRING(0, "refs", &data.ref_filter, N_("pattern"),
+				   N_("only use refs matching <pattern>")),

CHECK: Alignment should match open parenthesis
#238: FILE: builtin/name-rev.c:238:
+		OPT_BOOLEAN(0, "always",     &always,
+			   N_("show abbreviated commit object as fallback")),

CHECK: Alignment should match open parenthesis
#258: FILE: builtin/name-rev.c:258:
+			fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
+					*argv);

CHECK: Alignment should match open parenthesis
#265: FILE: builtin/name-rev.c:265:
+			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
+					*argv);

CHECK: Alignment should match open parenthesis
#39: FILE: builtin/mailinfo.c:39:
+	if (name->len < 3 || 60 < name->len || strchr(name->buf, '@') ||
+		strchr(name->buf, '<') || strchr(name->buf, '>'))

CHECK: Alignment should match open parenthesis
#643: FILE: builtin/grep.c:643:
+		OPT_BOOLEAN(0, "cached", &cached,
+			N_("search in index instead of in the work tree")),

CHECK: Alignment should match open parenthesis
#645: FILE: builtin/grep.c:645:
+		OPT_NEGBIT(0, "no-index", &use_index,
+			 N_("find in contents not managed by git"), 1),

CHECK: Alignment should match open parenthesis
#647: FILE: builtin/grep.c:647:
+		OPT_BOOLEAN(0, "untracked", &untracked,
+			N_("search in both tracked and untracked files")),

CHECK: Alignment should match open parenthesis
#652: FILE: builtin/grep.c:652:
+		OPT_BOOLEAN('v', "invert-match", &opt.invert,
+			N_("show non-matching lines")),

CHECK: Alignment should match open parenthesis
#654: FILE: builtin/grep.c:654:
+		OPT_BOOLEAN('i', "ignore-case", &opt.ignore_case,
+			N_("case insensitive matching")),

CHECK: Alignment should match open parenthesis
#656: FILE: builtin/grep.c:656:
+		OPT_BOOLEAN('w', "word-regexp", &opt.word_regexp,
+			N_("match patterns only at word boundaries")),

CHECK: Alignment should match open parenthesis
#658: FILE: builtin/grep.c:658:
+		OPT_SET_INT('a', "text", &opt.binary,
+			N_("process binary files as text"), GREP_BINARY_TEXT),

CHECK: Alignment should match open parenthesis
#660: FILE: builtin/grep.c:660:
+		OPT_SET_INT('I', NULL, &opt.binary,
+			N_("don't match patterns in binary files"),

CHECK: Alignment should match open parenthesis
#683: FILE: builtin/grep.c:683:
+		OPT_NEGBIT(0, "full-name", &opt.relative,
+			N_("show filenames relative to top directory"), 1),

CHECK: Alignment should match open parenthesis
#685: FILE: builtin/grep.c:685:
+		OPT_BOOLEAN('l', "files-with-matches", &opt.name_only,
+			N_("show only filenames instead of matching lines")),

CHECK: Alignment should match open parenthesis
#687: FILE: builtin/grep.c:687:
+		OPT_BOOLEAN(0, "name-only", &opt.name_only,
+			N_("synonym for --files-with-matches")),

CHECK: Alignment should match open parenthesis
#689: FILE: builtin/grep.c:689:
+		OPT_BOOLEAN('L', "files-without-match",
+			&opt.unmatch_name_only,

CHECK: Alignment should match open parenthesis
#692: FILE: builtin/grep.c:692:
+		OPT_BOOLEAN('z', "null", &opt.null_following_name,
+			N_("print NUL after filenames")),

CHECK: Alignment should match open parenthesis
#694: FILE: builtin/grep.c:694:
+		OPT_BOOLEAN('c', "count", &opt.count,
+			N_("show the number of matches instead of matching lines")),

CHECK: Alignment should match open parenthesis
#697: FILE: builtin/grep.c:697:
+		OPT_BOOLEAN(0, "break", &opt.file_break,
+			N_("print empty line between matches from different files")),

CHECK: Alignment should match open parenthesis
#699: FILE: builtin/grep.c:699:
+		OPT_BOOLEAN(0, "heading", &opt.heading,
+			N_("show filename only once above matches from same file")),

CHECK: Alignment should match open parenthesis
#702: FILE: builtin/grep.c:702:
+		OPT_CALLBACK('C', "context", &opt, N_("n"),
+			N_("show <n> context lines before and after matches"),

CHECK: Alignment should match open parenthesis
#705: FILE: builtin/grep.c:705:
+		OPT_INTEGER('B', "before-context", &opt.pre_context,
+			N_("show <n> context lines before matches")),

CHECK: Alignment should match open parenthesis
#707: FILE: builtin/grep.c:707:
+		OPT_INTEGER('A', "after-context", &opt.post_context,
+			N_("show <n> context lines after matches")),

CHECK: Alignment should match open parenthesis
#709: FILE: builtin/grep.c:709:
+		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
+			context_callback),

CHECK: Alignment should match open parenthesis
#711: FILE: builtin/grep.c:711:
+		OPT_BOOLEAN('p', "show-function", &opt.funcname,
+			N_("show a line with the function name before matches")),

CHECK: Alignment should match open parenthesis
#713: FILE: builtin/grep.c:713:
+		OPT_BOOLEAN('W', "function-context", &opt.funcbody,
+			N_("show the surrounding function")),

CHECK: Alignment should match open parenthesis
#716: FILE: builtin/grep.c:716:
+		OPT_CALLBACK('f', NULL, &opt, N_("file"),
+			N_("read patterns from file"), file_callback),

CHECK: Alignment should match open parenthesis
#734: FILE: builtin/grep.c:734:
+		OPT_BOOLEAN(0, "all-match", &opt.all_match,
+			N_("show only matches from files that match all patterns")),

CHECK: Alignment should match open parenthesis
#878: FILE: builtin/grep.c:878:
+			strbuf_addf(&buf, "+/%s%s",
+					strcmp("less", pager) ? "" : "*",

CHECK: Alignment should match open parenthesis
#74: FILE: builtin/mailsplit.c:74:
+		if (!keep_cr && buf.len > 1 && buf.buf[buf.len-1] == '\n' &&
+			buf.buf[buf.len-2] == '\r') {

CHECK: Alignment should match open parenthesis
#359: FILE: builtin/tag.c:359:
+			fprintf(stderr,
+			_("Please supply the message using either -m or -F option.\n"));

CHECK: Alignment should match open parenthesis
#454: FILE: builtin/tag.c:454:
+		OPT_BOOLEAN('a', "annotate", &annotate,
+					N_("annotated tag, needs a message")),

CHECK: Alignment should match open parenthesis
#460: FILE: builtin/tag.c:460:
+		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
+			N_("how to strip spaces and #comments from message")),

CHECK: Alignment should match open parenthesis
#462: FILE: builtin/tag.c:462:
+		OPT_STRING('u', "local-user", &keyid, N_("key id"),
+					N_("use another key to sign the tag")),

CHECK: Alignment should match open parenthesis
#544: FILE: builtin/tag.c:544:
+					die_errno(_("could not open or read '%s'"),
+						msgfile);

CHECK: Alignment should match open parenthesis
#21: FILE: builtin/update-ref.c:21:
+		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
+					N_("update <refname> not the one it points to")),

CHECK: Alignment should match open parenthesis
#812: FILE: builtin/pack-objects.c:812:
+		die("wrote %"PRIu32" objects while expecting %"PRIu32,
+			written, nr_result);

CHECK: Alignment should match open parenthesis
#1912: FILE: builtin/pack-objects.c:1912:
+		fprintf(stderr, "Delta compression using up to %d threads.\n",
+				delta_search_threads);

CHECK: Alignment should match open parenthesis
#2311: FILE: builtin/pack-objects.c:2311:
+		if ((!p->pack_local || p->pack_keep) &&
+			find_pack_entry_one(sha1, p)) {

CHECK: Alignment should match open parenthesis
#2345: FILE: builtin/pack-objects.c:2345:
+			if (!locate_object_entry(sha1) &&
+				!has_sha1_pack_kept_or_nonlocal(sha1))

CHECK: Alignment should match open parenthesis
#23: FILE: builtin/check-attr.c:23:
+	OPT_BOOLEAN('z', NULL, &null_term_line,
+		N_("input paths are terminated by a null character")),

CHECK: Alignment should match open parenthesis
#61: FILE: builtin/remote-ext.c:61:
+				die("Bad remote-ext placeholder '%%%c'.",
+					str[rpos]);

CHECK: Alignment should match open parenthesis
#117: FILE: builtin/mktree.c:117:
+		die("entry '%s' object type (%s) doesn't match mode type (%s)",
+			path, ptr, typename(mode_type));

CHECK: Alignment should match open parenthesis
#136: FILE: builtin/mktree.c:136:
+			die("entry '%s' object %s is a %s but specified type was (%s)",
+				path, sha1_to_hex(sha1), typename(obj_type), typename(mode_type));

CHECK: Alignment should match open parenthesis
#212: FILE: builtin/rm.c:212:
+	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
+				N_("exit with a zero status even if nothing matched")),

CHECK: Alignment should match open parenthesis
#377: FILE: builtin/notes.c:377:
+			error(_("Bad %s value: '%s'"), GIT_NOTES_REWRITE_MODE_ENVIRONMENT,
+					rewrite_mode_env);

CHECK: Alignment should match open parenthesis
#654: FILE: builtin/show-branch.c:654:
+		OPT__COLOR(&showbranch_use_color,
+			    N_("color '*!+-' corresponding to the branch")),

CHECK: Alignment should match open parenthesis
#293: FILE: archive-zip.c:293:
+	copy_le16(dirent.creator_version,
+		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);

CHECK: Alignment should match open parenthesis
#345: FILE: mailmap.c:345:
+		debug_mm("map_user:  to '%.*s' <.*%s>\n", *namelen, *name,
+				 *emaillen, *email);

CHECK: Alignment should match open parenthesis
#438: FILE: log-tree.c:438:
+		strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
+				    tag->tag, tag->tagged->sha1);

CHECK: Alignment should match open parenthesis
#57: FILE: alloc.c:57:
+	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
+			name, count, (uintmax_t) size);

CHECK: Alignment should match open parenthesis
#327: FILE: run-command.c:327:
+			error("cannot create %s pipe for %s: %s",
+				str, cmd->argv[0], strerror(failed_errno));

CHECK: Alignment should match open parenthesis
#397: FILE: run-command.c:397:
+			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
+			    cmd->dir);

CHECK: Alignment should match open parenthesis
#416: FILE: run-command.c:416:
+				error("cannot run %s: %s", cmd->argv[0],
+					strerror(ENOENT));

CHECK: Alignment should match open parenthesis
#424: FILE: run-command.c:424:
+		error("cannot fork() for %s: %s", cmd->argv[0],
+			strerror(errno));

CHECK: Alignment should match open parenthesis
#45: FILE: string-list.c:45:
+		memmove(list->items + index + 1, list->items + index,
+				(list->nr - index)

CHECK: Alignment should match open parenthesis
#116: FILE: usage.c:116:
+		fputs("fatal: recursion detected in die_errno handler\n",
+			stderr);

CHECK: Alignment should match open parenthesis
#425: FILE: notes.c:425:
+		die("Could not read %s for notes-index",
+		     sha1_to_hex(subtree->val_sha1));

CHECK: Alignment should match open parenthesis
#1218: FILE: notes.c:1218:
+	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen ||
+			type != OBJ_BLOB) {

CHECK: Alignment should match open parenthesis
#347: FILE: connect.c:347:
+			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
+				host,

CHECK: Alignment should match open parenthesis
#80: FILE: refs.c:80:
+			if ((flags & REFNAME_REFSPEC_PATTERN) &&
+					refname[0] == '*' &&

CHECK: Alignment should match open parenthesis
#902: FILE: refs.c:902:
+	add_ref(get_packed_refs(get_ref_cache(NULL)),
+			create_ref_entry(refname, sha1, REF_ISPACKED, 1));

CHECK: Alignment should match open parenthesis
#1138: FILE: refs.c:1138:
+			if (!prefixcmp(buffer, "refs/") &&
+					!check_refname_format(buffer, 0)) {

CHECK: Alignment should match open parenthesis
#1546: FILE: refs.c:1546:
+		error("Ref %s is at %s but expected %s", lock->ref_name,
+			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));

CHECK: Alignment should match open parenthesis
#1695: FILE: refs.c:1695:
+		error("unable to resolve reference %s: %s",
+			orig_refname, strerror(errno));

CHECK: Alignment should match open parenthesis
#1705: FILE: refs.c:1705:
+	if (missing &&
+	     !is_refname_available(refname, NULL,
get_packed_refs(get_ref_cache(NULL)))) {

CHECK: Alignment should match open parenthesis
#1908: FILE: refs.c:1908:
+			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
+				newrefname, strerror(errno));

CHECK: Alignment should match open parenthesis
#1945: FILE: refs.c:1945:
+		error("unable to restore logfile %s from %s: %s",
+			oldrefname, newrefname, strerror(errno));

CHECK: Alignment should match open parenthesis
#1949: FILE: refs.c:1949:
+		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
+			oldrefname, strerror(errno));

CHECK: Alignment should match open parenthesis
#2102: FILE: refs.c:2102:
+		error("Trying to write ref %s with nonexistent object %s",
+			lock->ref_name, sha1_to_hex(sha1));

CHECK: Alignment should match open parenthesis
#2108: FILE: refs.c:2108:
+		error("Trying to write non-commit object %s to branch %s",
+			sha1_to_hex(sha1), lock->ref_name);
---

There are 535 instances where parenthesis are not aligned. Do you
still think aligning open parenthesis is the "style of the project"?

Please. You are rejecting this patch on a whim, and nothing more.

Do you know what I do in the projects I maintain? I tell people to run
checkpatch, if checkpatch doesn't have any problems with the style,
neither do I. To do anything else is a waste of style for me, and the
contributors, because going back and forth into arguing if the style
is violated or not, and discussing every two patches what should be
the ideal guideline, and if the patch is meting the guideline or not
is *NOT PRODUCTIVE*. I do not tell them to follow the style of the
surrounding code, because the surrounding code might have the wrong
style, and they are perpetuating it.

But do what you will. I don't care. This patch fixed the code to
follow Documentation/CodingGuidelines to the letter, and it even
passes Linux's checkpatch script. Any sensible maintainer would have
applied it without reservations. Period.

-- 
Felipe Contreras

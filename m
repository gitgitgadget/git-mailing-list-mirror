Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964B31FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbcFQVV1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:21:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750986AbcFQVV1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 17:21:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B98625400;
	Fri, 17 Jun 2016 17:21:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tZLp0uffifx+
	PHENR40eSJnqQcQ=; b=Dg98+P9PTAW8zqUlSd10aVUWn6qBvuTWnCvZqsL7HvUD
	SaVs0Lw7EimVvA1DXGUXO6R3CY1vS4M68K/uoWzmfHKHVGZVIMjd98RE+G51cLIB
	L4cLmHYu/C+DDmJGkvbCCgkneaJFsre5NIk1ufE2GiuagYy44kZflLkzx9idUKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U2fqQK
	FB0y1gx7VGcH70r1vUoAivS+6PnYcbavp2RzD/qBKq8+DSaP7daE+48kbAxdTnf2
	QRRa6+VRJzHHilaAnE4t+lKYe59LXPpHnrgFc3PsGODydvB5QGREyCko03I5bEZM
	9JHdzZyAWllD1mXt4c0C0rZOIeEeBHJcLwkFI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92CAB253FE;
	Fri, 17 Jun 2016 17:21:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2631253FC;
	Fri, 17 Jun 2016 17:21:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 00/38] i18n and test updates
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Fri, 17 Jun 2016 14:21:23 -0700
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Fri, 17 Jun 2016 20:20:49 +0000")
Message-ID: <xmqqoa6zzf3g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 722793DA-34D1-11E6-B708-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Interdiff included below.
>
> Vasco Almeida (38):
>   i18n: builtin/remote.c: fix mark for translation
>   i18n: advice: mark string about detached head for translation
>   i18n: advice: internationalize message for conflicts
>   i18n: transport: mark strings for translation
>   i18n: sequencer: mark entire sentences for translation
>   i18n: sequencer: mark string for translation
>   i18n: merge-octopus: mark messages for translation
>   merge-octupus: use die shell function from git-sh-setup.sh

octopus.

>   i18n: rebase: fix marked string to use eval_gettext variant
>   i18n: rebase: mark placeholder for translation
>   i18n: bisect: simplify error message for i18n
>   t6030: update to use test_i18ncmp
>   i18n: git-sh-setup.sh: mark strings for translation
>   i18n: rebase-interactive: mark strings for translation
>   i18n: rebase-interactive: mark here-doc strings for translation
>   i18n: rebase-interactive: mark comments of squash for translation
>   i18n: setup: mark strings for translation
>   tests: use test_i18n* functions to suppress false positives
>   tests: unpack-trees: update to use test_i18n* functions
>   t9003: become resilient to GETTEXT_POISON
>   t4153: fix negated test_i18ngrep call
>   t5523: use test_i18ngrep for negation
>   i18n: bisect: mark strings for translation
>   i18n: transport-helper.c: change N_() call to _()
>   i18n: notes: mark strings for translation
>   i18n: notes: mark options for translation
>   i18n: config: unfold error messages marked for translation
>   i18n: merge: mark messages for translation
>   i18n: merge: change command option help to lowercase
>   i18n: sequencer: add period to error message
>   i18n: standardise messages
>   i18n: remote: mark URL fallback text for translation
>   i18n: remote: allow translations to reorder message

The last 5 patches seem to have been lost...

>   i18n: init-db: join message pieces
>   i18n: submodule: join strings marked for translation
>   i18n: submodule: escape shell variables inside eval_gettext
>   i18n: unmark die messages for translation
>   i18n: branch: mark comment when editing branch description for
>     translation
>
>  Makefile                              |   5 +-
>  advice.c                              |  23 ++-
>  bisect.c                              |  56 ++++---
>  builtin/apply.c                       |   6 +-
>  builtin/branch.c                      |   6 +-
>  builtin/checkout.c                    |   6 +-
>  builtin/init-db.c                     |  17 +-
>  builtin/merge.c                       |  12 +-
>  builtin/notes.c                       |  24 +--
>  builtin/pull.c                        |   2 +-
>  builtin/remote.c                      |  19 ++-
>  builtin/repack.c                      |   2 +-
>  cache.h                               |   9 +-
>  config.c                              | 101 ++++++++++--
>  git-bisect.sh                         |   8 +-
>  git-merge-octopus.sh                  |  23 ++-
>  git-rebase--interactive.sh            | 290 ++++++++++++++++++++--------------
>  git-rebase.sh                         |   5 +-
>  git-sh-i18n.sh                        |  18 +++
>  git-sh-setup.sh                       |  63 ++++++--
>  git-stash.sh                          |   1 -
>  git-submodule.sh                      |  23 +--
>  po/is.po                              |  46 +++---
>  sequencer.c                           |  15 +-
>  setup.c                               |  16 +-
>  submodule-config.c                    |   2 +-
>  t/lib-rebase.sh                       |   1 +
>  t/t0008-ignores.sh                    |   4 +-
>  t/t1011-read-tree-sparse-checkout.sh  |   2 +-
>  t/t1300-repo-config.sh                |   8 +-
>  t/t1307-config-blob.sh                |   5 +-
>  t/t1308-config-set.sh                 |   4 +-
>  t/t1400-update-ref.sh                 |   2 +-
>  t/t1506-rev-parse-diagnosis.sh        |   2 +-
>  t/t2010-checkout-ambiguous.sh         |   2 +-
>  t/t2018-checkout-branch.sh            |   2 +-
>  t/t3200-branch.sh                     |   6 +-
>  t/t3201-branch-contains.sh            |   2 +-
>  t/t3310-notes-merge-manual-resolve.sh |   8 +-
>  t/t3320-notes-merge-worktrees.sh      |   4 +-
>  t/t3400-rebase.sh                     |   4 +-
>  t/t3404-rebase-interactive.sh         |  18 +--
>  t/t4153-am-resume-override-opts.sh    |   2 +-
>  t/t4208-log-magic-pathspec.sh         |   4 +-
>  t/t5505-remote.sh                     |   2 +-
>  t/t5510-fetch.sh                      |   2 +-
>  t/t5520-pull.sh                       |   2 +-
>  t/t5523-push-upstream.sh              |  12 +-
>  t/t5536-fetch-conflicts.sh            |   4 +-
>  t/t6030-bisect-porcelain.sh           |  26 +--
>  t/t6301-for-each-ref-errors.sh        |  10 +-
>  t/t7063-status-untracked-cache.sh     |   2 +-
>  t/t7102-reset.sh                      |   4 +-
>  t/t7201-co.sh                         |   2 +-
>  t/t7400-submodule-basic.sh            |   2 +-
>  t/t7403-submodule-sync.sh             |   4 +-
>  t/t7406-submodule-update.sh           |  10 +-
>  t/t7508-status.sh                     |   4 +-
>  t/t7607-merge-overwrite.sh            |   2 +-
>  t/t9003-help-autocorrect.sh           |   4 +-
>  transport-helper.c                    |   2 +-
>  transport.c                           |  20 +--
>  wt-status.c                           |   4 +-
>  63 files changed, 604 insertions(+), 392 deletions(-)
>
> ---- >8 ----
> diff --git a/po/is.po b/po/is.po
> index 8692a8b..b8b34fd 100644
> --- a/po/is.po
> +++ b/po/is.po
> @@ -7,14 +7,15 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: Git\n"
>  "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
> -"POT-Creation-Date: 2010-09-20 14:44+0000\n"
> -"PO-Revision-Date: 2010-06-05 19:06 +0000\n"
> -"Last-Translator: Ævar Arnfjörð Bjarmason <avarab@gmail.com>\n"
> +"POT-Creation-Date: 2016-06-17 18:55+0000\n"
> +"PO-Revision-Date: 2016-06-17 19:17+0000\n"
> +"Last-Translator: Vasco Almeida <vascomalmeida@sapo.pt>\n"
>  "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
>  "Language: is\n"
>  "MIME-Version: 1.0\n"
>  "Content-Type: text/plain; charset=UTF-8\n"
>  "Content-Transfer-Encoding: 8bit\n"
> +"X-Generator: Poedit 1.8.5\n"
>  
>  #. TRANSLATORS: This is a test. You don't need to translate it.
>  #: t/t0200/test.c:5
> @@ -72,22 +73,31 @@ msgstr "TILRAUN: Perl tilraunastrengur"
>  msgid "TEST: A Perl test variable %s"
>  msgstr "TILRAUN: Perl tilraunastrengur með breytunni %s"
>  
> -#. TRANSLATORS: The first '%s' is either "Reinitialized
> -#. existing" or "Initialized empty", the second " shared" or
> -#. "", and the last '%s%s' is the verbatim directory name.
> -#: builtin/init-db.c:355
> +#: builtin/init-db.c:402
>  #, c-format
> -msgid "%s%s Git repository in %s%s\n"
> -msgstr "%s%s Git lind í %s%s\n"
> +msgid "Reinitialized existing shared Git repository in %s%s\n"
> +msgstr "Endurgerði Git lind í %s%s\n"
>  
> -#: builtin/init-db.c:356
> -msgid "Reinitialized existing"
> -msgstr "Endurgerði"
> +#: builtin/init-db.c:403
> +#, c-format
> +msgid "Reinitialized existing Git repository in %s%s\n"
> +msgstr "Endurgerði Git lind í %s%s\n"
> +
> +#: builtin/init-db.c:407
> +#, c-format
> +msgid "Initialized empty shared Git repository in %s%s\n"
> +msgstr "Bjó til tóma sameiginlega Git lind í %s%s\n"
> +
> +#: builtin/init-db.c:408
> +#, c-format
> +msgid "Initialized empty Git repository in %s%s\n"
> +msgstr "Bjó til tóma Git lind í %s%s\n"
> +
> +#~ msgid "Reinitialized existing"
> +#~ msgstr "Endurgerði"
>  
> -#: builtin/init-db.c:356
> -msgid "Initialized empty"
> -msgstr "Bjó til tóma"
> +#~ msgid "Initialized empty"
> +#~ msgstr "Bjó til tóma"
>  
> -#: builtin/init-db.c:357
> -msgid " shared"
> -msgstr " sameiginlega"
> +#~ msgid " shared"
> +#~ msgstr " sameiginlega"
> ---- >8 ----

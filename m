From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments
Date: Thu, 20 Mar 2014 18:34:08 -0400
Message-ID: <CAEjxke_+=v8HOi9u5Bd_CxmnWcJmaFBSjrXJF8puEp7X84H_nQ@mail.gmail.com>
References: <1395353785-23611-1-git-send-email-jlebar@google.com> <1395353785-23611-4-git-send-email-jlebar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Justin Lebar <jlebar@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 23:41:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQleL-0007rK-94
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 23:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759916AbaCTWlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 18:41:17 -0400
Received: from mailhub248.itcs.purdue.edu ([128.210.5.248]:32958 "EHLO
	mailhub248.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759160AbaCTWlP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 18:41:15 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Mar 2014 18:41:15 EDT
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com [209.85.216.48])
	(authenticated bits=0)
	by mailhub248.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id s2KMYTPS028020
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 20 Mar 2014 18:34:29 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so1649388qaj.35
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 15:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UnfXGkQjxAV2pbs87wUzq2eH7ZxBoHsEKp9nspTkMTY=;
        b=cFX2UacaZ5nN8Wj/gWPiUCXfCpivInjiCb7qWbnWCBCtsPHq4tUodxcBLeCK+y4oaY
         pR6Yisca1w35FPbEz0l2f0FW0X5QHyPooVBd//BeySv9mK2rpQtjJpzeHDpjrkVLavVQ
         eZM6MtaHCvmICt+jatFRQlYsZMpCFwRBPAPRdXfxfKKQ77MCukihuByx7LppBn7Iazdg
         m1xYOMHtUAF3bykn47NrfAY/mWQyS/e/x77icd2qfjBDVK9pLasnJIWwhLRLmx3BxAoz
         Pr5S+FcLtZvHA4RucY3PTjpDvhRvFhe9pLM1pHLWZxuzSHZVOQfZX23S7MqvWW8o4gXz
         KrPg==
X-Received: by 10.224.53.198 with SMTP id n6mr53198561qag.41.1395354869017;
 Thu, 20 Mar 2014 15:34:29 -0700 (PDT)
Received: by 10.140.102.212 with HTTP; Thu, 20 Mar 2014 15:34:08 -0700 (PDT)
In-Reply-To: <1395353785-23611-4-git-send-email-jlebar@google.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-URL-Scanned: Yes
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244597>

On Thu, Mar 20, 2014 at 6:16 PM, Justin Lebar <jlebar@google.com> wrote:
> Signed-off-by: Justin Lebar <jlebar@gmail.com>
> ---
>  Makefile                                    | 2 +-
>  builtin/apply.c                             | 2 +-
>  builtin/checkout.c                          | 2 +-
>  builtin/log.c                               | 2 +-
>  builtin/pack-objects.c                      | 2 +-
>  builtin/reset.c                             | 4 ++--
>  builtin/show-branch.c                       | 2 +-
>  column.c                                    | 2 +-
>  contrib/examples/git-checkout.sh            | 2 +-
>  contrib/examples/git-reset.sh               | 4 ++--
>  contrib/fast-import/import-directories.perl | 4 ++--
>  delta.h                                     | 2 +-
>  diff.c                                      | 2 +-
>  git-am.sh                                   | 2 +-
>  gitweb/gitweb.perl                          | 2 +-
>  http.h                                      | 4 ++--
>  perl/Git/SVN.pm                             | 2 +-
>  perl/Git/SVN/Migration.pm                   | 2 +-
>  pkt-line.h                                  | 2 +-
>  remote.c                                    | 2 +-
>  sha1_file.c                                 | 2 +-
>  test-chmtime.c                              | 2 +-
>  22 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index dddaf4f..fc02788 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -159,7 +159,7 @@ all::
>  #
>  # Define NEEDS_LIBINTL_BEFORE_LIBICONV if you need libintl before libiconv.
>  #
> -# Define NO_INTPTR_T if you don't have intptr_t nor uintptr_t.
> +# Define NO_INTPTR_T if you don't have intptr_t or uintptr_t.
>  #
>  # Define NO_UINTMAX_T if you don't have uintmax_t.
>  #
> diff --git a/builtin/apply.c b/builtin/apply.c
> index b0d0986..6013e19 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -4061,7 +4061,7 @@ static int write_out_one_reject(struct patch *patch)
>                 return error(_("cannot open %s: %s"), namebuf, strerror(errno));
>
>         /* Normal git tools never deal with .rej, so do not pretend
> -        * this is a git patch by saying --git nor give extended
> +        * this is a git patch by saying --git or giving extended
>          * headers.  While at it, maybe please "kompare" that wants
>          * the trailing TAB and some garbage at the end of line ;-).
>          */

I don't think the change from "give" to "giving" here is grammatically correct.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index ada51fa..7f37d1a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -895,7 +895,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>          *       between A and B, A...B names that merge base.
>          *
>          *   (b) If <something> is _not_ a commit, either "--" is present
> -        *       or <something> is not a path, no -t nor -b was given, and
> +        *       or <something> is not a path, no -t or -b was given, and
>          *       and there is a tracking branch whose name is <something>
>          *       in one and only one remote, then this is a short-hand to
>          *       fork local <something> from that remote-tracking branch.
> diff --git a/builtin/log.c b/builtin/log.c
> index b97373d..39e8836 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -503,7 +503,7 @@ static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *
>                 /* There was no "-m" on the command line */
>                 rev->ignore_merges = 0;
>                 if (!rev->first_parent_only && !rev->combine_merges) {
> -                       /* No "--first-parent", "-c", nor "--cc" */
> +                       /* No "--first-parent", "-c", or "--cc" */
>                         rev->combine_merges = 1;
>                         rev->dense_combined_merges = 1;
>                 }
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 541667f..ef1f20e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -999,7 +999,7 @@ static int pbase_tree_cache_ix_incr(int ix)
>  static struct pbase_tree {
>         struct pbase_tree *next;
>         /* This is a phony "cache" entry; we are not
> -        * going to evict it nor find it through _get()
> +        * going to evict it or find it through _get()
>          * mechanism -- this is for the toplevel node that
>          * would almost always change with any commit.
>          */
> diff --git a/builtin/reset.c b/builtin/reset.c
> index a991344..96dd4c9 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -309,7 +309,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>
>         /* git reset tree [--] paths... can be used to
>          * load chosen paths from the tree into the index without
> -        * affecting the working tree nor HEAD. */
> +        * affecting the working tree or HEAD. */
>         if (pathspec.nr) {
>                 if (reset_type == MIXED)
>                         warning(_("--mixed with paths is deprecated; use 'git reset -- <paths>' instead."));
> @@ -327,7 +327,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>                 die(_("%s reset is not allowed in a bare repository"),
>                     _(reset_type_names[reset_type]));
>
> -       /* Soft reset does not touch the index file nor the working tree
> +       /* Soft reset does not touch the index file or the working tree
>          * at all, but requires them in a good order.  Other resets reset
>          * the index file to the tree object we are switching to. */
>         if (reset_type == SOFT || reset_type == KEEP)
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index d9217ce..53dc042 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -698,7 +698,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>
>         if (extra || reflog) {
>                 /* "listing" mode is incompatible with
> -                * independent nor merge-base modes.
> +                * independent and merge-base modes.
>                  */
>                 if (independent || merge_base)
>                         usage_with_options(show_branch_usage,
> diff --git a/column.c b/column.c
> index 9367ba5..1854540 100644
> --- a/column.c
> +++ b/column.c
> @@ -311,7 +311,7 @@ static int parse_config(unsigned int *colopts, const char *value)
>                 value += strspn(value, sep);
>         }
>         /*
> -        * Setting layout implies "always" if neither always, never
> +        * Setting layout implies "always" if neither always, never,
>          * nor auto is specified.

This sentence does not seem grammatically correct. How about ``If none
of "always", "never", or "auto" is specified, then setting layout
implies "always".``?

>          *
>          * Current value in COL_ENABLE_MASK is disregarded. This means if
> diff --git a/contrib/examples/git-checkout.sh b/contrib/examples/git-checkout.sh
> index 1a7689a..d2c1f98 100755
> --- a/contrib/examples/git-checkout.sh
> +++ b/contrib/examples/git-checkout.sh
> @@ -168,7 +168,7 @@ cd_to_toplevel
>  # branch.  However, if "git checkout HEAD" detaches the HEAD
>  # from the current branch, even though that may be logically
>  # correct, it feels somewhat funny.  More importantly, we do not
> -# want "git checkout" nor "git checkout -f" to detach HEAD.
> +# want "git checkout" or "git checkout -f" to detach HEAD.
>
>  detached=
>  detach_warn=
> diff --git a/contrib/examples/git-reset.sh b/contrib/examples/git-reset.sh
> index bafeb52..cb1bbf3 100755
> --- a/contrib/examples/git-reset.sh
> +++ b/contrib/examples/git-reset.sh
> @@ -40,7 +40,7 @@ case "$1" in --) shift ;; esac
>
>  # git reset --mixed tree [--] paths... can be used to
>  # load chosen paths from the tree into the index without
> -# affecting the working tree nor HEAD.
> +# affecting the working tree or HEAD.
>  if test $# != 0
>  then
>         test "$reset_type" = "--mixed" ||
> @@ -60,7 +60,7 @@ then
>         update=-u
>  fi
>
> -# Soft reset does not touch the index file nor the working tree
> +# Soft reset does not touch the index file or the working tree
>  # at all, but requires them in a good order.  Other resets reset
>  # the index file to the tree object we are switching to.
>  if test "$reset_type" = "--soft"
> diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-import/import-directories.perl
> index 7f3afa5..4dec1f1 100755
> --- a/contrib/fast-import/import-directories.perl
> +++ b/contrib/fast-import/import-directories.perl
> @@ -109,8 +109,8 @@ was available previously is not included in this revision, it will
>  be removed.
>
>  If an on-disk revision is incomplete, you can point to files from
> -a previous revision. There are no restriction as to where the source
> -files are located, nor to the names of them.
> +a previous revision. There are no restrictions on where the source
> +files are located, nor on their names.
>
>   [3.files]
>   ; the key is the path inside the repository, the value is the path
> diff --git a/delta.h b/delta.h
> index b9d333d..9b67531 100644
> --- a/delta.h
> +++ b/delta.h
> @@ -9,7 +9,7 @@ struct delta_index;
>   *
>   * This returns a pointer to a struct delta_index that should be passed to
>   * subsequent create_delta() calls, or to free_delta_index().  A NULL pointer
> - * is returned on failure.  The given buffer must not be freed nor altered
> + * is returned on failure.  The given buffer must not be freed or altered
>   * before free_delta_index() is called.  The returned pointer must be freed
>   * using free_delta_index().
>   */
> diff --git a/diff.c b/diff.c
> index 1cd4672..635dee2 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3942,7 +3942,7 @@ static int diff_scoreopt_parse(const char *opt)
>                 }
>         }
>         if (cmd != 'M' && cmd != 'C' && cmd != 'B')
> -               return -1; /* that is not a -M, -C nor -B option */
> +               return -1; /* that is not a -M, -C, or -B option */
>
>         opt1 = parse_rename_score(&opt);
>         if (cmd != 'B')
> diff --git a/git-am.sh b/git-am.sh
> index bbea430..e92e5bb 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -523,7 +523,7 @@ Use \"git am --abort\" to remove it.")"
>                 esac
>         fi
>
> -       # Make sure we are not given --skip, --continue, nor --abort
> +       # Make sure we are not given --skip, --continue, or --abort
>         test "$skip$resolved$abort" = "" ||
>                 die "$(gettext "Resolve operation not in progress, we are not resuming.")"
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3bc0f0b..52108b9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1490,7 +1490,7 @@ sub is_valid_pathname {
>         my $input = shift;
>
>         return undef unless defined $input;
> -       # no '.' or '..' as elements of path, i.e. no '.' nor '..'
> +       # no '.' or '..' as elements of path, i.e. no '.' or '..'
>         # at the beginning, at the end, and between slashes.
>         # also this catches doubled slashes
>         if ($input =~ m!(^|/)(|\.|\.\.)(/|$)!) {
> diff --git a/http.h b/http.h
> index cd37d58..cba09d1 100644
> --- a/http.h
> +++ b/http.h
> @@ -13,8 +13,8 @@
>  /*
>   * We detect based on the cURL version if multi-transfer is
>   * usable in this implementation and define this symbol accordingly.
> - * This is not something Makefile should set nor users should pass
> - * via CFLAGS.
> + * This is not something Makefile should set nor something users should
> + * pass via CFLAGS.
>   */
>  #undef USE_CURL_MULTI
>

To leave "nor" here, I think you need to replace "not" with "neither".

> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 6e804a2..62f3293 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1191,7 +1191,7 @@ sub do_fetch {
>                 # we can have a branch that was deleted, then re-added
>                 # under the same name but copied from another path, in
>                 # which case we'll have multiple parents (we don't
> -               # want to break the original ref, nor lose copypath info):
> +               # want to break the original ref or lose copypath info):
>                 if (my $log_entry = $self->find_parent_branch($paths, $rev)) {
>                         push @{$log_entry->{parents}}, $lc;
>                         return $log_entry;
> diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
> index 30daf35..cf6ffa7 100644
> --- a/perl/Git/SVN/Migration.pm
> +++ b/perl/Git/SVN/Migration.pm
> @@ -1,6 +1,6 @@
>  package Git::SVN::Migration;
>  # these version numbers do NOT correspond to actual version numbers
> -# of git nor git-svn.  They are just relative.
> +# of git or git-svn.  They are just relative.
>  #
>  # v0 layout: .git/$id/info/url, refs/heads/$id-HEAD
>  #
> diff --git a/pkt-line.h b/pkt-line.h
> index 0a838d1..b6bd8b5 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -28,7 +28,7 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
>   * Read a packetized line into the buffer, which must be at least size bytes
>   * long. The return value specifies the number of bytes read into the buffer.
>   *
> - * If src_buffer is not NULL (and nor is *src_buffer), it should point to a
> + * If src_buffer is not NULL (and neither is *src_buffer), it should point to a
>   * buffer containing the packet data to parse, of at least *src_len bytes.
>   * After the function returns, src_buf will be incremented and src_len
>   * decremented by the number of bytes consumed.

This would be better worded as "If src_buffer and *src_buffer are not
NULL, it should ..."

> diff --git a/remote.c b/remote.c
> index 5f63d55..f43c7a9 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1409,7 +1409,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
>                                 /*
>                                  * Remote doesn't have it, and we have no
>                                  * explicit pattern, and we don't have
> -                                * --all nor --mirror.
> +                                * --all or --mirror.
>                                  */
>                                 goto free_name;
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 6e8c05d..b79efe4 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -787,7 +787,7 @@ void close_pack_index(struct packed_git *p)
>   * contain the same set of objects as an existing one.  In that case
>   * the resulting file might be different even if its name would be the
>   * same.  It is best to close any reference to the old pack before it is
> - * replaced on disk.  Of course no index pointers nor windows for given pack
> + * replaced on disk.  Of course no index pointers or windows for given pack
>   * must subsist at this point.  If ever objects from this pack are requested
>   * again, the new version of the pack will be reinitialized through
>   * reprepare_packed_git().
> diff --git a/test-chmtime.c b/test-chmtime.c
> index 0df7487..dfe8a83 100644
> --- a/test-chmtime.c
> +++ b/test-chmtime.c
> @@ -1,6 +1,6 @@
>  /*
>   * This program can either change modification time of the given
> - * file(s) or just print it. The program does not change atime nor
> + * file(s) or just print it. The program does not change atime or
>   * ctime (their values are explicitly preserved).
>   *
>   * The mtime can be changed to an absolute value:
> --
> 1.9.0.279.gdc9e3eb
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Jason

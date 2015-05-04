From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] fixed translation errors
Date: Mon, 4 May 2015 10:39:02 -0700
Message-ID: <CAGZ79kZW40f0q+ecxHKHZ=MxVc2Wt-960L9kcd_E8Xh7jbLNHw@mail.gmail.com>
References: <5547675a.274ec20a.69fb.ffffce22@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Alangi Derick <alangiderick@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 04 19:39:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpKKo-0003EN-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 19:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbbEDRjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 13:39:09 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35620 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbbEDRjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 13:39:03 -0400
Received: by igbyr2 with SMTP id yr2so91012638igb.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=Tk92uoCy7KRo+j1uTpmUu7MOH2Amnv5uh3xY3tcInPc=;
        b=THYzSwezWjNJzELtpn52b3AJdIIV8HYRED9A1qalYZuIq2R6VeLdkEUxE00h/LiOF6
         R6vMUl/wUeZfiwxIuBkxu8OI3LYvgdbTEe+s5JLwrGfP792grsiC1Gz34666crUnK7BY
         ATbfH2irq88/7Piqb9zPJqCSlZL1BMHSq2YDPpyo1w7AAfasTmFEgs4Hn63SFKdMqCbt
         pE5j0YhTPrYKQWcCYzsGQZl221f1GWPDFdOa9fplho0zFyqMJ6+3dIFv/zsEUKqW20rO
         FBoxXdr+8MB2Ky+iAurwb00OrPogyguLenSiWjCo05LvE4CFbfUY0fk6ar8/n0RqdpwE
         2Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=Tk92uoCy7KRo+j1uTpmUu7MOH2Amnv5uh3xY3tcInPc=;
        b=Jn3omhkrCF5U8z4iUVYGF3LYHoye2DqpHiWYtGCLUZfTBk5hazFZR5EYDfK+vdl/sQ
         JcmcIsvLWFrDesPepP5dyX/1wvFv7f2oN4YkGInTT89A7qPv5OUM3IF36G7pt0YVfJpS
         6cucIOjTX2o0O++Pl2kKDYISod31EldgRxOAVZ1z9eIIBn9axv0tWL6qlZmXxknByC/W
         nYSjIorArMXNyhpPZAyAqGRJ2SuLplmkIdQNBQbjRtMOo8RpGGNfpRt7mykEP221BHXI
         am9AZqxFEWYzvh0agDKmKrPfGHHbg9CGhtPQHEPFrrLv01WxhO3e6dIZnvgEW++2AhCo
         4qMA==
X-Gm-Message-State: ALoCoQkDHl5eVe7fF7r612UyiCGovEbhnx8CMIl/r26M2ELYRXDJoY8Pmawh0UmNK0cc98Dd8DAh
X-Received: by 10.107.13.11 with SMTP id 11mr29762923ion.70.1430761142788;
 Mon, 04 May 2015 10:39:02 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 4 May 2015 10:39:02 -0700 (PDT)
In-Reply-To: <5547675a.274ec20a.69fb.ffffce22@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268334>

On Sun, May 3, 2015 at 3:19 PM, Alangi Derick <alangiderick@gmail.com> wrote:
> Signed-off-by: Alangi Derick <alangiderick@gmail.com>
> ---
>  builtin/apply.c | 60 ++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 0769b09..66d2aba 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c

Please have a look at command-list.txt
or the entry man page of git [1], which makes
a difference between plumbing commands and
porcelain commands.

The plumbing layer is intended for use in scripts.
And looking for error messages in scripts is quite un easy
if these are actually translated.

The porcelain layer, which is intended to be used by people,
should have all the translations, because humans do like to
see the error message in their configured language.

[1] https://www.kernel.org/pub/software/scm/git/docs/

> @@ -1381,7 +1381,7 @@ static void recount_diff(const char *line, int size, struct fragment *fragment)
>         int oldlines = 0, newlines = 0, ret = 0;
>
>         if (size < 1) {
> -               warning("recount: ignore empty hunk");
> +               warning(_("recount: ignore empty hunk"));
>                 return;
>         }
>
> @@ -1500,8 +1500,8 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
>                                 patch->new_name = xstrdup(patch->def_name);
>                         }
>                         if (!patch->is_delete && !patch->new_name)
> -                               die("git diff header lacks filename information "
> -                                   "(line %d)", linenr);
> +                               die(_("git diff header lacks filename information "
> +                                   "(line %d)"), linenr);
>                         patch->is_toplevel_relative = 1;
>                         *hdrsize = git_hdr_len;
>                         return offset;
> @@ -2237,7 +2237,7 @@ static void update_pre_post_images(struct image *preimage,
>         if (postlen
>             ? postlen < new - postimage->buf
>             : postimage->len < new - postimage->buf)
> -               die("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d",
> +               die(_("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d"),
>                     (int)postlen, (int) postimage->len, (int)(new - postimage->buf));
>
>         /* Fix the length of the whole thing */
> @@ -2940,8 +2940,8 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
>         /* Binary patch is irreversible without the optional second hunk */
>         if (apply_in_reverse) {
>                 if (!fragment->next)
> -                       return error("cannot reverse-apply a binary patch "
> -                                    "without the reverse hunk to '%s'",
> +                       return error(_("cannot reverse-apply a binary patch "
> +                                    "without the reverse hunk to '%s'"),
>                                      patch->new_name
>                                      ? patch->new_name : patch->old_name);
>                 fragment = fragment->next;
> @@ -2984,8 +2984,8 @@ static int apply_binary(struct image *img, struct patch *patch)
>             strlen(patch->new_sha1_prefix) != 40 ||
>             get_sha1_hex(patch->old_sha1_prefix, sha1) ||
>             get_sha1_hex(patch->new_sha1_prefix, sha1))
> -               return error("cannot apply binary patch to '%s' "
> -                            "without full index line", name);
> +               return error(_("cannot apply binary patch to '%s' "
> +                            "without full index line"), name);
>
>         if (patch->old_name) {
>                 /*
> @@ -2994,16 +2994,16 @@ static int apply_binary(struct image *img, struct patch *patch)
>                  */
>                 hash_sha1_file(img->buf, img->len, blob_type, sha1);
>                 if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
> -                       return error("the patch applies to '%s' (%s), "
> +                       return error(_("the patch applies to '%s' (%s), "
>                                      "which does not match the "
> -                                    "current contents.",
> +                                    "current contents."),
>                                      name, sha1_to_hex(sha1));
>         }
>         else {
>                 /* Otherwise, the old one must be empty. */
>                 if (img->len)
> -                       return error("the patch applies to an empty "
> -                                    "'%s' but it is not empty", name);
> +                       return error(_("the patch applies to an empty "
> +                                    "'%s' but it is not empty"), name);
>         }
>
>         get_sha1_hex(patch->new_sha1_prefix, sha1);
> @@ -3020,8 +3020,8 @@ static int apply_binary(struct image *img, struct patch *patch)
>
>                 result = read_sha1_file(sha1, &type, &size);
>                 if (!result)
> -                       return error("the necessary postimage %s for "
> -                                    "'%s' cannot be read",
> +                       return error(_("the necessary postimage %s for "
> +                                    "'%s' cannot be read"),
>                                      patch->new_sha1_prefix, name);
>                 clear_image(img);
>                 img->buf = result;
> @@ -3342,7 +3342,7 @@ static int load_current(struct image *image, struct patch *patch)
>         unsigned mode = patch->new_mode;
>
>         if (!patch->is_new)
> -               die("BUG: patch to %s is not a creation", patch->old_name);
> +               die(_("BUG: patch to %s is not a creation"), patch->old_name);
>
>         pos = cache_name_pos(name, strlen(name));
>         if (pos < 0)
> @@ -3387,7 +3387,7 @@ static int try_threeway(struct image *image, struct patch *patch,
>                 write_sha1_file("", 0, blob_type, pre_sha1);
>         else if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
>                  read_blob_object(&buf, pre_sha1, patch->old_mode))
> -               return error("repository lacks the necessary blob to fall back on 3-way merge.");
> +               return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
>
>         fprintf(stderr, "Falling back to three-way merge...\n");
>
> @@ -3405,11 +3405,11 @@ static int try_threeway(struct image *image, struct patch *patch,
>         /* our_sha1[] is ours */
>         if (patch->is_new) {
>                 if (load_current(&tmp_image, patch))
> -                       return error("cannot read the current contents of '%s'",
> +                       return error(_("cannot read the current contents of '%s'"),
>                                      patch->new_name);
>         } else {
>                 if (load_preimage(&tmp_image, patch, st, ce))
> -                       return error("cannot read the current contents of '%s'",
> +                       return error(_("cannot read the current contents of '%s'"),
>                                      patch->old_name);
>         }
>         write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_sha1);
> @@ -3572,7 +3572,7 @@ static int check_to_create(const char *new_name, int ok_if_exists)
>
>                 return EXISTS_IN_WORKTREE;
>         } else if ((errno != ENOENT) && (errno != ENOTDIR)) {
> -               return error("%s: %s", new_name, strerror(errno));
> +               return error(_("%s: %s"), new_name, strerror(errno));
>         }
>         return 0;
>  }
> @@ -3888,29 +3888,29 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
>                         if (!preimage_sha1_in_gitlink_patch(patch, sha1))
>                                 ; /* ok, the textual part looks sane */
>                         else
> -                               die("sha1 information is lacking or useless for submodule %s",
> +                               die(_("sha1 information is lacking or useless for submodule %s"),
>                                     name);
>                 } else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
>                         ; /* ok */
>                 } else if (!patch->lines_added && !patch->lines_deleted) {
>                         /* mode-only change: update the current */
>                         if (get_current_sha1(patch->old_name, sha1))
> -                               die("mode change for %s, which is not "
> -                                   "in current HEAD", name);
> +                               die(_("mode change for %s, which is not "
> +                                   "in current HEAD"), name);
>                 } else
> -                       die("sha1 information is lacking or useless "
> -                           "(%s).", name);
> +                       die(_("sha1 information is lacking or useless "
> +                           "(%s)."), name);
>
>                 ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
>                 if (!ce)
>                         die(_("make_cache_entry failed for path '%s'"), name);
>                 if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
> -                       die ("Could not add %s to temporary index", name);
> +                       die(_("Could not add %s to temporary index"), name);
>         }
>
>         hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
>         if (write_locked_index(&result, &lock, COMMIT_LOCK))
> -               die ("Could not write temporary index to %s", filename);
> +               die(_("Could not write temporary index to %s"), filename);
>
>         discard_index(&result);
>  }
> @@ -4599,9 +4599,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>                         apply_usage, 0);
>
>         if (apply_with_reject && threeway)
> -               die("--reject and --3way cannot be used together.");
> +               die(("--reject and --3way cannot be used together."));
>         if (cached && threeway)
> -               die("--cached and --3way cannot be used together.");
> +               die(("--cached and --3way cannot be used together."));
>         if (threeway) {
>                 if (is_not_gitdir)
>                         die(_("--3way outside a repository"));
> @@ -4659,8 +4659,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>                                whitespace_error),
>                             whitespace_error);
>                 if (applied_after_fixing_ws && apply)
> -                       warning("%d line%s applied after"
> -                               " fixing whitespace errors.",
> +                       warning(_("%d line%s applied after"
> +                               " fixing whitespace errors."),
>                                 applied_after_fixing_ws,
>                                 applied_after_fixing_ws == 1 ? "" : "s");
>                 else if (whitespace_error)
> --
> 2.4.0.2.g3386abe.dirty
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

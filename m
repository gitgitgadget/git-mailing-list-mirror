Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78532207B3
	for <e@80x24.org>; Fri,  5 May 2017 22:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdEEWbB (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 18:31:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:57447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdEEWa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 18:30:59 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSMKx-1dVgRJ0QfL-00TXyb; Sat, 06
 May 2017 00:30:14 +0200
Date:   Sat, 6 May 2017 00:30:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Daniel Ferreira <bnmvco@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive
 add
In-Reply-To: <1494009820-2090-3-git-send-email-bnmvco@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705052328380.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com> <1494009820-2090-3-git-send-email-bnmvco@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1005375471-1494023414=:146734"
X-Provags-ID: V03:K0:wgHaDchhODDXZw4qFFtAHzvP+HOrNu/4mh1BAaJkmHZHb6fZEth
 D4IZCGi+nKlU39mJ8q9wrk40/zltAcx+PL7M6hwKCTj0pDDfa92WC7c3B4+TKkj3jz7JUPM
 MAYsVLalL7S52d7mHNcw/MRB9yVGPYb14vzrijFPrsZL5TZcK022xHu/MEdkzdygT0chdTB
 vHPBLGmVtEtTtEC1H239w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qFewLo5Ag3c=:MWVAgJaR/uEPXYK2Brgp9f
 bN0ss6DI5tT4xurCAMByudeCUsBlLvNObqfKXpQ5l/mvcsSZJMcTPPF1pPa7Z2ttni4F5Lvkv
 /enE71WPYzpu2NWhRTGthR0hOtSsqmSS7RHK713SylOkqu6FgAa89qswgrGOVvx28F9Vxd83X
 XjOIN6qxSrFX9v0Olc28eVJAxZkpNtKH0dsRnkAUewsk/MZ4NT+dhfTKS+U95U8oEcAur0AKW
 9ACkGErI0q65679qSXQAJuel1NJE6hCjv3HxjP2ZBMSlbS4A4nwnfQmzNjIAyFF3bKAI2Aecz
 YntbrwG2Y94hzJvRb0EQ1625hVh7IoNLlq6kBfs6SjhCpJDr9wqNVgTQHwleD8KeeOjWynMZX
 gOWv1kLeskxXSsc60mYF9Oam093QuRtHaq6rQYQ44hSRmc4n62o79tJPOGAruEijTSnoKXfVR
 z0lcty0KrOhLjSkrTY9h/fBZs1LP4B6/qt6WnCFRX+br6A7e86xIMi4B/rOiv/KRWlXbsBN02
 J4lUzyPIcGzKDjrjM8qkjp/bZs65MWjGIa7lXbpoH/uaWkb6u3FirkyvGRHrmGEkafNKVJMlh
 9IljtnakVE/OHdDSPAiAP3XChsGX9aNrM/ujmvMjeiEn3IBr6e4A4HA1Letu7hp86+ODLzWPY
 43/98FB7W7LFHvecqnPt1JkSJzsKK8IkXCBHhCJwMMz04VCH0D4EMQRLmDNAKiM9/6vODo4dt
 oTxWZ/yu+jQUHBTQlgNNr0y5wdQWM+wRQclu4xd7U+E6peidGov1I3zkxscuqk9fONXZ2zG4h
 /+aKt2z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1005375471-1494023414=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Daniel,


On Fri, 5 May 2017, Daniel Ferreira wrote:

> Create a builtin helper for git-add--interactive, which right now is
> only able to reproduce git-add--interactive.perl's status_cmd()
> function, providing a summarized diff numstat to the user.
>=20
> This is the first step in an effort to convert git-add--interactive.perl
> to a C builtin, in search for better portability, expressibility and
> performance (specially on non-POSIX systems like Windows).
>=20
> Additionally, an eventual complete port of git-add--interactive would
> remove the last "big" Git script to have Perl as a dependency, allowing
> most Git users to have a NOPERL build running without big losses.
>=20
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>

Good. I would think that git-add--helper is a better name. It is an
internal command only, anyway, and hopefully it will go away soon (i.e.
hopefully all of add -i will be builtin soon and can then be even moved
into a separate file outside builtin/, say, add-interactive.c).

> diff --git a/.gitignore b/.gitignore
> index 833ef3b..0d6cfe4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -11,6 +11,7 @@
>  /git
>  /git-add
>  /git-add--interactive
> +/git-add-interactive--helper

Personally, I would prefer a separate commit adding the helper, before it
learns about any functionality. Somehow I have an easier time reviewing
patches if they tease such things apart.

> diff --git a/builtin/add-interactive--helper.c b/builtin/add-interactive-=
-helper.c
> new file mode 100644
> index 0000000..97ca1b3
> --- /dev/null
> +++ b/builtin/add-interactive--helper.c
> @@ -0,0 +1,258 @@
> +#include "builtin.h"
> +#include "color.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "revision.h"
> +
> +#define ADD_INTERACTIVE_HEADER_INDENT "      "

This definition is local to this helper, and we already know that this is
all about add -i. So maybe not repeat it? HEADER_INDENT would be catchier
and just as expressive.

> +enum add_interactive_collection_mode {
> +=09COLLECTION_MODE_NONE,
> +=09COLLECTION_MODE_WORKTREE,
> +=09COLLECTION_MODE_INDEX
> +};

Likewise, maybe we do not want to have this COLLECTION_MODE_ prefix
littering the source code... NONE, WORKTREE and INDEX should be short and
sweet.

> +struct add_interactive_file_status {

Just struct file_status, maybe?

From=20a cursory glance, it also would appear that the only need for this
struct to be named is the memset() call when initializing a new item,
right? If that is the case, it would be better to use sizeof(*s->files)
and keep it unnamed, as part of the enclosing struct.

> +=09int selected;
> +
> +=09char path[PATH_MAX];

That is a bit wasteful. `char *name` is what diffstat_t uses...

> +=09int lines_added_index;
> +=09int lines_deleted_index;
> +=09int lines_added_worktree;
> +=09int lines_deleted_worktree;

Maybe for better readability:

=09struct {
=09=09uintmax_t added, deleted;
=09} index, worktree;

> +};
>
> +struct add_interactive_status {
> +=09enum add_interactive_collection_mode current_mode;

I am scared of future patches where you cannot wrap the code to the
required <=3D 80 columns/row because the data type or variable name is too
long... ;-)

> +
> +=09const char *reference;
> +=09struct pathspec pathspec;
> +
> +=09int file_count;
> +=09struct add_interactive_file_status *files;

The convention for growable arrays in Git is to have nr, alloc and the
array, and use ALLOC_GROW() to avoid reallocating for every single new
item.

> +};
> +
> +static int add_interactive_use_color =3D -1;
> +enum color_add_interactive {
> +=09ADD_INTERACTIVE_PROMPT,
> +=09ADD_INTERACTIVE_HEADER,
> +=09ADD_INTERACTIVE_HELP,
> +=09ADD_INTERACTIVE_ERROR
> +};

Again, if we were talking about a declaration in a .h file, that prefix
would make sense, but here we are safely in file-local territory where I
think this is just unnecessary churn.

> +static char add_interactive_colors[][COLOR_MAXLEN] =3D {
> +=09GIT_COLOR_BOLD_BLUE, /* Prompt */
> +=09GIT_COLOR_BOLD,      /* Header */
> +=09GIT_COLOR_BOLD_RED,  /* Help */
> +=09GIT_COLOR_BOLD_RED   /* Error */
> +};
> +
> +static const char *add_interactive_get_color(enum color_add_interactive =
ix)
> +{
> +=09if (want_color(add_interactive_use_color))
> +=09=09return add_interactive_colors[ix];
> +=09return "";
> +}
> +
> +static int parse_add_interactive_color_slot(const char *slot)
> +{
> +=09if (!strcasecmp(slot, "prompt"))
> +=09=09return ADD_INTERACTIVE_PROMPT;
> +=09if (!strcasecmp(slot, "header"))
> +=09=09return ADD_INTERACTIVE_HEADER;
> +=09if (!strcasecmp(slot, "help"))
> +=09=09return ADD_INTERACTIVE_HELP;
> +=09if (!strcasecmp(slot, "error"))
> +=09=09return ADD_INTERACTIVE_ERROR;
> +
> +=09return -1;
> +}
> +
> +static int git_add_interactive_config(const char *var,

Not git_add_interactive__helper_config()? ;-)

> +=09=09const char *value, void *cbdata)
> +{
> +=09const char *name;
> +
> +=09if (!strcmp(var, "color.interactive")) {
> +=09=09add_interactive_use_color =3D git_config_colorbool(var, value);
> +=09=09return 0;
> +=09}
> +
> +=09if (skip_prefix(var, "color.interactive", &name)) {
> +=09=09int slot =3D parse_add_interactive_color_slot(name);
> +=09=09if (slot < 0)
> +=09=09=09return 0;
> +=09=09if (!value)
> +=09=09=09return config_error_nonbool(var);
> +=09=09return color_parse(value, add_interactive_colors[slot]);
> +=09}
> +
> +=09return git_default_config(var, value, cbdata);
> +}
> +
> +static void add_interactive_status_collect_changed_cb(struct diff_queue_=
struct *q,

I did have that fear, and now it comes true... ;-)

Seriously again, this is a file-local function. We know it is about
add --interactive, and we can be pretty succinct about its role, i.e.
something like collect_changes_callback() would be plenty sufficient.

> +=09=09=09=09=09 struct diff_options *options,
> +=09=09=09=09=09 void *data)
> +{
> +=09struct add_interactive_status *s =3D data;
> +=09struct diffstat_t stat;
> +=09int i, j;
> +
> +=09if (!q->nr)
> +=09=09return;
> +
> +=09memset(&stat, 0, sizeof(struct diffstat_t));

I guess it makes sense to play it safe here (by zeroing the entire struct
rather than assigning the individual initial values).

But would

=09struct diffstat_t stat =3D { 0 };

not have done the same?

> +=09for (i =3D 0; i < q->nr; i++) {
> +=09=09struct diff_filepair *p;
> +=09=09p =3D q->queue[i];
> +=09=09diff_flush_stat(p, options, &stat);
> +=09}
> +
> +=09for (i =3D 0; i < stat.nr; i++) {
> +=09=09int file_index =3D s->file_count;
> +=09=09for (j =3D 0; j < s->file_count; j++) {
> +=09=09=09if (!strcmp(s->files[j].path, stat.files[i]->name)) {
> +=09=09=09=09file_index =3D j;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}

So basically, this is looking up in a list whether we saw the file in
question already, and the reason we have to do that is that we run the
entire shebang twice, once with the worktree and once with the index.

I wonder whether it would not make sense to switch away s->files from a
list to a hashmap.

> +=09=09if (file_index =3D=3D s->file_count) {
> +=09=09=09s->file_count++;
> +=09=09=09s->files =3D realloc(s->files,
> +=09=09=09=09=09(q->nr + s->file_count) * sizeof(*s->files));

We already have ALLOC_GROW() to do this, safer. And easier to verify ;-)

> +=09=09=09memset(&s->files[file_index], 0,
> +=09=09=09=09=09sizeof(struct add_interactive_file_status));
> +=09=09}
> +
> +=09=09memcpy(s->files[file_index].path, stat.files[i]->name,
> +=09=09=09=09strlen(stat.files[i]->name) + 1);

Apart from using PATH_MAX bytes for most likely only short names: should
this not be inside the if (file_index =3D=3D s->file_count) clause? I mean,=
 if
we do not hit that conditional code, it is because we already compared the
file name and figured out that s->files[file_index].path is identical to
stat.files[i]->name...


> +=09=09if (s->current_mode =3D=3D COLLECTION_MODE_WORKTREE) {
> +=09=09=09s->files[file_index].lines_added_worktree =3D stat.files[i]->ad=
ded;
> +=09=09=09s->files[file_index].lines_deleted_worktree =3D stat.files[i]->=
deleted;
> +=09=09} else if (s->current_mode =3D=3D COLLECTION_MODE_INDEX) {
> +=09=09=09s->files[file_index].lines_added_index =3D stat.files[i]->added=
;
> +=09=09=09s->files[file_index].lines_deleted_index =3D stat.files[i]->del=
eted;
> +=09=09}
> +=09}
> +}
> +
> +static void add_interactive_status_collect_changes_worktree(struct add_i=
nteractive_status *s)

I would use the name status_worktree() here instead.

> +{
> +=09struct rev_info rev;
> +
> +=09s->current_mode =3D COLLECTION_MODE_WORKTREE;

Now that I read this and remember that only WORKTREE and INDEX are handled
in the callback function: is there actually a use for the NONE enum value?
I.e. is current_mode read out in any other context than the callback
function? If there is no other read, then the NONE enum value is just
confusing.

BTW in the first pass, we pretty much know that we only get unique names,
so the entire lookup is unnecessary and will just increase the time
complexity from O(n) to O(n^2). So let's avoid that.

By moving to a hashmap, you can even get the second phase down to an
expected O(n).

> +
> +=09init_revisions(&rev, NULL);
> +=09setup_revisions(0, NULL, &rev, NULL);
> +
> +=09rev.max_count =3D 0;

Where does this come from? We are not logging commits... oh wait, I see
that diff-lib.c reuses that field for its diff_unmerged_stage value. Urgh.
Not your fault, of course.

> +=09rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
> +=09rev.diffopt.format_callback =3D add_interactive_status_collect_change=
d_cb;
> +=09rev.diffopt.format_callback_data =3D s;
> +
> +=09run_diff_files(&rev, 0);
> +}
> +
> +static void add_interactive_status_collect_changes_index(struct add_inte=
ractive_status *s)
> +{
> +=09struct rev_info rev;
> +=09struct setup_revision_opt opt;
> +
> +=09s->current_mode =3D COLLECTION_MODE_INDEX;
> +
> +=09init_revisions(&rev, NULL);
> +=09memset(&opt, 0, sizeof(opt));

=09struct setup_revision_opt opt =3D { NULL };

> +=09opt.def =3D s->reference;
> +=09setup_revisions(0, NULL, &rev, &opt);

Oh, I see, you want to use the opt argument to pass HEAD or the emtpy tree
SHA-1 if we're on an unborn branch.

Since you're already calling get_sha1() on "HEAD", you may just as well
keep the SHA-1 (and use the EMPTY_TREE_SHA1 if there is no HEAD), and then
pass that in via the argc, argv parameters to setup_revisions() (imitating
cmd_diff_index() a bit closer).

> +
> +=09rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
> +=09rev.diffopt.format_callback =3D add_interactive_status_collect_change=
d_cb;
> +=09rev.diffopt.format_callback_data =3D s;
> +
> +=09run_diff_index(&rev, 1);
> +}
> +
> +static void list_modified_into_status(struct add_interactive_status *s)
> +{
> +=09add_interactive_status_collect_changes_worktree(s);
> +=09add_interactive_status_collect_changes_index(s);
> +}

Why not collapse all three functions into one? It is not like they are
totally unrelated nor super-long.

> +static void print_modified(void)
> +{
> +=09int i;
> +=09struct add_interactive_status s;
> +=09const char *modified_fmt =3D _("%12s %12s %s");

We cannot really translate that...

> +=09const char *header_color =3D add_interactive_get_color(ADD_INTERACTIV=
E_HEADER);
> +=09unsigned char sha1[20];
> +
> +=09if (read_cache() < 0)
> +=09=09return;
> +
> +=09s.current_mode =3D COLLECTION_MODE_NONE;
> +=09s.reference =3D !get_sha1("HEAD", sha1) ? "HEAD": EMPTY_TREE_SHA1_HEX=
;
> +=09s.file_count =3D 0;
> +=09s.files =3D NULL;
> +=09list_modified_into_status(&s);
> +
> +=09printf(ADD_INTERACTIVE_HEADER_INDENT);
> +=09color_fprintf(stdout, header_color, modified_fmt, _("staged"),
> +=09=09=09_("unstaged"), _("path"));

I think these _() need to become N_().

> +=09printf("\n");

Wouldn't it be better to avoid defining modified_fmt (we do not really
modify it, do we?) and at least make the '\n' part of the format string?

> +=09for (i =3D 0; i < s.file_count; i++) {
> +=09=09struct add_interactive_file_status f =3D s.files[i];
> +=09=09char selection =3D f.selected ? '*' : ' ';

I would prefer the variable to be called "marker".

> +
> +=09=09char worktree_changes[50];
> +=09=09char index_changes[50];

Those "50" look a bit arbitrary... maybe use strbufs instead (so that we
do not have to hope that all translations of "nothing" or "unchanged",
even Welsh ones, will fit inside those buffers)?

> +=09=09if (f.lines_added_worktree !=3D 0 || f.lines_deleted_worktree !=3D=
 0)

In Git's source code, the convention is to just drop the `!=3D 0` in
comparisons, unless there is a really good reason not to.

> +=09=09=09snprintf(worktree_changes, 50, "+%d/-%d", f.lines_added_worktre=
e,
> +=09=09=09=09=09f.lines_deleted_worktree);
> +=09=09else
> +=09=09=09snprintf(worktree_changes, 50, "%s", _("nothing"));
> +
> +=09=09if (f.lines_added_index !=3D 0 || f.lines_deleted_index !=3D 0)
> +=09=09=09snprintf(index_changes, 50, "+%d/-%d", f.lines_added_index,
> +=09=09=09=09=09f.lines_deleted_index);
> +=09=09else
> +=09=09=09snprintf(index_changes, 50, "%s", _("unchanged"));
> +
> +=09=09printf("%c%2d: ", selection, i + 1);
> +=09=09printf(modified_fmt, index_changes, worktree_changes, f.path);
> +=09=09printf("\n");

It would be nicer to make this a single printf() call. The only idea I
have to allow for that is to turn modified_fmt into a `#define
MODIFIED_FMT "%12s %12s %s"`, though.

> +=09}
> +}
> +
> +static void status_cmd(void)
> +{
> +=09print_modified();
> +}

As long as this function really only calls another function with no
parameters, let's just drop it. We can call print_modified() instead of
status_cmd() just as easily.

=C3=86var already commented on the parseopt stuff.

Otherwise this looks pretty good to me!

Thanks,
Johannes
--8323329-1005375471-1494023414=:146734--

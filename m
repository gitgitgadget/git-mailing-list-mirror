From: Alexey Spiridonov <snarkmaster@gmail.com>
Subject: Re: "git am" crash (builtin/apply.c:2108) + small repro
Date: Mon, 5 Nov 2012 14:55:17 -0800
Message-ID: <CAOKKMFE=gwF4d+R2SD+3eRWqvZwkAt2hX8aPT8fvcwEZXiZbuQ@mail.gmail.com>
References: <CAOKKMFG4JsNyMY7=SB6EuR8_GnpAu-ysH02J5pwD1cNzUgaieQ@mail.gmail.com>
	<CACsJy8B9NDmGnopoFEAA0T4mgG+54npYnbb_d4tihRNB=xrGnw@mail.gmail.com>
	<CAOKKMFFGz5Waz3OV4_uTgwDaL=S9NWAnLnACPzSkGpu_rrChvQ@mail.gmail.com>
	<CACsJy8B4xeLSDPC42JifZwC7VWTPRd2iZfnxtPhf7u3OzOm_6Q@mail.gmail.com>
	<7vtxtz2x1g.fsf@alter.siamese.dyndns.org>
	<7vlifb2tfp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVVZt-0001HR-My
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 23:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab2KEWzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2012 17:55:21 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53127 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2KEWzT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 17:55:19 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1019382qcr.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=etcBzHTBbCYKuyhmWxAm7eE+9yU4Mp5l0BhFH/mW/yk=;
        b=DwQs43zqRiKA5/z2fsBtG8OK+Fz53YL+syQXAZvh8+3ICesxSyI0W4E6t6/sq1KO18
         7SC8TYgLm1HRIN+FflCJwTRtQTG3xVR/EvHpTKzeHLZE6pZ0O6TJrQpumIX8Weghqtdv
         U0U7A05z0SpmrEAts63AFGrSmK/KKUMT2LJJSWFWjioaxZWO15tMW9OzIKV1S+yX9SS6
         6Q5ju6XgawcEug1eGtvS7ZHY4h5O5hhHu/ZhUUyRNZmFozWSRJMXFOmAix7Bw+rx3OUi
         m59JQX8u6Me0qaJ5kTG9WWi6kOSn4QX7HwqJFB99woSypP0h9k91gteZxg+J7mOxh4Lg
         lc0Q==
Received: by 10.229.174.85 with SMTP id s21mr3990853qcz.37.1352156118188; Mon,
 05 Nov 2012 14:55:18 -0800 (PST)
Received: by 10.49.105.226 with HTTP; Mon, 5 Nov 2012 14:55:17 -0800 (PST)
In-Reply-To: <7vlifb2tfp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209089>

Thanks for looking into this, guys!

I seem to run into this with some regularity, but my setting is
apply.whitespace=3Dstrip rather than 'fix'.

Is there an obvious workaround?

Here are my remaining settings, sanitized for file paths and URLs:

svn.rmdir=3Dtrue
push.default=3Dupstream
color.ui=3Dauto
color.diff=3Dauto
color.status=3Dauto
color.branch=3Dauto
color.interactive=3Dauto
color.branch.current=3Dwhite blue bold
color.branch.local=3Dblue
color.branch.remote=3Dgreen
color.diff.plain=3Dwhite
color.diff.meta=3Dyellow bold
color.diff.frag=3Dmagenta bold
color.diff.old=3Dred
color.diff.new=3Dgreen
color.diff.whitespace=3Dred blink
color.status.added=3Dyellow
color.status.changed=3Dgreen
color.status.untracked=3Dcyan
svn.followparent=3Dtrue
log.date=3Drelative
blame.date=3Dshort
diff.renames=3Dcopies
diff.copies=3Dtrue
diff.mnemonicprefix=3Dtrue
apply.whitespace=3Dstrip
merge.tool=3Demerge
status.relativepaths=3Dtrue
web.browser=3Dlynx
rebase.stat=3Dtrue
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
rerere.enabled=3Dtrue
branch.autosetuprebase=3Dalways

-a

On Fri, Oct 12, 2012 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I've never been a fan of update_pre_post_images().  I think I know
>> what is going on (--whitespace=3Dfix).  Will post a fix sometime
>> later.
>
> It bisects down to 5166714 (apply: Allow blank context lines to
> match beyond EOF, 2010-03-06).
>
> I do not like this patch at all (I _think_ it should somehow check
> the corresponding postimage is sane when the "ah, we ran out of
> preimage because the caller fixed it to reduce trailing blank lines"
> case), but at least this should get the ball rolling.
>
> Bj=F6rn, both of the changes involved are yours, so I am thinking tha=
t
> you may be a good person to give a sanity check on this.  No need to
> hurry, as this is not a recent regression and we are in a pre-release
> freeze.
>
> Thanks.
>
> -- >8 --
> Subject: apply.c:update_pre_post_images(): the preimage can be trunca=
ted
>
> 5166714 (apply: Allow blank context lines to match beyond EOF,
> 2010-03-06) and then later 0c3ef98 (apply: Allow blank *trailing*
> context lines to match beyond EOF, 2010-04-08) taught "git apply"
> to trim new blank lines at the end in the patch text when matching
> the contents being patched and the preimage recorded in the patch,
> under --whitespace=3Dfix mode.
>
> When a preimage is modified to match the current contents in
> preparation for such a "fixed" patch application, the context lines
> in the postimage must be updated to match (otherwise, it would
> reintroduce whitespace breakages), and update_pre_post_images()
> function is responsible for doing this.  However, this function was
> not updated to take into account a case where the removal of
> trailing blank lines reduces the number of lines in the preimage,
> and triggered an assertion error.
>
> The logic to fix the postimage by copying the corrected context
> lines from the preimage was not prepared to handle this case,
> either, but it was protected by the assert() and only got exposed
> when the assertion is corrected.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/apply.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git c/builtin/apply.c w/builtin/apply.c
> index 156b3ce..6c11e8b 100644
> --- c/builtin/apply.c
> +++ w/builtin/apply.c
> @@ -2095,7 +2095,7 @@ static void update_pre_post_images(struct image=
 *preimage,
>                                    char *buf,
>                                    size_t len, size_t postlen)
>  {
> -       int i, ctx;
> +       int i, ctx, reduced;
>         char *new, *old, *fixed;
>         struct image fixed_preimage;
>
> @@ -2105,8 +2105,10 @@ static void update_pre_post_images(struct imag=
e *preimage,
>          * free "oldlines".
>          */
>         prepare_image(&fixed_preimage, buf, len, 1);
> -       assert(fixed_preimage.nr =3D=3D preimage->nr);
> -       for (i =3D 0; i < preimage->nr; i++)
> +       assert(postlen
> +              ? fixed_preimage.nr =3D=3D preimage->nr
> +              : fixed_preimage.nr <=3D preimage->nr);
> +       for (i =3D 0; i < fixed_preimage.nr; i++)
>                 fixed_preimage.line[i].flag =3D preimage->line[i].fla=
g;
>         free(preimage->line_allocated);
>         *preimage =3D fixed_preimage;
> @@ -2126,7 +2128,8 @@ static void update_pre_post_images(struct image=
 *preimage,
>         else
>                 new =3D old;
>         fixed =3D preimage->buf;
> -       for (i =3D ctx =3D 0; i < postimage->nr; i++) {
> +
> +       for (i =3D reduced =3D ctx =3D 0; i < postimage->nr; i++) {
>                 size_t len =3D postimage->line[i].len;
>                 if (!(postimage->line[i].flag & LINE_COMMON)) {
>                         /* an added line -- no counterparts in preima=
ge */
> @@ -2145,8 +2148,15 @@ static void update_pre_post_images(struct imag=
e *preimage,
>                         fixed +=3D preimage->line[ctx].len;
>                         ctx++;
>                 }
> -               if (preimage->nr <=3D ctx)
> -                       die(_("oops"));
> +
> +               /*
> +                * preimage is expected to run out, if the caller
> +                * fixed addition of trailing blank lines.
> +                */
> +               if (preimage->nr <=3D ctx) {
> +                       reduced++;
> +                       continue;
> +               }
>
>                 /* and copy it in, while fixing the line length */
>                 len =3D preimage->line[ctx].len;
> @@ -2159,6 +2169,7 @@ static void update_pre_post_images(struct image=
 *preimage,
>
>         /* Fix the length of the whole thing */
>         postimage->len =3D new - postimage->buf;
> +       postimage->nr -=3D reduced;
>  }
>
>  static int match_fragment(struct image *img,

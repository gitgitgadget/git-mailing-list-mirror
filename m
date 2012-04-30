From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] i18n: Add more TRANSLATORS comments
Date: Mon, 30 Apr 2012 10:37:50 -0700
Message-ID: <7v4ns1glxt.fsf@alter.siamese.dyndns.org>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
 <1335799995-7667-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 19:38:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOuXu-00069l-36
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 19:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab2D3Rhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 13:37:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754235Ab2D3Rhx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 13:37:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA6857D64;
	Mon, 30 Apr 2012 13:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=krvbgy8FoAV4
	dbwIjRLhArH7XhU=; b=QfjpTuY30iPr+WglOsUNFIeNT5LCrmH6AECoOKrwIef8
	s92IkIVdcPc0VBwxF3vlHCOOmysfyK5iJG9HrCGyDwLyivBAboUJGo9RTbc8q/m6
	co6WqIaA20aaMENsMhc7nCdsBvofvWgPV2Wul8moDOLUI62m0iKI1c32kXXSM4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LjeoTG
	fXKi6XQg7lXyDDI+JxuymhFgP1Dx+QEo6wnGDlphnm/4vLDfhzqaX2v1RePQ+6Jg
	CmxO5sgWo+QSXdRPedvqSW41R6zNvy7O6F+n9GjR5xEVnM6FX3oKQkvmehJo0+Cr
	Xxl/C8Nmw6jbZuDoQNG3Rz2XL0/1ZpJYJwynY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C103E7D63;
	Mon, 30 Apr 2012 13:37:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A29B7D62; Mon, 30 Apr 2012
 13:37:52 -0400 (EDT)
In-Reply-To: <1335799995-7667-3-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 30 Apr
 2012 15:33:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3638DA32-92EB-11E1-A02B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196582>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> I took a pass through git.pot and added comments to various messages
> that could use one, comments still need to be added to a lot of other
> things, but you have to start somewhere.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  advice.c    |    3 +++
>  bundle.c    |    5 +++++
>  commit.c    |    4 ++++
>  connected.c |    3 +++
>  diff.c      |    1 +
>  remote.c    |   10 ++++++++++
>  sequencer.c |   10 ++++++++++
>  7 files changed, 36 insertions(+)
>
> diff --git a/advice.c b/advice.c
> index a492eea..5944abb 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -37,6 +37,9 @@ void advise(const char *advice, ...)
> =20
>  	for (cp =3D buf.buf; *cp; cp =3D np) {
>  		np =3D strchrnul(cp, '\n');
> +		/* TRANSLATORS: This will be used to prefix each line of an
> +		 * advice message, with the format string being the line
> +		 */

	/*
         * Our multi-line comments are formatted like
         * this (many other places in the patch).
         */

Also end the sentence with a full-stop, please (many other places in th=
e
patch).

It is unclear what "with the format string being the line" means here, =
at
least to me, even though I think I wrote this code.

>  		fprintf(stderr,	_("hint: %.*s\n"), (int)(np - cp), cp);
>  		if (*np)
>  			np++;
> diff --git a/bundle.c b/bundle.c
> index 8d31b98..f24999e 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -86,6 +86,7 @@ int read_bundle_header(const char *path, struct bun=
dle_header *header)
>  	int fd =3D open(path, O_RDONLY);
> =20
>  	if (fd < 0)
> +		/* TRANSLATORS: The argument is a path that can't be opened */
>  		return error(_("could not open '%s'"), path);

That does not add much information.  "path to the file we tried to read
the bundle data from but failed"?

> @@ -137,6 +138,9 @@ int verify_bundle(struct bundle_header *header, i=
nt verbose)
>  	struct object_array refs;
>  	struct commit *commit;
>  	int i, ret =3D 0, req_nr;
> +	/* TRANSLATORS: This is a heading that'll precede a list of commit
> +	 * hashes and reference names
> +	 */

Please say "commit object names" (many other places in the patch).

>  	const char *message =3D _("Repository lacks these prerequisite comm=
its:");
> =20
>  	init_revisions(&revs, NULL);
> @@ -412,6 +416,7 @@ int create_bundle(struct bundle_header *header, c=
onst char *path,
>  		return error(_("pack-objects died"));
>  	if (!bundle_to_stdout) {
>  		if (commit_lock_file(&lock))
> +			/* TRANSLATORS: The argument is a path we can't create */
>  			die_errno(_("cannot create '%s'"), path);

That does not add much information.  "path to the file we tried to writ=
e
the bundle data to but failed"?

> @@ -365,6 +374,7 @@ static int do_pick_commit(struct commit *commit, =
struct replay_opts *opts)
>  		struct commit_list *p;
> =20
>  		if (!opts->mainline)
> +			/* TRANSLATORS: The argument is a commit digest */

Please consistently say "commit object name".

>  			return error(_("Commit %s is a merge but no -m option was given."=
),
>  				sha1_to_hex(commit->object.sha1));

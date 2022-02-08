Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342CC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiBHNPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiBHMzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:55:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138AC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644324895;
        bh=ltg76oZ0JIcwUPR8cE+e1YriJHrzOUOSSYI8HGDeulU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AWMTUs59VpFqVbSgXi7reidLPH25XQpi7V7Tk0V9iUH6aXoAXmCX+g9BcprfkeYs8
         wlUqe0o9Py0E2tzm0xHHGGAoIlbP/tp9IvXfe23x5ZjC+QIbjqnm1RR1OxwiNPUfHE
         NPCsVFWVodqvUCrAdblDjroOfR9HL5BGHB0ZzmxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMbO-1nVhlb0RFc-00EPlT; Tue, 08
 Feb 2022 13:54:55 +0100
Date:   Tue, 8 Feb 2022 13:54:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
In-Reply-To: <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
Message-ID: <nycvar.QRO.7.76.6.2202081310480.347@tvgsbejvaqbjf.bet>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com> <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com> <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-735070010-1644324895=:347"
X-Provags-ID: V03:K1:16uPY9OF8+Y2NmRdZ9RKt25QfKB/7U2b6kzxVXOLmfOExKr1lqt
 IjRKKFx35cNG//NWN58vnree/s8K13I60SqU84utacQpBoRS+GpmXrKtv5/dCDqY/kun6UY
 r2dUTAESaxMgEE4jqocCKRMkAqA9czLF6qpQ/YfDU7hd2Y81MCq/DszisqVg9fray8Nkg8c
 9eeVX/EJ/Qxdt+HZ7DX7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r6x5UZP0s4k=:zzedxFzACy5wHrQUSFzsX1
 v8WrLOvv2Qr2LVN6gjat/VcElLrledaDYtT9R/2F80cu3Mk96vNkz9uNVL2BqAl51zqsKb9Qe
 4Gg8BGcvcu8+usC5cORrIcTE01fJPXCBM9nvnCRwZJfRAFZbyJ4TISDQO13W0F5B9NcFCRt99
 ZiVQSwDKeDgu5jIYDH7rKE1TK7ftRyeKJw5aG4pcme9ulDJIqN/iYmLXNgMfUgiB9BGVyjh/t
 6634D3ItrtyuSPBgXLEfnhrQ6DGxyGsKX4vtd8qmc7OYFFNraii1GqRNj/GlIF2RmsvImn/+Y
 xqHri7FczEUsTlBtQVyja0AmChiY3pUwZWqSfUZvrSmRPmo9bKdtk4PUmEpmeCLMKd95PiwCr
 jSk0kWDFTbSW7s6CcvUSl4QmxferBrk0YXTiWbTwYHMJ0EAcpIbEndVezM3DURwz4695e8cnA
 sb7r8RegxqPg8EKfh2K1BJao0SyNus9X7dLQUxfztVhrcHWrYti0R6NVpcGAHtH2hpLtxw3ps
 zhi11CJKnHDwFvEwITywKPQjbYALs+CpY0khQ8w/dj+WqpwtFIhMTjjxQqD/tErx6SNof7INs
 82YMWowtVhAemgee8J99IIdO/bT2hTEuVmilTZxgtbPL7ZWyszGqeNoaM7W9k6jHSPVqowPWp
 wzsQ5nm6+vWj2rfEXJ5tOltSh6r99APTTQJZ2haKPqZEwgpwOJ5W3DeE9vru2aNMeMq9yXYtO
 I0eEzhgw32KlZHn/pkHf5mHu7BlHipeoAL4Uwwoacg52mc2qFHdgDePRdB+zsT0KSQJuVN/n5
 Pcv4KDDbll0nhYDaIoGf7DoqRaXtoohXwz7enNCtK9e+2VOtYs503WUjnrv0/5qcq6Q0/pZmn
 fRLTQY8kTuUbr0lRG7wHEAKDV5EwEJEENxvUBj2HlNHreBsQDWQR3Niha9/JUBlhY/Z3BhHy/
 PEwyNeEhQraDgGg9tQZx6wET0TNKzmpIr2sDaGEk7C9/op4Z3wPULFem23UzHjSMIFewv9WPl
 U4iROXIYtYHVQr6eTHt24r+mGY/ivlkROWCUMRxBCJr/5PRVmxzYnZGMsufrCUmOyjOzrFRyq
 I3xaWxKVrXLXhw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-735070010-1644324895=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Mon, 7 Feb 2022, Ren=C3=A9 Scharfe wrote:

> Am 06.02.22 um 23:39 schrieb Johannes Schindelin via GitGitGadget:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > With the `--add-file-with-content=3D<path>:<content>` option, `git
> > archive` now supports use cases where relatively trivial files need to
> > be added that do not exist on disk.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-archive.txt | 11 ++++++++
> >  archive.c                     | 51 +++++++++++++++++++++++++++++-----=
-
> >  t/t5003-archive-zip.sh        | 12 +++++++++
> >  3 files changed, 66 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/git-archive.txt b/Documentation/git-archive=
.txt
> > index bc4e76a7834..1b52a0a65a1 100644
> > --- a/Documentation/git-archive.txt
> > +++ b/Documentation/git-archive.txt
> > @@ -61,6 +61,17 @@ OPTIONS
> >  	by concatenating the value for `--prefix` (if any) and the
> >  	basename of <file>.
> >
> > +--add-file-with-content=3D<path>:<content>::
> > +	Add the specified contents to the archive.  Can be repeated to add
> > +	multiple files.  The path of the file in the archive is built
> > +	by concatenating the value for `--prefix` (if any) and the
> > +	basename of <file>.
> > ++
> > +The `<path>` cannot contain any colon, the file mode is limited to
> > +a regular file, and the option may be subject platform-dependent
>
> s/subject/& to/

Thanks.

> > +command-line limits. For non-trivial cases, write an untracked file
> > +and use `--add-file` instead.
> > +
>
> We could use that option in Git's own Makefile to add the file named
> "version", which contains $GIT_VERSION.

We could do that, that opportunity is a side effect of this patch series.

> Hmm, but it also contains a terminating newline, which would be a bit
> tricky (but not impossible) to add.  Would it make sense to add one
> automatically if it's missing (e.g. with strbuf_complete_line)?  Not
> sure.

It is really easy:

	LF=3D'
	'

	git archive --add-file-with-content=3Dversion:"$GIT_VERSION$LF" ...

(That's shell script, in the Makefile it would need those `\`
continuations.)

> >  --worktree-attributes::
> >  	Look for attributes in .gitattributes files in the working tree
> >  	as well (see <<ATTRIBUTES>>).
> > diff --git a/archive.c b/archive.c
> > index a3bbb091256..172efd690c3 100644
> > --- a/archive.c
> > +++ b/archive.c
> > @@ -263,6 +263,7 @@ static int queue_or_write_archive_entry(const stru=
ct object_id *oid,
> >  struct extra_file_info {
> >  	char *base;
> >  	struct stat stat;
> > +	void *content;
> >  };
> >
> >  int write_archive_entries(struct archiver_args *args,
> > @@ -337,7 +338,13 @@ int write_archive_entries(struct archiver_args *a=
rgs,
> >  		strbuf_addstr(&path_in_archive, basename(path));
> >
> >  		strbuf_reset(&content);
> > -		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
> > +		if (info->content)
> > +			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
> > +					  path_in_archive.len,
> > +					  info->stat.st_mode,
> > +					  info->content, info->stat.st_size);
> > +		else if (strbuf_read_file(&content, path,
> > +					  info->stat.st_size) < 0)
> >  			err =3D error_errno(_("could not read '%s'"), path);
> >  		else
> >  			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
> > @@ -493,6 +500,7 @@ static void extra_file_info_clear(void *util, cons=
t char *str)
> >  {
> >  	struct extra_file_info *info =3D util;
> >  	free(info->base);
> > +	free(info->content);
> >  	free(info);
> >  }
> >
> > @@ -514,14 +522,38 @@ static int add_file_cb(const struct option *opt,=
 const char *arg, int unset)
> >  	if (!arg)
> >  		return -1;
> >
> > -	path =3D prefix_filename(args->prefix, arg);
> > -	item =3D string_list_append_nodup(&args->extra_files, path);
> > -	item->util =3D info =3D xmalloc(sizeof(*info));
> > +	info =3D xmalloc(sizeof(*info));
> >  	info->base =3D xstrdup_or_null(base);
> > -	if (stat(path, &info->stat))
> > -		die(_("File not found: %s"), path);
> > -	if (!S_ISREG(info->stat.st_mode))
> > -		die(_("Not a regular file: %s"), path);
> > +
> > +	if (strcmp(opt->long_name, "add-file-with-content")) {
>
> Equivalent to:
>
> 	if (!strcmp(opt->long_name, "add-file")) {
>
> I mention that because the inequality check confused me a bit at first.

Good point. For some reason I thought it would be clearer to handle
everything but `--add-file-with-content` here, but that "everything but"
is only `--add-file`, so I sowed more confusion. Sorry about that.

>
> > +		path =3D prefix_filename(args->prefix, arg);
> > +		if (stat(path, &info->stat))
> > +			die(_("File not found: %s"), path);
> > +		if (!S_ISREG(info->stat.st_mode))
> > +			die(_("Not a regular file: %s"), path);
> > +		info->content =3D NULL; /* read the file later */
> > +	} else {
> > +		const char *colon =3D strchr(arg, ':');
> > +		char *p;
> > +
> > +		if (!colon)
> > +			die(_("missing colon: '%s'"), arg);
> > +
> > +		p =3D xstrndup(arg, colon - arg);
> > +		if (!args->prefix)
> > +			path =3D p;
> > +		else {
> > +			path =3D prefix_filename(args->prefix, p);
> > +			free(p);
> > +		}
> > +		memset(&info->stat, 0, sizeof(info->stat));
> > +		info->stat.st_mode =3D S_IFREG | 0644;
> > +		info->content =3D xstrdup(colon + 1);
> > +		info->stat.st_size =3D strlen(info->content);
> > +	}
> > +	item =3D string_list_append_nodup(&args->extra_files, path);
> > +	item->util =3D info;
> > +
> >  	return 0;
> >  }
> >
> > @@ -554,6 +586,9 @@ static int parse_archive_args(int argc, const char=
 **argv,
> >  		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
> >  		  N_("add untracked file to archive"), 0, add_file_cb,
> >  		  (intptr_t)&base },
> > +		{ OPTION_CALLBACK, 0, "add-file-with-content", args,
> > +		  N_("file"), N_("add untracked file to archive"), 0,
>                       ^^^^
> "<file>" seems wrong, because there is no actual file.  It should rather
> be "<name>:<content>" for the virtual one, right?

Or `<path>:<content>`. Yes.

Again, thank you for your clear and helpful review,
Dscho

--8323328-735070010-1644324895=:347--

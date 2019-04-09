Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6EE20248
	for <e@80x24.org>; Tue,  9 Apr 2019 02:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDICAI (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 22:00:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45716 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDICAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 22:00:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so8699919pfi.12
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=afuiJeJ1GvZ0HlEYjLE/Gbq6Z8y2aaApDFiJOWiSKEU=;
        b=HrYgyIkuOoWUFA8OUeV0y1bzLVDtmSZHVgf2l0kw/XrMzwL+D9OWMi0K3lWnxJAg8h
         kha47xB6DXtqfL2urlJ4GScurlKQ6NR0REjrsNhGc19c4oOzkvV0lrEa0AYcx13A/Qsm
         tjT87UGbzlbP1gqIGh96kj8UVhY+BG6F/K6ibkAoaGJ8QVd5mLEP2x+VElW6hbPm1L9I
         s4eTcwksZGAQ2wRyY4RdJY37Z0uFcgKjrhPzhfk125b55VVYcjXNRYgXnWah4ilaPSXW
         igtLQjZBmru2mBVaY/I1W6+XfUu3yM1YL8azAYBLT1lrmqTLSXT93fEBq1S5f696sdkU
         ovkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=afuiJeJ1GvZ0HlEYjLE/Gbq6Z8y2aaApDFiJOWiSKEU=;
        b=dMrnL6Z+HF7mrHgdMZpMcpq97K6F2Jb7ERx4vFPkQ2cOJSPqIq+AEz0BGzgTGgiPdd
         BHhNq3TRuD84d1vd8WaG5mxEuipmTBNdiakNMpGob8B62nFRorRGdGDWBeP3nLhES/a6
         cHDvCUVOm9HvMry2xe197KzHndmdTZ36LRZDtZBvtRiLem6iJt8m2RtvCn7dftqG6lAX
         n0YwGHW12ywtByWnWoUVW7iH2enzq+reXqfSOHNFj1/npnypHbnAqsZ9LqtaEf0Wn59e
         sWJXL2Xg2hAePgbYBCVpvfmtXV4t0Fn/zrsUTg24Lbq4+bTv0aoD6cxUuZNQ7oETRoay
         wltg==
X-Gm-Message-State: APjAAAVf8SKPojvDm6ogy9MxHSBj8/TkRdT2DaMdxkxSSQV3Naau4arq
        e85QG1mNOVms2nOOQSOlkDCbhw==
X-Google-Smtp-Source: APXvYqw7z60ccwWSGaHC7sizO4vwolsTPeqJQKW965vC+AG1gfMeJkV0qyB6qPo2rY4a2Zjos3IKxQ==
X-Received: by 2002:a63:5f05:: with SMTP id t5mr30740962pgb.176.1554775206420;
        Mon, 08 Apr 2019 19:00:06 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d869:cd1a:616d:3c11])
        by smtp.gmail.com with ESMTPSA id l88sm53345558pfb.104.2019.04.08.19.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:00:05 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 8 Apr 2019 19:00:04 -0700
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     UTKARSH RAI <utkarsh.rai60@gmail.com>, git@vger.kernel.org
Subject: Re: [[GSoC][PATCH =?utf-8?B?4oCmXQ==?= =?utf-8?Q?=5D?= In
 notes-merge.c updated notes_merge_commit()
Message-ID: <20190409020004.GA81620@Taylors-MBP.hsd1.wa.comcast.net>
References: <01020169ee702e51-e9c8d564-10f5-49e9-a411-fd7ceaef7afc-000000@eu-west-1.amazonses.com>
 <20190406144127.GZ32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190406144127.GZ32487@hank.intra.tgummerer.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sat, Apr 06, 2019 at 03:41:27PM +0100, Thomas Gummerer wrote:
> > Subject: [[GSoC][PATCH …]] In notes-merge.c updated notes_merge_commit()
>
> Commit messages are usually in the format "<area>: <short
> description>".  So a better title might be "notes-merge: use
> dir-iterator in notes_merge_commit".  It would also be beneficial for
> you to have a look at the mailing list archives at
> https://public-inbox.org/git/, and search for similar patches, to see
> how they have been done.
>
> On 04/05, UTKARSH RAI wrote:
> > Updated notes_merge_commit() by replacing readdir() ,opendir() apis by replacing them with dir_iterator_advance() and dir_iterator_begin() respectively.
>
> Please wrap commit messages at around 72 characters or less.  Also the
> commit message should be written in the imperative mood, see also
> Documentation/SubmittingPatches.

Thanks to brian carlson's, git has an .editorconfig which enforces this
explicitly (c.f., 6f9beef335 (editorconfig: provide editor settings for
Git developers, 2018-10-08)).

I use the editorconfig plugin for my editor [1], which makes sure that I
don't write a too-long line in a commit message, or in an email such as
this one ;-).

Utkarsh -- I certainly recommend an editor-appropriate plugin, if you
are worried about this sort of thing (as I certainly was/am).

I reviewed the patch while writing this note, and I agree with Thomas's
review, so I don't think I have anything to add there.

> > Signed-off-by: ur10 <utkarsh.rai60@gmail.com>
>
> The name in the Signed-off-by line should match the author of the
> commit.  Also there should be a blank line between the commit message
> and the Signed-off-by line.
>
> > ---
> >  notes-merge.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/notes-merge.c b/notes-merge.c
> > index 280aa8e6c1b04..dc4e2cce7151a 100644
> > --- a/notes-merge.c
> > +++ b/notes-merge.c
> > @@ -13,6 +13,8 @@
> >  #include "strbuf.h"
> >  #include "notes-utils.h"
> >  #include "commit-reach.h"
> > +#include "dir-iterator.h"
> > +#include "iterator.h"
> >
> >  struct notes_merge_pair {
> >  	struct object_id obj, base, local, remote;
> > @@ -673,8 +675,8 @@ int notes_merge_commit(struct notes_merge_options *o,
> >  	 * commit message and parents from 'partial_commit'.
> >  	 * Finally store the new commit object OID into 'result_oid'.
> >  	 */
> > -	DIR *dir;
> > -	struct dirent *e;
> > +	struct dir_iterator *iter;
> > +	int ok;
> >  	struct strbuf path = STRBUF_INIT;
> >  	const char *buffer = get_commit_buffer(partial_commit, NULL);
> >  	const char *msg = strstr(buffer, "\n\n");
> > @@ -689,27 +691,27 @@ int notes_merge_commit(struct notes_merge_options *o,
> >  		die("partial notes commit has empty message");
> >  	msg += 2;
> >
> > -	dir = opendir(path.buf);
> > -	if (!dir)
> > +	iter = dir_iterator_begin(path.buf);
> > +	if (!iter)
> >  		die_errno("could not open %s", path.buf);
> >
> >  	strbuf_addch(&path, '/');
> >  	baselen = path.len;
> > -	while ((e = readdir(dir)) != NULL) {
> > +	while ((ok = dir_iterator_advance(iter) )== ITER_OK) {
>
> Style: please don't leave a space between the closing braces, but
> there should be a space before the ==.
>
> But more importantly, there's a change in behaviour here, previously
> we wouldn't recurse into any subdirectories if there are any, while
> now we do.  It looks like there cannot be any subdirectories in this
> directory, so this might be fine, but I didn't check in detail.  This
> is something that you should investigate and describe in the commit
> message.
>
> >  		struct stat st;
> >  		struct object_id obj_oid, blob_oid;
> >
> > -		if (is_dot_or_dotdot(e->d_name))
> > +		if (is_dot_or_dotdot(iter->basename))
> >  			continue;
>
> The above condition is no longer necessary, as dir-iterator already
> skips these directories by default.
>
> >
> > -		if (get_oid_hex(e->d_name, &obj_oid)) {
> > +		if (get_oid_hex(iter->basename, &obj_oid)) {
> >  			if (o->verbosity >= 3)
> >  				printf("Skipping non-SHA1 entry '%s%s'\n",
> > -					path.buf, e->d_name);
> > +					path.buf, iter->basename);
> >  			continue;
> >  		}
> >
> > -		strbuf_addstr(&path, e->d_name);
> > +		strbuf_addstr(&path,iter->basename);
>
> Style: missing space after the comma.
>
> >  		/* write file as blob, and add to partial_tree */
> >  		if (stat(path.buf, &st))
> >  			die_errno("Failed to stat '%s'", path.buf);
> > @@ -731,7 +733,7 @@ int notes_merge_commit(struct notes_merge_options *o,
> >  		printf("Finalized notes merge commit: %s\n",
> >  			oid_to_hex(result_oid));
> >  	strbuf_release(&path);
> > -	closedir(dir);
> > +
>
> Please remove trailing spaces/tabs.  You can check for this using 'git
> diff --check [base]...HEAD', and fix it with 'git rebase --whitespace=fix'.
>
> >  	return 0;
> >  }
> >
> >
> > --
> > https://github.com/git/git/pull/594

Thanks,
Taylor

[1]: https://github.com/editorconfig/editorconfig-vim

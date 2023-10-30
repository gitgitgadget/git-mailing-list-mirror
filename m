Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2F1866
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="YChOTOsw"
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE89A9
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 23:07:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2802a569c23so629848a91.1
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 23:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698646020; x=1699250820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrjyyFp5/aKe6S1aEigaJTiPsB4wSDaTWp8U/0Xvv9s=;
        b=YChOTOswa9YuoN/LQ+1ofzASp6ozfIVB/JbFzX1D0FBpqgCBu8zi8VMPaXP4GkmGAQ
         VcwPIU+K09WkVqyMGJkrjVO/xXM8peyd4MSelbKAqMpT1WZsA9I46v1T/1qmiW/uO+cT
         r9VhJ1xc8UPWOjRwObs+nbU5BJEgP3Kj/oG3cW2izoVHiw7+bY0BaJDpBQMtarOxq/On
         zdlDRD3PjscTJ7JmrsEH+ABJHstMR7kZZOX1uoLwXB9fZjoZHJqSbp8+wtf+xk+D0TaX
         2x10NCuSTsIDXRfGXRVGIHFjHyZ8aBm/R7roc5XVEgEtM/k/Qs7af1dcakm1LvANFace
         AO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698646020; x=1699250820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrjyyFp5/aKe6S1aEigaJTiPsB4wSDaTWp8U/0Xvv9s=;
        b=VrAIs6sO8Yb99B0Q1fmB+THoSPYU3LQgupfChvo0TmRNbBxpvly1RiSpELztc8QQEK
         wJaJNE2z2zkpfaemJXWGnbioyw2ARuMXUHKnHHt8MIQPg5gZpsitmVVEnONUGtS4k6n+
         ZU1KfBAVQy+06RIXdg5XJBQENWm6bIfmzGocRThdCWhWpCi8Jij7bDiTyQU7SUccWZxE
         bkurTuC31RRHyqIyZ2fkd6OfFaFpBeJkeyRhyr9tTFtbhw5lQ+qzLjWGpDKSJigT4lR8
         h/Njq+LTR9zMld1n6Fx+rqJ9H0rpCRttfxCCMZ7IZS1iVUbiWBSTMDYX9+bx1mJdo+vs
         Z3ew==
X-Gm-Message-State: AOJu0Yx/Zt1wx9TP2YvLJNjWCXCeE74cakkTvzDV0qU8vIUI7YFJgjPh
	5dxHgqEtRoUfWcHIqoZCXGKJLQ==
X-Google-Smtp-Source: AGHT+IHr3X16kAgC4ItkRuTP7n7tdd6wmx8GlL3VqsiQjeSEm3cvMzOuXUCRqnO3XUQrDkcbYU/Lmg==
X-Received: by 2002:a17:90b:305:b0:280:2823:6612 with SMTP id ay5-20020a17090b030500b0028028236612mr2340361pjb.35.1698646019773;
        Sun, 29 Oct 2023 23:06:59 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-45-236.mycingular.net. [166.170.45.236])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a5c00b0026f39c90111sm4261429pjl.20.2023.10.29.23.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 23:06:59 -0700 (PDT)
Date: Sun, 29 Oct 2023 23:06:56 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/6] status: add noob format from status.noob
 config
Message-ID: <ZT9IACbL574boSw/.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <20231026224615.675172-2-jacob@initialcommit.io>
 <xmqqjzr4gaie.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzr4gaie.fsf@gitster.g>

On Mon, Oct 30, 2023 at 10:32:57AM +0900, Junio C Hamano wrote:
> Jacob Stopak <jacob@initialcommit.io> writes:
> 
> > diff --git a/table.c b/table.c
> > new file mode 100644
> > index 0000000000..15600e117f
> > --- /dev/null
> > +++ b/table.c
> 
> Yuck, do we need an entirely new file?  What trait are the things
> that are thrown into this file together supposed to share [*]?  It
> is not very clear to me what the focus of this file is.
> 
> 	Side note: for example, stuff in wt-status.c are to compute
> 	per-path status of the working tree and in-index files.

I created a new file because:

  * It will be used by more than just the status command (as patches 3/6
    and 5/6 show it applied to the "add" and "restore" commands
    respectively). And it will be applied to more commands as well.

  * For these RFC versions I mainly wanted to get some kind of minimal
    POC working, so I could get feedback and build on

  * It was easier to work on it in it's own file.

That being said, I was probably careless with what I tossed in there.
I intended it to specifically be things related to populating, coloring,
and printing the new table format.

But after reading all of your comments here, I see that I most likely
made the error (which I've made before) of being too specific. If I
generalize this file to be a generic table format that can be used for
anything, then the command-specific details can likely be extracted into
their respective existing files.

Another thing I totally didn't consider until I read your mail is the
possibility of refactoring the existing "git column" functionality to
provide a configurable table output format. At this point I'm not sure
if that's feasible or makes sense, but it's at least worth considering.

> > @@ -0,0 +1,117 @@
> > +#define USE_THE_INDEX_VARIABLE
> 
> I personally do not mind, but I suspect many people hate to see this
> compatibility set of macros used in a newly written source file.

Noted, I'll try to update this.

> > +static const char *color(int slot, struct wt_status *s)
> > +{
> > +	const char *c = "";
> > +	if (want_color(s->use_color))
> > +		c = s->color_palette[slot];
> > +	if (slot == WT_STATUS_ONBRANCH && color_is_nil(c))
> > +		c = s->color_palette[WT_STATUS_HEADER];
> > +	return c;
> > +}
> 
> Do we need to duplicate this from other files?  If this is about
> "git status", perhaps some parts of this patch, the truly new things
> (rather than what was copied, like this one) can be added to
> wt-status.c instead of adding a new file with unclear focus?

I just re-used the status coloring out of laziness, since I was thinking
about this in a narrow way that it's basically replicating the output
of Git status, so I figured I'd use the same colors.

Now that I'm thinking more generally I see why this needs to change,
to make table column output colors flexible.

> > +static void build_table_border(struct strbuf *buf, int cols)
> > +{
> > +	strbuf_reset(buf);
> > +	strbuf_addchars(buf, '-', cols);
> > +}
> 
> This seems to be horizontal border; do we need a separate vertical
> border?

Yes it is a horizontal border, the vertical border pipe characters are
included as a part of each table line being drawn, so I didn't need a
standalone vertical border in order to "draw" the tables. This one could
be renamed to reflect it's horizontal-ness, for clarity.

> > +static void build_table_entry(struct strbuf *buf, char *entry, int cols)
> > +{
> > +	strbuf_reset(buf);
> > +	strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
> > +	strbuf_addstr(buf, entry);
> > +
> > +	/* Bump right padding if entry length is odd */
> > +	if (!(strlen(entry) % 2))
> > +		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2 + 1);
> > +	else
> > +		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
> > +}
> 
> The code assumes that one byte in string "entry" occupies one and
> only one display columns, which is so 20th centry assumption that
> does not care about i18n.  Often what takes 3 bytes in a UTF-8
> string occupies 2 display columns, for example.  In addition, if you
> plan to color entries in the table, some substring would end up to
> be 0-width.

Thanks for this info. I'll look into these.

> Your pathname may be so long that 1/3 of a window
> width may not be sufficient to show it in its entirety, you might
> need to show it truncated in the middle.

This is exactly what patch 2/6 does (more details on that below). I
should have squashed that into 1/6. I'll do that in the next series.

> utf8.c has support for measuring the display width of UTF-8 string,
> which is used elsewhere in our code.  You may want to study it if
> you want to do a "tabular" output.  The code in diff.c that shows
> diffstat has many gems to help what this code wants to do, including
> measuring display columns of a string, chomping a long string to fit
> in a desired display columns, etc., by using helpers defined in
> utf8.c

Well that sounds like exactly what I need. I'll take a look, thanks!

> A potential excuse I can think of to have these outside wt-status.c
> and in a separate new file is to have a generic "table" layout
> machinery that is independent from "git status" or what each column
> of the table is showing (in other words, they may not be pathnames),
> and reusable by other subcommands that want to show things in the
> "table" layout.  

Yes that is my excuse (altho it may not be a valid one) - this patch
series adds the table output format for the "git add" (see patch 3/6) and
"git restore" (see patch 5/6) commands. Dragan will be working on
implementing verbose config options for several commands, that I will then
use as stepping stones to try and add this table format as the "extended"
(not "noob") verbosity option.

> But even as a candidate for such a generic table
> mechanism, the above falls far short by hardcoding that it can only
> show 3-col table whose columns are evenly distributed and nothing
> else.

Yeah - I was planning to update the table format so that the number of
columns is flexible. For example, I can think of commands like "git
stash" that would likely require 4 columns to display the required info,
so parameterizing the number of columns is on my agenda.

But you're right maybe there are many other useful things that a generic
table format would include. Things like alignment, spacing, etc. I didn't
think about how this might be used outside of my specific use case - I
tend to get tunnel vision on what I'm working on. I'll try to think more
broadly about how a format like this might be applicable, and at least
try to implement it in a way that it can be re-used for other things if
and when the need arises.

> > +static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
> > +{
> > +	printf(_("|"));
> > +	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", buf1->buf);
> > +	printf(_("|"));
> > +	color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%s", buf2->buf);
> > +	printf(_("|"));
> > +	color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%s", buf3->buf);
> > +	printf(_("|\n"));
> > +}
> 
> How does the code deal with unknown display width of translated
> version of "|" emitted here?  Are you assuming that no matter how
> these are translated, they will always occupy one display column
> each?

I'm not familiar with how the translation process works yet, so _if_ the
version of the "|" that I'm emitting here is a canditate for translation,
it was not even my intention to do so, as I'm just using the vertical
pipe as a column separator and table border. I think what I need is to
make sure these are _not_ translatable, so that we can guarantee the
single character display width? 

> > +void print_noob_status(struct wt_status *s)
> > +{
> > +	struct winsize w;
> > +	int cols;
> > +	struct strbuf table_border = STRBUF_INIT;
> > +	struct strbuf table_col_entry_1 = STRBUF_INIT;
> > +	struct strbuf table_col_entry_2 = STRBUF_INIT;
> > +	struct strbuf table_col_entry_3 = STRBUF_INIT;
> > +	struct string_list_item *item;
> > +
> > +	/* Get terminal width */
> > +	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
> > +	cols = w.ws_col;
> 
> Let's not reinvent an incomplete solution before studying and
> finding out what we already have in our codebase.  Immediately after
> you got tempted to type TIOCGWINSZ, you can "git grep" the codebase
> for that particular constant to see if we already use it, as that is
> one very reasonable way to achieve what this piece of code wants to
> do (i.e. find out what the display width would be).  You'd find
> pager.c:term_columns() and also learned that we want to prepare for
> the case where the ioctl() is not available.

Ah, ok let me look into that. I have utilized git grepping to understand
how various things are done in the codebase, but for some (no good) reason
I didn't think to try that here.

> > +	build_table_entry(&table_col_entry_1, "Untracked files", cols);
> > +	build_table_entry(&table_col_entry_2, "Unstaged changes", cols);
> > +	build_table_entry(&table_col_entry_3, "Staging area", cols);
> 
> Shouldn't these three strings be translatable?

Yes. I'll look into how translatable strings are done in the codebase.

> What should happen when these labels are wider than cols/3?

That's what patch 2/6 does. It splices out the center of strings that
are too long to fit in a column, keeping an equal number of characters
at the start and end of the string, and inserts a "..." in the middle.
Altho this makes sense for paths, this could be a bit confusing for
table headers, since it may be hard (or impossible) to read what the
column's purpose is, so it might be wiser to come up with even shorter
versions of the table headers to use when the console width is below a
certain size that makes the original strings unreadable.

> > diff --git a/table.h b/table.h
> > new file mode 100644
> > index 0000000000..c9e8c386de
> > --- /dev/null
> > +++ b/table.h
> > @@ -0,0 +1,6 @@
> > +#ifndef TABLE_H
> > +#define TABLE_H
> > +
> > +void print_noob_status(struct wt_status *s);
> > +
> > +#endif /* TABLE_H */
> 
> I am guessing that your plan is to add other "distim_noob_add()" and
> other "noob" variant of operations for various Git subcommands here,
> but I really do not think you want to add table.[ch] that has logic
> for such random set of Git subcommands copied and tweaked from all
> over the place, as the only trait being shared among them will
> become "they are written by Jacob Stopak", that is not a very useful
> grouping of the functions.  It is not even "this file collects all
> the code that produce tabular output from Git"---"git status -s"
> already gives tabular output, for example, without using any of the
> "I only want to draw a table with three columns of equal width"
> logic. Adding code that are necessary to add yet another output
> mode for "git status" directly to where various output modes of "git
> status" are implemented, i.e. wt-status.c, and do similar changes for
> each command would make more sense, I would think.

If you look at patches 3/6 and 5/6 I think you'll better understand my
"plan", not that I thought this would by any kind of final version, but
more of a starting point to get feedback and build on (hence the RFC).

I think the reason I clung so hard to "status" is that it contains a
lot of the info that I planned to display across various commands, so
much so that I baked it into the new table file itself. I see now that
needs to be separated out, as that data to be displayed can be calculated
in each command itself, and passed into the table functions to build and
print the thing.

But based on your input in this mail I'm going to:

  * Look into the existing "column" formatter to see if it can be
    repurposed for this table stuff.

  * If not, generalize the table stuff so that it can be used for anything
    and compartmentalize the command-specific stuff where it belongs.

> Thanks.

Thank you!

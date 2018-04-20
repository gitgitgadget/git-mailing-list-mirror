Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE25D1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 15:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755649AbeDTP1Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 11:27:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:58963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755523AbeDTP1X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 11:27:23 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ld3t6-1ejJsS01dg-00iDZj; Fri, 20
 Apr 2018 17:27:16 +0200
Date:   Fri, 20 Apr 2018 17:26:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/7] replace: introduce --convert-graft-file
In-Reply-To: <xmqqd0yud6vr.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804201640560.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de> <cecb82973f80fdd2db940410db2a7c3b23107c4b.1524125760.git.johannes.schindelin@gmx.de>
 <xmqqd0yud6vr.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Z2w68Hw6GZuLADalryLclvyELP3+WEUhdzLVICjXqmGlitmOCk/
 3qmsAg5Ejv6GOCvt5kiKSkhNIuRnX4KqknmOd291XBud3vIu75PS7DzwtWKULk+lK0A5YVp
 RLkaeOm7tsxCK7dSjl4zk1mOTY8GpTfXte/uIDouoYmgFgsK82WLALstJMpcX4ei0P0Ytts
 IlyGoZm86kqGds+Sb0Sfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kvusxvmHc5o=:wqEmO6AUo6ud/KQoVkNf8p
 OPZ4zX2edBQ0YS8K1dI79U+LlH8QM+jQMibrEgoWcbT3ymCeNzWzsm+EI876s3wefo/Jxzd60
 +oftpmhOcn8FQZjVC40q6f4VpaIS8KvsP6OibJ3IkgdyCOZa3ACzgxdQpAZIc5TkZYho+XAVw
 MjUK81e7AZz0z+UMemsDh7l4jO+LhqULYZJrxjaeucNlGwQBkMwYQ6N5iPQsabVSmfE27x9F/
 v0rlS6lyJmDKHY6yj41v95w5bYHL4bEaxSC6SjvnSHJuMa08tXqJrTqJ5PsG8PRFlqVsPH9Us
 Vp9cCjH/OuzNIrRIp1W7Lo032unXl18Rs/JjTj6wR8SEiG43a8ivOYUMHxx7GrulsHN554rpq
 PyqOSNCAgDUaEGbTcTFoI37fEmzzSje7N5IUOwSvumjYtSgujAbSHvvO8DYxrfn6r0LHi2Swu
 9OXcqqoxmHrUbaZ0ZlHXPvxn2wFGeoys9QNjru+meUNjKVrAwODeY3Cs2TWtyFoYiA4y74UJJ
 Q8ONNgSQpwfqda+/dAzmq2AWxgEPOT0A8dhn4/aTBPiw2sgn/e001AlvfZJPm0E5yOYvXg5xH
 5QwkwrTYmbPgbDwIZxXsG5btOf5b7rumeTH/JK+E+RYUw26Z26dBkgyBuwFCpSvW5Xl7D5rgf
 jgqWDqFf82Y34kgK6sjJJB4WcPNnW3Bh6T6hA9nwmqvzA9IJrzCf3oFSiaCqkoA1bVzL91bn7
 tcUn5FAEEVgkwpX1RVY/kwGtzqMw0jjLgW7P65U0oJA5aha1jMBWJ3CoaMfl3EZUTf0oWQh38
 rlQ2U/RXICQmuB9f17w1woTa0YZcJNigBg00oCDX10Q0Fuh73M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 20 Apr 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This option is intended to help with the transition away from the
> > now-deprecated graft file.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-replace.txt | 11 +++++--
> >  builtin/replace.c             | 59 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 66 insertions(+), 4 deletions(-)
> 
> I expected you to remove convert-grafts-to-replace-refs.sh from the
> contrib/ section in the same patch, actually.

Sorry, I was still under the impression that contrib/ was somewhat off
limits when replacing scripts by C code (it used to be the rule, but I did
see that the contrib/examples/*.sh files went poof).

Will change.

> FWIW, I think it is a much better approach to give the first-class UI
> for transition like this patch does than "go fish for a good way to
> transition yourself, we may have something useful in contrib/", which is
> what we had so far.

Obviously I agree. It just makes for such a vastly superior user
experience to get an explanation that yes, something has been deprecated,
but Do Not Panic, this is what you do to get out of this fix.

In the same vein, I considered some real hackery that would make the
deprecation notice in commit.c less annoying: I wanted to use some
tentative date in the future as cut-off, and then use some arithmetic
based on the time left until that date to show the deprecation notice
increasingly more often.

However, this would have made it really frustrating for users seeing the
notice fly by, say, in a lengthy script's output, and then trying to
reproduce the message. So as much fun as it would have been to come up
with that formula, I refrained from it.

> > +	while (strbuf_getline(&buf, fp) != EOF) {
> > +		int i = 0, j;
> > +
> > +		while (i != buf.len) {
> > +			char save;
> > +
> > +			for (j = i; j < buf.len && !isspace(buf.buf[j]); j++)
> > +				; /* look further */
> > +			save = buf.buf[j];
> > +			buf.buf[j] = '\0';
> > +			argv_array_push(&args, buf.buf + i);
> > +			buf.buf[j] = save;
> 
> It's a shame that we do not have a helper that splits the contents
> of a strbuf at SP and shove the result into an argv_array(). [*1*]
> 
> *1* There is one that splits into an array of strbuf but the point
> of splitting is often that these split pieces are the final thing we
> want, and placing them in separate strbuf (whose strength is that
> contents are easily manipulatable) is pointless.

FWIW I considered introducing such a helper. But I really want to have the
full line to show to the user, so I went with the current version.

Based on your comment, I realized that since argv_array_push() duplicates
the string *anyway*, I could have implemented argv_array_split().

Briefly deterred by the insight that some readers will invariably think
that this function performs de-quoting, Unix shell style, I almost decided
against that.

But only almost.

If anybody needs a de-quoting version of argv_array_split(), or a version
that uses a different delimiter than white-space, my version should
provide a neat starting point (new parameters should be added for those
purposes, of course, since we really need a non-de-quoting version in
--convert-graft-file).

So the next iteration of this patch series will sport a shiny new
argv_array_split(). Enjoy.

> > +
> > +			while (j < buf.len && isspace(buf.buf[j]))
> > +				j++;
> > +			i = j;
> 
> One difference I notice while comparing this with what is done by
> contrib/convert-grafts-to-replace-refs.sh is that this does not
> skip a line that begins with # or SP.  I offhand do not know what
> the point of skipping a line that begins with a SP, but I suspect
> that skipping a line that begins with "#" is a desirable thing to
> do, because commit.c::read_graft_line() does know that such a line
> is a valid comment.

Riiiight! I meant to look at the parser to verify that I do the same, but
forgot (I had the incorrect recollection that the graft file cannot
contain comments or empty lines).

So I remedied that now. Including correct handling of empty lines.

> > +		}
> > +
> > +		if (create_graft(args.argc, args.argv, force))
> > +			strbuf_addf(&err, "\n\t%s", buf.buf);
> > +
> > +		argv_array_clear(&args);
> > +		strbuf_reset(&buf);
> 
> Strictly speaking, this reset is redundant, as getline() will always
> stuff the line into a fresh buffer (and after the loop there
> correctly is a release).

Good point. I did assume that strbuf_getline() would append, and I was
wrong. I dropped the needless strbuf_reset() call.

> > +	}
> > +
> > +	strbuf_release(&buf);
> > +	argv_array_clear(&args);
> > +
> > +	if (!err.len)
> > +		return unlink_or_warn(graft_file);
> > +	warning(_("could not convert the following graft(s):\n%s"), err.buf);
> > +	strbuf_release(&err);
> 
> commit.c::read_graft_file() seems to ignore a broken graft line and
> salvages other lines, and this one follows suit, which is good.

Thanks.

> The remaining die() I pointed out in 1/2 can safely be turned into
> return error() for this caller (I didn't check for existing callers,
> though) and would automatically do the right thing.  The real
> consumer of the graft file, commit.c::read_graft_line(), shows an
> error when oid cannot be parsed, and the above code, when
> create_graft() is updated to return an error instead of dying, would
> append the problematic record to buf.buf in the code above.

It is a *lot* worse than just one remaining die(), unfortunately:
create_graft() calls replace_parents() and check_mergetags(), both without
checking their return value. Because neither return anything. Because they
all die (cue Dash from The Incredibles: We're gonna DIIIIIE!). Also,
replace_object_oid(), while it returns an int indicating an error, chooses
to die() in plenty of places. After following down to for_each_mergetag(),
export_object() and check_ref_valid(), I decided to just go ahead and
libify the entire builtin/replace.c, which seemed to be the vastly more
efficient route, and I really wish we would start deprecating die().
Thanks for sending me down that rabbit hole ;-)

Note: there is a call to get_commit_buffer() which still die()s if it
cannot read the object or if it is not a commit. If we care enough about
the concocted scenario where somebody would have installed a graft file
with a line that references, say, a tree object instead of a commit object
in its first oid, we need to do something about that: the graft line would
simply have been ignored, as grafts were only used when a corresponding
commit was parsed (which would never happen for the concocted example I
gave). I am rather certain, though, that I do not want to care about such
a scenario: a user would have to go out of their way to get into that
situation.

Ciao,
Dscho

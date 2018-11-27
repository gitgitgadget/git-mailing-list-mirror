Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C67A1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 13:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeK1Adq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 19:33:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:59865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeK1Adq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 19:33:46 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5IdH-1fTV7t15Jv-00zVWL; Tue, 27
 Nov 2018 14:35:46 +0100
Date:   Tue, 27 Nov 2018 14:35:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v11 03/22] strbuf.c: add `strbuf_insertf()` and
 `strbuf_vinsertf()`
In-Reply-To: <20181125214353.GI4883@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1811271428560.41@tvgsbejvaqbjf.bet>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com> <e8d86fae660a79eabcf4764dfa9986282c097242.1542925164.git.ungureanupaulsebastian@gmail.com> <20181125214353.GI4883@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:i3SrD9Tbj1cweSy/moFVfA2l08X7u8WVEWTQAn2qgTPtsyFXu4a
 iL5cm+3DVJPQLUNl6tvCQM7OG/EQG2QYAYZiIYsDNbCe3fMqKYl3esVX0TmvgZMwab/cPdq
 mcgV/fnXubdx3rMCA8MXPRbVVsPbyNrsjCXveYqnPxu0JH7oJZ4aHtna4IypM79vt6AP3ru
 9wy+XE9ATOUKHvCqcbU4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C0zvOBON0IM=:478ibZa5fAaJBMEt6i/TGR
 QKz5WZ6t5YB3aH4BfNhFKit7zTiiLLpLAPz3FW+MqDzBj/ZUkfl392OkJo1IXVcetsugKWTvz
 GeBgEYAc6R9AvRdPmUbupfIQKxQj1ejNzxeLNK2iHn9ES0s1wiFNtEjKPs6b+Z6gAtwwhTqPm
 QEztg3KBY/X5LJbR5aaw6S2ejII+jrpWzj1zj7JhbxWJIAEHgpB6WNZeu5uHEgshfHuLhhIvt
 +F6Ls/QUKzcTm0iVgUUoBcVGEpf0NAinwJ7nKVOhUf5Cx5NvF5A8OHYk/6HLadCZ+OM99yv5w
 S0hkrxlfpPcrSGxCHwO7plmSZGzIL800SeSrb9QkK9j75pTsQBEEp2ngP59zkMcM6jqdoyWUi
 SFQu6vG8W/fzCKNT5Ht3UZEYrUNLiU6/bsJbiutNls05vI93iB02MKHGRcjwtmtF1N5DJUV6Z
 iN6OqPnTW+WalLJOk9PEd696EDxfUBEDVQ9btwBRh97Kw1cdip0EtbXB0Y+YSCrQk40knVk/5
 H1NBkWEd0rOcaOrGjoRRn18Tw9ne2np5wKws9lkaOU9a5v2NTU0N0sRKgNMhwzfX5SDP9BhEj
 P+Uhruwm5pnFzaqH4VrFDFfqnWCLmOJEtdeQQ3RPOOtgU6MHSoFlS4799m+FnfsgpVk1I8mIS
 pBmmQAxyO421ygdf2SDyetUeTRnxmrGwy9XF8SpFtbRnks0MNb74Hnp2a9wLkz/PwgHjazN4j
 IbgMkAkLttCUroaVAl829NVHeXi1K1lAw52Q42qKVFkzMDmXjAXNFUimvyl0hDczHoksPbXGc
 LkHsvJmDCT0dej4wlxanMHeJafQ9zVAZHXaIRBS2OGLhRLluijalN8uC/IQ+IJfsrMZgKmz+1
 Mnhf79YP1LX/Qjvkd/aiIevI82VJevm0bI7SJaZDVOPCt020pTxy3Ga3ZxKGFn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 25 Nov 2018, Thomas Gummerer wrote:

> On 11/23, Paul-Sebastian Ungureanu wrote:
> > Implement `strbuf_insertf()` and `strbuf_vinsertf()` to
> > insert data using a printf format string.
> > 
> > Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> > ---
> >  strbuf.c | 36 ++++++++++++++++++++++++++++++++++++
> >  strbuf.h |  9 +++++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/strbuf.c b/strbuf.c
> > index 82e90f1dfe..bfbbdadbf3 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -249,6 +249,42 @@ void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
> >  	strbuf_splice(sb, pos, 0, data, len);
> >  }
> >  
> > +void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
> > +{
> > +	int len, len2;
> > +	char save;
> > +	va_list cp;
> > +
> > +	if (pos > sb->len)
> > +		die("`pos' is too far after the end of the buffer");
> 
> I was going to ask about translation of this and other messages in
> 'die()' calls, but I see other messages in strbuf.c are not marked for
> translation either.  It may make sense to mark them all for
> translation at some point in the future, but having them all
> untranslated for now makes sense.
> 
> In the long run it may even be better to return an error here rather
> than 'die()'ing, but again this is consistent with the rest of the
> API, so this wouldn't be a good time to take that on.

I guess I was too overzealous in my copying. These conditions really
indicate bugs in the caller... So I'd actually rather change that die() to
BUG().

But then, the original code in strbuf_vaddf() calls die() and would have
to be changed, too.

> > +	va_copy(cp, ap);
> > +	len = vsnprintf(sb->buf + sb->len, 0, fmt, cp);
> 
> Here we're just getting the length of what we're trying to format
> (excluding the final NUL).  As the second argument is 0, we do not
> modify the strbuf at this point...
> 
> > +	va_end(cp);
> > +	if (len < 0)
> > +		BUG("your vsnprintf is broken (returned %d)", len);
> > +	if (!len)
> > +		return; /* nothing to do */
> > +	if (unsigned_add_overflows(sb->len, len))
> > +		die("you want to use way too much memory");
> > +	strbuf_grow(sb, len);
> 
> ... and then we grow the strbuf by the length we previously, which
> excludes the NUL character, plus one extra character, so even if pos
> == len we are sure to have enough space in the strbuf ...
> 
> > +	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
> > +	/* vsnprintf() will append a NUL, overwriting one of our characters */
> > +	save = sb->buf[pos + len];
> > +	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
> 
> ... and we use vsnprintf to write the formatted string to the
> beginning of the buffer.

It is not actually the beginning of the buffer, but possibly the middle of
the buffer ;-)

> sb->alloc - sb->len can be larger than 'len', which is fine as vsnprintf
> doesn't write anything after the NUL character.  And as 'strbuf_grow'
> adds len + 1 bytes to the strbuf we'll always have enough space for
> adding the formatted string ...
> 
> > +	sb->buf[pos + len] = save;
> > +	if (len2 != len)
> > +		BUG("your vsnprintf is broken (returns inconsistent lengths)");
> > +	strbuf_setlen(sb, sb->len + len);
> 
> And finally we set the strbuf to the new length.  So all this is just
> a very roundabout way to say that this function does the right thing
> according to my reading (and tests).

:-)

It seems that Junio likes this way of reviewing, giving him confidence
that the review was thorough.

Thanks!
Dscho

> > +}
> > +
> > +void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	va_start(ap, fmt);
> > +	strbuf_vinsertf(sb, pos, fmt, ap);
> > +	va_end(ap);
> > +}
> > +
> >  void strbuf_remove(struct strbuf *sb, size_t pos, size_t len)
> >  {
> >  	strbuf_splice(sb, pos, len, "", 0);
> > diff --git a/strbuf.h b/strbuf.h
> > index be02150df3..8f8fe01e68 100644
> > --- a/strbuf.h
> > +++ b/strbuf.h
> > @@ -244,6 +244,15 @@ void strbuf_addchars(struct strbuf *sb, int c, size_t n);
> >   */
> >  void strbuf_insert(struct strbuf *sb, size_t pos, const void *, size_t);
> >  
> > +/**
> > + * Insert data to the given position of the buffer giving a printf format
> > + * string. The contents will be shifted, not overwritten.
> > + */
> > +void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt,
> > +		     va_list ap);
> > +
> > +void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...);
> > +
> >  /**
> >   * Remove given amount of data from a given position of the buffer.
> >   */
> > -- 
> > 2.19.1.878.g0482332a22
> > 
> 

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091541F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeA2VYC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:24:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:50618 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbeA2VYB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:24:01 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MPppG-1ek6f42GG2-00521F; Mon, 29 Jan 2018 22:23:52 +0100
Date:   Mon, 29 Jan 2018 22:23:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     phillip.wood@dunelm.org.uk
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to
 resettherevision
In-Reply-To: <d069a3c7-198e-81d2-0f35-f934e110c991@philandanna.no-ip.org>
Message-ID: <nycvar.QRO.7.76.6.1801292217590.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <d069a3c7-198e-81d2-0f35-f934e110c991@philandanna.no-ip.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gZAuU8f6JH/taQhRf7NRljnjoOnh+B68tLtoSZGK8xYNqFjW3Yy
 pzGfeklFzHzk6Q91y5L2PXXqkS4g/QzsE60DSvOnDjqgx6QSlhv/qUOGvbLFntW1tvsyKpg
 HdbLt44xTxQ+2rJK0CjIPWlx8ftneneIwpVECxVJxOUVBiPlttMHgFrAzv5oqzGUU/vMlag
 zWYXQ/v/ddiHAQkPjO7Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pbxOg57PJN0=:u8P/lln11futSRN4FqEY3M
 O2Anx53KXU3w5X/Bk1dItmc7+hIukQY9z9JPtQbyXYPbHxCF5wRGT/bjma23to+9uSP8O82AY
 tsWlkHf2NU+v+OOB3SfvCKbd8CXKOKsgxaGl+paOXelfKSEv3I6frzwq50FtW76hMI8DMerCE
 /YnRCFPBgBoTVHwOJ2TJ4S0+WSPqI3qOMd+Ry58XIyzSCjJpA2TnoBru+Q3D7kPcwTZT762tD
 9Gf+OQ9EpiIX7VuBGlUeH54Gp20uVaXz75Asa0tknRnzCOWm8mXyYRJbtcT4gti74LctRR1PA
 yL0LRVaKZ17oyCZwsTANc3XlwbGfAMWMq1a66AfeFZFpPJcKtXRmL515hTmfBZHmWuAhuwykQ
 dXkgUdV5BoukugWrEvHZkKywn1Pc+GgVJfy/w2HbQI0i59ka1lOM6UmQOzgkbrlXwgdvJJjlR
 Y1qxXqFCToX7iDQvYkoxlJTUdoimk1nSlCY5THYS/eo26GdVGMHS6p9p13/b7/+CmF9hwKZX+
 XJzUAnTS7eWJVXTS24SGYWAndMNeeFHXj93Hzhl3ZUHDxxZ98BgO7vUM/NxBbjpZ14+4FnncD
 82DVG2rOFGW4tvUjCP5mtrRJuLfif3ZvkI6iEHeGYSoDrdeLTC9KR9MpsiHkOZ4E8h2S1WUgS
 nprj1C9hwM46CCtmYh94rVHyYNpKHDLatv+fHeNqjFN7hHiKHhiI6mq48PsgWELxBZ8PvEi5t
 Xne5piI6JHUKKhX7vrpsxoSehX85C0J7iwbvFqLypScBFQ1WtJUPLTcWuSJaxMSiFHzokGRJX
 DSlKorHRRtlxU74c2FegkYvx+yUxipIWfM+KG5yo2NYa4tbThmhstTBppurLS6qX0VkP6Ro
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 19 Jan 2018, Phillip Wood wrote:

> 
> On 18/01/18 15:35, Johannes Schindelin wrote:
> 
> > This idea was developed in Git for Windows' Git garden shears (that
> > are used to maintain the "thicket of branches" on top of upstream
> > Git), and this patch is part of the effort to make it available to a
> > wider audience, as well as to make the entire process more robust (by
> > implementing it in a safe and portable language rather than a Unix
> > shell script).
> > 
> > This commit implements the commands to label, and to reset to, given
> > revisions. The syntax is:
> > 
> > 	label <name>
> > 	reset <name>
> 
> If I've understood the code below correctly then reset will clobber
> untracked files, this is the opposite behaviour to what happens when
> tries to checkout <onto> at the start of a rebase - then it will fail if
> untracked files would be overwritten.

This would be completely unintentional, I will verify that untracked files
are not clobbered.

However, in practice this should not happen because the intended use case
is for revisions to be labeled *before* checking them out at a later
stage. Therefore, the files that would be clobbered would already have
been tracked in the revision when it was labeled, and I do not quite see
how those files could become untracked without playing sloppy exec games
in between.

> > Internally, the `label <name>` command creates the ref
> > `refs/rewritten/<name>`. This makes it possible to work with the labeled
> > revisions interactively, or in a scripted fashion (e.g. via the todo
> > list command `exec`).
> 
> If a user has two work trees and runs a rebase in each with the same
> label name, they'll clobber each other. I'd suggest storing them under
> refs/rewritten/<branch-name or detached HEAD SHA> instead. If the user
> tries to rebase a second worktree with the same detached HEAD as an
> existing rebase then refuse to start.

That is why a later patch marks those refs/rewritten/ refs as
worktree-local.

> > +static int do_label(const char *name, int len)
> > +{
> > +	struct ref_store *refs = get_main_ref_store();
> > +	struct ref_transaction *transaction;
> > +	struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
> > +	struct strbuf msg = STRBUF_INIT;
> > +	int ret = 0;
> > +	struct object_id head_oid;
> > +
> > +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> > +	strbuf_addf(&msg, "label '%.*s'", len, name);
> 
> The other reflog messages below have a (rebase -i) prefix

Good point. I changed it to "rebase -i (label)".

> > +	transaction = ref_store_transaction_begin(refs, &err);
> > +	if (!transaction ||
> > +	    get_oid("HEAD", &head_oid) ||
> > +	    ref_transaction_update(transaction, ref_name.buf, &head_oid, NULL,
> > +				   0, msg.buf, &err) < 0 ||
> > +	    ref_transaction_commit(transaction, &err)) {
> > +		error("%s", err.buf);
> 
> if get_oid() fails then err is empty so there wont be an message after
> the 'error: '

Yep, that would be nasty. Fixed.

> > +static int do_reset(const char *name, int len)
> > +{
> > +	struct strbuf ref_name = STRBUF_INIT;
> > +	struct object_id oid;
> > +	struct lock_file lock = LOCK_INIT;
> > +	struct tree_desc desc;
> > +	struct tree *tree;
> > +	struct unpack_trees_options opts;
> > +	int ret = 0, i;
> > +
> > +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> > +		return -1;
> > +
> > +	for (i = 0; i < len; i++)
> > +		if (isspace(name[i]))
> > +			len = i;
> 
> If name starts with any white space then I think this effectively
> truncates name to a bunch of white space which doesn't sound right. I'm
> not sure how this is being called, but it might be better to clean up
> name when the to-do list is parsed instead.

The left-trimming of the name was already performed as part of the todo
list parsing.

And we are not really right-trimming here. We are splitting a line of the
form

	reset <label> <oneline>

In fact, after reflecting about it, I changed the code so that it would
now even read:

	reset <label> # <oneline>

So the code really is doing the intended thing here.

Ciao,
Dscho

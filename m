Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735291F404
	for <e@80x24.org>; Wed, 31 Jan 2018 13:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeAaNVz (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 08:21:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:57117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752865AbeAaNVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 08:21:54 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.195.59]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MQMBU-1eJkrm0yMe-00TjWn; Wed, 31 Jan 2018 14:21:46 +0100
Date:   Wed, 31 Jan 2018 14:21:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 02/10] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <CAGZ79kYK9H88HRLKBFs+OatYMVVqmc1WOsTbaUbaK9yW0Sqqrg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801311411040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de> <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de>
 <CAGZ79kYK9H88HRLKBFs+OatYMVVqmc1WOsTbaUbaK9yW0Sqqrg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WOrxUqUQRMjive3Ssx2bHTcHUYEUs1qS2gbIn78Ky9ZK+VmYsuV
 XCdIzGlWhOhM4c84X0dngvazLr9H7q7RY7MWGA9zgXbVuMPdNkxTjjfZBnLHakGX6UfIuRW
 YGx2B3gLDfyTJu3ffJ+jATZlya5o7roCPK/QqELVNliM4muldMhCU2elQGdPDpr7qvPQpmq
 tnC7MEAUhUZsBwauB6Mmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DQGiZqnNfQs=:8mo+d6wYBzVUV2N6UmrFDi
 3C6ICGYL1cv+soFfpMeVK/002B0KV1j1oBAaSwhlgFjVFH7NTdN985dBX0RmayoSIdvDaD1JQ
 ZlN57IDfZSYrcDaIZ4u73YuJi+XnmHT/NTgb3myeND2xFUQU88U1WJrF4qVjqBMIv697NggzD
 KTW0C4qPBJhlyr7pvo6KGpZy7/1W0JW7B0qHMTOGhancj/1m2bvquFKvnLUaVd9L3IksGEkO1
 siDczn/sN3V4Vk87Ah+uw9Gs1hnM4oOW0wWKajw11KrKrGwaB2ER9OC7VtUMh85XsDWIHV5rO
 b/42auwXm2VvqZ7jHBV7oWX5rT2h70icHhg0TjwuGhahzQAo45NkieWgVEGmqIb0/vo9in6q2
 wm+lUvzp2eh/35kM+KWvde394UX+IZt/jV1dzWWJw7ZFF8VejOo5eBvxi6K286k2BOEJtiy0B
 f2UGRNFZFG9c6c97k7g1+mcUvSdIp3NQq2yBT41vBdVDBFM+SWDqnD+qZQlZtoGrtLSWekxzb
 5XXpoFSHXxNfbasLVR7CjemIwt7Mure4OZYuf4Kid2qgwEaA4172Z9ZFQ3o/+jFnXQfOIID1Q
 2Q48GpiFqAJG3w84d8qMF8DaHycYwYF7W2NF2rfn/LG9oS5qu+DIVR8K6jA5OyWpqXQz3xkeL
 38sThT2D2I+U+eK8WcHAmBsq687kms9OD5hFiP7fxWn2mEDo8CemzuLn8VW4Gtj+nQKCOmjcF
 FUxhmjzcorUMOqpvC/mEg4/IpZn/R7cHWPNCyqwX3QiDZGGj3EaBqev6upeTMfPQFnP9gP1zZ
 sMzfiFfitGOJyvTs5DtS0ArCC5+8mDfxKU7Idbm2Dz7wiIhaVtBu2YsdTm6LCZeXOrVOEus
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 30 Jan 2018, Stefan Beller wrote:

> On Mon, Jan 29, 2018 at 2:54 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > @@ -116,6 +118,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
> >  static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
> >  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
> >         "rebase-merge/rewritten-pending")
> > +
> > +/*
> > + * The path of the file listing refs that need to be deleted after the rebase
> > + * finishes. This is used by the `merge` command.
> > + */

Whoops. The comment "This is used by the `merge` command`" is completely
wrong. Will fix.

> So this file contains (label -> commit),

Only `label`. No `commit`.

> which is appended in do_label, it uses refs to store the commits in
> refs/rewritten.  We do not have to worry about the contents of that file
> getting too long, or label re-use, because the directory containing all
> these helper files will be deleted upon successful rebase in
> `sequencer_remove_state()`.

Yes.

> > +static int do_reset(const char *name, int len)
> > +{
> > +       struct strbuf ref_name = STRBUF_INIT;
> > +       struct object_id oid;
> > +       struct lock_file lock = LOCK_INIT;
> > +       struct tree_desc desc;
> > +       struct tree *tree;
> > +       struct unpack_trees_options opts;
> > +       int ret = 0, i;
> > +
> > +       if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> > +               return -1;
> > +
> > +       /* Determine the length of the label */
> > +       for (i = 0; i < len; i++)
> > +               if (isspace(name[i]))
> > +                       len = i;
> > +
> > +       strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> > +       if (get_oid(ref_name.buf, &oid) &&
> > +           get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
> > +               error(_("could not read '%s'"), ref_name.buf);
> > +               rollback_lock_file(&lock);
> > +               strbuf_release(&ref_name);
> > +               return -1;
> > +       }
> > +
> > +       memset(&opts, 0, sizeof(opts));
> > +       opts.head_idx = 1;
> > +       opts.src_index = &the_index;
> > +       opts.dst_index = &the_index;
> > +       opts.fn = oneway_merge;
> > +       opts.merge = 1;
> > +       opts.update = 1;
> > +       opts.reset = 1;
> > +
> > +       read_cache_unmerged();
> 
> In read-tree.c merge.c and pull.c we guard this conditionally
> and use die_resolve_conflict to bail out. In am.c we do not.
> 
> I think we'd want to guard it here, too?

Yes.

> Constructing an instruction sheet that produces a merge
> conflict just before the reset is a bit artificial, but still:
> 
>     label onto
>     pick abc
>     exec false # run "git merge out-of-rebase-merge"
>         # manually to produce a conflict

This would fail already, as `exec` tests for a clean index after the
operation ran.

>     reset onto # we want to stop here telling the user to fix it.

But you are absolutely right that we still need to fix it.

> > +       if (!fill_tree_descriptor(&desc, &oid)) {
> > +               error(_("failed to find tree of %s"), oid_to_hex(&oid));
> > +               rollback_lock_file(&lock);
> > +               free((void *)desc.buffer);
> > +               strbuf_release(&ref_name);
> > +               return -1;
> > +       }
> > +
> > +       if (unpack_trees(1, &desc, &opts)) {
> > +               rollback_lock_file(&lock);
> > +               free((void *)desc.buffer);
> > +               strbuf_release(&ref_name);
> > +               return -1;
> > +       }
> > +
> > +       tree = parse_tree_indirect(&oid);
> > +       prime_cache_tree(&the_index, tree);
> > +
> > +       if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
> > +               ret = error(_("could not write index"));
> > +       free((void *)desc.buffer);
> 
> For most newer structs we have a {release, clear, free}_X,
> but for tree_desc's this seems to be the convention to avoid memleaks.

Yep, this code is just copy-edited from elsewhere. It seemed to be
different enough from the (very generic) use case in builtin/reset.c that
I did not think refactoring this into a convenience function in
unpack-trees.[ch] would make sense.

Ciao,
Dscho

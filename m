Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05EA620248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfCMWPG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:15:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:49485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfCMWPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:15:06 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV5hN-1hXkgx4AtZ-00YUzj; Wed, 13
 Mar 2019 23:14:51 +0100
Date:   Wed, 13 Mar 2019 23:14:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: pass pathspec as pointer
In-Reply-To: <20190312234046.GF16414@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1903132311200.41@tvgsbejvaqbjf.bet>
References: <20190225231631.30507-1-t.gummerer@gmail.com> <20190225231631.30507-19-t.gummerer@gmail.com> <20190307191836.GB29221@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet> <20190309182610.GD31533@hank.intra.tgummerer.com>
 <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com> <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com> <20190311214244.GB16414@hank.intra.tgummerer.com> <20190311221624.GC16414@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1903122323460.41@tvgsbejvaqbjf.bet>
 <20190312234046.GF16414@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7oNNVE11QX6pZFqdPITt1R9BQ78b6WLFqigE0pY6P+WWuY92fHc
 XcEACo3dNLhIdTHEfpeIyw6HVm0PEB8w0jYsPTlCC47ndpmUUfwxfn/3AjpbLi6DTlpDl4Y
 jPJ0MmpNIfz5eoz8sEfwj7+7vl/er2hbdjCEk8aNPExO2WpUoyHHYnF5EXvosUGHL6Vp6cV
 ArD7fzriw/YLQlPKshKQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cbnwcGND3pU=:cWt62eZ8giViX49ixdfE/3
 zKCdzmt9PHZYjSK2nLJhs4Vx2t+US5L39BF0y6QxprvsV+Yw0hOiAyw7eiLYl9inrzgE8HaIq
 xJgb2ZmlRC74CEvA9L1FuAHphU278LXk+4ZaQVRyGgocOtQDUA4LOfmv1c3tcYve+7hxKhUXO
 pVcuYuE0L/5mbus/uIBZE7XRCApseqxdM9gcHN+I4MSOdL5gQPJopAOOgL5GUMpiN/WrTnFfM
 cM1g85Ak1FCIh4px/5nOY8Ye4tzxKPv2rKhFp+pTehrIpWQp71EyL5VPn+aZvEFpYchn2yyp8
 KEI2qQpxuwWeeV3b6gNpH7aB+4vIeD3s3rUjR32BwHEyxH7fHjBdivElyVAlQOgBzgjLtZOPM
 Yjdedt09/9tvxYtFf+7UmJ1/gsDu78aUHqyQAGqnslBJtl+wnD9JoKKbfrtDI4CN7xKFEsNm/
 yfdLLG8efKS/D3EgSsS4QYRTpPpsRV/ZOsq/H4s4ronnJdHjjjLizSqQrBiyvS5r17cdHGIi1
 F9PwwI0Cx66mgro4SrbAlZurJK8ocUfx7ADJMZMBSEj/QdkfspJrAbkuC+EHuowY3JQm878ej
 BtU/qc4aFNdRal5vRKEL4ZuXxrWgEh4Il49DzBahT7OWhOoYKEEPu+KxqOv/9mYFIdeQ0e3Kg
 gnKVaxUIiIfb+QkBPBfTTaFhkwGMFjKvxvk6jf4j9Mqk/ki5kJE5LsRFuKTqJMasDtRhN4D77
 bu8qxrJxeqwDZp2XHUjODDM4nhWE0hl0s9Ffz/eLgP/5PM4eh0CSH+MKlru1vKehiNz7yodti
 cGpgKVEvRViVDeFczcVWLc9ZwxmujnnMZaYxRHWYsIEJND5OK+bG3Sd53kvi4P+hjTJsiy5f1
 pUgVtqNDcgvy+wBmLCoT3eT9T6KCJ7PDcB5BVCpnKBQ/Ad742iY+0UQo5odW1Twa5vgaXVI0J
 R+heny3YIUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Tue, 12 Mar 2019, Thomas Gummerer wrote:

> On 03/12, Johannes Schindelin wrote:
> 
> > On Mon, 11 Mar 2019, Thomas Gummerer wrote:
> > > [...]
> > > @@ -1042,6 +1049,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
> > >  	struct index_state istate = { NULL };
> > >  
> > >  	init_revisions(&rev, NULL);
> > > +	copy_pathspec(&rev.prune_data, ps);
> > 
> > This moved here... because...
> > 
> > >  
> > >  	set_alternate_index_output(stash_index_path.buf);
> > >  	if (reset_tree(&info->i_tree, 0, 0)) {
> > 
> > ... this `if` block could jump to...
> > 
> > 
> > > @@ -1050,7 +1058,6 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
> > >  	}
> > >  	set_alternate_index_output(NULL);
> > >  
> > > -	rev.prune_data = ps;
> > >  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> > >  	rev.diffopt.format_callback = add_diff_to_buf;
> > >  	rev.diffopt.format_callback_data = &diff_output;
> > > @@ -1089,12 +1096,13 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
> > 
> > ... this point (the `done:` label is *just* one line further up, and this
> > is a static diff, so we cannot just increase the context when we need to
> > see more, unlike, say, GitHub PRs) and...
> > 
> > >  	discard_index(&istate);
> > >  	UNLEAK(rev);
> > >  	object_array_clear(&rev.pending);
> > > +	clear_pathspec(&rev.prune_data);
> > 
> > ... we add this call here.
> > 
> > However, we would not have needed to move the initialization of
> > `rev.prune_data`, I don't think, because `init_revision()` zeros the
> > entire struct, including `prune_data`, which would have made
> > `clear_pathspec()` safe to call, too.
> 
> 'clear_pathspec()' doesn't actually check whether the parameter passed
> to it is NULL or not before dereferencing it.

In this case, it does not need to check for NULL, as `&rev.prune_data`
will always be non-NULL: `rev`'s `prune_data` field is of type `struct
patchspec`, i.e. *not* a pointer (in which case the type would be `struct
pathspec *`). See for yourself:

	https://github.com/git/git/blob/v2.21.0/revision.h#L91

Ciao,
Dscho

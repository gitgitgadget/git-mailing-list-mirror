Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432F820248
	for <e@80x24.org>; Mon, 11 Mar 2019 20:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfCKUKd (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 16:10:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:56981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbfCKT4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:34 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2ts6-1gk7ET0J1y-00seJ5; Mon, 11
 Mar 2019 20:56:27 +0100
Date:   Mon, 11 Mar 2019 20:56:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: respect core.hidedotfiles = false in git-init
 again
In-Reply-To: <xmqqva0ujboi.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903112037070.41@tvgsbejvaqbjf.bet>
References: <pull.131.git.gitgitgadget@gmail.com> <008e367d26de12debd596e8f16356f70c74d3d7e.1551951339.git.gitgitgadget@gmail.com> <xmqqva0ujboi.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zgWgxZKf2P1pF0kPEH4tGr3SQ9HbNW3DwJuSvdYpV+fPVGzgVei
 bB4pGU/TVZt1qPnUh+7yBvQqs602Z60wZa8Pav58jCCytaRvhAS8+JxQpdi/z+62m6mboM1
 /vpwd09rvpybDOH2KmilK8wejO7JXUGRqBUtFZQHNjwMM+OT8eToT1QOXXpxZLWupLdh8zC
 UeOUlC55OnWNnSIaGr3dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p4Uy7ZqPANA=:xmSmFehRn9hrAUQrylvgsG
 UPr8Xktv3WAsHwx8ZuBxI+7ljWDYGS/ncJ0ZXvHBPQU3Rs/OnGK/6eTCcMwdO4onefoVBuIt0
 fgl5dQcTjDJkUdVw4NjSrCjXxMXh1xUlCTUsJlFSQiLlAS9kzqkOD+xkXkobYpyiV0PTwDl6K
 lgiqJQfqyi0DGeZk3WGgCj78B7DnCppyQW72UcJSoQtdLjkcXmlcNQwpxnfJN9fIB4kkUrNSq
 cQXwO08iNBnVDmLVhOp5gVGN7tkyydcRId875krPE5oQlqicEk+3AimcRC/rv1VQU4m672Srt
 fqZMt8lWXvL2k7pb3CI9LJHFB27ykIGK79TB1GPHdkXHwDp2o7jwYNQp/3EKXdQhJSglNXF+z
 zHt0K13oMDZBIowwcTbtTH5Og4BjUI/qJYX+BAltSyH0FkdOR9y9rnTGPM55TdHu51i1PodAx
 x8DjKWC+20wTtT42xqrcCrP5E1XnRi86agqkVE/JFxl/r/1bHMkYTO6QSVf2XNPUCvYoVx5nZ
 6iK7oH6Dsl0J8BsiNUj40S0IIvXDkVrgK7125JEvCbknT/7BugMsQxWKcLjNhIDRKQjz4/c/D
 hUib0DbCfU1cgEMom2RratsMhvO5D0cF6jvQ6h7SXT/Pr6U9LZnO7DiQ9RlANpPnk2CPqS+Yp
 C1Vyv+wFYhUnBTlQRcV7w/lDhqUqeXCbXhPd9XtsUlv7VVNMEMryeit4b7LxDNZ2KJr9AsvoI
 B2U+mhJW5DWtZ4b/H2vkCXQnCcAJhkOpaa4V25tTc8AfTNK58dQusA0zYqN4r1LGq+2KC7RtK
 Eu5XvQ1269xHMJDxXBLgpxdjiQd0Hk+0paqgi6zsHkpDzd2So5b0NH9JLYIZ2U7F8KsYgNesS
 iVU1SVDF3A111iimP5/dggcV76+WGF6DTZT0GBKoJfSs76v3TC7TRQ/6asPDkoLGba1kVHc5o
 A5bnUuoKwnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 Mar 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 93eff7618c..94df241ad5 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -155,6 +155,9 @@ static int git_init_db_config(const char *k, const char *v, void *cb)
> >  	if (!strcmp(k, "init.templatedir"))
> >  		return git_config_pathname(&init_db_template_dir, k, v);
> >  
> > +	if (starts_with(k, "core."))
> > +		return platform_core_config(k, v, cb);
> > +
> >  	return 0;
> >  }
> 
> OK.  I think this is very much futureproof and a sensible thing to
> have a "platform_core_config()" call here.  That way, we do not have
> to say the details of what platform specific thing each platform
> wants when init_db_config works.

I am glad you agree.

> > @@ -361,6 +364,9 @@ int init_db(const char *git_dir, const char *real_git_dir,
> >  	}
> >  	startup_info->have_repository = 1;
> >  
> > +	/* Just look for `init.templatedir` and `core.hidedotfiles` */
> 
> And from that point of view, replacing `core.hidedotfiles` with
> something like "platform specific core config" would be more
> appropriate.

Probably. But it could potentially make some developer (such as myself,
six months from now) wonder why we don't just remove this call because
clearly nothing uses this on Linux.

So even if it is not quite future-proof from the point of view where we
*technically* would have to extend this comment if we ever introduced
another platform-specific config setting that is relevant to the early
phase of `git init`, I would like to keep the comment in the current form.

Well, actually *almost* in the current form.

I did realize, based on your comment below, that the mention of
`init.templatedir` here is bogus, wrong even: if `git init` is started in
a Git worktree, we do not *want* to use the `init.templatedir` setting
from said worktree.

And that is the reason why...

> > +	git_config(git_init_db_config, NULL);
> > +
> 
> We use git_init_db_config from create_default_files(), which is a
> function called several lines after this point; shouldn't that now
> be removed from create_default_files()?

... we have to call `git_config()` *again* in `create_default_files()`.

> >  	safe_create_dir(git_dir, 0);
> >  
> >  	init_is_bare_repository = is_bare_repository();
> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index 42a263cada..35ede1b0b0 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -453,6 +453,18 @@ test_expect_success 're-init from a linked worktree' '
> >  	)
> >  '
> >  
> > +test_expect_success MINGW 'core.hidedotfiles = false' '
> > +	git config --global core.hidedotfiles false &&
> > +	rm -rf newdir &&
> > +	(
> > +		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
> > +		mkdir newdir &&
> > +		cd newdir &&
> > +		git init
> > +	) &&
> 
> This is not incorrect per-se, but I think most tests do the mkdir
> outside subshell, i.e.
> 
> 	rm -rf newdir &&
> 	mkdir newdir &&
> 	(
> 		cd newdir &&
> 		sane_unset ... &&
> 		...
> 	) &&

Legit.

Thanks,
Dscho

> 
> Other than these, I find nothing questionable in the patch.  Nicely
> done.
> 
> 
> 

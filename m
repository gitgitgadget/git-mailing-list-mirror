Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D537B20133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdCCPIr (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:08:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:54372 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbdCCPIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:08:24 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRXSK-1cqWb83SfY-00ShFX; Fri, 03
 Mar 2017 15:49:26 +0100
Date:   Fri, 3 Mar 2017 15:49:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/9] Export the discover_git_directory() function
In-Reply-To: <20170303044518.rdtyvgs7kqe7fkpf@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031511490.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <0ca4cce042cc0b0f13f87363b70a3689057ae9b0.1488506615.git.johannes.schindelin@gmx.de> <20170303044518.rdtyvgs7kqe7fkpf@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Fqabjks3g9ctxOmeR+qtdVO1dl4AOrnW80gGBISJwnkvsN+YjFH
 SkWkDmOpBuapI1PwTcfrzQbjbbDgZBQhkB6HkTl9K3cA73UCzod/J7KuAzemadSbdGUHR+1
 QNlI21YInS2Z8ex9MUhx5fVitKXbFZBOwmd6NMEuTqt8Z+8xbpcFdSc7I/jPsPE9TDmzejO
 oJDPFAIbHrd4+wM0/otTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CJ3TczdZVXk=:AO5P47cof09Y6UirwOI5bM
 9M4NjSIt9wpocNgEnuVI2PjBdtVMYNd7qDxJduVdBW7ZLDmSJ55ejwqHokb2AclHdkU4xf+Bm
 h0NwOqCwffPFritm9i7Oq1hiHp55OKHXGFtiOm8VxevGEKWQMwBXpkLbaagyZlVHHJ2jS6pYr
 ybVdGArdFvCYUKbEjXGzdeTNnjRkeN6mX8Cs7auoU630BGxPLUwXEhNvm1xKXJaVKuq/gR+nr
 0YBu9BjlYWNiYF0XCWMk456FyGAW/nneLmBrk4y6bS3CkBKT4Z8ekCQM9MxlDUP2gaHQ+Vwh/
 NGjzqqy8OrRb8AM14Hwaa8ss++haf4NQPrv1Z3eYgB3Xh2qdIqTRSHXV4ZxELmew2XGydyYjd
 EoIOqZHaoz9SidiMtygVuhMLt9q1glWftiq6Op0WXY42K3GvVTsyt1J0vsiJT77uYBHrAQa5P
 M5jYkDZh4zMU9DCSRgT0dZBajzBa6OcejB7QdlAW0mRadqGGMMtPjZvqnao4F3E4HAs+lgDht
 vfhcDMRL3guDff8YQxMHx/RFE9BfGdY6Nq2ASZ/v/zoIosBgOXXO3YaKuLbpag877rLGD+W3D
 EnIlltXzTCt2IvOMgRCK91VHuzMkJd4jD0//GQRusS8J4F3cNhUOFSvJDvWHwDYeD6gal3Tz9
 sRp5IYc49qWmUlu6kBqJ93alyKTbEKKxrPVIqafw+VLC4DQ/1UtpmAWrAOsWRqXCMPZMN8EWy
 CVl65/9ChRFx5Vq2GiMpQ/Ee9spSJrCWLdYk3snDqNT0Ugreg+CZc+xutqWNtylYKBaA+tyhS
 YCDYzKN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 2 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 03:04:15AM +0100, Johannes Schindelin wrote:
> 
> > diff --git a/cache.h b/cache.h
> > index 80b6372cf76..a104b76c02e 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -518,6 +518,7 @@ extern void set_git_work_tree(const char *tree);
> >  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
> >  
> >  extern void setup_work_tree(void);
> > +extern const char *discover_git_directory(struct strbuf *gitdir);
> 
> Perhaps it's worth adding a short docstring describing the function.

Okay.

> > +const char *discover_git_directory(struct strbuf *gitdir)
> > +{
> > +	struct strbuf dir = STRBUF_INIT;
> > +	int len;
> 
> Nit: please use size_t for storing strbuf lengths.

Okay.

> > +	if (strbuf_getcwd(&dir))
> > +		return NULL;
> > +
> > +	len = dir.len;
> > +	if (discover_git_directory_1(&dir, gitdir) < 0) {
> > +		strbuf_release(&dir);
> > +		return NULL;
> > +	}
> > +
> > +	if (dir.len < len && !is_absolute_path(gitdir->buf)) {
> > +		strbuf_addch(&dir, '/');
> > +		strbuf_insert(gitdir, 0, dir.buf, dir.len);
> > +	}
> > +	strbuf_release(&dir);
> 
> I was confused by two things here.
> 
> One is that because I was wondering whether "gitdir" was supposed to be
> passed empty or not, it wasn't clear that this insert is doing the right
> thing.  If there _is_ something in it, then discover_git_directory_1()
> would just append to it, which makes sense. But then this insert blindly
> sticks the absolute-path bit at the front of the string, leaving
> whatever was originally there spliced into the middle of the path.
> Doing:
> 
>   size_t base = gitdir->len;
>   ...
>   strbuf_insert(gitdir, base, dir.buf, dir.len);
> 
> would solve that.

And of course the is_absolute_path() call also needs to offset `gitdir->buf
+ base`.

> It's probably not that likely for somebody to do:
> 
>   strbuf_addstr(&buf, "my git dir is ");
>   discover_git_directory(&buf);
> 
> but since it's not much effort, it might be worth making it work.

Plus, I have no assert()s in place to ensure any expectation to the
contrary. So I fixed it as you suggested.

> The second is that I don't quite understand why we only make the result
> absolute when we walked upwards. In git.git, the result of the function
> in various directories is:
> 
>   - ".git", when we're at the root of the worktree
>   - "/home/peff/git/.git, when we're in "t/"
>   - "." when we're already in ".git"
>   - "/home/peff/git/.git/." when we're in ".git/objects"
> > I'm not sure if some of those cases are not behaving as intended, or
> there's some reason for the differences that I don't quite understand.

Yes, some of those cases do not behave as intended: it is true that
setup_git_directory() sets git_dir to "/home/peff/git/.git" when we
(actually, you, given that my home directory is different) are in "t/",
but setup_git_directory_gently_1() would set gitdir to ".git" and dir to
"/home/peff/git". But the current directory is still what cwd says it is:
"/home/peff/git/t".

I added a comment:

        /*
         * The returned gitdir is relative to dir, and if dir does not reflect
         * the current working directory, we simply make the gitdir
         * absolute.
         */

And thanks: you reminded me of another issue I wanted to address but
forgot: if gitdir is ".", I do not want the resulting absolute path to
have a trailing "/.". I fixed that, too.

Ciao,
Dscho

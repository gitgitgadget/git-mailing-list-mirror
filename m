Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567AD1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbeKMWaT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 17:30:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:51371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732923AbeKMWaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 17:30:19 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeQ43-1g7vWp1VKJ-00QBeK; Tue, 13
 Nov 2018 13:32:00 +0100
Date:   Tue, 13 Nov 2018 13:31:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 1/2] refs: show --exclude failure with
 --branches/tags/remotes=glob
In-Reply-To: <xmqqd0r9wm49.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811131157060.39@tvgsbejvaqbjf.bet>
References: <20181112132545.31092-1-rafa.almas@gmail.com>        <20181112132545.31092-2-rafa.almas@gmail.com> <xmqqd0r9wm49.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1109098002-1542112320=:39"
X-Provags-ID: V03:K1:CKVTH6+9NrqqmjOKgFKi3i2+BECYuh2CtMBFTamyq35+83EGaHa
 1iT8kpNsn4F/w6etqm7VlzGMX1EvIf0zRlzchxafIuu6ussj1SZHC6MJqU+55QWvluGkHz3
 QfK3QOCudd5qqSRe9PhxQmBoFO7oQxgd5KUU/cLwdjpDJNBj0SPj4a1NzpsoF8luuOgqAxf
 mTzACLBYPB7bQpkty/qRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f7Hp4sfMJNg=:FCge7Sr2CAtGPJ6S5WN6ER
 xSvLAQVPaikdgcY5XFhhzKQUtfe0WJhH7x+//NmSF3WvFP5AA4hSoJYL5JpoXN7Qsroj6rPz3
 /6cTzW3XwvHsNioE/rEHZ/hQzh7ArL2ndMjfJWFbXPVJ+tPw01Dsd14G2p69VdqhR4t9Z5PTh
 kqyGhmIgpRUcHjnGC39C4gERYOBa7sjL5DgnbtHJz8EK69DP8JdhtZvvisTPQZ3CXHIQeXn/o
 L2ta8sz0b+G7RN3l1l52nVNHoObR+wexQDHrBA2L1kA1GkuACGbgGeh7mtBuXAz7X5XW+mk+1
 lQf5KxP/uQP+4sy11saUo0elN30K4qDpzumDHB0a4dKO/DZJlAvMAwm5qJ0aaBI7xq+LhbmTn
 iig43d45XLOobXzrtjZiF2UNwEAIOFPwkcTWQUvWvLP9dedG/Guy86zQsFcWAo9Nnj8iYQl8b
 aCQqpSQdBE0AygCh80jU7al7AzCq/RgK3dH2dj0Fgyp+HuBtImcNnOXHGiGj/gv7uATBdU09W
 c9pRHxCA0c/fK4RURYMNGUMaHjBYKbHVu2B6VP5mbK9e2Nwx3V8/Wml/V/hgmdkaIt+k1P2DI
 VB8dB1tkHHzg7xo58QLt+WqIWIl1VTsotEm3rW3WMu9g1eYvXS9frNaQ5ekpQT19mhUVJrOYo
 bXPGLiKujRbp1ruI0IHwpWuywggZn+f2yP3v1WQj013zRgq+zA8Syrr+JiyjxUs3RZMNWS+ji
 XDv9jB1kWtICophJES5bihUlccg079hflP0etydTLeNHrI44FkaPPXUUtsCHzFWSmRjZ9fA1W
 2CUEFmJIwycjtQxko/NkMd2+fPbyiUjivcvQv56bU3V2uHyqjv6vhb4M5o9qeEzxepPZw5xrL
 lvb/1Cv/YxKSu0MknM7TufaKxAor3eM6D9R6hen7HGXUdE2ycXVaTUL2Jf6xPm2gweApcecpb
 dGyao0G+nbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1109098002-1542112320=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Junio,

On Tue, 13 Nov 2018, Junio C Hamano wrote:

> Rafael Ascensão <rafa.almas@gmail.com> writes:
> 
> > The documentation of `--exclude=` option from rev-list and rev-parse
> > explicitly states that exclude patterns *should not* start with 'refs/'
> > when used with `--branches`, `--tags` or `--remotes`.
> >
> > However, following this advice results in refereces not being excluded
> > if the next `--branches`, `--tags`, `--remotes` use the optional
> > inclusive glob.
> >
> > Demonstrate this failure.
> >
> > Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
> > ---
> >  t/t6018-rev-list-glob.sh | 60 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 57 insertions(+), 3 deletions(-)
> 
> For a trivially small change/fix like this (i.e. the real fix in 2/2
> is just 4 lines), it is OK and even preferrable to make 1+2 a single
> step, as applying t/ part only to try to see the breakage (or
> "am"ing everything and then "diff | apply -R" the part outside t/
> for the same purpose) is easy enough.

I wish you were not so adamant about this. I really consider it poor style
to smoosh those together, and there is nothing easy about disentangling
changes that have been thrown into the same commit. Please stop saying
that this is easy. It is as easy as maintaining Linux kernel development
using .tar files and patches. It is possible, yes, and Linus Torvalds did
it for years. It is also error-prone and the entire reason we have Git.
And nobody wants to go back anymore to .tar files and patches. Likewise, I
do not want to read anybody recommending some semi-understandable
diff|apply-R dance when the alternative would be a simple cherry-pick. I
do not even want to read such a recommendation from you. I respect you a
lot for what you do, and for your knowledge, but this is simply bad advice
and I would wish you stopped giving it.

Besides, we spent a decade trying to come up with clear-cut rules how to
organize commits, and we ended up pretty quickly with recommending
logically-separate changes belonging to separate commits. A typo fix
should not be thrown in with a regression fix, they are two different
things. Likewise, demonstrating a bug is a different thing from fixing it.

If you need more arguments to make the case, here is another one: it is
reflecting the reality a lot better if the regression test comes first,
and then the fix. This is how Rafael did it, too, according to what he
said on IRC. And reflecting this in the commit history is a good thing,
not a bad thing.

It goes further: obviously, Rafael had really good success with this
strategy, even figuring out part of the bug while trying to write the
regression test.

I, myself wrote a regression test yesterday that completely
short-circuited the bug hunt: originally, I thought the left-over
MERGE_HEAD files in the rebase -r stemmed from mere conflicts during a
`merge` command, and somehow `git commit` not cleaning it properly. But
when I wrote that regression test and ran it, it failed to show a
regression. So then I took my (rather lengthy: >200 todo commands)
real-world example, and condensed it into the regression test that you saw
yesterday. I would estimate that this saved me about 1-3 hours of
debugging in vain.

So it is a very, very good idea to start with the regression test, and
only then analyze the bug.

Reading the commit history this way makes therefore not only sense, but
also sets a good example for new contributors to follow.

For these reasons, and many more, I implore you to stop suggesting to
conflate the demonstration of a bug with the fix.

Instead, we should be happy to see good practices in action and encourage
more of the same.

Thank you,
Dscho


> Often the patch 2 with your method ends up showing only the test
> set-up part in the context by changing _failure to _success, without
> showing what end-user visible breakage the step fixed, which usually
> comes near the end of the added test piece.  For this particular
> test, s/_failure/_success/ shows everything in the verification
> phase, but the entire set-up for these tests cannot be seen while
> reviewing 2/2.  Unlike that, a single patch that gives tests that
> ought to succeed would not force the readers to switch between
> patches 1 and 2 while reading the fix.
> 
> Of course, the above would not apply for a more involved case where
> the actual fix to the code needs to span multiple patches.
> 
> > diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
> > index 0bf10d0686..8e2b136356 100755
> > --- a/t/t6018-rev-list-glob.sh
> > +++ b/t/t6018-rev-list-glob.sh
> > @@ -36,7 +36,13 @@ test_expect_success 'setup' '
> >  	git tag foo/bar master &&
> >  	commit master3 &&
> >  	git update-ref refs/remotes/foo/baz master &&
> > -	commit master4
> > +	commit master4 &&
> > +	git update-ref refs/remotes/upstream/one subspace/one &&
> > +	git update-ref refs/remotes/upstream/two subspace/two &&
> > +	git update-ref refs/remotes/upstream/x subspace-x &&
> > +	git tag qux/one subspace/one &&
> > +	git tag qux/two subspace/two &&
> > +	git tag qux/x subspace-x
> >  '
> 
> Let me follow along.
> 
> We add three remote-tracking looking branches for 'upstream', and
> three tags under refs/tags/qux/.
> 
> 
> > +test_expect_failure 'rev-parse --exclude=glob with --branches=glob' '
> > +	compare rev-parse "--exclude=subspace-* --branches=sub*" "subspace/one subspace/two"
> > +'
> 
> We want to list all branches that begin with "sub", but we do not
> want ones that begin with "subspace-".  subspace/{one,two} should
> pass that criteria, while subspace-x, other/three, someref, and
> master should not.  Makes sense.
> 
> > +
> > +test_expect_failure 'rev-parse --exclude=glob with --tags=glob' '
> > +	compare rev-parse "--exclude=qux/? --tags=qux/*" "qux/one qux/two"
> > +'
> 
> We want all tags that begin with "qux/" but we do not want qux/
> followed by just a single letter.  qux/{one,two} are in, qux/x is
> out.  Makes sense.
> 
> > +test_expect_failure 'rev-parse --exclude=glob with --remotes=glob' '
> > +	compare rev-parse "--exclude=upstream/? --remotes=upstream/*" "upstream/one upstream/two"
> > +'
> 
> Similarly for refs/remotes/upstream/ hierarchy.
> 
> > +test_expect_failure 'rev-parse --exclude=ref with --branches=glob' '
> > +	compare rev-parse "--exclude=subspace-x --branches=sub*" "subspace/one subspace/two
> > +'
> 
> This is almost a repeat of the first new one.  As subspace-* in
> branches only match subspace-x, this should give the same result as
> that one.
> 
> > +test_expect_failure 'rev-parse --exclude=ref with --tags=glob' '
> > +	compare rev-parse "--exclude=qux/x --tags=qux/*" "qux/one qux/two"
> > +'
> 
> Likewise.
> 
> > +test_expect_failure 'rev-parse --exclude=ref with --remotes=glob' '
> > +	compare rev-parse "--exclude=upstream/x --remotes=upstream/*" "upstream/one upstream/two"
> > +'
> 
> Likewise.
> 
> > +test_expect_failure 'rev-list --exclude=glob with --branches=glob' '
> > +	compare rev-list "--exclude=subspace-* --branches=sub*" "subspace/one subspace/two"
> > +'
> 
> And then the same pattern continues with rev-list.
> 
> > +test_expect_failure 'rev-list --exclude=glob with --tags=glob' '
> > +	compare rev-list "--exclude=qux/? --tags=qux/*" "qux/one qux/two"
> > +'
> > +
> > +test_expect_failure 'rev-list --exclude=glob with --remotes=glob' '
> > +	compare rev-list "--exclude=upstream/? --remotes=upstream/*" "upstream/one upstream/two"
> > +'
> > +
> > +test_expect_failure 'rev-list --exclude=ref with --branches=glob' '
> > +	compare rev-list "--exclude=subspace-x --branches=sub*" "subspace/one subspace/two"
> > +'
> > +
> > +test_expect_failure 'rev-list --exclude=ref with --tags=glob' '
> > +	compare rev-list "--exclude=qux/x --tags=qux/*" "qux/one qux/two"
> > +'
> > +
> > +test_expect_failure 'rev-list --exclude=ref with --remotes=glob' '
> > +	compare rev-list "--exclude=upstream/x --remotes=upstream/*" "upstream/one upstream/two"
> > +'
> > +
> 
> With the ordering of these tests, it is fairly clear that you are
> exhaustively testing all the combinations 
> 	
> for command in rev-parse rev-list:
> 	for exclude in glob ref:
> 		for specifc in glob ref:
> 			for kind in branches tags remotes:
> 				compare $command exclude=$exclude --$kind=$specific
> 
> which is very good.  No, I am not suggesting to write a shell loop
> to drive these tests; I am saying that the list of tests are in the
> same order as such a nested loop would invoke compare, which makes
> it predictable for the readers who pay attention, and it is a good
> thing.
> 
> 
> >  test_expect_success 'rev-list --glob=refs/heads/subspace/*' '
> >  
> >  	compare rev-list "subspace/one subspace/two" "--glob=refs/heads/subspace/*"
> > @@ -233,7 +287,7 @@ test_expect_success 'rev-list --tags=foo' '
> >  
> >  test_expect_success 'rev-list --tags' '
> >  
> > -	compare rev-list "foo/bar" "--tags"
> > +	compare rev-list "foo/bar qux/x qux/two qux/one" "--tags"
> 
> Of course, you'd need to compensate for new stuff here ...
> 
> >  
> >  '
> >  
> > @@ -292,7 +346,7 @@ test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
> >  	  "master other/three someref subspace-x subspace/one subspace/two" \
> >  	  "--glob=heads/*" &&
> >  	compare shortlog foo/bar --tags=foo &&
> > -	compare shortlog foo/bar --tags &&
> > +	compare shortlog "foo/bar qux/one qux/two qux/x" --tags &&
> 
> ... and here.
> 
> >  	compare shortlog foo/baz --remotes=foo
> 
> All makes sense.  Will queue.
> 
> 
--8323328-1109098002-1542112320=:39--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF041F424
	for <e@80x24.org>; Fri, 30 Mar 2018 10:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeC3KU2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 06:20:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:34589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbeC3KU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 06:20:27 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWTfu-1f3cD63pJi-00XaMS; Fri, 30
 Mar 2018 12:20:23 +0200
Date:   Fri, 30 Mar 2018 12:20:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Luciano Joublanc <ljoublanc@dinogroup.eu>, git@vger.kernel.org
Subject: Re: Bad refspec messes up bundle.
In-Reply-To: <xmqq370wvugk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803301102430.5026@qfpub.tvgsbejvaqbjf.bet>
References: <CAO+-ZX_-COVpzqoAZLRGu4mvLMkLYiR3y7rkCtwmnvJ8kA7txQ@mail.gmail.com> <xmqq370wvugk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:G6PzoWyS/cXk650gqDquG9Y4ek6Bv2jB+y3c8jQmKo0lVf2NHOz
 BdXSGIQTBtQkk+K2zgwFMHJNZdX30ibJASbEVzTqxZ2s75nrOH7+/AyhsQOeLdKYfEAAEF4
 303TQWbeQUVtR+bAiN/inJcQKpM9oMx267JO8kutLFWucSkOC4ubpgb99aLS6hfB4WY8fvn
 QPVUNeC9IAFe9OLUgIpbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gkyvuqwm6E4=:GJfmDn/XqMrqlDvgARdqRg
 Vdenj9RdJg3ilufuRSmSoUAzXtcMYLyuMGlf5O861O0k8xnkzx/ia+uPkPxat8U0iXtf4qKWz
 AX8d5I/fwEB62+u6UwsmezYTRvnGpunqntRpiO3tYTOeF15TivIfYZa4zoCCAwyedssSg9Z1m
 CD8hWEE1JW3r0n2k2OtE5Pcnnk6nDlltYVdracT/nQZjihMw/t5Hl6jSchvxas3GYROPN3+Zt
 UArOELEqfr5wiTCMjGD5G759jRlgqudAhnrwiLiwCnzzpW0C4EjnqcH4QsOsIgwSMWpKK8joL
 B9vcbUQEWaEXvfREjF8zatXM8TMM7tKC27autTvf6T9cXBEJt0H0NCtmcWPCGzhRUlrvv0SJL
 4+LVDzzIGgJv32WgKFc5Ien0w4q/8q/TWp292jN/8ivE25NFqQzphldSOdZ6YgvtWiMUgF5dY
 2Bf3de+B2TykGGqV4V2ncd9x3wsI2xbWrsAexVAR+RwIwFCGvnhVf4Ka8a59qLv4Rl77miPb+
 ZG+l3qZLMtCcNEoA9sXFFiEJtFuCwX76R43Wfgx8LR/VSCdkbWH/LnVWgbcnXm3nYe2sUIHdH
 M0WeOKa5dcc4DOJvaSvqsAMEFG3YYT+lJxvp8olcoW2LwaA8Tsb7AXSM0Uk3M8J246Rkl57AV
 vxk7ZIeX+CzhlrDkxk4eTL6HjCShMy15hm8sCXwBBZ3fp6SOepSC43DORXNI+x7/3GV1/3eMu
 QBWxCH4FVs72WuY6Tei6poo43+Fsmq0VkJy8VgxI3Sw86jiavTUe5Zn8u6qrul1vA1kUnSmfR
 Fo83wRC7ZVhcSxhhda0pGe7Rq1NSyogFITjoHdaCWhI97j68GsLlJdUk00xWJnj1gOpfVqr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luciano,

On Mon, 19 Mar 2018, Junio C Hamano wrote:

> Luciano Joublanc <ljoublanc@dinogroup.eu> writes:
> 
> > Yesterday I created a git bundle as best as I can remember like this
> >
> > git bundle save chunk chunk.bundle --all master
> >
> > Note the 'master' I added accidentally at the end - this was a user
> > error but still the bundle was created.
> >
> > When I tried to clone this, I get
> >
> > ~\local\src> git clone 'G:\My Drive\chunk.bundle' fs2-columns
> > Cloning into 'fs2-columns'...
> > Receiving objects: 100% (31/31), done.
> > Resolving deltas: 100% (5/5), done.
> > fatal: multiple updates for ref 'refs/remotes/origin/master' not allowed.
> > ~\local\src> git bundle verify chunk.bundle
> > The bundle contains these 3 refs:
> > 3c804437a5f8537db1bfb5d09b7bff4f9950605e refs/heads/master
> > 3c804437a5f8537db1bfb5d09b7bff4f9950605e HEAD
> > 3c804437a5f8537db1bfb5d09b7bff4f9950605e refs/heads/master
> > The bundle records a complete history.
> > chunk.bundle is okay
> >
> > After trying a couple of things, I finally managed to clone it using
> >
> > ~\local\src> git clone -b master --single-branch .\chunk.bundle fs2-columns
> >
> > i.e. the '--single-branch' option saved me.
> >
> > Is this a bug? Should bundle allow providing multiple refspecs when
> > `--all` is provided? I admit this was clearly a case of 'caveat
> > emptor', but shouldn't this be disallowed (i.e. is there any situation
> > when this is useful?)
> 
> Thanks for a report.
> 
> Just like a remote repository that reports the same ref more than
> once in its initial advertisement (i.e. "git ls-remote $remote"
> gives duplicate entries), a bundle file that records the same ref
> more than once *is* a bug, I would think.
> 
> A "git bundle create" command that creates such a bundle file
> shouldn't.  It is not very useful to diagnose it as an error; it
> probably makes more sense to dedup the refs instead when writing the
> bundle file.  Of course, we should abort with an error *if* the code
> ever tries to store the same ref twice with different object name
> (i.e. attempt to dedup, in vain).
> 
> Also, "git clone" from such a bundle file (or for that matter, a
> remote repository that advertises the same ref twice) probably
> should do a similar deduping, with a warning message.

I agree that it is a bug if a bundle file records a ref multiple times.
Luciano, here are some pointers so you can fix it:

- probably the best way to start would be to add a new test case to
  t/t5607-clone-bundle.sh. The script *should* be relatively easy to
  understand and imitate. The new test case would probably look somewhat
  like this:

	test_expect_failure 'bundles must not contain multiple refs' '
		git bundle create all.bundle --all master &&
		grep master all.bundle >master.lines &&
		test_line_count = 1 master.lines
	'

- then, ensure that this test passes and reports this correctly as a known
  breakage.

- now it is time to fix the actual bug. The code in question is the
  write_bundle_refs() function in bundle.c (careful, there are two files
  of that name in Git's source code, one in the builtin/ subdirectory, the
  other one in the toplevel directory, you will want to look at the
  latter one).

- notice that there is already a construct in the loop over the pending
  refs where some are skipped:

		if (e->item->flags & UNINTERESTING)
			continue;

  The "uninteresting" refs would be those on the excluded end of a commit
  range, e.g. if you called `git bundle create x.bundle master..next`, the
  `master` ref would be such an "uninteresting" ref.

- one might be tempted to introduce another flag and set it once a ref was
  shown and skip a ref for which that flag is set. And indeed, this was my
  own first thought!

  However, this would be incorrect, as the flags are stored with the
  *commit*, not with the ref. So if two refs point to the same commit,
  that new code would skip the second one by mistake!

  By the way, this makes me think that there is another very real bug in
  the bundle code, in the part I showed above. Suppose you have a `master`
  and a `next` ref, and both point at the same commit, then you would want
  `git bundle create next.bundle master..next` to list `next`, don't you
  think? This one would be a lot harder to fix, though, as the
  setup_revisions() function really only sets the flag on the respective
  commits because it wants to set things up for revision walking, not
  necessarily to list "interesting" refs. A possible solution might be to
  abuse the `mode` field in the object_array (which is the type of the
  `pending` field in the `rev_info` struct where the parsed command-line
  parameters are held, when that `mode` makes only sense for blobs and
  we store refs pointing to commits or tags).

  That's a side-track, though.

- most likely, the best way to avoid duplicate refs entries is to use the
  actual ref name and put it into a hash set. Luckily, we do have code
  for this, and examples how to use it, too. See e.g. fc65b00da7e
  (merge-recursive: change current file dir string_lists to hashmap,
  2017-09-07). So you would define something like

	struct ref_name_entry {
		struct hashmap_entry e; /* must be first field */
		char ref_name[FLEX_ARRAY];
	}

  and implement the cmp function similar to the path_hashmap_cmp() in
  merge-recursive.c, then initialize a hashset in write_bundle_refs(),
  add handled ref names via

	FLEX_ALLOC_STR(entry, ref_name, e->name);
	hashmap_entry_init(entry, strhash(e->name));
	hashmap_add(&shown_refs, entry);

  and look up whether a ref should be skipped via

	if (hashmap_get_from_hash(&shown_refs, strhash(e->name), e->name))
		continue;

  Oh, and before returning from write_bundle_refs(), the hashset
  (including its entries) should be released via

	hashmap_free(&shown_refs, 1);


These hints should get you started on this project.

Looking forward to your contribution,
Johannes

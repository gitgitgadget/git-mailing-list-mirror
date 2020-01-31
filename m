Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D40C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9EB20CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KfaWk8W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAaVXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:23:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:35573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgAaVXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580505815;
        bh=R/gQPSJXjk7+i7KcIVMobHphITYr035E7zk3jxsqRes=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KfaWk8W3Lh+pTp1QtwxT4fJdRaN/hcKxEtubIMWuvlxUYOginXDUhte8DF0iF9Gxr
         N0n6EQOItMswqT6OTdMG/iIJ9mqv0JGZrMHGT1FtlHs04Cq2fxaXV9JZqYSXRFxYTG
         k6f3L+y8XiS+7FL2YldcoqxcyTjWrLohCN5oNQmc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1iuaxG038X-0083IC; Fri, 31
 Jan 2020 22:23:35 +0100
Date:   Fri, 31 Jan 2020 22:23:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: Comparing rebase --am with --interactive via p3400
In-Reply-To: <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001312216410.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet> <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1058022757-1580505813=:46"
X-Provags-ID: V03:K1:ZNluu1LTZEzU0iwZSdpZOVDlLxerbvklY/dOKQIhDrws6+1mPVw
 tOX6x51HZRGrBnYiCifwnX9rn6+eCrZbIGOQtW8HwqpjjK2XBYH+B7cu7tUuzGMJqoMuHx+
 wOcMVt9UJfwiqcxAfU8N38kEq9+dsWr3lCVfWA+mR2UCRJZ429gjqO/1XfFlKvXw028YuV5
 DySEM6hl+8biaOWhXeyhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YvOBFu8xEFA=:Io99IDNbO8Ug0RhxuNlima
 V44dkTaNazVKBtDJvD8aoONctYvSoOH7UlFrJ4c/JqwQgfg/CZWL7oiQvuczy8nbftZ5rF93J
 amBwwujjYWCtfQujL9/wsZaDPKWCKovQNcz4xoRCWsTfWJ0btUGZqxyBULyaiwdOg/mJ1f5lm
 GjxnPJSDMyXP8Q3i/H1ULrRILT7VypbK59WeR2/YGJZ3/cYmWcggZO/Aac9kZnR1zxNa6jdh9
 bWyIMrqkRzKFaN9I/WLZ8WuG40y5L0BbFvk0TDs5jDAwME+pEt3VvxMZWSD1jMlzVzzb2daTG
 qSlw5/L5pM06MrBSWioDOQHUT/ZnXSIvXNf2Br4dbnyuvI/fC7A0YptSbBoOYpteGjrIhMJ/r
 rAt/LcasRs1Y09bcU+r9TCJDpgHYryDxbhVuHPHms9CmC8dK/yv13S5wjOSz9U19Mb1jO3TTl
 mypVZE2hpzbNLGdcahNGSiw72Zc74YZwslTDAakc9JAaKDapeUQEh1yjrzjIO3qyfg8dNoI7r
 FeqZKHaapzVZe+2y65A5W+FoEzsBO9AWwDECSlLDcE6Bcsz435PuG8a37LFgeflZPQRvDFzgD
 0C6xic63QqslSBijEMEm11y7QoAqIb8tkLRFsTALUPXXfr6Kv0F6Iyp7PLihsSlLJQWoTa2wL
 Ol3BiXPscUCAW7XBg9wlI99OexrN4ddNMNIi2cvw7FLhJmj3riEE00gfGaiUkebO1cv4pKnzM
 eRPGyy648KOkc64KHG1dAV2wL44F1CRR9r7FAfs/R2MWJXKeSkz28h+jy/soiQQ32dvLFMFVn
 5gbume+U/puKYPmUAIAmtEDcDdPjmLXiAV0M8r5EAJhSz+U/Sj9yEOaaiVQTkRGAZVnmLoLSg
 bAJTp1HqLO6yGhppj5Tc6LliNSYFhll9FtWCLHTdsejGlgoLqSC37LKPEq3Zx9VnWStYBajTY
 XqNvfzVw6UEJH6D0u9B8UjsjgvelFRVzWJpfqf9yisxIh79MUVjHQYcrQOXcZ2mGXLZ5U6OUY
 /hOk3PsSd+ttVsPrgzd2Xb2loxE2NwLoYlIe6sLmp3WR8yhRLNaOM1uAeQ9kD0JmSZPBRdFod
 91bmdJj/tpZaevsu4YVwhi5py0XDAaSYePTcBI+7ouvA17yhf63YoVp6TsUaUN43a48aTLl/Y
 fH8Hu1ZTO5mBQs6a2q57V+Fb2jE1BjMH/RBZPtFdGSKEmh4wOmaJHmF56/gJX6KUHS2k0xLTW
 PpZJkVS+LNcetxxHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1058022757-1580505813=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alban,

On Fri, 27 Dec 2019, Alban Gruin wrote:

> Le 01/02/2019 =C3=A0 07:04, Johannes Schindelin a =C3=A9crit=C2=A0:
>
> > as discussed at the Contributors' Summit, I ran p3400 as-is (i.e. with=
 the
> > --am backend) and then with --keep-empty to force the interactive back=
end
> > to be used. Here are the best of 10, on my relatively powerful Windows=
 10
> > laptop, with current `master`.
> >
> > With regular rebase --am:
> >
> > 3400.2: rebase on top of a lot of unrelated changes             5.32(0=
.06+0.15)
> > 3400.4: rebase a lot of unrelated changes without split-index   33.08(=
0.04+0.18)
> > 3400.6: rebase a lot of unrelated changes with split-index      30.29(=
0.03+0.18)
> >
> > with --keep-empty to force the interactive backend:
> >
> > 3400.2: rebase on top of a lot of unrelated changes             3.92(0=
.03+0.18)
> > 3400.4: rebase a lot of unrelated changes without split-index   33.92(=
0.03+0.22)
> > 3400.6: rebase a lot of unrelated changes with split-index      38.82(=
0.03+0.16)
> >
> > I then changed it to -m to test the current scripted version, trying t=
o
> > let it run overnight, but my laptop eventually went to sleep and the t=
ests
> > were not even done. I'll let them continue and report back.
> >
> > My conclusion after seeing these numbers is: the interactive rebase is
> > really close to the performance of the --am backend. So to me, it make=
s a
> > total lot of sense to switch --merge over to it, and to make --merge t=
he
> > default. We still should investigate why the split-index performance i=
s so
> > significantly worse, though.
> >
> > Ciao,
> > Dscho
> >
>
> I investigated a bit on this.  From a quick glance at a callgrind trace,
> I can see that ce_write_entry() is called 20 601[1] times with `git am',
> but 739 802 times with the sequencer when the split-index is enabled.
>
> For reference, here are the timings, measured on my Linux machine, on a
> tmpfs, with git.git as the repo:
>
> `rebase --am':
> > 3400.2: rebase on top of a lot of unrelated changes             0.29(0=
.24+0.03)
> > 3400.4: rebase a lot of unrelated changes without split-index   6.77(6=
.51+0.22)
> > 3400.6: rebase a lot of unrelated changes with split-index      4.43(4=
.29+0.13)
> `rebase --quiet':
> > 3400.2: rebase on top of a lot of unrelated changes             0.24(0=
.21+0.02)
> > 3400.4: rebase a lot of unrelated changes without split-index   5.60(5=
.32+0.27)
> > 3400.6: rebase a lot of unrelated changes with split-index      5.67(5=
.40+0.26)
>
> This comes from two things:
>
> 1. There is not enough shared entries in the index with the sequencer.
>
> do_write_index() is called only by do_write_locked_index() with `--am',
> but is also called by write_shared_index() with the sequencer once for
> every other commit.  As the latter is only called by
> write_locked_index(), which means that too_many_not_shared_entries()
> returns true for the sequencer, but never for `--am'.
>
> Removing the call to discard_index() in do_pick_commit() (as in the
> first attached patch) solve this particular issue, but this would
> require a more thorough analysis to see if it is actually safe to do.

Indeed. I offered these insights in #git-devel (slightly edited):

This `discard_index()` is in an awfully central location. I am rather
certain that it would cause problems to just remove it.

Looking at `do_merge()`: it explicitly discards and re-reads the index if
we had to spawn a `git merge` process (which we do if a strategy other
than `recursive` was specified, or if it is an octopus merge). But I am
wary of other code paths that might not be as careful.

I see that `do_exec()` is similarly careful.

One thing I cannot fail to notice: we do not re-read a changed index
after running the `prepare-commit-msg` hook, or for that matter, any other
hook. That could even be an old regression from the conversion of the
interactive rebase to using the sequencer rather than a shell script.

Further, `reset_merge()` seems to spawn `git reset --merge` without
bothering to re-read the possibly modified index. Its callees are
`rollback_single_pick()`, `skip_single_pick()` and `sequencer_rollback()`,
none of which seem to be careful, either, about checking whether the index
was modified in the meantime.

Technically, the in-memory index should also be discarded
in `apply_autostash()`, but so far, we do not have any callers of that
function, I don't think, that wants to do anything but release resources
and exit.

The `run_git_checkout()` function discards, as intended. I
am not quite sure whether it needs to, though, unless the `.git/index`
file _was_ modified (it _is_ possible, after all, to run `git rebase -i
HEAD`, and I do have a use case for that where one of my scripts generates
a todo script, sort of a `git cherry-pick --rebase-merges`, because
`cherry-pick` does not support that mode).

The `continue_single_pick()` function spawns a `git
commit` which could potentially modify the index through a hook, but the
first call site does not care and the second one guards against that
(erroring out...).

My biggest concern is with the `run_git_commit()` function: it does not
re-read a potentially-modified index (think of hooks).

We will need to be very careful with this `discard_index()`, I think, and
in my opinion there is a great opportunity here for cleaning up a little:
rather than discarding and re-reading the in-memory index without seeing
whether the on-disk index has changed at all appears a bit wasteful to me.

This could be refactored into a function that only discards and re-reads
the index if the mtime of `.git/index` changed. That function could then
also be taught to detect when the in-memory index has unwritten changes:
that would constitute a bug.

Ciao,
Dscho

>
> After this, ce_write() is still called much more by the sequencer.
>
> Here are the results of `rebase --quiet' without discarding the index:
>
> > 3400.2: rebase on top of a lot of unrelated changes             0.23(0=
.19+0.04)
> > 3400.4: rebase a lot of unrelated changes without split-index   5.14(4=
.95+0.18)
> > 3400.6: rebase a lot of unrelated changes with split-index      5.02(4=
.87+0.15)
> The performance of the rebase is better in the two cases.
>
>
> 2. The base index is dropped by unpack_trees_start() and unpack_trees().
>
> Now, write_shared_index() is no longer called and write_locked_index()
> is less expensive than before according to callgrind.  But
> ce_write_entry() is still called 749 302 times (which is even more than
> before.)
>
> The only place where ce_write_entry() is called is in a loop in
> do_write_index().  The number of iterations is dictated by the size of
> the cache, and there is a trace2 probe dumping this value.
>
> For `--am', the value goes like this: 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4,
> 4, 4, 5, 5, 5, 5, =E2=80=A6 up until 101.
>
> For the sequencer, it goes like this: 1, 1, 3697, 3697, 3698, 3698,
> 3699, 3699, =E2=80=A6 up until 3796.
>
> The size of the cache is set in prepare_to_write_split_index().  It
> grows if a cache entry has no index (most of them should have one by
> now), or if the split index has no base index (with `--am', the split
> index always has a base.)  This comes from unpack_trees_start() -- it
> creates a new index, and unpack_trees() does not carry the base index,
> hence the size of the cache.
>
> The second attached patch (which is broken for the non-interactive
> rebase case) demonstrates what we could expect for the split-index case
> if we fix this:
>
> > 3400.2: rebase on top of a lot of unrelated changes             0.24(0=
.21+0.03)
> > 3400.4: rebase a lot of unrelated changes without split-index   5.81(5=
.62+0.17)
> > 3400.6: rebase a lot of unrelated changes with split-index      4.76(4=
.54+0.20)
> So, for everything related to the index, I think that=E2=80=99s it.
>
> [1] Numbers may vary, but they should remain in the same order of magnit=
ude.
>
> Cheers,
> Alban
>
>

--8323328-1058022757-1580505813=:46--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0099B1F462
	for <e@80x24.org>; Fri, 31 May 2019 18:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEaStQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:49:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:54899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfEaStP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 14:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559328548;
        bh=1n68jLmvF8v6W1MS7t69OlmJBH74pElQ8mcAh80cjXU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e9+9cpNlvSqVLCCulvhZOesDVaqvJMx7EGg1HZ+fpYehCDKQBzAP9ZNPUyNKwnszu
         Hw5ngTVJZaW0ojDFO5peKnGyIeyDghU1s5HabOBVDlnl8D+D95rRzTZSY/1BZVnjaH
         KXnyoNHDIsPUztKws1uslNrCz4+dlxNqvWkRk5Q0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lug8u-1gXDnw1O6K-00zjyK; Fri, 31
 May 2019 20:49:08 +0200
Date:   Fri, 31 May 2019 20:48:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
In-Reply-To: <xmqq5zpqwms1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905312032370.1775@tvgsbejvaqbjf.bet>
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet> <xmqq5zpqwms1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GiBVdcVmBKY/1af+fur7nmIlU9NfjFBpDDpcFK3MpUUimQzmhs5
 JhMbHN1X0IJ4khcTNXp9SPtZFVYhXYnwT1vygqZEPafbFw1o0KHLuQ4PJq6CGp7L9IToeab
 4YdcoS3+s/JKV2+fh8xEADXHXWiRAVl35Mx2cCd3o+qhGxHGE896cK8K5P6E7kzvh6ucadg
 L1QUeHL732BBYInttQWrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8rqQrG0tsSc=:3Pa/Xa8jewMIyML8kDnjHi
 5s2Myb+eTPX9Iw7tB+nhJ+y63MhZsFy4vpy0gNcedHpZ8LedxAtTAk1P+B4L7fWD/j7Z5ALBQ
 Yb4/d/5do8YZHKfsyI524hKa2qPTvSF2MvAhu6ozG01vdoSumXtO/MLI6XzK4tFi7/xgSTTNG
 Lhfn6abOrMK00CKqBcihPLputko1NbpNKwoRkHuBmWAswpgGFwSeF5dCOuYkVisCrfu001Wto
 Y/jYIgjTxstZU98PqgZQd4mIGbNfq8If1uGyi6YG9mwf6pYfBOBhp+RllBXfcHdv92zN2Wa0z
 ldjuZIGJ6T/+V3JEi1x4vArstpTaEa6jYntimOoO9Be9uLzo6O0INlo3eBrxhnOpCJnbRqkId
 p38oOPja/BD5yfvmNOEuePSYWGndANQwBnS9Wz/A5qNaz87MrHjcJZBII1VoTgcObqYxI087y
 YJLgKGkd860xLBHYbw8sZCLww0XYAKxRluRvtH0IpRzZNz+I+ZkxqdLQXErq6f4+0/C0RmgpV
 pAS63UrqtjMDsgoVSRxTVtau2viyTj0iwLafogA3mURKwOEBiiEE4BWBroKftiTmCYSncQcJl
 /neW+LYKbwLnppy4NBq/96WlkNwpexKb+NHSLcNSjaF1VDHvfmCBhwpMXqE1IJlI44CJqZzoM
 rJ9Cgv8gt9R3cH7J7k6oO3jcIJOzVqIzJzEDRPURuYmpfGDgCpe/3UIdAXH9CFP/LYOzhaeDw
 wdyJLXTkfYypfumt7ax7nhyyvDqj7SjGQw5QDsALvpt2Du8hB72cQyRorsrxVmiUC42+7nkC2
 uAXCUb0KTekYdC9UE7M2FvQbUi2F1OISk5GjTXluomybuWaTfBm8KNqln4jh5pQZSIvPXWHyc
 S6CyI89xToYE2Z2sjCN/I+rrIOjUHazRNvTHwp0dobeccONcjduJkYB5I6VEP0pOjoQyojOmP
 xMX6vk9twB6MKbkLSMyqJ1XQtiJVEqSoxCAoPQLr4L20nqyeOPHS0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 31 May 2019, Junio C Hamano wrote:

> [...] as I said in "What's cooking" report one issue ago, the criteria
> is no longer "this is obviously correct"---it is "this is obvious and
> trivial fix for a regression".

I heard that, just wanted to give you my stance ;-)

In Git for Windows, I am not *quite* as conservative, but then, I do not
have to deal with the onslaught of a gazillion patch series, either.

And of course, Git for Windows caters to *Windows* users, which does
change the perspective quite a bit: file locking issues are no longer just
a nuisance, scripts are too slow to be called production-ready,
repositories tend to be ridiculously large (a lot larger than regular open
source repositories, for sure), etc.

So for example, I did fast-track the experimental built-in `git add -i`,
even if it was tested only by me, and for less than two months: the
benefit is just too great to pass up.

So yeah, I run Git for Windows in a different way than you run Git, and I
think both ways have their merits.

> [...]
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Thu, 30 May 2019, Junio C Hamano wrote:
> >
> >> * po/git-help-on-git-itself (2019-05-16) 2 commits
> >>  - Doc: git.txt: remove backticks from link and add git-scm.com/docs
> >>  - git.c: show usage for accessing the git(1) help page
> >>
> >>  "git help git" was hard to discover (well, at least for some
> >>  people).
> >>
> >>  Will merge to 'next'.
> >
> > I guess it would not hurt anybody (and get a bit more exposure) if it =
was
> > merged before v2.22.0, but it does not fix a problem introduced in thi=
s
> > cycle, so...
>
> Yeah, I think you already know this but my stance towards these
> "would never hurt to merge even in -rc period" topics is to merge
> them soon after the final.

Fair enough.

> >> * ba/clone-remote-submodules (2019-05-28) 1 commit
> >>   (merged to 'next' on 2019-05-29 at 71972f94c2)
> >>  + clone: add `--remote-submodules` flag
> >>
> >>  "git clone --recurse-submodules" learned to set up the submodules
> >>  to ignore commit object names recorded in the superproject gitlink
> >>  and instead use the commits that happen to be at the tip of the
> >>  remote-tracking branches from the get-go, by passing the new
> >>  "--remote-submodules" option.
> >>
> >>  Will cook in 'next'.
> >
> > Are we really sure that this is a good option name? With that
> > description, I would have expected `--recurse-submodules=3Dfollow-tips=
`
> > or some such.
> >
> > In other words, I would have been in favor of keeping this in `pu` for
> > a little while longer. But it's already in `next`...
>
> As far as I am concerned, ones in 'next' that is not meant to be
> fast-tracked to 'master' during the -rc period are like only in `pu`.
> Soon after the final, when 'next' is rewound, any of them can be kicked
> out to give it a fresh start, and it is a good time to think and
> nominate which ones to boot and reboot, like you just did.
>
> As to your question, I do not have a strong opinion either way. Input
> from folks more invested in submodules, and especially from those who
> want to use submodules in non-traditional ways, would be most welcome.
> To me, it feels that the "ignore what gitlink entries say, and use the
> commits that happen to be pointed at by refs of a clone of the submodule
> you happen to follow" is not really a good match to the way "gitlink"
> based Git submodules are designed to be used, but that mode of the
> operation is not wrong per-se (it was just that we did not design the
> system to support well).

I am probably a terrible person to ask about submodules, as I am of the
firm opinion that friends don't let friends use submodules. And people who
suggest to their enememies to use submodules are just awful people that I
don't want to talk to, like, ever.

And it is no secret that I believe that the submodule feature was just
pushed through for no other reason than to shut up the people who wanted
to discuss a Git feature that would reflect the svn:externals (something
for which there are real scenarios out there, and they were just
steamrollered by the push for submodules).

Nevertheless, I still think that even a feature as unwise as submodules
*can* be the best solution under certain circumstances, at least for now.

And those circumstances deserve really good naming. Just like all other
Git use cases.

> >> * ds/close-object-store (2019-05-28) 3 commits
> >>  - packfile: rename close_all_packs to close_object_store
> >>  - packfile: close commit-graph in close_all_packs
> >>  - commit-graph: use raw_object_store when closing
> >>  (this branch uses ds/commit-graph-write-refactor.)
> >>
> >>  The commit-graph file is now part of the "files that the runtime
> >>  may keep open file descriptors on, all of which would need to be
> >>  closed when done with the object store", and the file descriptor to
> >>  an existing commit-graph file now is closed before "gc" finializes
> >>  a new instance to replace it.
> >>
> >>  Waiting on ds/commit-graph-write-refactor to stabilize.
> >
> > FWIW I backported this to Git for Windows, as the underlying bug would
> > prevent an auto gc from working as intended (iff the commit graph feat=
ure
> > is turned on, of course).
>
> Yes, I can see how a system that does not allow filesystem
> operations on a still-open file would need these three patches.  How
> ready is the underlying topic?  IIRC there were a few internal API
> details still to be reworked?

Well, what can I say: I cheated. I rebased these three patches to Git for
Windows' `master` *excluding* `ds/commit-graph-write-refactor`.

Because even I am conservative, at times ;-)

AFAICT even Stolee is on board with giving that refactoring effort a bit
more time.

Ciao,
Dscho

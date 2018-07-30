Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596311F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeG3RZ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:25:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:33369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeG3RZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:25:27 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MePcd-1fK6ah2C59-00QBDc; Mon, 30
 Jul 2018 17:49:40 +0200
Date:   Mon, 30 Jul 2018 17:49:36 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Akinori MUSHA <knu@iDaemons.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] fix "rebase -i --root" corrupting root commit
In-Reply-To: <1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1807301747330.10478@tvgsbejvaqbjf.bet>
References: <20180730092929.71114-1-sunshine@sunshineco.com> <1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zFeb4OK57+9a5ZqZsaALahMP9/DNbNwlETQFAk3H/AnkuWG8fSx
 wFc9lhBRq+ptC3fgTHHbfjfofwK6GE/TzJrtXSi4Km2ZOzRq6LmLLrvPXkWKrbsOR4/SBYq
 sehgj9F5KvdLYNbGQu13HFfoK2tC+/kTXC3GZXQG+RY8gBsoEec0NZ4Ncy+I6MUD0CcCIF9
 BdyAWqbOApd8TyJuQYCww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:myrapwdCWxE=:XNtfauUqrRe1s6i+G94lAi
 MydDgUpt7yGH0MWz0ugAytDdJW3rt0okIqHHv7UpkNjcwJE5XAX50NM5uVN03np2sZHlTdZJ+
 3X2SPIZQBrlGDABg8XnxHFMU8ETTHYFnvZ2AW0CvqpPdBrwVqmZliYjd2JHTUBMO0Kgrpdhpf
 wKD8Qht6B8YBVQoQuixY+9wbLm+Bo3trPXcCPR2yOA0hx83W4z7uJ8X+VkN54dK1aFXcgbL0n
 CkNhu5PT2rVC2d9z7ZK+DhGuTdKU2QbKvkpTZMXrU5RUpN99RtLIBAdVHGle90+XmFtQcD5R8
 fIK9myNL6NNosRMG1O/E55bHkAWNquNY6yeFumHZMa/MHEao13cjf9oL5ARRLxb9WPTLcStT9
 WNffx8wSGMe50ph7Y9hDhJ6I5jcmH/5EZQ+se7rUa0VWvo4i0yT2pq4EvBzPEFHHmU3YVKNem
 wWlS+4o8clYBXtoKTo1k9dWPNQ24RkIBO1kd8nqyVldofRHy8srvChSeOXEjKSCraVrRHGM+k
 SgMLVHprGDTSiehPhTYMEzlFV8WRfrT2dgykN+9aVgeQ2+ljsr3OhoQ9zHhvUNn5Q9qzQEPEh
 MB4sQdXWUKKTJ9bRqAj3oYfZjb7Zj1ooNnWsdEw01vnUcegJsDhsGhoS0zR0a6ESR5JTmvgqa
 GKPF/Iy/Y7dhJgaUFwWgWlN+IJOY7GPo6D2+ZFE8E1+cNyDFSXb/De4Bfk+o2lZ5jNwj01L6F
 mdabV31K01PNRw+yd7G0KoxbXQDTalYIQiCeV4uTg//QcNVs7w8RnIgYy8ah3oOHzexZvJn+G
 uRph8D5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 30 Jul 2018, Phillip Wood wrote:

> On 30/07/18 10:29, Eric Sunshine wrote:
> > This series fixes bugs causing corruption of the root commit when
> > "rebase -i --root" is used to swap in a new root commit. In particular,
> > the "author" header has trailing garbage. Some tools handle the
> > corruption somewhat gracefully by showing a bogus date, but others barf
> > on it (gitk, for instance). git-fsck correctly identifies the
> > corruption. I discovered this after git-rebase corrupted one of my own
> > projects.
> > 
> > Unfortunately, these bugs (from js/sequencer-and-root-commits) made it
> > into the v2.18.0 release. It's worrying that a released Git can be
> > creating corrupt commits, but fortunately "rebase -i --root" is not
> > likely used often (especially on well-established projects).
> > Nevertheless, it may be 'maint' worthy and applies cleanly there.
> > 
> > It was only after I diagnosed and fixed these bugs that I thought to
> > check 'pu' and discovered that Akinori MUSHA already made a stab[1] at
> > fixing one of the three bugs which this series fixes. Akinori's fix has
> > the somewhat undesirable property that it adds an extra blank line to
> > the end of the script, as Phillip correctly pointed out in review[2].
> > Patch 2/2 of this series has the more "correct" fix, in addition to
> > fixing another bug.
> > 
> > Moreover, patch 2/2 of this series provides a more thorough fix overall
> > than Akinori, so it may make sense to replace his patch with this
> > series, though perhaps keep the test his patch adds to augment the
> > strict test of the "author" header added by this series.
> 
> Johannes and I have some fixups for Akinori's patch on the branch
> fix-t3403-author-script-test at https://github.com/phillipwood/git
> 
> That branch also contains a fix for the bad quoting of names with "'" in
> them. I think it would be good to somehow try and combine this series
> with those patches.

I would like that, too.

> I'd really like to see a single function to read and another to write
> the author script that is shared by 'git am' and 'git rebase -i', rather
> than the two writers and three readers we have at the moment. I was
> thinking of doing that in the longer term, but given the extra bug
> you've found in read_author_script() maybe we should do that sooner
> rather than later.

You are at least the second person (after Junio) with that wish.

Please note, however, that the purpose of author-script reading/writing is
very different in git-am vs rebase -i, or at least it used to be:
read_env_script() in sequencer.c very specifically wants to construct an
env parameter for use in run_command().

Don't let me stop you from trying to consolidate the two different code
paths, though.

Ciao,
Dscho

> 
> > [1]: https://public-inbox.org/git/86a7qwpt9g.knu@iDaemons.org/
> > [2]: https://public-inbox.org/git/f5b56540-d26a-044e-5f46-1d975f889d06@talktalk.net/
> > 
> > Eric Sunshine (2):
> >   sequencer: fix "rebase -i --root" corrupting author header
> >   sequencer: fix "rebase -i --root" corrupting author header timezone
> > 
> >  sequencer.c                   |  9 +++++++--
> >  t/t3404-rebase-interactive.sh | 10 +++++++++-
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> > 
> 
> 

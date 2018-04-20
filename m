Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8AE71F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeDTIMe (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:12:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:52991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754381AbeDTIMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:12:08 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI5rO-1f8tzD1eMY-003w3w; Fri, 20
 Apr 2018 10:12:01 +0200
Date:   Fri, 20 Apr 2018 10:11:45 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] ident: don't cache default date
In-Reply-To: <65ca9629-46b1-2963-9b6b-99f12a18689d@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804201010120.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org> <20180418102236.7183-1-phillip.wood@talktalk.net> <87vacoeovh.fsf@evledraar.gmail.com> <85ecb584-77a7-f818-14c9-1019873d87f9@talktalk.net> <d4aee85d-956f-ac93-b909-6dfeb5ea8fd7@kdbg.org>
 <65ca9629-46b1-2963-9b6b-99f12a18689d@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1717360249-1524211921=:4241"
X-Provags-ID: V03:K1:ooiBmSIYMktDFu2/LaslP5cYd3I/2kaMJElb2imm1AsGbnDX7fU
 sTwfdSU3RE1P9M2nhsI76XOkUwe+2/cJkzOhKoaLz+23sI33L1o+tOca5BuDRjSxbpjtW9u
 VKuhwbP8tbYtDVLx2EZ08xI93LcM5P1AA/aX0/xzW7I8TP+g6nyP9CNtPnfNVoWyKjzZSSv
 J7YJEB1HPvxa7aaCjPXYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DfPCwCuymjk=:VgrZr5cevX8i1pQhjUBwvN
 NvPRPxjNq4jKFRywBHtKj0gz+i8W+HUxLhpDKA9GckNivczclTSMEWxQpK8XQf7NOyPrNtXsP
 4hXTDwviDkR4ycBkfwFMBjsSv3YiEzmjUBWEqXP4MuS4Qgp2czvNrWDQXdsBP3RexbXvjXE2p
 gUDhWiixX5puv0I7IqT/BRD92euqt6Q8XeeDrdUeR/5xSKe0o5DPHrCXceuakpO9m3ztupMKU
 iBzJXYt73jpZ/RDEvBIlByCDWFHwKCOZwww82NtgXRwujoZWfYApc69uJfFD2cDCK3KfXj4o7
 +JrYt4o0jjlf4AKx9Dfv4bXn84AwBMZrb5JLToZbN04wAoD3K0f/AqreqK5toMXnKaEslTKog
 Xd2ojh7hL8VJWDQ1C6BkT0MIxxidYOLUx7bC1GlBgOcNHIxq6YCRfG7SY5u0nAyQX8C7ShapE
 YuFEDMkr/pCsB6jNI7fI4xPHaZQP+McYyxR4sU/3zHgJc7RLbBT6gDYlDqXffITh8Ec949Vsm
 DDgTHC4PlPdZJrBqVqEFzp3fYqJEi7flUuI+Lo0ZvsagCGtOPQ6k6HDQJBXXIYCEGVimRAUdX
 Be6Whva6ZWgqOqFieFZ0dRyX78IzX0sblP7nh7HioeQwVREQE/W7vEReyNmA1ANlF8uyMp9DJ
 eoTi1vSdweLQOwH765JaAI04unKRyRiT8l9ERXm0fF5LseCwnwm0fi3eG6/i/1NmUpRJGKDZf
 1d80TgdjZmQrcvb5YV3s10ie/zAEGhlnq65P9UMzSYtTGN1b1Hz6N9i+jdYHCWHFN2eTeXm9O
 pLVKILEUH72eTc3IuWh4fska/VpdXSyZiGDcH1OSg8AApf3R54=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1717360249-1524211921=:4241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Phillip,

On Thu, 19 Apr 2018, Phillip Wood wrote:

> On 18/04/18 19:15, Johannes Sixt wrote:
> > Am 18.04.2018 um 19:47 schrieb Phillip Wood:
> >> On 18/04/18 12:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>> On Wed, Apr 18 2018, Phillip Wood wrote:
> >>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>>> as it is created by running an separate instance of 'git commit'.  I=
f
> >>>> the reworded commit is follow by further picks, those later commits
> >>>> will have an earlier committer date than the reworded one. This is
> >>>> caused by git caching the default date used when GIT_COMMITTER_DATE =
is
> >>>> not set. Fix this by not caching the date.
> >>>>
> >>>> Users expect commits to have the same author and committer dates whe=
n
> >>>> the don't explicitly set them. As the date is now updated each time
> >>>> git_author_info() or git_committer_info() is run it is possible to e=
nd
> >>>> up with different author and committer dates. Fix this for
> >>>> 'commit-tree', 'notes' and 'merge' by using a single date in
> >>>> commit_tree_extended() and passing it explicitly to the new function=
s
> >>>> git_author_info_with_date() and git_committer_info_with_date() when
> >>>> neither the author date nor the committer date are explicitly
> >>>> set. 'commit' always passes the author date to commit_tree_extended(=
)
> >>>> and relied on the date caching to have the same committer and author
> >>>> dates when neither was specified. Fix this by setting
> >>>> GIT_COMMITTER_DATE to be the same as the author date passed to
> >>>> commit_tree_extended().
> >>>>
> >>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>>> Reported-by: Johannes Sixt <j6t@kdbg.org>
> >>>> ---
> >>>>
> >>>> I'm slightly nervous that setting GIT_COMMITTER_DATE in
> >>>> builtin/commit.c will break someone's hook script. Maybe it would be
> >>>> better to add a committer parameter to commit_tree() and
> >>>> commit_tree_extended().
> >=20
> > While I like the basic theme of your patch, I think we should fix this
> > case in a much simpler way, namely, use the infrastructure that was
> > introduced for git-am.
> >=20
> > I've shamelessly lifted the commit message from your patch.
>=20
> Thanks, that is a better way (I'm annoyed with myself for not having
> noticed reset_ident_date() when I edited the function above it)

Don't be too annoyed. I did remember that The Linus had complained about
something similar and assumed that it had been fixed in the meantime, but
I failed to find it within 30 minutes where I tried to dig through
public-inbox and pu.

Thanks Hannes for remembering, and for coming up with the final form of
the patch!

Ciao,
Dscho
--8323329-1717360249-1524211921=:4241--

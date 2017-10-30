Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C032055E
	for <e@80x24.org>; Mon, 30 Oct 2017 10:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbdJ3KaJ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 30 Oct 2017 06:30:09 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:24462
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751822AbdJ3KaI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2017 06:30:08 -0400
X-IronPort-AV: E=Sophos;i="5.44,319,1505772000"; 
   d="scan'208";a="242808575"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 30 Oct 2017 11:30:07 +0100
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: future of the mediawiki extension?
In-Reply-To: <87vaix731f.fsf@curie.anarc.at> ("Antoine \=\?utf-8\?Q\?Beaupr\?\=
 \=\?utf-8\?Q\?\=C3\=A9\=22's\?\= message of
        "Sun, 29 Oct 2017 23:00:44 -0400")
References: <87vaix731f.fsf@curie.anarc.at>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Date:   Mon, 30 Oct 2017 11:29:55 +0100
Message-ID: <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Please Cc: me in these discussions ]

Antoine Beaupré <anarcat@debian.org> writes:

> I think, however, it would be good to have a discussion about the future
> of that extension in Git. The extension has a bit of a hybrid presence -
> it is partly in git core (as a contrib, but still) and partly on GitHub
> here:
>
> https://github.com/Git-Mediawiki/Git-Mediawiki/

The initial plan was to use Git's contrib/ subdirectory to get more of
the Git community involved in its development, and avoid making it a
personal toy.

Initially, Git-Mediawiki is both a personnal project and a student's
project (most of the code was written by students as part of an Ensimag
project under my supervision, with strong interaction with the Git
community).

It did work well in the first times of the project, there were very
fruitfull interactions between Git-Mediawiki and Git. Some issues raised
while developing Git-Mediawiki led to improvements in the remote-helper
mechanism in Git. Some code written for Git-Mediawiki ended up in Git
(the Perl layer for the credential helpers at least). I think this would
have been harder if Git-Mediawiki was a separte project.

However, the rest of the plan did not work that well. I thought having
the code in contrib/ would help keeping the project alive if I became
inactive. It's been a while I didn't have enough time-budget to work on
the project, and the git.git review mechanism has actually blocked a lot
of contributors. Patches get posted here and there but no one takes time
for a proper submission here, and when this happens contributors give up
after the first round of review instead of re-rolling.

So, my conclusion is that a simpler submission mechanism (GitHub's
pull-requests) and a less picky code review would help Git-Mediawiki.

From previous discussions, I think Junio will agree with that: he's
reluctant to keeping too much stuff in contrib/ and usally prefers
external projects.

> It should also be mentioned that this contrib isn't very active: I'm not
> part of the GitHub organization, yet I'm probably the one that's been
> the most active with patches in the last year (and I wasn't very active
> at all).

FYI, I'm no longer using Mediawiki as much as I did, and I don't really
use Git-Mediawiki anymore.

The main blocking point to revive Git-Mediawiki is to find a new
maintainer (https://github.com/Git-Mediawiki/Git-Mediawiki/issues/33). I
believe I just found one ;-).

> Please avoid "mailing list vs GitHub" flamewars and keep to the topic of
> this specific contrib's future. :)

Note that being a separate project doesn't mean there can't be any
interaction with this list. Requests for reviews for separate projects
are usually welcome even though they don't happen often here.

There's also a hybrid solution used by git-multimail: have a copy of the
code in git.git, but do the development separately. I'm not sure it'd be
a good idea for Git-Mediawiki, but I'm mentionning it for completeness.

Regards,

-- 
Matthieu Moy
https://matthieu-moy.fr/

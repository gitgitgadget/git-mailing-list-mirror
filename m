Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4601F790
	for <e@80x24.org>; Tue,  2 May 2017 15:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750767AbdEBPsU (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 11:48:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:61622 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdEBPsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 11:48:19 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LguAU-1dtTUu3Itq-00oEpj; Tue, 02
 May 2017 17:48:14 +0200
Date:   Tue, 2 May 2017 17:48:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate
 command-names
In-Reply-To: <20170502040048.9065-1-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.20.1705021741580.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0Y50zlOD04a6y4noKrcd0lSvLB12QP2zqsAmfMIl6FC8bL5QpPY
 uOOp07iw0Lgl9kcUhZzRNPnKQnPT8+UKEXvJOSbkPFfFI0fkNiQ2aGLHGkw6rJ8hxo0Q/By
 ql6i9sb9TznqXKPDy2HEGGp48Hkh4pOpT408i5mKyrLygros9JFcTe99mgNb7u2pLLao62y
 Kpw0yM2jzF3jmKxy2/d/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EVzBjuDh9gI=:qR2mUlX+PPijLyqGjkV+4D
 M8J1tqW4RkXX5uXjMxp0tHOvLfNixnT5qsMKAvJx/AuvlolfbQfEl9wq1GuC1hOj9YgH58iNs
 W751LeiQznl+3AaZTC2lNCrIMURUD0aQJ3E4PC9Yu1OnnjB+PHu5OnFpgrgYK5aAvrzAjLFCt
 hZPD/+HLpalFkfQFMuBZMBms+zlW2Hn4mJd2nvpGQJBbhrSjC4dpw8oHsuHv3Eb46vaFJ7NTY
 ebfzt/3uhWkOLG2wJmQnWbJukyIY0WjRqmqrYn3t/yH+PIKb0wW4Gcd2xaEpkpc2gxNGxAWzc
 6yOhKtvYqOos8j5TVFNfeyWaHlFtBVRfwToXkEUPJDR6tfv//qo1DkjwZqIrvPack96KUuXFC
 j3idO7AvMIpbKwlBLrq28rz8PMGxPVHUtMo1Ga6P6IOx3ULgqPbpkcheSTCkhnb86UeZVRK4U
 2XHZR0pARo1fG2WMuel6VM8ecpV73ev6npwwTGiYZRJm1V8q3AdMO1OM4w+OQ0rq8uDSgjshk
 jdBpvWPBdVhqHHSJBpY2EuymrDvpFCxQ0NGDJYsnvbDuO4ALOXZh4LSc69zw2KjOoEzyz570v
 1vov8ArgyzTDS8e0DVxRjFwso6qgINryAITaRcHUOyiqUIiXXrNMp5KQ61408+bFihDfnI03w
 c6dFM+YIS5uujeXg3we8q14dfFs3SCWpXsPWCEZkpFXQOeSN22APVxnoFzpb6K7ma10vxdED8
 1S5fGCwY1qt2AKM7ywhS5YBOj/rpmaOjDUax4SxBsKbitpTSK0stuxmpiQ2lWpRRo90wVTK3H
 upJnfqt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Tue, 2 May 2017, Liam Beguin wrote:

> Add the 'rebase.abbreviateCommands' configuration option to allow `git
> rebase -i` to default to the single-letter command-names in the todo
> list.
> 
> Using single-letter command-names can present two benefits.  First, it
> makes it easier to change the action since you only need to replace a
> single character (i.e.: in vim "r<character>" instead of
> "ciw<character>").  Second, using this with a large enough value of
> 'core.abbrev' enables the lines of the todo list to remain aligned
> making the files easier to read.
> 
> Changes from v1 to v2:
>  - Improve Documentation and commit message
> 
> Changes from v2 to v3:
>  - Transform a single patch into a series
>  - change option name from 'rebase.abbrevCmd' to 'rebase.abbreviateCommands'
>  - abbreviate all commands (not just pick)
>  - teach `git rebase -i --autosquash` to recognise single-letter command-names
>  - move rebase configuration documentation to Documentation/rebase-config.txt
>  - update Documentation to use the preferred naming for the todo list
>  - update Documentation and commit messages according to feedback

Thank you for this pleasant read. It is an excellent contribution, and the
way you communicate what you changed and why is very welcome.

I offered a couple of comments, my biggest one probably being that this
patch series is crossing paths with my patch series that tries to move
more functionality out of the git-rebase--interactive.sh script into the
git-rebase--helper that is written in C, closely followed by my suggestion
to fold at least part of the functionality into the SHA-1
collapsing/expanding.

If your patch series "wins", I can easily forward-port your changes to the
rebase-i-extra branch, but it may actually make sense to build on top of
the rebase-i-extra branch to begin with. If you agree: I pushed the
proposed change to the `rebase-i-extra+abbrev` branch at
https://github.com/dscho/git.

I look forward to see this story unfold!

Ciao,
Johannes

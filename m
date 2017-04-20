Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE8A1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 13:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031426AbdDTNZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 09:25:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:63674 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945686AbdDTNZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 09:25:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfAog-1cdbUG2S8A-00Oqfk; Thu, 20
 Apr 2017 15:24:58 +0200
Date:   Thu, 20 Apr 2017 15:24:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, bmwill@google.com
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
In-Reply-To: <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
Message-ID: <alpine.DEB.2.20.1704201523390.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IKpvXN7e6TZ/cjg1rr9sChJnSBTrUCVnFdyWLvBcks14kWZ4jiz
 AenmphU/UzgSJKpiNLSFc87VandnuMV0I45cdao6ZGEd7B7xEBlhgDtG07qmp5tE45dMZfx
 DSRSrW9AyBeBYuB9rmWNCPq/MYjwwNHm7+iOtin9gv2+sqqpYJxCfWll8BwVO0SlC3QbzVQ
 GBnbP7psyRaNHNcLQPRzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4zW/jK/jxVA=:Yp9wRYcXnV6qNjwTwaqEZ0
 slYWtO3Iq0MmBcpgHJqSuoNmmHkXmOKpU4HDusUKs/I93Ff5TWHhT9Yj+Ji6wVbybPdmaAp+Z
 TqfiXPeaGoV+d2902BkicJbXgUtkcB0Wywu8iASE8jL75kFQyN9mb40/RJcasFTjAO+/T8Hax
 +WWk3zlBe8LyFmmfOMbUq/ZNd62zVqJ0M92/EFLiLtZI3WPUzRAnj9yZTaioT6gm3WueLcsKw
 PCWqnis5y623q96VXRAXKs9cnwoNEuTzClKY5YustBu66m9FOokbkbkdfgfXku4T2LSXj3jdP
 G1xv2WVq5upFq4BQeYMORWbByZTtvUC+5hbnbjZBvnOEgNmkjfyBO0CjfTBOEs7rGpCtm7vyR
 1f2vp6QagRUreaeLl1ahib8ZOZGjS181olOMkb5YPQbslUGFS93TP+5Ah3KPwuOUuwLRBXLt3
 ZQfV95lLmlbEw9KwkbDUbVvlbpidyURcu5E/bHfoTTWH80J03v8szeSXOu+HUk5fSr7MfMhYe
 Ag+SqTv2XLF8B5EF1GQLwKW2dAcR7h12GiaPN2n0dGXlt9bDmdRp4PQWMyIOhEQwjbckzRBoM
 mOo2uIb5Dro7j/S5DIALtVJhicLxJOUa/R5iCYSIF/B3SxwtEibPoyiY9rDNhxiO+UKIyQ676
 tU7g1kv5zIFZ/cUJvkIgokE89wcWvEwjHZwaFQeerISGKwAk1ma9uoVCvpJxkHzhCX0tQ2RXj
 Yp2QjAna+x03qcAR/59lKed64i/+8AvmdwSGSuZ9nJ/H4VO22JHN0qWQmVrNXvNZYePk+nYU6
 QiWoLbe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars & Junio,

On Thu, 20 Apr 2017, Lars Schneider wrote:

> > * bw/forking-and-threading (2017-04-19) 11 commits
> > - run-command: block signals between fork and execve
> > - run-command: add note about forking and threading
> > - run-command: handle dup2 and close errors in child
> > - run-command: eliminate calls to error handling functions in child
> > - run-command: don't die in child when duping /dev/null
> > - run-command: prepare child environment before forking
> > - string-list: add string_list_remove function
> > - run-command: use the async-signal-safe execv instead of execvp
> > - run-command: prepare command before forking
> > - t0061: run_command executes scripts without a #! line
> > - t5550: use write_script to generate post-update hook
> > 
> > The "run-command" APIimplementation has been made more robust
> > against dead-locking in a threaded environment.
> > 
> > Will merge to 'next'.
> 
> There might be a problem on Windows with this (that's just a hunch, i can't test this right now):
> https://travis-ci.org/git/git/jobs/223830474

Thanks for keeping track of Travis' failure reports. From what I see, the
latest iteration (which does not seem to have made it to `pu` yet) has the
!MINGW prerequisite which should fix the issue. Hopefully my suggested
addition to the commit message will make it into the commit history, too.

Ciao,
Dscho

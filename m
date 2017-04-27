Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04732207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755559AbdD0WBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:01:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:53460 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754292AbdD0WBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:01:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me8di-1dSYIM075C-00PxCb; Fri, 28
 Apr 2017 00:01:24 +0200
Date:   Fri, 28 Apr 2017 00:01:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/9] t3404: relax rebase.missingCommitsCheck tests
In-Reply-To: <xmqqmvb2o2x7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704272345370.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <975e7749c2fba9dc263cca1d04879c703c0b3c66.1493207864.git.johannes.schindelin@gmx.de> <xmqqmvb2o2x7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+3mtui/hIHwAEe2apAIuWBP3rcUdcYRLPJ5VyYS2Aew8u964isA
 bOSyR+bvoBcZ3hqJv3TJMuaVjOUmHTtAiUsFGUMpmopERvGbYDEFunQdrglOLo2hidJqaEe
 7Sf2kb+aC2rtaqaG/eruO+1MCigg5kfLrofzbnMhatGDAjuwpTRlWYtJg/ATYUWfKetfbvp
 Dbhtv1J4/w0EiiNPy4TPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EWEwRJquDsY=:kLx/OxPP8Nmn6fhhmQQ96Y
 LG2K7cSC8YDeIWREEqpL6rDks7gnKnEpVvP4aAB4bQ8aiLi3Fx5X+ozLhyXBdpJDp+iei7gn/
 PQTQ6mHIik++/ycTU6Ik4ELm2Upm0O5lWL4OqT0W1SWstqXhLFT193l/BBeA3W+YnGUt/EZ3/
 /E2OcL1W4bKkSixYCPsSR/pC4Rf1SE9kEURQLUriEQerXQ6+Xqxyne3GNyiUSuSkHpMgkef6s
 7tpBCuhcskFjce8R22O/RdYY7J6XYqbEpASY+HxaT0SqKsxxe7xICDz74eAx4GVF/2u96a8wW
 7KYuTxtvVTubCxUZlRxKYs+w6h3C+EBPYhlX273AoTY4Z5SsQ/7ANvf4W2SzizLmdQGVzja5Y
 PdxjUt4FvLuFi7LwI68zVVe1lHjbMsSQPxFPNwz9qDh4O6px+a8JTVkAQAAIUd/Gp2ykV3Jai
 1hINCYmnnOe/spjBmB0MHTe18lrRgf9ziDzLtUpj+cUHnZpO8jvvJptjYqLt9LSiD7owWjkwc
 DUpGgFqLLFkVy2b9Uprku5A81+3y53TEsk9ZK7v88hdJ5wCi5I/1HPTDh7J408/RkbBh2STYJ
 RzV125HKejXXjwvgRxQId/DlFUVN4MJAv3ZQ2JSwo+GgYIk427OoZeXCn/3KBJY6CdZ59wu/G
 Tf3eb7dxspQafXEs3Ysl57zXtZ+ZMulDB8OVKDVCcG6OsexNTxTZHnrmSgAru+YjdPVSOnlq+
 EMGKzX9z8/Ud46FtMHNPRVQCUZuGwXaRzHgbEJ1v001GZyLEnvHApyF4W6hdcaTSmdFQSFnWA
 iDiznpV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > These tests were a bit anal about the *exact* warning/error message
> > printed by git rebase. But those messages are intended for the *end
> > user*, therefore it does not make sense to test so rigidly for the
> > *exact* wording.
> >
> > In the following, we will reimplement the missing commits check in
> > the sequencer, with slightly different words.
> 
> Up to this point I thought your strategy was to mimic the original
> as closely as possible, and changes to update (and/or improve) the
> end user experience (like rewording messages) are left as a separate
> step.  Changes to the test can be used to demonstrate the improved
> end-user experience that way, and I found it a good way to structure
> your series.  Is there a technical reason why you deviate from that
> pattern here?  
> 
> Just being curious, as I do not particularly mind seeing things done
> differently (especially if there is a good reason).

Yes, I remember the qualms I had about this patch. It was simply too
cumbersome to keep the exact error message, as it would have meant to
deviate purposefully from the way we do things in C.

In our C code, we error out using the error() function, with translateable
messages. That is what the todo list parsing code in sequencer.c does:

	error: invalid line 4: badcmd 0547e3f1350d D

It even prints out the line number, which I think is a nice touch.

Compare that to the non-standard way the rebase -i *shell* code reported
the failure:

	Warning: the command isn't recognized in the following line:
	 - badcmd 0547e3f1350d D

First of all, it reported it as a "Warning". Which is wrong, as it is a
fatal error, and it was always treated as such.

Second, it uses a capitalized prefix, which not even our warning()
function does.

Third, it uses two lines, and then indents the offending line with a
leading dash (as if we were in the middle of an enumeration).

I would have added that the previous message also imitated Lore in that it
uses a contraction, but I was shocked to learn through a simple git grep
that plenty of our error messages use that style, too.

I could have simply re-written the error() as an `fprintf(stderr,
"Warning: ...");` but that was just too inconsistent for my taste.

Hence I settled for relaxing the error message, which I had already done
much earlier so that running the test with a `set -x` inserted somewhere
into git-rebase--interacive.sh would still work.

Ciao,
Dscho

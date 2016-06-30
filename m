Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9B41F744
	for <e@80x24.org>; Thu, 30 Jun 2016 08:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbcF3IZp (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 04:25:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:55837 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbcF3IZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 04:25:43 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MFPyK-1b4FX52K3w-00ENGc; Thu, 30 Jun 2016 10:25:31
 +0200
Date:	Thu, 30 Jun 2016 10:25:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3404: add a test for the --gpg-sign option
In-Reply-To: <xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606301019040.12947@virtualbox>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de> <xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nnJ10xeKmTvU4fBkwLqRgaHeJX/iARYFY0PbwDGAh8hQIGCVUTo
 NMvXEm3ogDtWWssJhh9tEnbp6PigI/kje8fc3xZBR2ZgXJGIThqDzlMG+JHPy1VF4exV3tD
 vQ6RF4sgixiyPlKqNXV6J5mIJaennEj57DigeHs6MZbHbcgA/pU5T/MuM7tGjNXPiK6T9c7
 O5LQeYZczp44m7iEW3tsg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fFnw1HhNoEc=:cIOm63a0fCeeWX8tcDn1eB
 RbggIfm+rlW1EaTNba7iOBdDd/5tsG+KisSoiFcuxvjIhk6rbYBQX7OmPmiRLW2hG1hKcy3dW
 dWYWd0PdMw2gup24qz9PhVpPnSv8avrUWTBZnuRAd3BUGpC+puyz2HuEr6tNfbc3x3pHM882j
 pLagCzcvJ4QZBNFVBTz4q4yhU2YPKa++WdSyEVdYwmi4uninf9rAKE8i3grzScHI6m+UGdwA+
 Z9kqYW6s20xGRvoa7E870AG0k6V5yMwnc0qAxLOABYD/0CehXD/DtmkffU3thNDQ6UyQ780Rg
 txrdRtdnqT6zbB9ZvQyOCWwXNIowByFFwuHVFFgPwHIh31gg3xUvP78IWJmCYfVRuWOPIN6CU
 kkrt1cSz4dvCvTE8m0GicT9Mxv+2M6z1kl/3I9Dg+GG1pgGJwYrYhCNmrw4W/SFn1KZvgUytc
 GZEXpkFuToHGPDX5t8d1J2KYFd4s6xbzowVcm2IxXurY4aqt+a0j1vMCv9WZJKOC+7jU0AU+x
 LOXjqut/BopuLaHp2an59HoEKvFHivL4jLN5KSIG5rd1ZFf0NedzVpZOkc+6dldAjHra3A5we
 nxrvgPQ+D3Aof4bdsvfXbP0t/sPoHHomuhNn1HHIq9GDo20GLYt7UBn0qyIb9aWqhKfHysETM
 3E36Zbv/l33fmhPwZesqqMTrhauLCpnS/UrRZ+jjFho8XWpzTtN1aWbB7DCPLhOP35O/2q3l+
 xTbzCKxW3HfW49WxlXNsWeAbBCdJMxuZ0Hpf/79cpL4IJmgeMwI+tl83b93bBeG94XGyzyc7L
 CvdWNAv
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > To keep the time t3404 requires short (in this developer's Windows
> > setup, this single test already takes a painful 8 minutes to pass),
> > we avoid a full-blown GPG test and cop out by verifying the message
> > displayed to the user upon an 'edit' command.
> 
> This is a tangent, but I wonder if we should be solving it by
> parallelizing the tests even more.  If the script for example
> can be split into part1 and part2 that share the same set-up
> that is prepared by the very first test, we could split this
> into three files (common one that is dot-sourced by two actual
> test scripts that have part1 and part2).

Sure, that would work around the problem in the short run.

In the long run, the only real solution would be to stop relying on shell
scripting so much, because the biggest performance hit on Windows stems
from the fact that our test suite is a big honking shell script.

> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> > index c7ea8ba..4c96075 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -1281,4 +1281,11 @@ test_expect_success 'editor saves as CR/LF' '
> >  	)
> >  '
> >  
> > +EPIPHANY="'"
> 
> Why?  If you really need a variable, SQ is probably the way this
> codebase typically spell it.

Have you ever watched the movie "Hook"?

> > +test_expect_success 'rebase -i --gpg-sign=<key-id>' '
> > +	set_fake_editor &&
> > +	FAKE_LINES="edit 1" git rebase -i --gpg-sign=\" HEAD^ >out 2>err &&
> > +	grep "$EPIPHANY-S\"$EPIPHANY" err
> 
> I am not sure what is going on here.  You are asking to sign using
> the keyid of a single double-quote, and expecting the message that
> says
> 
> 	You can amend the commit now, with
> 
> 		git commit --amend '-S"'

Precisely. That way, I not only verified that the key ID was correctly
passed around, but also that it is quoted properly.

> 	...
> 
> that has a substring '-S"' in it to ensure that the codepath to
> parse --gpg-sign= on the command line of "rebase", and to the
> message we see here are working correctly, without actually checking
> if GPG is invoked at all, or if it is invoked the key given by the
> option is correctly passed to the invocation?

Exactly. I want to test --gpg-sign even when there is no gpg executable
available.

> If so, can't you do that without confusing users by using keyid "?
> IOW, wouldn't using --gpg-sign=me work equally well?

Not really, because it is much easier to get quoting of "me" right than of
"\"".

I guess I could change the test to pass --gpg-sign="\"S I Gner\"".

Ciao,
Dscho

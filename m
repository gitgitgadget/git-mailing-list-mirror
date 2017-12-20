Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877531F404
	for <e@80x24.org>; Wed, 20 Dec 2017 17:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755822AbdLTRfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 12:35:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:57250 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755607AbdLTRfj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 12:35:39 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1Cw-1ez6oy1yAw-00dC4C; Wed, 20
 Dec 2017 18:35:34 +0100
Date:   Wed, 20 Dec 2017 18:35:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 5/6] fsmonitor: Remove debugging lines from
 t/t7519-status-fsmonitor.sh
In-Reply-To: <xmqqpo7av5au.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712201833420.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171219002858.22214-1-alexmv@dropbox.com> <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com> <0e1b58795c3cfe2a6a64ae8ab0f87f46e5716da4.1513642743.git.alexmv@dropbox.com> <xmqqpo7av5au.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e3K2s3ZWGF1cscDzXrhwiH0TrCflwAamwajWbxXa4jgyPcnuyrA
 gc0Ph7w816k/NNmS0PuHw1PIUGkhCn6kdddx9I0UeEavwVWZs/+AvIt/bKV2UfscewZPr0Y
 Uiu/8/W3SyPEhvXMICBRsBPMLZi05QJuPpF96skpB7ZesRQ59fvJBROz0qIRbie/bFwJakz
 8wDm90X9aKjp8KV0Y2Ptg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VCEg1qPEj3Q=:qXNN+VYOL4aSCyoJBN1Ffx
 Uozyb08tlQmno/At6KsERGjkE8d+9n56qTM/4ICxbXYtDxJa5+SXsAUGZiyzNeRKe1QZbP8LU
 j8hyW4No+N8w7cCz2WyJvbxJbRmOq9LkQTdVzTN3SbIYLSfc1IkAT5SEeB+LrZ+FBfiDBPJ9H
 9qZZND1gZ01xOxKRmDBe8/kNl+eLGlKKnHncDGpgQDywXjFToGE8Cn9dAp6RF0x+FtPrba9mD
 gAuLGklC1zsxkImvFhMiL3sqSbqg7m1vnWFRAlGdMLmdipOkMxHH3tIYBg5p5nfc58xl5i9zX
 2W/6yXYyOygiZJwOM2/9/5SZmA/BpxJst9OYtQ4vgUKZVRz8b6l2q2+Kt7gpiQ9AZnsav2zWS
 EUDQq/rluTE7EtZvhEtwfybdQNQqOPi0YqwLUhN53HYTlNCNjkfZwkihVBv06/SzTZmOIKeSm
 v5VDaJ5dQWphvWzJMZ9tc8nqY7pd1ZjzdBen+6PFDUo35AB310xWBuql6ltXO4bkEmlAd8OU/
 3FXFvbO9ViuLU4kj89UEdnz2rO6LlTVaSexb3hz5a0dGUIElPovpecx54rIPGYQZXWW6tE6qX
 RP4Dlw7ppCyDQveFavhdG1JZf55vPqHA9/hobgdes67dkhnXk0eRm7L8Yz+xEL/YtvDwGW1Rv
 eVix8GbRAPp4RMWGGd46jtipOKhReyhut8yzQ9S/PusD/15jXNNpmw8OEB0Thb/gaupcHrEvK
 PwmJQFMLmTGZqB4oI1/+lg9nMaE7XDmwRYkJ3UFar0nSa5cIIOz6/tEVH01mhl/OaQZCYJHfP
 lP7772lMnqeZDRlYUbA2rZSmUNy6/6x+aIzoOglxAZaVA3syBw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 19 Dec 2017, Junio C Hamano wrote:

> Alex Vandiver <alexmv@dropbox.com> writes:
> 
> > These were mistakenly left in when the test was introduced, in
> > 1487372d3 ("fsmonitor: store fsmonitor bitmap before splitting index",
> > 2017-11-09)
> >
> > Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> > ---
> >  t/t7519-status-fsmonitor.sh | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> > index eb2d13bbc..19b2a0a0f 100755
> > --- a/t/t7519-status-fsmonitor.sh
> > +++ b/t/t7519-status-fsmonitor.sh
> > @@ -307,9 +307,7 @@ test_expect_success 'splitting the index results in the same state' '
> >  	dirty_repo &&
> >  	git update-index --fsmonitor  &&
> >  	git ls-files -f >expect &&
> > -	test-dump-fsmonitor >&2 && echo &&
> >  	git update-index --fsmonitor --split-index &&
> > -	test-dump-fsmonitor >&2 && echo &&
> >  	git ls-files -f >actual &&
> >  	test_cmp expect actual
> >  '
> 
> Hmph, by default the standard output and standard error streams are
> not shown in the test output, and it would help while debugging test
> failures, so I am not sure if this is a good change.  With the
> previous step [4/6], we can lose the "echo", of course, and I do not
> think we need >&2 redirection there, either.

I think you got it backwards. Sure, this helps debugging, but it hurts
runtime of the entire test suite (which I might have happened to mention a
couple of times takes way too long on Windows, thanks to our choice of
test "framework").

And in the bigger picture, I think that it is very, very easy to insert
those debugging statements when something breaks (we have to do that with
other tests, anyways).

So I am in favor of this patch, and disagree with your assessment, Junio.

Ciao,
Dscho

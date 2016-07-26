Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C6D203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 12:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514AbcGZMWX (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 08:22:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:63039 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756472AbcGZMWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 08:22:04 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M1nOg-1bC9P43FJC-00toYm; Tue, 26 Jul 2016 14:21:32
 +0200
Date:	Tue, 26 Jul 2016 14:21:22 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 01/16] Verify that `git pull --rebase` shows the
 helpful advice when failing
In-Reply-To: <xmqqk2g94cti.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607261421180.14111@virtualbox>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de> <37e2f36e4f982261a741e327f1b534cb67b65149.1469187652.git.johannes.schindelin@gmx.de> <xmqqk2g94cti.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7jtq2F3Ui1YcMg5DXzaw2cgJeiZMWC9SOmGUgy9u9hAHh3iMvmP
 0DJfsRIYTB45bCjahVuISHFZ8Ku8IaZViLmzjPCgQ4LROpQXNv9c20A+9tu4MGH4XSSSEdU
 3AF23OY+wHURo//QDbv+AwLUDTKXNcbyJxR7LCBuUG6CrcWKqhi8SqjKQ2DruDYq/iVClUW
 g+Z/5guRcfAtIYJldlSAg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:G2knnGgS+iA=:d4xT/2Jr5ybeA/ARNilvaf
 /zlL4rUyWzU7bIX1b8Vawyt5DyXg68ZmMZmMnqGHOV0jHyjSz2BJwdGyq6tnCox2EkQoFImEu
 NDbEDgej6zIZjg1/K5W0uW6Lz/nVRrjhXKlHqDXHcJoP0C9pdermBsdzI7SQtcavLqOfPNX/K
 9FGuMjkf+41OZ6G4hatB3/f9AxpW4LdtsTi4Cy29/1py+ZriMbzaCsmaxrJyBOySQhblKPvxJ
 qlHmovknTaSq8X1uS1udz299BoLjyjs/uvMZAi1NSbPR07eVD4VdsKVaZuXUCj0E971q1jdJQ
 9XJbIZ2q3p/BVIDjzD85uT7AsosAab48C0Yu3c7rH0YSeYhIC8KGAAh19twVZ/tsJjX2N1pD2
 SeOEvGQHw0pfMdv8p2tuz6tuh6olvEX1+7KaOKybJfHP5ypSVqbN9tGxDKEIvrJoqlkxSVxEf
 irZlKMGTkYJxjTGiJKXLsOGOPUFTYnppQ5hyLtt+wwTOPrluBbynhGb9ZIVfgllrixW6o3JY9
 xWTkuAIghNhCihQdoYtVWyK2S2IGISNWX65+ZiOBrfW7MUg4ej6qU+lod7kA97OXRrdHm0vdO
 UfTAxN6B2dvy6Jf6F9O1n5pLVl7rty1k89QlyOM3yx2Q7hhwlukBFbl6M2aMaTSXehxOwj/ym
 FGls2oSpa8GSvVMKXlkHRinzEiN8ViUbs/acRb3O5xvap568hhiRVUdENqYsKsUrQbC51Y3cH
 hxKppYogEtej9ziZE/KjvAM62YftEP5Mvp6cZGj2RtRa9jWJNYNz3gojzXBfzdl/QBNG3SDDJ
 ACiY0hG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 25 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +test_expect_success '--rebase with conflicts shows advice' '
> > +	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
> > +	git checkout -b seq &&
> > +	printf "1\\n2\\n3\\n4\\n5\\n" >seq.txt &&
> 
> Make this more readble by using test-write-lines, perhaps?

Or even test_seq. Thanks for pointing my nose to this.

> > +	git add seq.txt &&
> > +	test_tick &&
> > +	git commit -m "Add seq.txt" &&
> > +	printf "6\\n" >>seq.txt &&
> > +	test_tick &&
> > +	git commit -m "Append to seq.txt" seq.txt &&
> > +	git checkout -b with-conflicts HEAD^ &&
> > +	printf "conflicting\\n" >>seq.txt &&
> > +	test_tick &&
> > +	git commit -m "Create conflict" seq.txt &&
> > +	test_must_fail git pull --rebase . seq 2>err >out &&
> > +	grep "When you have resolved this problem" out
> > +'
> > +test_expect_success 'failed --rebase shows advice' '
> 
> Need a blank line before this one.

Yep, sorry.

> > +	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
> > +	git checkout -b diverging &&
> > +	test_commit attributes .gitattributes "* text=auto" attrs &&
> > +	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
> > +	git update-index --cacheinfo 0644 $sha1 file &&
> > +	git commit -m v1-with-cr &&
> > +	git checkout -f -b fails-to-rebase HEAD^ &&
> 
> It is unclear what the "-f" is for; is it attempting to clean up a
> potential mess previous steps might have left?  We didn't have it in
> the previous test above.

It is there to clean up a very non-potential mess: forcing a CR/LF into a
file marked with `text=auto` makes a royal mess. Neither `git reset
--hard` nor `git stash` will make that file clean. As a consequence, the
`git checkout` without an `-f` would *always* fail "because of uncommitted
changes".

I clarified that in a comment.

> > +	test_commit v2-without-cr file "2" file2-lf &&
> > +	test_must_fail git pull --rebase . diverging 2>err >out &&
> > +	grep "When you have resolved this problem" out
> > +'
> > +
> >  test_expect_success '--rebase fails with multiple branches' '
> >  	git reset --hard before-rebase &&
> >  	test_must_fail git pull --rebase . copy master 2>err &&
> 
> Not worth a reroll but after this series settles we would probably
> want to address some of the above up with a follow-up clean-up patch.

As I re-roll anyway, no big deal.

Ciao,
Dscho

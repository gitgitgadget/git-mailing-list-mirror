Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CBE2055A
	for <e@80x24.org>; Wed,  3 Aug 2016 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbcHCOm4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 10:42:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:58500 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbcHCOmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 10:42:54 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MVedf-1blJUO3PLT-00Z0VT; Wed, 03 Aug 2016 16:35:11
 +0200
Date:	Wed, 3 Aug 2016 16:35:10 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeremy Huddleston Sequoia <jeremyhu@macports.org>
cc:	git@vger.kernel.org
Subject: Re: 2.9.2 test failures on macOS
In-Reply-To: <C4207508-629B-41DF-8E89-CDD1989BCF2E@macports.org>
Message-ID: <alpine.DEB.2.20.1608031632110.107993@virtualbox>
References: <C4207508-629B-41DF-8E89-CDD1989BCF2E@macports.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:58CojNUCljrLyLGlDCZnetkaBUctBANim7qAbkDE30GK3e8W+VM
 vQamH7Mv1hGMJgRoexdbK27ddlbiEFI4rXJr7nDI66LkjuN0ip/QFtYaKVElyS2jXb4gW4b
 IpmKuKEjH6itEQ1Qf4mYw81i+ajxX3vfUpSz3o/WBR9Ab1j9zP6qM+dDCczctkfVKs91i17
 bonGSNoQ9liM4Z3hG4/Pw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:vOU9L32VIq4=:HyoKwiTT779hTXotZXdbPM
 EigoG3oYChsGcAq8UBSsl/v4BNFTt5lW6LqVDDyAQEyJQdxdmN1lseVJ/v1jHcSixegkMGvvg
 AXeEejnUPoooDVI9YBMpz/9h0ObltQgWEbCR7wUJt0xb+dn7eVt2PxYJ4Hh7PiQz4t1r/RHyP
 rURxFAXMdk6ZVOr0Eozo6zHkZyvK/ClU96F2bqtjMxE0udXdakJ+stGSEtqd+SSvEOhkioHYt
 +to9Fv4xrzGQlfcwZWk7Fhj22dyWZq0ApfjYUrjLxPR7cNOo9OWzNN4Md4RVoz4lvxmQ3xw2n
 axPC9bz/T7akqPrawFl5NTaA0vASvzfBZrP42ZxR84McFJ3RZHOymU5zm1PL3287kx6KlNF6e
 21FQQ/aY53DWiMl1u/MUIeytMc+AK4vJ5pn7yRF5ieKoi06qktE6/jWsN21d32lTLqOiPUqyB
 nzAtR+hGA4/lP6YyARtgoEgh/GYtD8KO/e7LSMF3IwmNaWBm3ZF2Sm/pbnoO0TpN4coRVHXWj
 cBsYLWdJ7okFYF0WPHTSCXSOKGZxANODkg1xOyuK7IX9ADc1wDVTPC177AbtcM5+i/9zTj05E
 5R6M5NAnPM5Jm8Klcam+YlKWt6fI3oGUKA8nqMKsnivq72lPGO01RFD5cc9DCB0+kcZuQE2y2
 02smeMrBu6Y67JT1p326SsvovMsp6IRasFGNk1ByOOZ0K8v9Gp6fxovJEL4tEOaMN9tCZde7G
 pOqEH3n2dl+NjnBXu8YfenA4kCGTTTdRi48qYhPCTelNdJNn6jfH65dq5+lDjAaymkbm9w+9U
 Tggcupo
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jeremy,

On Wed, 3 Aug 2016, Jeremy Huddleston Sequoia wrote:

> I have two test failures to report in git 2.9.2 on macOS:
> 
> 
> t3210-pack-refs.sh has not changed between 2.8.4 and 2.9.2.  This test passed fine with 2.8.4, but it now fails with 2.9.2 at:
> 
> not ok 26 - retry acquiring packed-refs.lock
> #	
> #		LOCK=.git/packed-refs.lock &&
> #		>"$LOCK" &&
> #		test_when_finished "wait; rm -f $LOCK" &&
> #		{
> #			( sleep 1 ; rm -f $LOCK ) &
> #		} &&
> #		git -c core.packedrefstimeout=3000 pack-refs --all --prune
> #	
> 
> ===
> 
> t3700-add.sh recently added the 'git add --chmod=-x stages an executable file with -x' test.  This test passes when run as a normal user but fails when run as root:
> 
> $ ./t3700-add.sh
> ...
> # passed all 40 test(s)
> 1..40
> 
> $ sudo ./t3700-add.sh
> ...
> not ok 39 - git add --chmod=-x stages an executable file with -x
> #	
> #		echo foo >xfoo1 &&
> #		chmod 755 xfoo1 &&
> #		git add --chmod=-x xfoo1 &&
> #		case "$(git ls-files --stage xfoo1)" in
> #		100644" "*xfoo1) echo pass;;
> #		*) echo fail; git ls-files --stage xfoo1; (exit 1);;
> #		esac
> #	
> # failed 1 among 40 test(s)
> 1..40

I tried to write up all I know about debugging test failures here:

https://github.com/git-for-windows/git/wiki/Running-Git's-regression-tests#running-individual-tests

Could you give it a try and diagnose the breakage further? (The output you
provided is unfortunately not enough to determine what went wrong.)

Ciao,
Johannes

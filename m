Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B241F859
	for <e@80x24.org>; Tue, 16 Aug 2016 12:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbcHPMmu (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 08:42:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:59851 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbcHPMmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 08:42:50 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MZwYd-1btmDK239b-00Loi6; Tue, 16 Aug 2016 14:42:37
 +0200
Date:	Tue, 16 Aug 2016 14:42:34 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	ryenus <ryenus@gmail.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
Subject: Re: [PATCH] rev-parse: respect core.hooksPath in --git-path
In-Reply-To: <20160815125006.qdssqgd4rzjw4vi5@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608161440290.4924@virtualbox>
References: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de> <20160815125006.qdssqgd4rzjw4vi5@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CZbH2iDc9nbQen1LWKWhUeNoR31qCZQpeTxQSf58L2Hpm7ysgMf
 pAoAW+Mmb+SUt51NIqSbBQqsm6VHAJrzBEykN4AF+BRUgbnz9eUPfasw9RnE15snD0oc2T7
 KRor/EYQSeVCOglUq5Y9gyK0SRpYVW3Oh8xxpq3w+S8tSzPdNUevHIaUuXLCCylP0lNGjYC
 a07U+W6q0lQAxJ3E/SypA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:NFj45tyadrI=:zwFabrv2umevyE/Zz17f1u
 /9vW3Ug82rQXvG13CGL6/Anb+UsV5LGEinQNf9oELd5Bd1TMi+KMzz+6OXEDxfw6im4mLf+o6
 taypTQlPquXn8G2J4dOrck08v3+6wGz//iiP31nOQk7UDasN0HV+w+vWVpabTguqsVVtkbf9x
 PpdFWaxLBE+eK49v0Niqxt1E9z5iif4ib4WTIB6XNN/FPNCQjgKN2HInyxSyeqOGSgPSmmh/k
 G85X4HIbHI1YbbpRLxy4jqlKJ9QrVHlL1EIt7uUugqdbNDhENmHxdZBR4MFLFhZ3/g/ixDsxA
 Ra0hbvMay7ojQUT7uxWjBGklfdpx0z28k2bvp/cWq+1MwTvFJAa0PDs4X7Q4EuIeZFSsP8VcG
 Bt0BlVZfnqAEnKxKZHmLoBZWPf4cAW0o2bSCNdIVrgkGqNE3UcFD3cGFl8RJ0RKtj/AGagtE2
 Ffe+BZdToyIGDtPU+ft5swFHDPwcz7BCWvtEhburn3gSPwt7xzoFmxJfJ48Y5/fXIFOLsOTn2
 iSdpWoFEBdA5xJg579qFWqFIsUIdwzqwxpBYyuzJZEdcFRvTAH5VxTytb3x4lr5nq9Hjw/N+e
 I9w+eNPISBbAGDJEbU3Cx5k0H0A09OROUQfubIxkpafY3QataMQnmLEqU/zq+VftBejnqUtHq
 FwQZrA5bBATKTEC1ek/WKAChfYBoe6+9Zq0kQ4GXnxR2ufYmKck67XjmCJSQb03d4X+kJ500g
 /HZD2+kqFqPmqK/LuKKwmWVUrTx7hseyHq8CtgZ+uPb4zse7+rl0uWh+RQdW1b1C5jK3j+Jhf
 +XHpvyO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Mon, 15 Aug 2016, Jeff King wrote:

> On Mon, Aug 15, 2016 at 02:43:18PM +0200, Johannes Schindelin wrote:
> 
> > The idea of the --git-path option is not only to avoid having to
> > prefix paths with the output of --git-dir all the time, but also to
> > respect overrides for specific common paths inside the .git directory
> > (e.g. `git rev-parse --git-path objects` will report the value of
> > the environment variable GIT_OBJECT_DIRECTORY, if set).
> > 
> > When introducing the core.hooksPath setting, we forgot to adjust
> > git_path() accordingly. This patch fixes that.
> 
> Makes sense.
> 
> I think you can squash in:
> 
> diff --git a/run-command.c b/run-command.c
> index 33bc63a..5a4dbb6 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -824,10 +824,7 @@ const char *find_hook(const char *name)
>  	static struct strbuf path = STRBUF_INIT;
>  
>  	strbuf_reset(&path);
> -	if (git_hooks_path)
> -		strbuf_addf(&path, "%s/%s", git_hooks_path, name);
> -	else
> -		strbuf_git_path(&path, "hooks/%s", name);
> +	strbuf_git_path(&path, "hooks/%s", name);
>  	if (access(path.buf, X_OK) < 0)
>  		return NULL;
>  	return path.buf;
> 
> as strbuf_git_path() handles this now.

Good point.

BTW in light of the discussion we are having elsewhere I just need to
point out that it was *dramatically* faster for me to edit run-command.c,
find "hooks/" and adjust the code manually than it would have been to save
the diff and apply it.

That's because I do not have advanced tooling on top of email (and I also
could not handle mutt, so I am stuck with a not-really-scriptable email
client).

Just sayin'.

Ciao,
Dscho

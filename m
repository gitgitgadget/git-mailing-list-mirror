Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2ED20281
	for <e@80x24.org>; Mon, 22 May 2017 11:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758139AbdEVL5B (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 07:57:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:54437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756155AbdEVL47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 07:56:59 -0400
Received: from virtualbox ([95.208.58.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcBPV-1deRsT1qr7-00jbfx; Mon, 22
 May 2017 13:56:56 +0200
Date:   Mon, 22 May 2017 13:56:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Windows: do not treat a path with backslashes as a
 remote's nick name
In-Reply-To: <6347731f26396b1256070e02376bf3623bfb7102.1495261020.git.j6t@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1705221353570.3610@virtualbox>
References: <cover.1495261020.git.j6t@kdbg.org> <6347731f26396b1256070e02376bf3623bfb7102.1495261020.git.j6t@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zXZcsckSLNOjDQdWswwljS2vvmV4J8wWi4h2pfKbp9zWmR+5Bnw
 95j8KdIJ+GjMjn9x5KCX4l5pio3Yaz389zCVTVNxX9jPy3DzCSvtpFKrgw2D3AiE/gei01L
 YMGhUBWey46s2sTuYoXH+lkA4nA10CshM9NB3dm1jWgbhCSJlD9i+VqpnRNkXwyW1fttHfe
 TYdDwaPZo86kNOk6Nem0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b2PN1Vekh1A=:a9x1CSk1GEAhu2w80d9d7d
 c992wbUfAmVUrFCu63gypUDKGatfrjc5Gs0GfzXPJmpDZcDFqLbyrnWw6CW4sKRRPhsTwbtza
 GUo+3uNg526sfC5edAJVqyXVS5vOICXv25ZjMRTUUudbGTYt+TGGe1/UIJ45Zb/ekeAm6PF8P
 6hFHRHjR0caEByty4ncapTM7rKGlsifp4qhfqQhGBhlBOj8RiRMWB7Yi65IXAMYI3FSvsUKhs
 9cUmxGzdjKwjptfjrhWNYQfpelp8DKCkbQp3QOWfGEBWz5g+dQQq9bAt5+EROlwGrxKROgMB7
 8I7L702E27yH7qE3vHo6aqVO7LpuVeqvJpuUDUrmdCWLQ1TnV3VeUieaWGlFbAog1+JFSwp82
 vKynLN68islry72MsPiKyrYJVJIKOYuHb6edkUoPpcIILqPWHplsmGMNiSvr3VlZdPcOheAqQ
 HYhbxV2Cvy8LidBXZZkiIIm+fePvSQi3Um3etrER0DKWZLdhJ6R0Hg7AKVI+i1CYelFbhgUmp
 H58TfJSFwuiQs27RCk5iMZ7OtitjTNQ+o0ML+Jaewo5MUOc2fD6CfDBU6c2E77iQopDjPf/6i
 Jfo4SUJbBmGjg5onK9dmHZomTly+8uFDGPk1xKU5JFpuuoGWsBcnnY7b3wjIwaMNxCRjwbyNH
 f8/sBaVYExxvbnQ4koH2k74QFrvClQJbTKRm0mowCdXrKoIzL3+w6e7I37ZNXgEyKZsANWiEp
 rFXlAEiMXFbzUvB+us9Qy2I4CeX96EiEJCA1y9yzt+pI1pJnfewL1dOMNTjAyJnqhAgkwVhb2
 n2Eb6Os
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sat, 20 May 2017, Johannes Sixt wrote:

> Fetching from a remote using a native Windows path produces these warnings:
> 
> C:\Temp\gittest>git fetch C:\Temp\gittest
> warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
> warning: unable to access '.git/branches/C:\Temp\gittest': Invalid argument
> From C:\Temp\gittest
>  * branch            HEAD       -> FETCH_HEAD
> 
> The functions that read the branches and remotes files are protected by
> a valid_remote_nick() check. Its implementation does not take Windows
> paths into account, so that the caller simply concatenates the paths,
> leading to the error seen above.
> 
> Use is_dir_sep() to check for both slashes and backslashes on Windows.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

I like this explanation.

> diff --git a/remote.c b/remote.c
> index 9584af366d..9501357c06 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -649,7 +649,10 @@ static int valid_remote_nick(const char *name)
>  {
>  	if (!name[0] || is_dot_or_dotdot(name))
>  		return 0;
> -	return !strchr(name, '/'); /* no slash */
> +	while (*name)
> +		if (is_dir_sep(*name++))	/* no slash */

I understand that you simply kept the comment, yet I have to admit that I
find it confusing in the post image. Something like

	/* remote nicknames cannot contain slashes */

(and putting it *above* the `if` line instead of appending it separated by
a <tab>) would have made it easier on me.

> +			return 0;
> +	return 1;
>  }
>  

With my suggested change or without it, ACK.

Ciao,
Dscho

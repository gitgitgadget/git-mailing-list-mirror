Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB8020195
	for <e@80x24.org>; Sun, 17 Jul 2016 07:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbcGQHrA (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 03:47:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:63231 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbcGQHq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 03:46:59 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0ML7NR-1bOPfh0D3J-000IVU; Sun, 17 Jul 2016 09:46:52
 +0200
Date:	Sun, 17 Jul 2016 09:46:51 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	norm@dad.org
cc:	git@vger.kernel.org
Subject: Re: Question: Getting 'git diff' to generate /usr/bin/diff output
In-Reply-To: <578a9d5b.xL1egXSTCv+mjhAT%perryh@pluto.rain.com>
Message-ID: <alpine.DEB.2.20.1607170942580.28832@virtualbox>
References: <201607161912.u6GJCM79069898@shell1.rawbw.com> <578a9d5b.xL1egXSTCv+mjhAT%perryh@pluto.rain.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pWqOD4DCj5vNUwcmKRpsN3DAKwPR3NYUFri8BNAwUHniKVwVlhc
 10heizr8ZLPYra+GwnK6TRgrItyJR74s2M5JSYhaRg3FMZ8YaBUwVwdBrT1uNtPK0FeeUF9
 bv2J+0fSRXg2m6FqEFJnXet5TARBRsxTtqU1bqbDNdW+eozqw7azSfxe8KOsDDg8CcWW0m3
 b6jEDVIpBoIcsID6//fng==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:tAdWgkTmDFs=:LXvwhth6OtgUyEZ6CYYu+c
 AsaFrFhAy/ZmEBb0tjMvrRQjiFkzlf/IDDUSUqlEETu6tdjBl/yCtYdtMV8NlQQ4vgRgYGmn7
 ssvqIFl0chk4FY6WXoAyvfgJkvscejwmLEUscAQQ/r6397GCR6ECv31lWxOxaUEfWx1n9Ixjo
 elE9BfeX4HIM6JyPxM8qyxLJY4GR212iMeBL6Q4MFn/MxRay2ltwTiDgdXw2vuVazxLiXp/l0
 5zyCUj6ejR3bwTMCpVU7B/+O1FWf+hNKqvaxMc8noaRSQu7fa3jq6+AigR7VE6qNcqVcyymR7
 bWMf5jwIRYh2bHU9pY4FezhKxJWPdPlBDLCOALHNtawN6M0jK7fVaP38VUkJ+prEwvgOFisoU
 vt4uneIspPrDC0qBVgy902GKYaejfKiVn1JIV15tB7gQ8f7C00bx9iXOBMuboG/zlJPE4Fvg9
 ppFYf3RV+ksf564vZdOH2drDeoereK3FK9Jbm+dsqEP8UdYS5Mg/CAv06G+Fyc+VbWFSqMSpR
 B1brN2sgyZ4ivDpBz9siapKDxsUxBfId1S18B5HIL/6o3Z5VYSc1M64tLwj5fp5DSWORxvckF
 f3qmXy8MPOjFMl58GJT7EnurhdN4c3SWRPY+/JBgz3zeCZ513Y88M2TiWFWcKGOLGgd8otheB
 fTJhvV/bSM7PLhtedjgOYWnvYjDjEgkiHM36oyYd9Shqb6tX0pz4B1+cN9iRIAHpr3ciyxOrm
 IhEOgLToLxamh8jRhxewJoezx2QJHYFPzXJQwfDzxbAPYVedReeStEpA2+lYA6gThoRpTGU/Q
 yQryK7i
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

[Perry, my mailer could not find your MX record, so I am sorry I had to
drop you from the explicit To:...]

On Sat, 16 Jul 2016, Perry Hutchison wrote:

> norm@dad.org wrote:
> 
> > Would some kind soul be willing to tell me if there is a way to
> > do that, short of making a backup copy of the relevant file, and
> > then doing 'git checkout'. Maybe the '--ext-diff' argument to
> > 'git diff' will do that, but I can't figure out how to use it.
> > ...
> >     git version: 2.5.1.454.g1616360
> 
> 'git cat' would be simpler than making a backup and using 'git checkout',
> but for this use case there's a better way even than that.

$ git cat
git: 'cat' is not a git command. See 'git --help'.

;-)

You probably meant `git cat-file blob <SHA-1>`.

> Google is your friend when you can't figure something out from (or
> find the right part of) a program's own documentation.  A search for
> 
>     git "external diff program"
> 
> (including the quotes) found several references.
> 
> One possible complication:  It's likely that the command parameters
> which git passes to an external diff program are not exactly what
> /usr/bin/diff requires.  The solution to that sort of problem is to
> write a very short executable script that rearranges the parameters
> as needed, and specify that script (instead of /usr/bin/diff itself)
> as the external diff program.

To spell it out, you probably referred to the --ext-diff option:
https://github.com/git/git/blob/v2.9.2/Documentation/diff-options.txt#L528-L531

This option can be used with any diff-producing Git command, but it
requires a .gitattribute setting together with the corresponding
diff.external setting in the config.

A better method might be to use the `git difftool` command, e.g.

	git difftool -x diff

You can also inspect the diff of a commit, using the ^! suffix, e.g.

	git difftool -x diff origin/master~3^!

If you want to avoid the prompt and get the complete diff for all files in
one go, you will have to write a small script as indicated, e.g.

	printf '#!/bin/sh\n\n/usr/bin/diff -r "$@"\n' >my-diff.sh
	chmod a+x my-diff.sh
	git difftool -d -x $PWD/my-diff.sh HEAD^!

I did write all of this in the mail program, so I highly recommend reading
the man page of the difftool e.g. to understand the meaning of the -d
option, so that you can fix any problems with my examples yourself.

Ciao,
Johannes

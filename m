From: sean <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 14:45:22 -0400
Message-ID: <BAYC1-PASMTP049717FBA1C348C8A60C8CAEB70@CEZ.ICE>
References: <20060502232553.GL27689@pasky.or.cz>
	<7virooj92i.fsf@assigned-by-dhcp.cox.net>
	<4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com>
	<20060503090007.GM27689@pasky.or.cz>
	<4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com>
	<Pine.LNX.4.64.0605030934220.28543@localhost.localdomain>
	<20060503142957.GA9056@spearce.org>
	<4458C5D7.8010501@op5.se>
	<Pine.LNX.4.64.0605030817580.4086@g5.osdl.org>
	<20060503164732.GB9820@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, ae@op5.se, spearce@spearce.org, nico@cam.org,
	paolo.ciarrocchi@gmail.com, pasky@suse.cz, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 20:50:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbMQT-0002SQ-4J
	for gcvg-git@gmane.org; Wed, 03 May 2006 20:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWECSuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 14:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWECSuN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 14:50:13 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:45163 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750730AbWECSuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 14:50:11 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 3 May 2006 11:50:10 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 61A49644C28;
	Wed,  3 May 2006 14:50:09 -0400 (EDT)
To: Theodore Tso <tytso@mit.edu>
Message-Id: <20060503144522.7b5b7ba5.seanlkml@sympatico.ca>
In-Reply-To: <20060503164732.GB9820@thunk.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 03 May 2006 18:50:10.0866 (UTC) FILETIME=[67BBC120:01C66EE2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 3 May 2006 12:47:32 -0400
Theodore Tso <tytso@mit.edu> wrote:

> Of course, a lot of it is that git *is* much more powerful, much like
> the difference between a stickshift with a racing clutch (git) and a
> car with an automatic transmission (hg).  So maybe one thing that
> would help git would be a stronger emphasis of cogito for those
> projects that don't need the full power of using git "straight up".

The docs and higher-level user commands can still use some work, but
telling people they have to install and learn an entire extra layer
isn't going to win many converts.  Personally I think Git needs a bit
more polish and to stop thinking of itself as mostly plumbing.  Even so
Git really has become pretty good at making simple things simple:

init-db, add/rm, commit -a,
status, show, log, gitk, diff,
branch, checkout, clone, fetch/pull

The fact that it's faster, requires less disk space, and has all the
lower level tools you need to do "complex stuff", should make it a
tempting choice once the remaining rough edges are removed.
But there is nothing inherently complex about Git.

Sean

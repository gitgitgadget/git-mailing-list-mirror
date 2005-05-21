From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 15:00:37 -0400 (EDT)
Message-ID: <2329.10.10.10.24.1116702037.squirrel@linux1>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
    <20050521150926.GA96606@dspnet.fr.eu.org>
    <2015.10.10.10.24.1116696150.squirrel@linux1>
    <20050521184909.GA1729@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 21:00:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZZCU-0007ss-Ae
	for gcvg-git@gmane.org; Sat, 21 May 2005 20:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVEUTAp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 15:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVEUTAp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 15:00:45 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:172 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261776AbVEUTAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 15:00:38 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521190038.TTBM28065.simmts8-srv.bellnexxia.net@linux1>;
          Sat, 21 May 2005 15:00:38 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4LJ0bph021841;
	Sat, 21 May 2005 15:00:37 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 15:00:37 -0400 (EDT)
In-Reply-To: <20050521184909.GA1729@dspnet.fr.eu.org>
To: "Olivier Galibert" <galibert@pobox.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 21, 2005 2:49 pm, Olivier Galibert said:
> On Sat, May 21, 2005 at 01:22:30PM -0400, Sean wrote:
>> Both of these options are generated automatically by argp.
>
> I see.  Then I'll guess I'll have to put argp in the "crap" pile next
> to libtool and automake.

Okay now don't go saying things you can't take back <g>.

> How neat.  Of course using the right option under (t)csh gives:
>
> galibert@m62:~ #201 >git-fsck-cache -?
> git-fsck-cache: No match.
>
> Importing this windowism is beyond stupid.

Hmmm, that kinda sucks, but the --help should still work fine.  I suppose
we could figure out how to use -h instead.

Sean



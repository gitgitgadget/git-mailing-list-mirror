From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 13:22:30 -0400 (EDT)
Message-ID: <2015.10.10.10.24.1116696150.squirrel@linux1>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
    <20050521150926.GA96606@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 19:22:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZXfM-0007nL-CT
	for gcvg-git@gmane.org; Sat, 21 May 2005 19:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVEURWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 13:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVEURWi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 13:22:38 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:4760 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261756AbVEURWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 13:22:33 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521172232.TLGB28065.simmts8-srv.bellnexxia.net@linux1>;
          Sat, 21 May 2005 13:22:32 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4LHMTNr020778;
	Sat, 21 May 2005 13:22:30 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 13:22:30 -0400 (EDT)
In-Reply-To: <20050521150926.GA96606@dspnet.fr.eu.org>
To: "Olivier Galibert" <galibert@pobox.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 21, 2005 11:09 am, Olivier Galibert said:
> On Fri, May 20, 2005 at 11:38:52PM -0400, Sean wrote:
>>  -?, --help             Give this help list
>
> Could you make that '-h' please ?
>
>>  -V, --version          Print program version
>
> And that '-v'.  -V traditionally means verbose, -v version.  Yes, I
> know there are counter-examples, but statistically...
>

Hey Olivier,

Both of these options are generated automatically by argp.  I'm sure there
is a way to override them, but i'd rather just leave them as given by
argp.  For the first case, if you try '-h' on the command line you get:

$ git-fsck-cache -h
git-fsck-cache: invalid option -- h
Try `git-fsck-cache --help' or `git-fsck-cache --usage' for more information.

So it leads to the proper help message.

Sean



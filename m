From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: removal of "percent done" messages from git pull
Date: Fri, 16 Feb 2007 18:47:02 +0100
Message-ID: <slrnetbrgm.ahb.siprbaum@xp.machine.xx>
References: <45D5E06B.6020706@lightspeed.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 18:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI7Ca-00016f-LM
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 18:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946016AbXBPRsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 12:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946026AbXBPRsw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 12:48:52 -0500
Received: from main.gmane.org ([80.91.229.2]:47767 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946016AbXBPRsv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 12:48:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HI78H-00021y-Pu
	for git@vger.kernel.org; Fri, 16 Feb 2007 18:44:30 +0100
Received: from p54aa9498.dip0.t-ipconnect.de ([84.170.148.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 18:44:29 +0100
Received: from siprbaum by p54aa9498.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 18:44:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54aa9498.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39934>

Larry Streepy <larry@lightspeed.com> schrieb:
> I run a nightly script to build and test our product.  I capture all the 
> output and email it to interested parties.  One very annoying thing is the 
> "percent done" messages that come out of git pull.  It results in log files 
> that look like this:
>
> + git pull
> remote: Generating pack...
> remote: Done counting 204 objects.
> Result has 107 objects.
> Deltifying 107 objects.
>     0% (1/107) done   1% (2/107) done   2% (3/107) dremote: one   3% 
> (4/107) done   4% (5/107) done   5% (6/107) done   6% (7/107) done   7% 
> (8/107) done   8% (9/107) done   9% (10/remote: 107) done  10% (11/107) 
> done  11% (12/107) done  12% (13/107) done  13% (14/107) done  14% (15/107) 
> done  15% (17/107) donremote: e  16% (18/107) done  17% (19/107) done  18% 
> (20/107) done  19% (21/107) done  20% (22/107) done  21% (23/107) done  22% 
> remote: (24/107) done  23% (25/107) done  24% (26/107) done  25% (27/107) 
> done  26% (28/107) done  27% (29/107) done  28% (30/107)remote:  done  29% 
> (32/107) done  30% (33/107) done  31% (34/107) done  32% (35/107) done  33% 
> (36/107) done  34% (37/107) done  remote: 35% (38/107) done  36% (39/107) 
> done  37% (40/107) done  38% (41/107) done  39% (42/107) doneremote:   40% 
> (43/107) doneremote:   41% (44/107) doneremote:   42% (45/107) doneremote: 
>    43% (47/107) doneremote:   44% (48/107) doneremote:   !
>   45% (49/107) doneremote:   46% (50/107) doneremote:   47% (51/107) 
> doneremote:   48% (52/107) doneremote:   49% (53/107) doneremote:   50% 
> (54/107) doneremote:   51% (55/107) doneremote:   52% (56/107) doneremote: 
>    53% (57/107) doneremote:   54% (58/107) doneremote:   55% (59/107) 
> doneremote:   56% (60/107) doneremote:   57% (61/107) doneremote:   58% 
> (63/107) doneremote:   59% (64/107) doneremote:   60% (65/107) doneremote: 
>    61% (66/107) doneremote:   62% (67/107) done  63% (68/107) doneremote: 
>   64% (69/107) doneremote:   65% (70/107) doneremote:   66% (71/107) 
> doneremote:   67% (72/107) done  68% (73/107) done  69% (74/107) done  70% 
> (75/107) done  71% (76/107) doneremote:   72% (78/107) done  73% (79/107) 
> done  74% (80/107) done  75% (81/107) done  76% (82/107) done  77% (83/107) 
> done  78% (8remote: 4/107) done  79% (85/107) done  80% (86/107) done  81% 
> (87/107) done  82% (88/107) done  83% (89/107) done  84% (90/107) dremote: on!
>   e  85% (91/107) done  86% (93/107) done  87% (94/107) done!
>     88% (9
> 5/107) done  89% (96/107) done  90% (97/107) done  91remote: % (98/107) 
> done  92% (99/107) done  93% (100/107) done  94% (101/107) done  95% 
> (102/107) done  96% (103/107) done  97% (1remote: 04/107) done  98% 
> (105/107) done  99% (106/107) done 100% (107/107) done
> Unpacking 107 objects
> remote: Total 107, written 107 (delta 70), reused 78 (delta 41)
>
> I have found no way to make these messages go away.  When running in a 
> "batch" mode, IMHO, interactive messages like these should not be emitted. 
>   At least there should be a switch to suppress them.
>
> Have I missed the magic switch that will accomplish this?
>
> Larry.
>
> P.S. I'm using 1.4.4.1

Have you tried with -q to make it more silent? (I didn't try this, but
normaly the git porcelain commands just pass the options they don't
understand to the underlying core commands; and git-fetch-pack has the
option -q for quiet)

-Peter

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: "make test" works again (sort-of) on cygwin.
Date: Thu, 3 Jul 2008 22:26:37 +0200
Message-ID: <20080703202637.GC3546@steel.home>
References: <486D0FFC.5090308@ramsay1.demon.co.uk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 03 22:27:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEVP1-0008Ho-Gc
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 22:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYGCU0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 16:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYGCU0k
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 16:26:40 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:44243 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbYGCU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 16:26:39 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf4EDTSQ==
Received: from tigra.home (Fae7d.f.strato-dslnet.de [195.4.174.125])
	by post.webmailer.de (mrclete mo28) (RZmta 16.45)
	with ESMTP id 3066d4k63I1sRF ; Thu, 3 Jul 2008 22:26:37 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C7C4B277BD;
	Thu,  3 Jul 2008 22:26:37 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B585D56D27; Thu,  3 Jul 2008 22:26:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <486D0FFC.5090308@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87315>

Ramsay Jones, Thu, Jul 03, 2008 19:44:28 +0200:
> I spent many hours (not recently) trying to determine the reason for
> the crash, but it seems to be essentially "random gremlins" :-)
> However, since I mostly use Linux, I've not been very motivated to
> find a solution, particularly when git works fine (touch wood) when
> used for real work. (i.e. only "make test" crashes my machine).
> Also, as Alex and Shawn have not reported problems, I have assumed
> it is something specific to my environment. Dunno.

I haven't tried to run the test on XP recently (it is a production
workstation, after all), but the last time I risked it was locked up
hard. Win2k runs (and I even can work, well, browse, on it)

> Anyhow, the "sort-of" in the subject line, relates to the fact that
> I am seeing some test failures.  In particular, all tests in
> t0004-unwritable.sh and tests 21->24 in t3700-add.sh. All of these
> tests involve chmod/permissions ...

Don't run "make test" as root (or "backup operator" on windows).
OTOH, a windows machine is almost useless, unless you're a member of
local administrators group (which includes "backup" permission).

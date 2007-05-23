From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] disable merge summaries if they are disabled
Date: Wed, 23 May 2007 13:03:45 -0700
Message-ID: <7vd50r2tpa.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com>
	<7vhcq32yda.fsf@assigned-by-dhcp.cox.net>
	<20070523195823.GA2554@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 22:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqx44-0004D7-KA
	for gcvg-git@gmane.org; Wed, 23 May 2007 22:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbXEWUDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 16:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757291AbXEWUDx
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 16:03:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44994 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbXEWUDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 16:03:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523200351.RAIQ15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 16:03:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2k3l1X00B1kojtg0000000; Wed, 23 May 2007 16:03:50 -0400
In-Reply-To: <20070523195823.GA2554@steel.home> (Alex Riesen's message of
	"Wed, 23 May 2007 21:58:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48170>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Wed, May 23, 2007 20:22:57 +0200:
>> "Alex Riesen" <raa.lkml@gmail.com> writes:
>> 
>> > Otherwise the merge.summary option has no visible effect.
>> 
>> I suspect you are mistaking a different merge summary.  The
>> option affects fmt-merge-msg, iow, the shortlog looking summary
>> that appears as the commit message in a merge commit.
>> 
>> The command line parameter --no-summary inhibits the diffstat
>> given to the terminal after "git-pull/git-merge" is made.
>> 
>
> I did it again, didn't I?! :)

You could argue that it is not your fault but is a faulty and
misleading documentation, if you supply a patch to clarify it
;-).

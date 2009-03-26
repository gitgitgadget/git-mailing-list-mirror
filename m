From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/2] Make local branches behave like remote branches when
 --tracked
Date: Thu, 26 Mar 2009 21:57:25 +0100
Message-ID: <49CBEC35.7030403@drmicha.warpmail.net>
References: <alpine.LNX.1.00.0903201358440.19665@iabervon.org> <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Mar 26 21:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmwfL-0002FJ-QT
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 21:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983AbZCZU5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 16:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbZCZU5e
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 16:57:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33120 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755601AbZCZU5d (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 16:57:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id DC8CA2FF08A;
	Thu, 26 Mar 2009 16:57:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Mar 2009 16:57:31 -0400
X-Sasl-enc: tu9R5keOAFalfp/lnzWQeMvebrDrWslmKPc0SttxIJsa 1238101051
Received: from localhost.localdomain (p4FC63417.dip0.t-ipconnect.de [79.198.52.23])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D0C7D5903;
	Thu, 26 Mar 2009 16:57:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114819>

Michael J Gruber venit, vidit, dixit 26.03.2009 21:53:
> [Sorry it took so long to finish... This is from my "sick bed", I hope
> it doesn't show ;)]
> 
> This mini series makes local branches behave the same as remote ones
> when they are used as --tracked branches. This means differences are
> reported by git status and git checkout, and also that the soon to be
> released tracking branch short cut (aka BEL) will work.
> 
> Michael J Gruber (2):
>   Test for local branches being followed with --track
>   Make local branches behave like remote branches when --tracked
> 
>  remote.c                 |    9 +++++----
>  t/t6040-tracking-info.sh |   10 +++++++++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 

Sorry, I meant to point out also that 2/2 changes the display format of
the branch: refs/ is removed rather than refs/remotes/, if present. This
makes for unique branch names ready to copy&paste (they were not
necessarily unique before).

Michael

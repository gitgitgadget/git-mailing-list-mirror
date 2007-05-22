From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revert/cherry-pick: allow the last parameter to be -h
Date: Tue, 22 May 2007 15:23:39 -0700
Message-ID: <7vwsz07b10.fsf@assigned-by-dhcp.cox.net>
References: <20070522212945.GA8002@diku.dk>
	<20070522221156.GL30871@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 00:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqclc-0001VP-Lj
	for gcvg-git@gmane.org; Wed, 23 May 2007 00:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbXEVWXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 18:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759688AbXEVWXl
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 18:23:41 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54537 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbXEVWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 18:23:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070522222340.HBYY19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 22 May 2007 18:23:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2NPf1X00L1kojtg0000000; Tue, 22 May 2007 18:23:40 -0400
In-Reply-To: <20070522221156.GL30871@steel.home> (Alex Riesen's message of
	"Wed, 23 May 2007 00:11:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48128>

Alex Riesen <raa.lkml@gmail.com> writes:

> Jonas Fonseca, Tue, May 22, 2007 23:29:45 +0200:
>> +	if (!strcmp(arg, "-h"))
>> +		usage(usage_str);
>
>     $ git rev-list --usage
>     usage: git-rev-list [OPTION] <commit-id>... [ -- paths... ]
>       limiting output:
> 	--max-count=nr
> 	--max-age=epoch
>     ...
>
> Why should cherry-pick be different?

Good question.  FYI

	$ git rev-list --huh?

works equally well ;-)

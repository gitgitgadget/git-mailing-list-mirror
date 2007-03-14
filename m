From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Tue, 13 Mar 2007 18:23:50 -0700
Message-ID: <7v1wjsipnd.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<Pine.LNX.4.63.0703140201240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:23:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRIDa-0002sx-5g
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbXCNBXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbXCNBXv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:23:51 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43199 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbXCNBXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:23:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314012351.SGLW24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Mar 2007 21:23:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aRPq1W00Y1kojtg0000000; Tue, 13 Mar 2007 21:23:51 -0400
In-Reply-To: <Pine.LNX.4.63.0703140201240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 14 Mar 2007 02:03:16 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42165>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 14 Mar 2007, Alex Riesen wrote:
>
>> This introduces a new command-line option: --exit-code. The diff 
>> programs will return 1 for differences, return 0 for equality, and 
>> something else for errors.
>
> I am not convinced that this exit code (even if expected by experience) 
> makes sense. A diff should _only_ fail if anything goes _wrong_, not if 
> the files are _different. That is what cmp is for, no?

Not really, if you are used to use diff as a replacement for
cmp.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb not friendly to firefox?
Date: Thu, 01 Mar 2007 22:51:06 -0800
Message-ID: <7v1wk8i1et.fsf@assigned-by-dhcp.cox.net>
References: <7v4pp4ntpo.fsf@assigned-by-dhcp.cox.net>
	<989B956029373F45A0B8AF02970818902DA7E4@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <rea-git@codelabs.ru>,
	"Raimund Bauer" <ray@softwarelandschaft.com>,
	<git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 07:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN1bl-0003Im-2h
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 07:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422975AbXCBGvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 01:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422976AbXCBGvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 01:51:09 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55049 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422975AbXCBGvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 01:51:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302065107.LRST24587.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 01:51:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vir61W00A1kojtg0000000; Fri, 02 Mar 2007 01:51:07 -0500
In-Reply-To: <989B956029373F45A0B8AF02970818902DA7E4@zch01exm26.fsl.freescale.net>
	(Li Yang-r's message of "Fri, 2 Mar 2007 14:47:59 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41162>

"Li Yang-r58472" <LeoLi@freescale.com> writes:

>> > Yes, you are right.  But why gitweb didn't do that for me?  I
> observed
>> > that some early version of gitweb doesn't have this problem.  Is it
>> > possible that some new change caused this?
>> 
>> It's very possible.
>
> Well, I had found out that the escapeHTML() is not functioning on my
> server.  It leaves the "<", ">", "@" unchanged.  Does anyone have a clue
> about it?  I'm using Redhat 9.0 full installation.

I am not sure offhand if escapeHTML implementation is wrong or
the call site is calling escapeHTML when it should be using some
other kinds of escape.

The person who knows about this issue the best, if I have to
guess, would be Jakub Narebski.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 14:53:26 -0800
Message-ID: <7vwt3mwpll.fsf@assigned-by-dhcp.cox.net>
References: <45AC3B5D.6080700@midwinter.com>
	<Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com>
	<Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45AD383E.50105@midwinter.com>
	<Pine.LNX.4.63.0701162218070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<eojh8r$9e6$1@sea.gmane.org>
	<2696299C-A54D-4A7E-BA3B-029C8E4B278D@silverinsanity.com>
	<Pine.LNX.4.63.0701162350150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 23:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6xBK-0005Ok-S9
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 23:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbXAPWx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 17:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbXAPWx3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 17:53:29 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39551 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbXAPWx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 17:53:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070116225327.SHRB7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 16 Jan 2007 17:53:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BysZ1W0131kojtg0000000; Tue, 16 Jan 2007 17:52:34 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701162350150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 16 Jan 2007 23:51:36 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36978>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I'd put a simple patch to add the reset to git-merge.sh, but I'm not sure I
>> understand what --skip is doing in there with a 30 second peek.
>
> Better put "git reset --hard" into git-rebase.sh... Just search for 
> "--skip" and you will find where it has to go.

I'd later want to allow starting rebase from a dirty working
tree as long as the rebasing of the entire series would not
conflict with the local changes, so I would seriously prefer a
solution without "reset --hard".

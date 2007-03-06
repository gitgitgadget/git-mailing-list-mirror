From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 05 Mar 2007 17:58:26 -0800
Message-ID: <7v8xebuo8t.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	<7vejo3xuq9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703060137210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd53nupg9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703060242130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:58:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOOwo-0004Hr-ES
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 02:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965531AbXCFB6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 20:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbXCFB63
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 20:58:29 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35754 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933849AbXCFB61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 20:58:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306015827.DPAA3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 20:58:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XDyS1W00y1kojtg0000000; Mon, 05 Mar 2007 20:58:27 -0500
In-Reply-To: <Pine.LNX.4.63.0703060242130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Mar 2007 02:44:28 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41525>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I missed that, too. Maybe I should get more familiar with the revision 
> walker first,...

No.  You are asking the right questions and helped finding a few
bugs already.

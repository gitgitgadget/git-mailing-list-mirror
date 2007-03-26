From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added options NO_TCLTK, WITH_P4IMPORT and --with-tcltk/--without-tcltk.
Date: Mon, 26 Mar 2007 01:27:54 -0700
Message-ID: <7v1wjcz9x1.fsf@assigned-by-dhcp.cox.net>
References: <etpuen$2uo$2@sea.gmane.org> <20070321051406.GW96806@codelabs.ru>
	<Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321115004.GB14837@codelabs.ru>
	<Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321144008.GE14837@codelabs.ru>
	<Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321160126.GH14837@codelabs.ru>
	<7v1wji371q.fsf@assigned-by-dhcp.cox.net>
	<20070326073143.GB44578@codelabs.ru>
	<20070326073250.GC44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Mon Mar 26 10:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVkZ4-0004RK-9f
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 10:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXCZI14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 04:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbXCZI14
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 04:27:56 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36812 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbXCZI1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 04:27:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326082754.ZWMI28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 04:27:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fLTu1W0021kojtg0000000; Mon, 26 Mar 2007 04:27:54 -0400
In-Reply-To: <20070326073250.GC44578@codelabs.ru> (Eygene Ryabinkin's message
	of "Mon, 26 Mar 2007 11:32:50 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43128>

Please do not mix P4IMPORT and TCLTK issues in the same patch.
As I am still not convinced about what to do with NO_TCLTK, this
forces people who might want to see P4IMPORT to wait longer than
necessary.

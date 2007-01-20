From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not verify filenames in a bare repository
Date: Fri, 19 Jan 2007 16:56:03 -0800
Message-ID: <7vmz4ebjoc.fsf@assigned-by-dhcp.cox.net>
References: <eoqc09$454$2@sea.gmane.org>
	<Pine.LNX.4.63.0701200149010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84Wg-0003rG-MP
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbXATA4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbXATA4H
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:56:07 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36877 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965040AbXATA4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:56:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120005603.RVNQ19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 19:56:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DCwM1W00B1kojtg0000000; Fri, 19 Jan 2007 19:56:21 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200149010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 01:52:16 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37235>

This feels very sane.  Thanks.

A handful tests to make sure it catches the cases wants to catch
and it does not hiccup with the cases it shouldn't catch would
be appropriate, though.

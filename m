From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 09:17:21 -0700
Message-ID: <7v1wji371q.fsf@assigned-by-dhcp.cox.net>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org>
	<20070321051406.GW96806@codelabs.ru>
	<Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321115004.GB14837@codelabs.ru>
	<Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321144008.GE14837@codelabs.ru>
	<Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321160126.GH14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Mar 21 17:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU3VH-0003A9-Te
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 17:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbXCUQRY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 12:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932886AbXCUQRY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 12:17:24 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:40790 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbXCUQRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 12:17:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321161722.PXVV1312.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 12:17:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dUHN1W0061kojtg0000000; Wed, 21 Mar 2007 12:17:22 -0400
In-Reply-To: <20070321160126.GH14837@codelabs.ru> (Eygene Ryabinkin's message
	of "Wed, 21 Mar 2007 19:01:26 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42801>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Technically, the checks in Makefile will look as 'ifndef NO_GUI && NO_TCL_TK'
> instead of 'ifndef NO_GUI'. Later they can diverge as the software will
> evolve.
>
> Are people happy with such plan?

Maybe later you might even want to view the graphical history
from the server displaying on remote X, who knows?

We have NO_CURL and such because lack of the necessary libraries
and headers prevent your build from completing, but in the case
of git-gui and gitk, they are just scripts and you would not
have any trouble in building.  I do not know if adding more
conditional to Makefile in order to skip them is worth it.

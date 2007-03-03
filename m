From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --amend Rename --pretty=changelog to --pretty=gnucl
Date: Sat, 03 Mar 2007 12:07:11 -0800
Message-ID: <7vlkie9jm8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702272147590.29426@xanadu.home>
	<Pine.LNX.4.63.0702281343200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslcoghcd.fsf@assigned-by-dhcp.cox.net>
	<7v649icxis.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703031511300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 03 21:07:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNaVi-0000MI-Gb
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 21:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbXCCUHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 15:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXCCUHO
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 15:07:14 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42023 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbXCCUHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 15:07:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303200713.RVOG2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 15:07:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WL7C1W0091kojtg0000000; Sat, 03 Mar 2007 15:07:13 -0500
In-Reply-To: <Pine.LNX.4.63.0703031511300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 3 Mar 2007 15:13:19 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41320>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> $ git show ':/print_wrapped_text: fix output for negative indent'

I forgot that your patch is relative to 'next'.  Silly me.

I cannot fork a topic directly from 'next', but I always test
topics in isolation first.  And I forgot that this topic
depended on that fix.

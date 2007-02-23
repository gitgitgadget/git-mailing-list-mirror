From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-diff: fix combined diff
Date: Thu, 22 Feb 2007 21:22:05 -0800
Message-ID: <7vbqjlbg8y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702230517480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 06:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1HKSxW-0006Wq-HV
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 06:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbXBWFWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 00:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXBWFWH
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 00:22:07 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52979 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbXBWFWH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 00:22:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223052206.SMVI2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 00:22:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id StN51W00F1kojtg0000000; Fri, 23 Feb 2007 00:22:05 -0500
In-Reply-To: <Pine.LNX.4.63.0702230517480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Feb 2007 05:20:32 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40415>

With this,

	$ git diff maint master next pu

starts working as planned ;-).

Thanks.

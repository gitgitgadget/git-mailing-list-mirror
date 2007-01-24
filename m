From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff --check: use colour
Date: Wed, 24 Jan 2007 15:18:33 -0800
Message-ID: <7vr6tkdnee.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 00:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9rO7-0002EW-He
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 00:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbXAXXSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 18:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbXAXXSf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 18:18:35 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55460 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872AbXAXXSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 18:18:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124231834.LPZN19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 18:18:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FBJs1W00e1kojtg0000000; Wed, 24 Jan 2007 18:18:53 -0500
In-Reply-To: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 24 Jan 2007 15:05:48 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37690>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Reuse the colour handling of the regular diff.

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Reuse the colour handling of the regular diff.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>
> 	Is it possible that diff_get_color() _never_ returns NULL?
> 	Then diff.c can be further cleaned up...

Does anybody actually use "diff --check"?  We could lose more
code by removing the option altogether ;-)

Seriously, this option needs to be documented.  Volunteers?

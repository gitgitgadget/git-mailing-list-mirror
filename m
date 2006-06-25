From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport: setup indexes correctly for ancestors and incremental imports
Date: Sat, 24 Jun 2006 20:10:36 -0700
Message-ID: <7v64iqq6ab.fsf@assigned-by-dhcp.cox.net>
References: <11511475882820-git-send-email-martin@catalyst.net.nz>
	<Pine.LNX.4.63.0606242111250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 05:10:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuL1F-00070R-Sm
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 05:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWFYDKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 23:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWFYDKi
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 23:10:38 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:9430 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751359AbWFYDKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 23:10:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625031037.GKPP19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 23:10:37 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606242111250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 24 Jun 2006 21:42:20 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22580>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about this on top of your patch (which fixes things with my setup):
>
> ---
> [PATCH] cvsimport: always set $ENV{GIT_INDEX_FILE} to $index{$branch}
>
> Also, make sure that the initial git-read-tree is performed.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---

Please please please do not use --- between the cover letter and
commit message body if you choose to do the cover letter first.

Superficial look tells me this would be OK, so it will go to
"next".  Please fix things up as needed and let's have this in
upcoming 1.4.1 whenever that happens.

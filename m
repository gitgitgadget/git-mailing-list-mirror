From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] enable rerere by default
Date: Tue, 06 Feb 2007 15:06:41 -0800
Message-ID: <7vhctyhon2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702061103070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0702060556r3e366defwe4b7afabdf5ffb7c@mail.gmail.com>
	<Pine.LNX.4.63.0702061602360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 00:07:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEZOf-0003rj-UZ
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 00:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbXBFXGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 18:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbXBFXGn
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 18:06:43 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:55407 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030507AbXBFXGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 18:06:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206230642.UQQK1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 18:06:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LP6h1W00u1kojtg0000000; Tue, 06 Feb 2007 18:06:42 -0500
In-Reply-To: <Pine.LNX.4.63.0702061602360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Feb 2007 16:03:58 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> How do I disable rerere by default?
>
> How'd you like it? Should this rather become a config variable, or do you 
> want to make a file called "rr-cache" in the templates, which just 
> contains a word "disabled"? (git-rerere checks if a _directory_ 
> $GIT_DIR/rr-cache exists.)

Is it so bad to do "rm -rf .git/rr-cache"?

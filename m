From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Fri, 23 Feb 2007 17:29:29 -0800
Message-ID: <7vvehs1gxy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKljC-0002P0-Bi
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933314AbXBXB3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933316AbXBXB3b
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:29:31 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57541 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933314AbXBXB3a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:29:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224012930.PZGE2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 20:29:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TDVW1W0081kojtg0000000; Fri, 23 Feb 2007 20:29:30 -0500
In-Reply-To: <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 24 Feb 2007 02:19:55 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40481>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since most servers will not have a no-progress aware upload-pack, how 
> about this? (It is slightly ugly, but at least works...)

Please no.

What's "slight" about this ugliness?

> +		if (no_progress && band != 3 && len > 7 + 5 &&
> +				!prefixcmp(buf + 7 + len - 5, "done\r"))
> +			continue;

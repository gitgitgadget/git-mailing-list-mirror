From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 04 May 2007 12:22:24 -0700
Message-ID: <7v1whwtmvj.fsf@assigned-by-dhcp.cox.net>
References: <463ADE51.2030108@gmail.com>
	<56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	<7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	<463AFAAE.853DEF7B@eudaptics.com>
	<7vabwktsng.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705042104370.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 04 21:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk3MM-0001Bi-3T
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423018AbXEDTW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423019AbXEDTW0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:22:26 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54974 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423018AbXEDTWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:22:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504192226.TXQD1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 15:22:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id v7NQ1W00T1kojtg0000000; Fri, 04 May 2007 15:22:25 -0400
In-Reply-To: <Pine.LNX.4.64.0705042104370.4015@racer.site> (Johannes
	Schindelin's message of "Fri, 4 May 2007 21:06:30 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46203>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW I still find that unintuitive. I know "<something>:<path>" from ssh, 
> and there it does not change meaning depending on where I am. IMHO in most 
> cases you want to use git-diff anyway, which _does_ honour the current 
> relative path.

There, its meaning is relative to where you are, namely "$HOME".

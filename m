From: Junio C Hamano <junkio@cox.net>
Subject: Re: fix t5000-tar-tree.sh when $TAR isn't set
Date: Tue, 08 Nov 2005 11:29:48 -0800
Message-ID: <7vslu7ey4z.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511080245m12ed5fe0ha0ed98ca25e2f6e9@mail.gmail.com>
	<Pine.LNX.4.63.0511081250020.2649@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 20:33:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZZAH-0002pD-OZ
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 20:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVKHT3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 14:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbVKHT3u
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 14:29:50 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:393 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964987AbVKHT3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 14:29:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108192905.GXEW29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 14:29:05 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11349>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You run "sh t5000*" in t/, right? Usually, TAR is set in t/Makefile (that 
> is why it Just Works in the normal case). Note that you can -- instead of 
> your patch -- run "TAR=tar sh t5000*".

Yes, but "cd t && sh ./t5000-*.sh" should work by itself.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch/upload: Fix corner case with few revs
Date: Tue, 25 Oct 2005 10:39:12 -0700
Message-ID: <7vll0hfqdb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510251730200.12176@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 19:39:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUSla-0001k0-S5
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 19:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVJYRjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 13:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVJYRjO
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 13:39:14 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52157 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932239AbVJYRjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 13:39:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025173843.DWLQ29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 13:38:43 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510251730200.12176@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 25 Oct 2005 17:34:07 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10602>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When git-fetch-pack did not have enough revs to send, it did not realize 
> that the server actually speaks multi_ack. The server would now continue 
> sending ack', but the client would try to unpack objects. Oops.

I've already pushed your initial set out to "master", but I
suspect we may be better of if I recall them and let it simmer a
bit longer in the proposed updates branch, and defer them post
0.99.9.  What do you think?

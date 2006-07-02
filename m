From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: replace ugly and unportable sed invocation
Date: Sun, 02 Jul 2006 11:36:07 -0700
Message-ID: <7virmf4zxk.fsf@assigned-by-dhcp.cox.net>
References: <7vr7145u17.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607021109540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 20:36:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx6ns-0002y9-Fp
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 20:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWGBSgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWGBSgJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 14:36:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35510 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932454AbWGBSgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 14:36:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702183608.FDWQ22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 14:36:08 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607021109540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 2 Jul 2006 11:31:30 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23112>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	First of all, it is _ugly_ (three invocations of sed, where one 
> 	really is sufficient). Then, it uses the non-portable ';' 
> 	operator, and then, the non-at-all-portable 'T'.
>
> 	And worst: it is unnecessary.

Thanks -- I was not paying enough attention.

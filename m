From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support username and password inside URL
Date: Thu, 24 Nov 2005 15:01:42 -0800
Message-ID: <7v7jaxmyzt.fsf@assigned-by-dhcp.cox.net>
References: <87u0e71zpx.fsf@litku.valo.iki.fi>
	<873blriqh0.fsf@litku.valo.iki.fi>
	<7vwtj3xe72.fsf@assigned-by-dhcp.cox.net>
	<87d5kraxsr.fsf@litku.valo.iki.fi>
	<7vbr09n16w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242321500.26651@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 00:02:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfQ68-0003bs-M9
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 00:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbVKXXBp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVKXXBp
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 18:01:45 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9416 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932670AbVKXXBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 18:01:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124230105.KYEX6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 18:01:05 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511242321500.26651@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 24 Nov 2005 23:24:06 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12720>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> even if HTTP authentication is not really strong, we could permit at least 
> the username to be specified. The password could come from .netrc. In this 
> manner, it would be possible to use different user names on the same 
> server.

I did not say HTTP authentication in general is not adequate (I
did say that at least digest should be used not basic, though).

How well does curl work with username but without password in a
UR,(e.g. http://joe@host.example.com/frotz/nitfol)?

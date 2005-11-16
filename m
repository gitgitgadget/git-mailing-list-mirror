From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] symref support for import scripts
Date: Wed, 16 Nov 2005 12:26:42 -0800
Message-ID: <7v8xvo730d.fsf@assigned-by-dhcp.cox.net>
References: <1132165648.4024.6.camel@dv>
	<7vu0ec7502.fsf@assigned-by-dhcp.cox.net>
	<20051116195737.GE27727@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 21:28:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTrj-0006LM-QD
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbVKPU0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 15:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbVKPU0p
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:26:45 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32717 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030485AbVKPU0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 15:26:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116202550.LOWB17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 15:25:50 -0500
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051116195737.GE27727@kiste.smurf.noris.de> (Matthias Urlichs's
	message of "Wed, 16 Nov 2005 20:57:37 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12053>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> The only thing we want to do with HEAD, in order to accomplish that,
> is to find the SHA1 it points to, before and after the import.
> No use of git-symbolic-ref is necessary for that.

True.  'git-rev-parse --verify HEAD^0' would be sufficient.

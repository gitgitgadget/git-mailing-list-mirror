From: Junio C Hamano <junkio@cox.net>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 00:03:13 -0800
Message-ID: <7vbr0imlha.fsf@assigned-by-dhcp.cox.net>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
	<7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net>
	<20051118075117.GK31613@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 09:08:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed1De-0001b1-UI
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 09:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVKRIDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 03:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbVKRIDU
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 03:03:20 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:5075 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030403AbVKRIDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 03:03:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118080315.LUTC25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 03:03:15 -0500
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051118075117.GK31613@kiste.smurf.noris.de> (Matthias Urlichs's
	message of "Fri, 18 Nov 2005 08:51:17 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12213>

Matthias Urlichs <smurf@smurf.noris.de> writes:

>>> Files /dev/null and b/file3 differ
>
> Of course, with LANG=de_DE.UTF-8 the situation is worse ...

And at this point it becomes more and more tempting to have our
own internal diff generator, without relying on external diff.

A midway compromise solution would be to detect if either file
is binary ourselves and not to call diff but always say "Binary
files difer".

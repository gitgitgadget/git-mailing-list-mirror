From: David Miller <davem@davemloft.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 17:29:06 -0700 (PDT)
Message-ID: <20070509.172906.71874810.davem@davemloft.net>
References: <7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
	<7vd519r10c.fsf@assigned-by-dhcp.cox.net>
	<7v7irhr08y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu May 10 02:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlwWv-0005xu-Kw
	for gcvg-git@gmane.org; Thu, 10 May 2007 02:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbXEJA3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 20:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755452AbXEJA3J
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 20:29:09 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47695
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755296AbXEJA3H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 20:29:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id D3843510001;
	Wed,  9 May 2007 17:29:06 -0700 (PDT)
In-Reply-To: <7v7irhr08y.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46816>

From: Junio C Hamano <junkio@cox.net>
Date: Wed, 09 May 2007 17:27:41 -0700

> Side note.  Earlier you said:
> 
>    master.kernel.org just upgraded to git-1.5.1.4 and I notice
>    that doing something like this:
> 
>            git clone --bare -n -l -s ../torvalds/linux-2.6.git test-2.6.git
> 
>    is no longer an instantaneous operation, it seems to be doing a lot
>    of stuff now:
> 
> But I do not see any difference between v1.5.1.3 and v1.5.1.4 in
> this area.  In fact, that get_repo_base() shell function has not
> changed since v0.99.

Correct.  I happened to create and start using that symlink
around the same time they upgraded, that's why I made that
(false) connection.

There is no connection between git version and this problem, it's just
the symlink thing.

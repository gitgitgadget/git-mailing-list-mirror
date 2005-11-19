From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 19 Nov 2005 00:48:20 -0800
Message-ID: <7voe4h9g6j.fsf@assigned-by-dhcp.cox.net>
References: <200511181833.40048.ismail@uludag.org.tr>
	<200511182245.01713.ismail@uludag.org.tr>
	<7v7jb5hcm2.fsf@assigned-by-dhcp.cox.net>
	<200511182329.52368.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 09:48:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdOOX-0005O6-3b
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 09:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVKSIsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 03:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVKSIsW
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 03:48:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8446 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750798AbVKSIsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 03:48:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119084706.GXNN17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 03:47:06 -0500
To: Ismail Donmez <ismail@uludag.org.tr>
In-Reply-To: <200511182329.52368.ismail@uludag.org.tr> (Ismail Donmez's
	message of "Fri, 18 Nov 2005 23:29:52 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12324>

Ismail Donmez <ismail@uludag.org.tr> writes:

> Your produced XML is NOT valid then. You put encoding=utf-8 and then put 
> latin-1 encoded data in it. You SHOULD NOT do that. Either put latin-1 as 
> encoding in the RSS because you say its the way data should be else encode 
> non-utf stuff to be utf-8.

Maybe, but that is not me ;-).

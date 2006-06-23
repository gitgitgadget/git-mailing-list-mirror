From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] git-merge --squash
Date: Fri, 23 Jun 2006 14:25:01 +0200
Message-ID: <20060623122501.GD15631@cip.informatik.uni-erlangen.de>
References: <7virmscl2u.fsf@assigned-by-dhcp.cox.net> <7vd5d09pe2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:25:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftkig-0006qP-WA
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWFWMZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWFWMZE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:25:04 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:10997 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S964777AbWFWMZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 08:25:03 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 5F58C305F9; Fri, 23 Jun 2006 14:25:01 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5d09pe2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22413>

Hello Junio,

> So in that sense I would imagine --squash is not really useless
> in such a situation as I made it sound like, but at the same
> time I suspect people might be better off to use tools like
> StGIT which are specially designed to support such a workflow if
> they were to do this.

thanks for --squash. So --squash is basically a 'suck multiple deltas
from another branch into ., but don't commit it'. I very often use that
way of work flow. I do small and many commits, and when I am done I
merge them to one a bit bigger one and submit it upstream. I useally use
'one branch per feature'.

        Thomas

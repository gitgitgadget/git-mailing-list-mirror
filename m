From: Junio C Hamano <junkio@cox.net>
Subject: Re: Which packages/versions are needed to build documentation
Date: Wed, 09 Nov 2005 10:22:57 -0800
Message-ID: <7vr79pfzpa.fsf@assigned-by-dhcp.cox.net>
References: <200511091655.51093.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 19:27:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZubN-0001Tg-Ot
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 19:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030655AbVKISXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 13:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbVKISXJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 13:23:09 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29628 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030655AbVKISXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 13:23:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109182304.PXJ9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 13:23:04 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200511091655.51093.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Wed, 9 Nov 2005 16:55:50 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11407>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> I have just downloaded git-core-0.99f
>
> On my debian unstable system I can build the documentation just fine
>
> On my debian sarge system it fails almost immediately

The debs on kernel.org were done in a chrooted sarge environment
(vanilla + security) with one exception: asciidoc 7.

I tried to make the documentation usable with asciidoc 6 as
well, but it turns out that not having xhtml11 is the least of
the problems with version 6 (see my message the other day).

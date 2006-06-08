From: Junio C Hamano <junkio@cox.net>
Subject: Re: HEAD branch duplicated in remotes/origin
Date: Thu, 08 Jun 2006 09:39:48 -0700
Message-ID: <7vpshj8uuj.fsf@assigned-by-dhcp.cox.net>
References: <20060608073857.GA5072@informatik.uni-freiburg.de>
	<7vverc9i4i.fsf@assigned-by-dhcp.cox.net>
	<20060608123337.GA12456@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 18:40:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoNY1-0005BE-BS
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 18:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWFHQju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 12:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWFHQju
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 12:39:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:65534 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964826AbWFHQju (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 12:39:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060608163949.DLPF19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Jun 2006 12:39:49 -0400
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060608123337.GA12456@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Thu, 8 Jun 2006 14:33:38 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21499>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> I wonder if this is easier not to add the other duplicate.

Unfortunately the above is probably easier.  The other duplicate
is coming from the lowlevel code that makes sure each of the
fetch-pack parameters is not used to match more than once.  We
should fix it eventually, though.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 15:21:04 -0700
Message-ID: <7vzmdwmmy7.fsf@assigned-by-dhcp.cox.net>
References: <200608211739.32993.jnareb@gmail.com>
	<7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org>
	<7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org>
	<7vodudno88.fsf@assigned-by-dhcp.cox.net>
	<86fyfohb4v.fsf@blue.stonehenge.com> <ecfnf0$4bg$1@sea.gmane.org>
	<ecfnqj$5m9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 00:21:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFecQ-0000Et-FB
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 00:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWHVWVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 18:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWHVWVH
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 18:21:07 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44183 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751323AbWHVWVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 18:21:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822222105.QUKH2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 18:21:05 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ecfnqj$5m9$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	22 Aug 2006 22:01:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25876>

Jakub Narebski <jnareb@gmail.com> writes:

> Third, read comment to esc_param:
>
>         # quote unsafe chars, but keep the slash, even when it's not
>         # correct, but quoted slashes look too horrible in bookmarks
>
> I assume that URI module methods do not keep slash...

I do not think so either but I do not necessarily agree with
that comment ;-).

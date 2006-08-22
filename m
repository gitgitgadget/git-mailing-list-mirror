From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 15:26:08 -0700
Message-ID: <7vveokmmpr.fsf@assigned-by-dhcp.cox.net>
References: <200608211739.32993.jnareb@gmail.com>
	<7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org>
	<7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org>
	<7vodudno88.fsf@assigned-by-dhcp.cox.net> <ecenc1$b5o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 00:26:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFehM-00012R-P1
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 00:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWHVW0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 18:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWHVW0K
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 18:26:10 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:44161 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751302AbWHVW0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 18:26:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822222609.CVNP6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 18:26:09 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ecenc1$b5o$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	22 Aug 2006 12:47:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25877>

Jakub Narebski <jnareb@gmail.com> writes:

> URL for search is created and encoded by browser I think, so search
> for "a = b" generates
>
>         gitweb.cgi?p=git.git&a=search&h=HEAD&s=a+%3D+b

which means href() should generate something similar when it
wants to reproduce what the user queried, doesn't it?  I do not
think quoting after joining does, and that is why I asked that
question.

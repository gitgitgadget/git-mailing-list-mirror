From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 16:39:39 -0700
Message-ID: <7v64idey84.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com>
	<7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<44AAF49F.6090008@gmail.com> <e8esnn$mb5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 01:39:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxuUb-0002aQ-Od
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 01:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGDXjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 19:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWGDXjl
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 19:39:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:1505 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932356AbWGDXjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 19:39:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704233940.ZSSN19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 19:39:40 -0400
To: jnareb@gmail.com
In-Reply-To: <e8esnn$mb5$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	05 Jul 2006 01:14:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23330>

Jakub Narebski <jnareb@gmail.com> writes:

> What about timestamp = MAX(now(), timestamps of parents) idea, which
> doesn't need changing the structure of a commit?

It changes the semantics without change syntax, which is not any
better (and in fact I think it is worse).

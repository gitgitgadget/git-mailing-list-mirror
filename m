From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support precise tracking of file modes
Date: Thu, 19 Jan 2006 10:25:03 -0800
Message-ID: <7vacdsdqio.fsf@assigned-by-dhcp.cox.net>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>
	<7vlkxckf7o.fsf@assigned-by-dhcp.cox.net>
	<b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
	<7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
	<43CF3061.2030504@michonline.com>
	<7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
	<20060119094156.GY28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, Adam Hunt <kinema@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 19:29:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzeT9-0001pG-RS
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWASSZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWASSZH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:25:07 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19893 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030275AbWASSZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 13:25:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119182509.SRZP25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 13:25:09 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14923>

Petr Baudis <pasky@suse.cz> writes:

> Taking "quick'n'dirty" to the extreme _and_ combining it with Linus'
> attitude to testing and documentation... ;-)

It is premature for us mere mortals to imitate Linus in that
aspect by at least ten years ;-).  Please don't.

About the content of the change, if we were to do this, we need
to also record owner and group. recording full permissions
without recording owner and group does not make much sense.

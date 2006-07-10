From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Mon, 10 Jul 2006 01:10:13 -0700
Message-ID: <7vmzbhdgnu.fsf@assigned-by-dhcp.cox.net>
References: <20060708183402.GA17644@spearce.org>
	<7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
	<20060708190327.GA17763@spearce.org>
	<20060709073155.GP22573@lug-owl.de>
	<20060710052255.GA15173@spearce.org> <1152512523.3504.28.camel@dv>
	<20060710062513.GZ22573@lug-owl.de> <1152514328.3504.58.camel@dv>
	<20060710073532.GA22573@lug-owl.de>
	<20060710040711.z1h4w0wsgk8sskg4@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 10:10:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzqqS-0007OL-Lg
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 10:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWGJIKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 04:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGJIKQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 04:10:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15260 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751254AbWGJIKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 04:10:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710081014.RELX554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 04:10:14 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20060710040711.z1h4w0wsgk8sskg4@webmail.spamcop.net> (Pavel
	Roskin's message of "Mon, 10 Jul 2006 04:07:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23603>

Pavel Roskin <proski@gnu.org> writes:

> Going all the way to strict c89 could be too much, but fixing
> initializers in a few places is a minor issue.  Users of the
> Sun's compiler can expect us to do such changes,...

I am fully with you on this one.

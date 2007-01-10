From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 01:46:16 -0800
Message-ID: <7vwt3vb4ev.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<20070109142130.GA10633@coredump.intra.peff.net>
	<7virffkick.fsf@assigned-by-dhcp.cox.net>
	<20070109213117.GB25012@fieldses.org>
	<87zm8ryiyz.wl%cworth@cworth.org> <45A4AD08.1020002@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Jeff King <peff@peff.net>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 10:46:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4a2L-0006W9-AF
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 10:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbXAJJqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 04:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbXAJJqS
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 04:46:18 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53148 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769AbXAJJqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 04:46:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110094617.HWUO18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 04:46:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9MlS1W00Q1kojtg0000000; Wed, 10 Jan 2007 04:45:27 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <45A4AD08.1020002@op5.se> (Andreas Ericsson's message of "Wed, 10
	Jan 2007 10:08:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36495>

Andreas Ericsson <ae@op5.se> writes:

> ... Since committing on
> detached heads really should be a very rare case I don't think many
> people will find this terribly annoying.

Quite the contrary, I would imagine it would be quite natural to
do throw-away commits and merges on detached head while
bisecting the history (e.g. commit small fixup to make it
compile and then mark the result for bisection to hunt for real
bugs that are hidden by silly compilation problems).  

The check suggested by Linus would be safe enough for people to
whom it is "very rare" for their workflow to commitg on detached
HEAD anyway, so you should not burden "git commit" with such an
annoying warning messages.

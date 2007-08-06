From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible bug in git apply?
Date: Mon, 06 Aug 2007 02:37:18 -0700
Message-ID: <7vir7tc8c1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
	<alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
	<7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
	<7vabt5dq11.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, git@vger.kernel.org, rob@landley.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 11:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHz1i-0001IW-LH
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 11:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763378AbXHFJhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 05:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763350AbXHFJhV
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 05:37:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62175 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763305AbXHFJhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 05:37:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806093719.LSDC26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 05:37:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YZdJ1X0041kojtg0000000; Mon, 06 Aug 2007 05:37:19 -0400
In-Reply-To: <7vabt5dq11.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 06 Aug 2007 01:29:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55130>

Junio C Hamano <gitster@pobox.com> writes:

> Actually that will break the case of removing foo/bar, which is
> the only file in directory foo, and creating a new file foo.

Sorry.  The creation codepath already has enough code to remove
the left-over directory foo/ when creating the file foo.  I
think your three-step process should be Ok.

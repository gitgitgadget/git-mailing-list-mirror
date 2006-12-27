From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Create 'git gc' to perform common maintenance operations.
Date: Wed, 27 Dec 2006 00:26:36 -0800
Message-ID: <7vhcvh922r.fsf@assigned-by-dhcp.cox.net>
References: <20061227071759.GA23057@spearce.org>
	<7vr6ul93wz.fsf@assigned-by-dhcp.cox.net>
	<20061227075330.GA23022@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 09:26:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzU7V-00042r-0M
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 09:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbWL0I0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 03:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753598AbWL0I0i
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 03:26:38 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36442 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbWL0I0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 03:26:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227082637.BJVU18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 03:26:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3kSq1W00F1kojtg0000000; Wed, 27 Dec 2006 03:26:50 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061227075330.GA23022@spearce.org> (Shawn Pearce's message of
	"Wed, 27 Dec 2006 02:53:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35456>

Shawn Pearce <spearce@spearce.org> writes:

> I don't care either way.  60 days may be too long for some users,
> but for others it may be nice to have.  I think the two defaults
> should match just because.  Feel free to edit my patch before
> applying to be whatever 'git-reflog expire' uses if you want.

I think the built-in git-reflog should be updated to honor the
configuration in the absense of command line options; if we do
that git-gc.sh does not even have to call repo-config anymore.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Tue, 14 Aug 2007 22:25:45 -0700
Message-ID: <7vlkcdjrmu.fsf@assigned-by-dhcp.cox.net>
References: <1186984174.10249.7.camel@localhost>
	<200708131933.10125.m.kozlowski@tuxland.pl>
	<1187026955.2688.4.camel@laptopd505.fenrus.org>
	<1187037445.6628.98.camel@heimdal.trondhjem.org>
	<1187054366.2757.0.camel@laptopd505.fenrus.org>
	<46C10AA8.3090505@gmail.com>
	<20070814102033.604c8695@the-village.bc.nu>
	<46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	<7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
	<1187143925.32555.208.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 07:26:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILBOG-000244-FA
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 07:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbXHOFZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 01:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXHOFZx
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 01:25:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35012 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbXHOFZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 01:25:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070815052552.GUCZ25808.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 15 Aug 2007 01:25:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id c5Rp1X00o1kojtg0000000; Wed, 15 Aug 2007 01:25:50 -0400
In-Reply-To: <1187143925.32555.208.camel@localhost> (Joe Perches's message of
	"Tue, 14 Aug 2007 19:12:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55877>

Joe Perches <joe@perches.com> writes:

> Yes please.

Huh?

> Rene Herman had an idea about using some git
> metadata that might be useful.  The completely
> external data approach suggested by Al Viro 
> might be OK too in that it wouldn't tie listeners
> to git requiring more content in git metadata.

The reason I found Linus's suggestion desirable is because it
fundamentally does not require git to track any metadata.  If
the commits are in git, then his script would let you gather the
data, but otherwise you should be able to do the same by
grepping patches.  Obviously you would need to filter by paths,
looking at the diffstat, but the approach does _not_ tie users
to git.

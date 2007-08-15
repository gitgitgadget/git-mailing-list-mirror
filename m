From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -
	scripts/get_maintainer.pl
Date: Tue, 14 Aug 2007 19:12:05 -0700
Message-ID: <1187143925.32555.208.camel@localhost>
References: <1186984174.10249.7.camel@localhost>
	 <200708131933.10125.m.kozlowski@tuxland.pl>
	 <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	 <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 04:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL8N6-00030M-E1
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 04:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204AbXHOCMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 22:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758153AbXHOCMW
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 22:12:22 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:1136 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757971AbXHOCMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 22:12:20 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id TAA25143;
	Tue, 14 Aug 2007 19:34:27 -0700
In-Reply-To: <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55875>

On Tue, 2007-08-14 at 18:31 -0700, Junio C Hamano wrote:
>    On the other hand, git-send-email _is_ all about sending it
>    out, and it needs to know who your patch should reach.  I
>    think it makes sense to have one script that, given a set of
>    paths that are affected, gives a list of potentially
>    interested people (that is "Finding" part -- and I see there
>    are 600+ patches to implement this on the list), and a new
>    option to git-send-email to (1) inspect the patch to see what
>    paths are affected, and (2) call that "Find" script to figure
>    out whom to send it to, and probably asking for confirmation.

Yes please.

The LK MAINTAINERS file is ugly.

Might there be a git portable way to "find"?

Rene Herman had an idea about using some git
metadata that might be useful.  The completely
external data approach suggested by Al Viro 
might be OK too in that it wouldn't tie listeners
to git requiring more content in git metadata.

Perhaps both via something like:

	--external-find "cmd @filelist"

Thanks,  Joe

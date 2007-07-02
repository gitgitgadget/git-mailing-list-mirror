From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document git-stash
Date: Mon, 2 Jul 2007 00:10:46 -0400
Message-ID: <20070702041046.GB17384@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0706301853400.4438@racer.site> <200707010533.l615XiH6006728@mi1.bluebottle.com> <20070701080757.GA6093@coredump.intra.peff.net> <7vlkdz4wp3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 06:10:54 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5DFS-0006lk-HT
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 06:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbXGBEKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 00:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXGBEKs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 00:10:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3693 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbXGBEKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 00:10:48 -0400
Received: (qmail 10656 invoked from network); 2 Jul 2007 04:11:08 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 2 Jul 2007 04:11:08 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2007 00:10:46 -0400
Content-Disposition: inline
In-Reply-To: <7vlkdz4wp3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51339>

On Sun, Jul 01, 2007 at 02:54:00PM -0700, Junio C Hamano wrote:

> I would further suggest that we _require_ 'git stash save' to
> create a new one and perhaps make the non-subcommand case run
> 'git stash list'.  While I was trying the code out I
> accidentally created a new stash when I did not mean to, which
> pushed the stash I wanted to apply down in the list every time I
> made such a mistake.

I think that makes sense...it's somehow cleaner to me if the
non-subcommand case doesn't make any changes (maybe just because I like
to explore commands by running them).

I see you have already applied this change. However, you missed a spot
in the documentation. Patch will follow, along with a couple of minor
cleanups for the script.

-Peff

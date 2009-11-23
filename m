From: Petr Baudis <pasky@suse.cz>
Subject: Re: how to suppress progress percentage in git-push
Date: Mon, 23 Nov 2009 16:50:43 +0100
Message-ID: <20091123155043.GA28963@machine.or.cz>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bill lam <cbill.lam@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 16:51:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCbBl-0000E8-ME
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 16:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbZKWPul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 10:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbZKWPuk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 10:50:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:45442 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbZKWPuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 10:50:40 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id E2766125A0EC; Mon, 23 Nov 2009 16:50:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091123145959.GA13138@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133505>

On Mon, Nov 23, 2009 at 10:00:00AM -0500, Jeff King wrote:
> The patch for (1) would look something like what's below.  It's simpler,
> but it does change the semantics; anyone who was relying on
> --all-progress to turn on progress unconditionally would need to now
> also use --progress. However, turning on progress unconditionally is
> usually an error (the except is if you are piping output in real-time to
> the user and need to overcome the isatty check).

I'm actually doing exactly that in the mirrorproj.cgi of Girocco, so I
would be unhappy if I would have to go through creating ptys or whatever
now. Maybe conditioning this by an environment variable?

				Petr "Pasky" Baudis

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Mon, 26 Mar 2007 15:03:04 -0400
Message-ID: <20070326190304.GB31844@coredump.intra.peff.net>
References: <20070326073502.GD44578@codelabs.ru> <7vwt14xvaw.fsf@assigned-by-dhcp.cox.net> <20070326083617.GG13247@spearce.org> <7v8xdkxukt.fsf@assigned-by-dhcp.cox.net> <20070326100857.GW14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVuTX-0000ge-Am
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 21:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbXCZTDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 15:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbXCZTDJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 15:03:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2496 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbXCZTDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 15:03:07 -0400
Received: (qmail 23797 invoked from network); 26 Mar 2007 19:03:36 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 Mar 2007 19:03:36 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2007 15:03:04 -0400
Content-Disposition: inline
In-Reply-To: <20070326100857.GW14837@codelabs.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43176>

On Mon, Mar 26, 2007 at 02:08:57PM +0400, Eygene Ryabinkin wrote:

> I do not like the left/right keys: it is wery hard to get the
> right typing speed if we're using the arrow keys. But it is just
> my habit since I learned to 10 fingers typing.

You might try:

cat >>$HOME/.lesskey <<'EOF'
h left-scroll
l right-scroll
EOF
lesskey

-Peff

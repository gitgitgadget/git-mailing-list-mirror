From: Jeff King <peff@peff.net>
Subject: Re: git-fetch will leave a ref pointing to a tag
Date: Tue, 3 Jul 2007 00:18:59 -0400
Message-ID: <20070703041859.GB4007@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0707022207420.4071@racer.site> <20070703032315.7279.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Jul 03 06:19:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Zqx-0006br-Jq
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbXGCETB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXGCETB
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:19:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2098 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbXGCETA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 00:19:00 -0400
Received: (qmail 25947 invoked from network); 3 Jul 2007 04:19:21 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Jul 2007 04:19:21 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2007 00:18:59 -0400
Content-Disposition: inline
In-Reply-To: <20070703032315.7279.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51451>

On Mon, Jul 02, 2007 at 11:23:15PM -0400, linux@horizon.com wrote:

> And until git-merge-ff is available, what's the recommended way to
> "advance master to tag <foo>, but only if that wouldn't lose anything?"

You can ask "do I have anything that foo doesn't?":

  test "`git-rev-list foo.. | wc -l`" -gt 0

-Peff

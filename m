From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] git config --get-colorbool
Date: Thu, 6 Dec 2007 00:35:14 -0500
Message-ID: <20071206053514.GA23201@coredump.intra.peff.net>
References: <475697BC.2090701@viscovery.net> <1196906706-11170-1-git-send-email-gitster@pobox.com> <1196906706-11170-2-git-send-email-gitster@pobox.com> <20071206053059.GF5499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 06:35:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J09Od-0002Vz-96
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 06:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXLFFfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 00:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbXLFFfS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 00:35:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2109 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbXLFFfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 00:35:17 -0500
Received: (qmail 28013 invoked by uid 111); 6 Dec 2007 05:35:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 00:35:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 00:35:14 -0500
Content-Disposition: inline
In-Reply-To: <20071206053059.GF5499@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67244>

On Thu, Dec 06, 2007 at 12:30:59AM -0500, Jeff King wrote:

> Also, your patch doesn't seem to implement the color.pager/pager.color
> behavior, either (which is probably not important for git-add -i, but is
> used by git-svn).

Oops, maybe I should actually read your patch more carefully before
criticizing. I see that you do handle pager_use_color in
git_config_colorbool, but I think that for --get-colorbool usage,
pager_in_use is going to be useless (wow, three forms of "use" in one
clause).

-Peff

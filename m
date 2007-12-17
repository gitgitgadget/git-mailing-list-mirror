From: Jeff King <peff@peff.net>
Subject: Re: Solaris install error: didn't get git-init link was [Fwd: Re:
	The Reposithon!  Take 2]
Date: Mon, 17 Dec 2007 10:13:05 -0500
Message-ID: <20071217151305.GA21750@coredump.intra.peff.net>
References: <47668ABB.9000504@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 16:15:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Hex-0002jQ-G6
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 16:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbXLQPNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 10:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbXLQPNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 10:13:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1490 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367AbXLQPNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 10:13:08 -0500
Received: (qmail 9534 invoked by uid 111); 17 Dec 2007 15:13:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 10:13:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 10:13:05 -0500
Content-Disposition: inline
In-Reply-To: <47668ABB.9000504@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68570>

On Tue, Dec 18, 2007 at 03:42:03AM +1300, Sam Vilain wrote:

> Refer attached ... 1.5.3.6 install, didn't get git-init link to git.
> Ring any bells?

I just tried it and it worked OK. Note that the hardlinks are the _last_
part of the install procedure, even after doing the perl and git-gui
subdirectories. Are we sure the "make install" actually made it to
completion?

-Peff

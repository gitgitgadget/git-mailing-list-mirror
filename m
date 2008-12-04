From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 4 Dec 2008 13:51:38 -0500
Message-ID: <20081204185138.GA24858@coredump.intra.peff.net>
References: <49382612.3010207@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:53:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8JK2-0000Fp-O7
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 19:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762AbYLDSvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 13:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613AbYLDSvl
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 13:51:41 -0500
Received: from peff.net ([208.65.91.99]:2087 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755621AbYLDSvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 13:51:40 -0500
Received: (qmail 7009 invoked by uid 111); 4 Dec 2008 18:51:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 04 Dec 2008 13:51:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2008 13:51:38 -0500
Content-Disposition: inline
In-Reply-To: <49382612.3010207@fs.ei.tum.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102356>

On Thu, Dec 04, 2008 at 07:48:50PM +0100, Simon 'corecode' Schubert wrote:

> Boyd Stephen Smith Jr. wrote:
> > I'm thinking your sed line doesn't do what you think it does.  You  
> probably
> > want something like:
> > bss@monster:~$ echo "don't" | sed -e "s/'/'\\\\''/g"
> > don'\''t
>
> Thanks, I clearly did not test this well enough.

Maybe it would be a good idea to add a test to the test script, then?

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [bug?] git-format-patch produces a 0-byte long patch for the
	first commit
Date: Tue, 24 Mar 2009 03:54:24 -0400
Message-ID: <20090324075424.GC32400@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0903231119110.4871@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 24 08:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1UR-0003z9-0w
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 08:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbZCXHye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 03:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754406AbZCXHyd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 03:54:33 -0400
Received: from peff.net ([208.65.91.99]:60601 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbZCXHyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 03:54:33 -0400
Received: (qmail 27568 invoked by uid 107); 24 Mar 2009 07:54:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 03:54:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 03:54:24 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0903231119110.4871@axis700.grange>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114410>

On Mon, Mar 23, 2009 at 11:34:07AM +0100, Guennadi Liakhovetski wrote:

> mkdir x
> cd x
> git-init
> echo hi > greating
> git-commit -a
> git-format-patch -1
> 
> produces a 0-byte long patch. git-format-patch HEAD^ produces an error, 
> whereas with more than one commit it produces tha last patch. Yes, I know 
> about "--root" and that it does allow to extract the very first commit.

What version of git are you using? I believe the 0-byte diff has been
fixed since git 1.6.1.1.

-Peff

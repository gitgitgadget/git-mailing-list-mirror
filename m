From: Jeff King <peff@peff.net>
Subject: Re: Update a bare repository
Date: Tue, 17 Jul 2007 03:31:15 -0400
Message-ID: <20070717073115.GA14629@coredump.intra.peff.net>
References: <20070717063026.GA5823@cip.informatik.uni-erlangen.de> <20070717070428.GA13266@coredump.intra.peff.net> <20070717072635.GG5823@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 09:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAhWj-0002ix-Al
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 09:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbXGQHbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 03:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbXGQHbS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 03:31:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1905 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbXGQHbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 03:31:17 -0400
Received: (qmail 13653 invoked from network); 17 Jul 2007 07:31:44 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 17 Jul 2007 07:31:44 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2007 03:31:15 -0400
Content-Disposition: inline
In-Reply-To: <20070717072635.GG5823@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52745>

On Tue, Jul 17, 2007 at 09:26:35AM +0200, Thomas Glanzmann wrote:

> > The simplest thing is not to give write access to the repo for your
> > pushers. However, you could also put in a pre-receive hook that rejects
> > all pushes.
> 
> Is there an example somewhere?

Not that I know of, but it should be as simple as:

echo "echo Sorry, no pushing allowed.; exit 1" >.git/hooks/pre-receive
chmod +x .git/hooks/pre-receive

-Peff

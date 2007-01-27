From: Jeff King <peff@peff.net>
Subject: Re: Problems with branches
Date: Sat, 27 Jan 2007 08:13:56 -0500
Message-ID: <20070127131355.GA2417@coredump.intra.peff.net>
References: <4b73d43f0701261551oef411f7tfd5cdbfdce7f6abc@mail.gmail.com> <7vfy9xtjxs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Rigby <jcrigby@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 14:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAnNb-0002Ax-2q
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 14:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbXA0NN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 08:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbXA0NN7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 08:13:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3293 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751811AbXA0NN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 08:13:59 -0500
Received: (qmail 15309 invoked from network); 27 Jan 2007 08:14:21 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Jan 2007 08:14:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Jan 2007 08:13:56 -0500
Content-Disposition: inline
In-Reply-To: <7vfy9xtjxs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37952>

On Fri, Jan 26, 2007 at 04:03:27PM -0800, Junio C Hamano wrote:

> Probably you are using v1.4.4.X.
> 
> The change to make git-merge accessible as the first level UI
> happened during the preparation for the upcoming v1.5.0, and is
> available only in v1.5.0-rc0 and newer versions (the latest is
> at v1.5.0-rc2).

This highlights a problem with the current web pages. The documentation
at http://www.kernel.org/pub/software/scm/git/docs/ is for the current
master (which is presumably where this user got the tutorial mentioning
'git merge' as porcelain). But I suspect a lot of people will be using
the latest released version (either from the tarball, or a binary
package). We could:
  1. Only re-publish the web doc at time of release
  2. Build the published web doc from 'maint' instead of master
  3. Publish (and clearly mark) both last-released and master doc
  4. Disregard it; this particular release made a lot of UI changes, but
     we're not likely run into this for most releases.

-Peff

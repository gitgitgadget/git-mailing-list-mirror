From: Jeff King <peff@peff.net>
Subject: Re: Commit to other branch
Date: Mon, 31 May 2010 19:50:17 -0400
Message-ID: <20100531235016.GB13698@sigill.intra.peff.net>
References: <4C03D9C1.1060404@cedarsoft.com>
 <vpq8w70m3wf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schneider <mailings@cedarsoft.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 01 01:50:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJEkT-0002Cx-JQ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 01:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab0EaXuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 19:50:21 -0400
Received: from peff.net ([208.65.91.99]:43137 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930Ab0EaXuU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 19:50:20 -0400
Received: (qmail 20505 invoked by uid 107); 31 May 2010 23:50:25 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 May 2010 19:50:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 May 2010 19:50:17 -0400
Content-Disposition: inline
In-Reply-To: <vpq8w70m3wf.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148058>

On Mon, May 31, 2010 at 06:28:48PM +0200, Matthieu Moy wrote:

> Johannes Schneider <mailings@cedarsoft.com> writes:
> 
> > I tried to "git stash "
> > But then *all* changes are stashed (including my changes)...
> 
> Not completely answering the question, but "git stash -k"
> (--keep-index) allows you to do a selective stash. If you have

Also, recent versions of git have "git stash -p" to interactively stash
just a few changes.

-Peff

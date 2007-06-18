From: Jeff King <peff@peff.net>
Subject: Re: Stupid quoting...
Date: Mon, 18 Jun 2007 12:19:33 -0400
Message-ID: <20070618161933.GC4662@sigill.intra.peff.net>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org> <86ir9l1ylc.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 18:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Jx5-0000R1-Lu
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 18:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759231AbXFRQTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 12:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbXFRQTi
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 12:19:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3295 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758679AbXFRQTh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 12:19:37 -0400
Received: (qmail 15226 invoked from network); 18 Jun 2007 16:19:51 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 18 Jun 2007 16:19:51 -0000
Received: (qmail 6009 invoked by uid 1000); 18 Jun 2007 16:19:33 -0000
Content-Disposition: inline
In-Reply-To: <86ir9l1ylc.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50401>

On Mon, Jun 18, 2007 at 10:00:31AM +0200, David Kastrup wrote:

> > 7-bit email.
> 
> I think it can be reasonably safely assumed that people using 8-bit
> characters in file names will not refrain from using them in the files

Not to mention the commit messages.

But more importantly, diffs aren't necessarily going through mail. When
I run 'git-show', this isn't useful to me:

diff --git "a/ni\303\261o" "b/ni\303\261o"

I can only imagine how git-show might look to somebody using all-utf8
filenames (such as Japanese).

-Peff

From: Ray Lehtiniemi <rayl@mail.com>
Subject: Re: Can you do this with GIT?
Date: Fri, 27 Jul 2007 13:45:03 -0600
Message-ID: <200707271345.03300.rayl@mail.com>
References: <11834063.post@talk.nabble.com> <Pine.LNX.4.64.0707272002250.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: CPD <cdavidson@altsoftware.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVlK-0005wY-0L
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935713AbXG0TqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935566AbXG0TqB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:46:01 -0400
Received: from static-68-179-52-57.ptr.terago.ca ([68.179.52.57]:37590 "EHLO
	mail.headplay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934568AbXG0Tp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:45:59 -0400
Received: from linux.local ([192.168.1.201])
	by mail.headplay.com with ESMTP; Fri, 27 Jul 2007 13:45:34 -0600
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0707272002250.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53958>

On Friday 27 July 2007 13:05, Johannes Schindelin wrote:
> On Fri, 27 Jul 2007, CPD wrote:

> > We produce variations based on a (mostly) common codebase. In CVS I set
> > up "environment" modules for each platform, then when you are working on
> > that platform, you simply check out the correct environment and build.
> > Only the needed code and tools are exposed in that environment (this is
> > important as clients must NOT see each other's code and most customers
> > have some customization). I do this by defining and renaming modules in
> > the CVSROOT modules file.
>
> I would use branches for that.  A base branch with the common code, and
> the customisations in all the branches, which merge from the base branch.

this would break down if there were client-specific modules in the base 
branch, though... how could those be hidden from the other clients?


ray

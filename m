From: Mirko Stocker <m1stocke@hsr.ch>
Subject: Re: Working with Git and CVS in a team.
Date: Fri, 13 Jun 2008 22:43:36 +0200
Message-ID: <200806132243.36695.m1stocke@hsr.ch>
References: <200806131633.34980.mirko.stocker@hsr.ch> <20080613145010.GU29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 22:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7GEu-0007cq-Ms
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 22:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYFMUuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 16:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYFMUuW
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 16:50:22 -0400
Received: from luc80-74-131-252.ch-meta.net ([80.74.131.252]:36584 "EHLO
	lucius.metanet.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753121AbYFMUuV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 16:50:21 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jun 2008 16:50:21 EDT
Received: (qmail 6896 invoked from network); 13 Jun 2008 22:43:39 +0200
Received: from 77-57-13-126.dclient.hispeed.ch (HELO pluto7) (77.57.13.126)
  by luc80-74-131-153.ch-meta.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 13 Jun 2008 22:43:39 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080613145010.GU29404@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84941>

On Friday 13 June 2008 16:50:10 Miklos Vajna wrote:
> On Fri, Jun 13, 2008 at 04:33:34PM +0200, Mirko Stocker 
<mirko.stocker@hsr.ch> wrote:
> > What I don't like is how we have to make the upstream patch(es). Is
> > there an easy way we can get multiple patches, lets say for each
> > commit we made? Or is it easier to make a lots of branches and to
> > then create a patch from the diff between the branch and origin/origin?
>
> Don't you mean origin/master?

Hm, I'm not sure.. if I work on an a feature in a branch, and now I want to 
create a patch that applies to the CVS head, then I have to make the diff to 
origin/origin, right?

> In general, if you don't merge your changes but you rebase on top of the
> new upstream head, then you can use 'git format-patch origin/master..'
> to create patches for each commit.

Ah, I didn't know about git-rebase, thanks! That's exactly what I wanted :) I 
think I've already fallen in love with git.

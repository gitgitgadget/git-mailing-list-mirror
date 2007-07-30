From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] per-user ignore file
Date: Mon, 30 Jul 2007 16:43:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707301638490.8054@iabervon.org>
References: <Pine.LNX.4.64.0707301612160.8054@iabervon.org>
 <20070730203605.GD2386@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:44:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFc67-0002js-7A
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 22:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967692AbXG3UoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967803AbXG3UoD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 16:44:03 -0400
Received: from iabervon.org ([66.92.72.58]:3303 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967692AbXG3UoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 16:44:01 -0400
Received: (qmail 30173 invoked by uid 1000); 30 Jul 2007 20:43:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jul 2007 20:43:56 -0000
In-Reply-To: <20070730203605.GD2386@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54263>

On Mon, 30 Jul 2007, J. Bruce Fields wrote:

> On Mon, Jul 30, 2007 at 04:28:13PM -0400, Daniel Barkalow wrote:
> > It would be nice to have a per-user ignore file, so that emacs users can 
> > ignore "*~", "#*#", and ".#*". Probably this should be in the form of 
> > having a config option for additional ignore file names, so that the user 
> > can decide where to put it. (E.g., ~/.gitignore would be an issue if the 
> > user is tracking their home directory with git and wants to ignore some 
> > files in the home directory repository but track similarly named files in 
> > some other repository). Are there any fundamental issues with this, or is 
> > it just that nobody's been sufficiently motivated to do it?
> 
> See 'man gitignore' or
> 
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#ignoring-files

Ah, I was just looking at too old versions of the documentation.

	-Daniel
*This .sig left intentionally blank*

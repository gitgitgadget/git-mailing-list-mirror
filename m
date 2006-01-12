From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: merging initial part of a branch?
Date: Wed, 11 Jan 2006 19:55:32 -0500
Message-ID: <20060112005531.GB14599@fieldses.org>
References: <20060111230451.GH8618@fieldses.org> <7vek3epbs9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 01:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewqkx-00084q-1A
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWALAze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWALAze
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:55:34 -0500
Received: from mail.fieldses.org ([66.93.2.214]:13272 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S964894AbWALAzd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:55:33 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1EwqkW-00048i-1l; Wed, 11 Jan 2006 19:55:32 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek3epbs9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14539>

On Wed, Jan 11, 2006 at 03:47:34PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> > External kernel projects sometimes work only against major
> > releases--it's easier for their users/testers to find a major release
> > than a random git version, and at least in the early prototype stage, it
> > isn't critical to be working on the tip all the time.
> >
> > Is there a simple way to say, for example, "merge in all the upstream
> > changes up to v2.6.15"?
> 
> I haven't tried this for some time, but I presume
> 
> 	$ git pull linus tag v2.6.15
> 
> would do what you want.

Yep!  Thanks.  The only documentation I can find for this is a slightly
obscure bit in the git-pull man page which lists this as a "short-cut"
notation.  What is it a shortcut for?  Is it possible to specify an
arbitrary commit in place of the "tag v2.6.15" somehow?

--b.

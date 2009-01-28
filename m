From: Theodore Tso <tytso@mit.edu>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 08:03:33 -0500
Message-ID: <20090128130333.GA11160@mit.edu>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com> <1233144045221-2231849.post@n2.nabble.com> <49804D41.3010801@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zabre <427@free.fr>, git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 14:05:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSA6L-00045G-V3
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 14:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbZA1NDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 08:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbZA1NDk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 08:03:40 -0500
Received: from THUNK.ORG ([69.25.196.29]:38114 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbZA1NDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 08:03:39 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LSA4t-0002eH-8u; Wed, 28 Jan 2009 08:03:35 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LSA4r-0003Du-7e; Wed, 28 Jan 2009 08:03:33 -0500
Content-Disposition: inline
In-Reply-To: <49804D41.3010801@dbservice.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107533>

On Wed, Jan 28, 2009 at 01:19:13PM +0100, Tomas Carnecky wrote:
>
> Oops, sorry. git checkout HEAD -- d.txt
> You have to tell which version of d.txt you want. In your case the  
> version in HEAD.
>

I use this command enough that I have this defined as an alias in my
~/.gitconfig file.  Try running this command:

	git config --global alias.revert-file "checkout HEAD --"

Now you will be able to do this:

	git revert-file d.txt

This is also useful when I've edited d.txt, and decided that I didn't
go about it the right away, and so I want to revert my edits.

						- Ted

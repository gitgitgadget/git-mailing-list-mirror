From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: Problems with git over http
Date: Sat, 20 Sep 2008 20:42:57 +0200
Message-ID: <20080920184257.GD18932@strlen.de>
References: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sean Davis <sdavis2@mail.nih.gov>
X-From: git-owner@vger.kernel.org Sat Sep 20 20:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh7RD-0003dK-85
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 20:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbYITSnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 14:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYITSnC
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 14:43:02 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:55596 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028AbYITSnA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Sep 2008 14:43:00 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1Kh7Q1-00058o-GI; Sat, 20 Sep 2008 20:42:57 +0200
Content-Disposition: inline
In-Reply-To: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96361>

Hello Sean,

On Sat, Sep 20, 2008 at 01:13:53PM -0400, Sean Davis wrote:
> I am new to git and trying to set up a remote repository over http.  I
> have configured apache2 and the bare, empty repository.  Using curl, I
> can get the file HEAD without a password (seems .netrc is correct?).
> However, when I try to push to the repository, I get the following:
> 
> sdavis@lestrade:/tmp/testing> git push
> http://sdavis@watson.nci.nih.gov/git/sean_git.git/ master
> fatal: exec http-push failed.
> error: failed to push some refs to
> 'http://sdavis@watson.nci.nih.gov/git/sean_git.git/'
> 
> What can I do to try to debug this, as the error message isn't helping
> me to sort out what is wrong.  The client and server are both running
> git-1.5.x (although the minor versions are a bit different).  Any
> suggestions?
Try cloning first.  And check the error log of apache.  I don't know how
pushing over http works, but maybe you installed git into /usr/local and
/usr/local/bin is not in the PATH for the apache user?

Best regards
Uwe

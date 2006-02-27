From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Mon, 27 Feb 2006 11:24:22 -0800
Message-ID: <20060227192422.GB9518@hand.yhbt.net>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 27 20:24:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDnyu-0002b1-2K
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 20:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWB0TYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 14:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWB0TYY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 14:24:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:10673 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751698AbWB0TYY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 14:24:24 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id E8FDF2DC01A; Mon, 27 Feb 2006 11:24:22 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060227185557.GA32142@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16878>

Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> On Mon, Feb 27, 2006 at 10:46:41AM -0800, Eric Wong wrote:
> > > now i am a little confused about that... oh, i actually modified the
> > > svn-git directly instead of a private working branch... perhaps that was
> > > not intended.
> > 
> > You should never, ever modify the git-svn-HEAD branch yourself.
> > Interface branches should never be modified.  It's the golden rule of
> > interfacing between different SCM interfaces.  Sorry, I've been doing
> > things like this this for a while now I guess I didn't make it
> > abundantly clear in the documentation.
> 
> If it is not supposed to be changed by the user, maybe it could be
> stored as a tag.
> 
> Or maybe another type of reference can be introduced. refs/remote/, for
> branches we are tracking, but which should not be modified locally.

Either of those could work for me.  Changing git-svn-HEAD to become a
tag would probably be easier (not having to update other tools, such as
git-fetch), but refs/remote may make more sense.

-- 
Eric Wong

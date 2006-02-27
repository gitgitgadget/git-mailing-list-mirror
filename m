From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Mon, 27 Feb 2006 13:55:57 -0500
Message-ID: <20060227185557.GA32142@delft.aura.cs.cmu.edu>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 19:56:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDnXR-0002u5-3C
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 19:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWB0S4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 13:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWB0S4A
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 13:56:00 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:52943 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1751624AbWB0Sz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 13:55:59 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1FDnXJ-0001hX-00; Mon, 27 Feb 2006 13:55:57 -0500
To: Eric Wong <normalperson@yhbt.net>
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060227184641.GA21684@hand.yhbt.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16875>

On Mon, Feb 27, 2006 at 10:46:41AM -0800, Eric Wong wrote:
> > now i am a little confused about that... oh, i actually modified the
> > svn-git directly instead of a private working branch... perhaps that was
> > not intended.
> 
> You should never, ever modify the git-svn-HEAD branch yourself.
> Interface branches should never be modified.  It's the golden rule of
> interfacing between different SCM interfaces.  Sorry, I've been doing
> things like this this for a while now I guess I didn't make it
> abundantly clear in the documentation.

If it is not supposed to be changed by the user, maybe it could be
stored as a tag.

Or maybe another type of reference can be introduced. refs/remote/, for
branches we are tracking, but which should not be modified locally.

Jan

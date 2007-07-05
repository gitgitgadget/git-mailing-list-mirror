From: David Kastrup <dak@gnu.org>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Thu, 05 Jul 2007 16:00:48 +0200
Message-ID: <86abubkl0v.fsf@lola.quinscape.zz>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net> <vpq7ipittl2.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707022205210.4071@racer.site> <vpqoditkc23.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707031308170.4071@racer.site> <vpqir91hagz.fsf@bauges.imag.fr> <20070704200806.GA3991@efreet.light.src> <vpqd4z7q820.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 16:01:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6RtP-0006Qn-AX
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 16:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299AbXGEOBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 10:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbXGEOBG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 10:01:06 -0400
Received: from main.gmane.org ([80.91.229.2]:51061 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756336AbXGEOBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 10:01:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I6Rt9-0002qL-DC
	for git@vger.kernel.org; Thu, 05 Jul 2007 16:00:55 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 16:00:55 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 16:00:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:kjl3CSPA8tCUrb6zOZRVC5sBsL0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51678>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> One benefit is: you don't have to use "-f" for a non-dangerous
> senario. That seems stupid, but for the plain "rm" command, the
> "-rf" is hardcoded in the fingers of many unix users, and I know
> several people having lost data by typing it a bit too mechanically
> (with a typo behind, like forgetting the "*" in "*~" ;-).

Just a few days ago, I used rm -rf * in a temporary directory.  I
would now advise people against doing that without an absolute path.
The problem was that at some later point of time, some history
search/key fsckup popped that line back into the shell and executed
it.

At that time, in my home directory.  This was definitely annoying,
even though the files and directories .* (and thus most configuration
data) were spared.

> I'll try writting patch for that if people agree that this is saner
> that the current behavior.

Sounds like it.

-- 
David Kastrup

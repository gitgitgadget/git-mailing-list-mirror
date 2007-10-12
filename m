From: Barry Fishman <barry_fishman@acm.org>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 13:05:01 -0400
Message-ID: <m3y7e8jmbm.fsf@barry_fishman.acm.org>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
	<86fy0hvgbh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
	<20071011192103.GD2804@steel.home>
	<Pine.LNX.4.62.0710120726470.11771@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 19:38:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgOMb-0002WR-Oy
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 19:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbXJLRbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 13:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755162AbXJLRbn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 13:31:43 -0400
Received: from main.gmane.org ([80.91.229.2]:40536 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754905AbXJLRbm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 13:31:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IgO89-0003Uv-Ft
	for git@vger.kernel.org; Fri, 12 Oct 2007 17:16:57 +0000
Received: from fl-71-0-147-208.dhcp.embarqhsd.net ([71.0.147.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 17:16:57 +0000
Received: from barry_fishman by fl-71-0-147-208.dhcp.embarqhsd.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 17:16:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: fl-71-0-147-208.dhcp.embarqhsd.net
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:jqLVqqc4PimOoCUaJS/vxvdwgoo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60697>

Peter Karlsson <peter@softwolves.pp.se> writes:
> Yes, but not embedded in the page in a format that is visible to the
> visitor. For CVS I use something like this:
>
> <p class="date">$Date$</p>
>
> to embed the last update time into the page.
>

I guess everyone moving from CVS/SVN to Git faces rethinking of
what the RCS markers really mean in the context of their project.

In my case the identifier was just a away of seeing when the file was
last changed, and who did it.  I decided this fit better as an editor
function, rather than a checkin function.

I changed my editor (Emacs) to convert RCS Ids to timestamps when I
opened a file for reading.  This would fix old files.  When i wrote out
files I would update the timestamp before writing them (via emacs's
timestamp package).  I didn't have to think about it as my RCS Id
stamped files slowly evolve into my editor stamped ones.  I'm sure I
could do something similar in VIM, or with a script encapsulating
another editor.

This actually worked out better for me.  Now the timestamps were updated
even when I hadn't yet checked in the file.  Since I test things before
checking them in, I did not have my file changed after testing by the
checkin process.

I could find the the commit assocated with the file fairly quickly using
"git log" and finding the commit for the file just after its timestamp.

-- 
Barry Fishman

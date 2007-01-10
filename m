From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] git-remote
Date: Wed, 10 Jan 2007 13:13:20 -0500
Message-ID: <20070110181320.GA20108@fieldses.org>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net> <20070109042851.GF1686@fieldses.org> <7vr6u4sq9e.fsf@assigned-by-dhcp.cox.net> <45A35EED.5090105@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 19:13:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4hx2-0003Se-2W
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 19:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbXAJSNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 13:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbXAJSNZ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 13:13:25 -0500
Received: from mail.fieldses.org ([66.93.2.214]:49285 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964941AbXAJSNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 13:13:25 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H4hwu-0005Xt-9C; Wed, 10 Jan 2007 13:13:20 -0500
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <45A35EED.5090105@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36520>

On Tue, Jan 09, 2007 at 10:22:53AM +0100, Andreas Ericsson wrote:
> Junio C Hamano wrote:
> >"J. Bruce Fields" <bfields@fieldses.org> writes:
> >
> >>Would it make sense for "git add" to do the initial fetch as well?
> >
> >It would be handy.
> >
> >And perhaps we could make it the default but with a command line
> >override to help disconnected people.
> >
> 
> I'd rather do it the other way around ("--fetch" switch) and if that 
> wasn't supplied, tell the user that he should now run
> 
> 	git fetch $whatever_name_was_supplied
> 
> The reason being it's easier to fetch afterwards than it is to undo the 
> fetch if you didn't mean to do it straight away. Judging by its other 
> uses, I also wouldn't expect the command to actually work over the network.

Actually, "git remote show" also seems to require the network, as it
does an ls-remote.  That I found a little more surprising.

I don't think a user should be surprised that a command that takes a url
would require the network.  And although I could imagine uses for "git
remote add" when disconnected, I'd imagine by far the most common uses
would be where the user also wants to examine a remote branch
immediately.

--b.

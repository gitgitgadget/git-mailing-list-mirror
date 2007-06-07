From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: pull/merge --no-commit
Date: Thu, 7 Jun 2007 16:43:33 -0400
Message-ID: <20070607204333.GC14463@fieldses.org>
References: <46678909.10608@alcatel-lucent.com> <7vfy54qqu8.fsf@assigned-by-dhcp.cox.net> <46684EFD.1080804@alcatel-lucent.com> <alpine.DEB.0.99.0706080658070.6319@sleipnir.no.net.nz> <46686B63.6080808@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Keith Duthie <keith@no.net.nz>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Green <Kevin.T.Green@morganstanley.com>
To: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwOpf-0007kf-87
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 22:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762149AbXFGUni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 16:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762225AbXFGUni
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 16:43:38 -0400
Received: from mail.fieldses.org ([66.93.2.214]:60480 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762149AbXFGUni (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 16:43:38 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HwOpR-000726-Ii; Thu, 07 Jun 2007 16:43:33 -0400
Content-Disposition: inline
In-Reply-To: <46686B63.6080808@alcatel-lucent.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49385>

On Thu, Jun 07, 2007 at 04:32:35PM -0400, kurt_p_lloyd wrote:
> One thing I was thinking might be useful would be a command to make
> (just) my repository unavailable for 'fetch' or 'pull' from others,
> temporarily.  And then a command to make it available again,
> after I finish things that could end up needing "database" surgery,
> like maybe something that could result in having to do a git reset.
> I was thinking maybe something like:
> 
>   $ git config maintenance true
>   .... do something that may end up needing "database" surgery
>   $ git config maintenance false

You could probably do that with file permissions, but...

> Just an idea.  Of course, if something like this already exists ....
> (I'd rather not shut down sshd, nor have to create a separate "public"
>  repository (for certain types of "projects" anyway).)

... why not?  Having a separate public repository also allows you to do
this and much more.  And it should be cheap and easy--if you're worried
about the space, clone with --shared or something.

--b.

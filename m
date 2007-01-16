From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn - username/password
Date: Mon, 15 Jan 2007 16:41:37 -0800
Message-ID: <20070116004137.GA10706@localdomain>
References: <8664b73maf.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 01:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6cOY-0003sR-4k
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 01:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXAPAll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 19:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbXAPAlk
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 19:41:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39175 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166AbXAPAlj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 19:41:39 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3D7227DC094;
	Mon, 15 Jan 2007 16:41:38 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 16:41:38 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <8664b73maf.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36904>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> 
> It's not clear from the docs where I'm supposed to put a subversion
> username/password in git-svn.  In fact, git-svn makes absolutely no mention of
> password.  And I see there's some --username=%s kind of stuff in the arg
> parsing, but I'm not able to seem to make it work.  (At one point, git-svn
> init actually created a subdir named "http:"... oops!)
> 
> Eric?  Or anyone?

git-svn fetch --username <username> should work with recent-ish git-svn
(since around Thanksgiving); and eventually prompt you for the password
(just like svn does).

If you're using older versions, just run
   `svn log -rHEAD --username <username> <repository>'
and have it cache your password.

-- 
Eric Wong

From: Petr Baudis <pasky@suse.cz>
Subject: Re: qiuestion about Git and Cogito
Date: Tue, 20 Mar 2007 16:56:23 +0100
Message-ID: <20070320155623.GH4489@pasky.or.cz>
References: <45FFFA94.4040105@mail.nih.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francois Lang <flang@mail.nih.gov>
X-From: git-owner@vger.kernel.org Tue Mar 20 16:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTghQ-0006Bk-40
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 16:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbXCTP41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 11:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbXCTP41
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 11:56:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35637 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbXCTP40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 11:56:26 -0400
Received: (qmail 10840 invoked by uid 2001); 20 Mar 2007 16:56:23 +0100
Content-Disposition: inline
In-Reply-To: <45FFFA94.4040105@mail.nih.gov>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42751>

On Tue, Mar 20, 2007 at 04:15:32PM CET, Francois Lang wrote:
> Hello. We have started using Git and Cogito, and are very happy users so 
> far. There's one thing that I haven't been able to figure out, however:
> 
> Suppose I've done a bunch of commits in my local repository that I have 
> not yet pushed to the remote repository. How can I determine what has 
> been cg-commit-ed but not yet cg-pushe-ed WITHOUT actually doing the 
> cg-push?
> 
> Many thanks in advance for your help.

Assuming that you work on master and push to origin,

	cg-log -r master..origin

or

	cg-diff -r master..origin

respectively.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett

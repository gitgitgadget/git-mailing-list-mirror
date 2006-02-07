From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: git-http-push and hooks
Date: Tue, 7 Feb 2006 20:54:58 +0100
Message-ID: <20060207195458.GA7217@c165.ib.student.liu.se>
References: <20060206205203.GA20973@guybrush.melee> <20060206232231.GK3873@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Bertrand Jacquin (Beber)" <beber@guybrush.melee>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 20:55:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6Yvr-0007LD-8l
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 20:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWBGTzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWBGTzL
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 14:55:11 -0500
Received: from [85.8.31.11] ([85.8.31.11]:60592 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750792AbWBGTzK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 14:55:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id ADC864103; Tue,  7 Feb 2006 21:08:47 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F6YvT-0001si-00; Tue, 07 Feb 2006 20:54:59 +0100
To: Nick Hengeveld <nickh@reactrix.com>
Content-Disposition: inline
In-Reply-To: <20060206232231.GK3873@reactrix.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15710>

On Mon, Feb 06, 2006 at 03:22:31PM -0800, Nick Hengeveld wrote:
> On Mon, Feb 06, 2006 at 09:52:03PM +0100, Bertrand Jacquin (Beber) wrote:
> 
> > Why aren't excute hooks/* (with +x perms) when I do a git-http-push ?
> > Also if i push with cg-push on the same repo but with git+ssh
> > protocol, hooks are execute.
> 
> Hooks must run on the destination server when you're doing a push.  If
> you use the git+ssh protocol, that server is running a git daemon that
> knows how to execute hooks; if you use the http/DAV protocol, that
> server does not.
> 

I know basically nothing about DAV, but wouldn't it be possible to
have a CGI-script which executes the hooks upon the client's request?

- Fredrik

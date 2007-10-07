From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: respect Subversion's [auth] section configuration values
Date: Sat, 6 Oct 2007 20:24:46 -0700
Message-ID: <20071007032446.GH14972@hand.yhbt.net>
References: <20071006185719.GA3943@void.codelabs.ru> <4708355B.4090403@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 06:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeMlD-0001kR-Ia
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 05:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbXJGDYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 23:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbXJGDYr
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 23:24:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38917 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbXJGDYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 23:24:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2E9817DC093;
	Sat,  6 Oct 2007 20:24:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4708355B.4090403@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60162>

Sam Vilain <sam@vilain.net> wrote:
> Eygene Ryabinkin wrote:
> > +		# The usage of $SVN::_Core::SVN_CONFIG_* variables
> > +		# produces warnings that variables are used only once.
> > +		# I had not found the better way to shut them up, so
> > +		# warnings are disabled in this block.
> > +		no warnings;
> >   
> 
> You can use no warnings 'once';

Interesting, I should use that globally in git-svn and get rid of the
$kill_stupid_warnings variable :)

-- 
Eric Wong

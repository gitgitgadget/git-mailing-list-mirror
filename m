From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [CFT] git-svn - almost a rewrite...
Date: Fri, 23 Feb 2007 02:40:49 -0800
Message-ID: <20070223104049.GA2326@mayonaise.dyndns.org>
References: <20070201132934.GB7800@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 11:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKXrF-0007ko-5G
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 11:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXBWKky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 05:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbXBWKkx
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 05:40:53 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35067 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224AbXBWKkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 05:40:53 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E27D42DC01A;
	Fri, 23 Feb 2007 02:40:50 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 23 Feb 2007 02:40:49 -0800
Content-Disposition: inline
In-Reply-To: <20070201132934.GB7800@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40436>

Junio:
Please pull the HEAD of git://bogomips.org/git-svn.git into
your master, thanks.

I have found several bugs since the last announcement and fixed
them.  Additionally Sam has provided some patches to get rid
of the username in the metadata URL.

Eric Wong (3):
      git-svn: fix clone when a target directory has been specified
      git-svn: fix reconnections to different paths of svn:// repositories
      git-svn: fix some potential bugs with --follow-parent

Sam Vilain (2):
      git-svn: don't consider SVN URL usernames significant when comparing
      git-svn: document --username

-- 
Eric Wong

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: re-map repository URLs and UUIDs on SVK mirror paths
Date: Sun, 11 Feb 2007 01:41:15 -0800
Message-ID: <20070211094114.GB19590@hand.yhbt.net>
References: <20070210233750.A333013A384@magnus.utsl.gen.nz> <20070211045518.GA20663@mayonaise.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 10:41:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGBD5-0003Ml-5o
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 10:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbXBKJlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 04:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbXBKJlQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 04:41:16 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55814 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbXBKJlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 04:41:15 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 214887DC094; Sun, 11 Feb 2007 01:41:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070211045518.GA20663@mayonaise.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39278>

Eric Wong <normalperson@yhbt.net> wrote:
> Note: these patches (both Sam's and mine below) are not meant for
> master, but the development/semi-rewrite version of git-svn at
> http://git.bogomips.org/git-svn.git
> 
> Sam: here's my take on your patches.  I'll add support for
> per-[svn-remote "..."] configuration that we talked about
> on IRC in a separate patch.

I've added per-[svn-remote "..."] config support to my latest revision.
I forgot to take into account the 'log' command breakage/inconsistency
from using .rev_db with svn-remote.svn.useSvmProps, so the 'git svn log'
command won't work well with -r.  I'll try to find time for that
tomorrow.

-- 
Eric Wong

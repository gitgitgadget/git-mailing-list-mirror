From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn throwing assertion on old svn tracking branch
Date: Fri, 22 Dec 2006 00:38:03 -0800
Message-ID: <20061222083803.GD26800@hand.yhbt.net>
References: <20061220235551.GA2974@hermes.lan.home.vilz.de> <20061221010520.GB3901@localdomain> <20061222013510.GA9595@hermes> <20061222021613.GB9595@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 09:38:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxfus-0008Db-77
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945978AbWLVIiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWLVIiH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:38:07 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37269 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945978AbWLVIiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:38:06 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id C17FB2DC089; Fri, 22 Dec 2006 00:38:03 -0800 (PST)
To: Nicolas Vilz <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <20061222021613.GB9595@hermes>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35147>

Nicolas Vilz <niv@iaglans.de> wrote:
> On Fri, Dec 22, 2006 at 02:35:10AM +0100, Nicolas Vilz wrote:
> > On Wed, Dec 20, 2006 at 05:05:20PM -0800, Eric Wong wrote:
> > > Nicolas Vilz <niv@iaglans.de> wrote:
> [...]
> > beneath there is svn, version 1.4.2 (r22196) ... on that repository is
> > Subversion version 1.1.4 (r13838).
> 
> i should ammend, that the same error message comes, when i want to
> dcommit something in this repository...

Weird, so you have the SVN:: libraries installed? (dcommit requires it).
Is the repository you're tracking public?  If so, I'd like to have a
look...

-- 
Eric Wong

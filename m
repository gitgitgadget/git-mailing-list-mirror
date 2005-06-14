From: Matt Mackall <mpm@selenic.com>
Subject: Re: hgweb and gitweb: Commit times displayed incorrectly
Date: Tue, 14 Jun 2005 10:38:31 -0700
Message-ID: <20050614173831.GR26633@waste.org>
References: <42AEFB66.80902@gorzow.mm.pl> <20050614162541.GA27165@intevation.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 14 19:34:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiFIw-0004Yz-JJ
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 19:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFNRil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 13:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVFNRil
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 13:38:41 -0400
Received: from waste.org ([216.27.176.166]:33710 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261266AbVFNRig (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2005 13:38:36 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j5EHcW9H015711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Jun 2005 12:38:32 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j5EHcVmp015708;
	Tue, 14 Jun 2005 12:38:31 -0500
To: mercurial@selenic.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050614162541.GA27165@intevation.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2005 at 06:25:41PM +0200, Thomas Arendsen Hein wrote:
> * Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> [20050614 17:45]:
> > Who is wrong there, especially with hours count?
> > Here it's 17:43 +0200
> > 
> > hgweb:
> > *16 hours ago: *
> 
> http://www.kernel.org/hg/?cmd=changelog;rev=30069
> 
> > gitweb:
> > /11 hours ago/
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=log;h=e2c16499515aa044676a14b97a1b8a35f879152a
> 
> > My clone:
> > author Jon Smirl <jonsmirl@gmail.com> Mon, 13 Jun 2005 15:52:36 -0700
> > committer Linus Torvalds <torvalds@ppc970.osdl.org> Mon, 13 Jun 2005 20:58:58 -0700
> 
> Both are correct.
> 
> hgweb uses the timestamp of the "author" line, gitweb uses the
> timestamp of the "commiter" line. Mercurial (hg) doesn't distinguish
> author and commiter, therefore it uses the earlier time.

I may change this. One of the goals here is to have enough information
to generate git-compatible exports. Possibly through an extended
version of hgweb (hgitweb?).

So I'm eventually going to preserve both fields. The question is how.
Do we want separate author and committer fields in Mercurial?

-- 
Mathematics is the supreme nostalgia of our time.

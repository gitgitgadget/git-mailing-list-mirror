From: Johan Herland <johan@herland.net>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 21:16:03 +0200
Message-ID: <200708052116.04140.johan@herland.net>
References: <873ayymzc1.fsf@catnip.gol.com>
 <200708051411.25238.johan@herland.net> <20070805161117.GE28263@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:08:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHnLJ-0008A3-2v
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 23:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbXHEVIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 17:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXHEVIh
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 17:08:37 -0400
Received: from smtp.getmail.no ([84.208.20.33]:40180 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbXHEVIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 17:08:37 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JMB00A9IK2APC00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 05 Aug 2007 23:08:34 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JMB0081CEUSQPD0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 05 Aug 2007 21:16:04 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JMB005C0EUS1M00@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 05 Aug 2007 21:16:04 +0200 (CEST)
In-reply-to: <20070805161117.GE28263@thunk.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55071>

On Sunday 05 August 2007, Theodore Tso wrote:
> On Sun, Aug 05, 2007 at 02:11:24PM +0200, Johan Herland wrote:
> > Adding a git-addremove command should not be much work, and it would be
> > a lot friendlier to people whose workflow is more aligned with #2 than 
> > #1. 
> Not much work at all:
> 
> # git config --system --add alias.addremove "git add . ; git add -u"
> 
> :-)

Nice :)

But I'm wondering whether we'd want to include it in git by default (instead 
of having to tell confused users to add the alias).

> (And the performance problem with git add . is fixed in 1.5.3-rc4,
> right?)

Yes, according to Junio elsewhere in this thread.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

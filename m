From: Johan Herland <johan@herland.net>
Subject: Re: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 20:05:14 +0200
Message-ID: <200705172005.14196.johan@herland.net>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
 <200705171857.22891.johan@herland.net> <20070517174807.GM5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 20:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HokLv-0004rY-Lp
	for gcvg-git@gmane.org; Thu, 17 May 2007 20:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbXEQSFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 14:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbXEQSFU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 14:05:20 -0400
Received: from [84.208.20.33] ([84.208.20.33]:33421 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754439AbXEQSFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 14:05:18 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JI700H0B68TBL00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 20:05:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI700C1X68QH5A0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 20:05:14 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI700LC668QXUA0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 20:05:14 +0200 (CEST)
In-reply-to: <20070517174807.GM5272@planck.djpig.de>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47547>

On Thursday 17 May 2007, Frank Lichtenheld wrote:
> On Thu, May 17, 2007 at 06:57:22PM +0200, Johan Herland wrote:
> > Hmm, doesn't seem like git-tar-tree (or git-archive for that matter) 
> > supports this out of the box. Maybe it's possible to achieve in combination 
> > with the $Id$ construct?
> 
> $Id$ contains the blob id, not the commit id.

Oops. My bad. In that case, your solution (to add another commandline switch 
to git-archive) is definitely what Michael needs.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

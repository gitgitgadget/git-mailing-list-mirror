From: Johan Herland <johan@herland.net>
Subject: Re: error: char103: premature end of data
Date: Fri, 08 Jun 2007 01:05:27 +0200
Message-ID: <200706080105.28102.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 01:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwR31-0002ym-4r
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbXFGXFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966193AbXFGXFc
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:05:32 -0400
Received: from [84.208.20.33] ([84.208.20.33]:46085 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932197AbXFGXFb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:05:31 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJA00103G565200@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:05:30 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA00MHAG54HE00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:05:28 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA00KKLG54ZT10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:05:28 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706072348110.4046@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49405>

On Friday 08 June 2007, Johannes Schindelin wrote:
> Hi,
> 
> I just tried to fetch from one of my repos which was perfectly usable (and 
> fetchable) before, and got this error message:
> 
> 	error: char103: premature end of data

Sorry about that. Do you have an idea of which tag object caused the 
failure? If so, could you send the output of "git-cat-file tag <name>" on 
it?

git-fsck on the repo should report the same error. If you run with -v 
(verbose) you should also get some hints as to which tag object causes 
this.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

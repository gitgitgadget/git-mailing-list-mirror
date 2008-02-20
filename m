From: Daniel Quinlan <danq@brtt.com>
Subject: git on Solaris?
Date: Wed, 20 Feb 2008 14:57:47 -0700
Message-ID: <200802202158.m1KLw2wM014330@rs40.luxsci.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 23:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRx7b-0003sS-JW
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759089AbYBTWIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758427AbYBTWIY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:08:24 -0500
Received: from rs40.luxsci.com ([65.61.166.82]:53938 "EHLO rs40.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550AbYBTWIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:08:23 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2008 17:08:23 EST
Received: from rs40.luxsci.com (localhost [127.0.0.1])
	by rs40.luxsci.com (8.13.1/8.13.7) with ESMTP id m1KLwO35014838
	for <git@vger.kernel.org>; Wed, 20 Feb 2008 15:58:24 -0600
Received: (from root@localhost)
	by rs40.luxsci.com (8.13.1/8.13.7/Submit) id m1KLw2wM014330
	for git@vger.kernel.org; Wed, 20 Feb 2008 21:58:02 GMT
Received: (from danq@brtt.com) by Lux Scientiae SMTP Processor; Wed, 20 Feb 2008 21:58:02 +0000
X-Comment: Lux Scientiae SMTP Processor Message ID - 1203544682-1842697.9468068
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74549>

I'm investigating moving to git for our development, but I'm having  
difficulty getting a functional
version on Solaris.  I've looked through a lot of web pages, and seen  
a discussion of some of
the problems a few years ago, and I see that at least some of the  
changes proposed then (moving
from shell scripts to c) have been implemented.

However, it's by no means straightforward to compile git on solaris,  
no one seems to provide
a compiled version (eg, sunfreeware.com), and I haven't found any  
clear cookbook description of how to
compile, test and install git on the solaris (10) platform.

So my questions are:

* Is there a set of instructions for Solaris somewhere that I've missed?

* Is anyone actually using git on Solaris?

  Right now, it appears that gnu make and bash are both required to  
make git, and perhaps a bunch
  of other gnu utilities.

* Once made, do the git scripts require gnu utilities to work  
properly?  I'm a bit leery of putting the
     GNU utilities ahead of the solaris ones in my path (and everyone  
elses).

Thanks,
-- danq

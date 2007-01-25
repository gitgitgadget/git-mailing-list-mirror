From: Ray Lehtiniemi <rayl@mail.com>
Subject: how to git-svnimport gnucash?
Date: Thu, 25 Jan 2007 15:26:50 -0700
Message-ID: <200701251526.50618.rayl@mail.com>
Reply-To: rayl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 00:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAE1r-0006R7-7v
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbXAYX3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbXAYX3M
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:29:12 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54662 "EHLO
	pd4mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030502AbXAYX3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:29:11 -0500
X-Greylist: delayed 3640 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jan 2007 18:29:11 EST
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JCG00BW13POYYA0@l-daemon> for git@vger.kernel.org; Thu,
 25 Jan 2007 15:27:24 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
 by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTP id <0JCG003Q93PC8DB1@pd2mr6so.prod.shaw.ca> for
 git@vger.kernel.org; Thu, 25 Jan 2007 15:27:13 -0700 (MST)
Received: from s0106001109ed07db.cg.shawcable.net ([68.147.121.172])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JCG003073OSLU82@l-daemon> for git@vger.kernel.org; Thu,
 25 Jan 2007 15:26:52 -0700 (MST)
Content-disposition: inline
User-Agent: KMail/1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37777>


hi all

does anyone have a magic command line that will import the gnucash svn repo?

     http://svn.gnucash.org/repo/gnucash/trunk


i've tried every variation of the command line i can think of and keep getting 
pages and pages of this sort of thing:

15420: Unrecognized path: /gnucash/trunk/src/gnome-utils/gnc-html-graph-gog.c
15421: Unrecognized path: /gnucash/trunk/src/engine/gnc-commodity.c
15421: Unrecognized path: /gnucash/trunk/src/engine/iso-4217-currencies.scm
15422: Unrecognized path: /gnucash/trunk/src/engine/iso-4217-currencies.scm

followed by this sort of thing:

Generating pack...
Done counting 0 objects.
Nothing new to pack.
Removing unused objects 100%...
Done.
cp: cannot stat `/opt/gnucash/src/import/.git/refs/heads/origin': No such file 
or directory
fatal: master: not a valid SHA1
warning: You appear to be on a branch yet to be born.
warning: Forcing checkout of HEAD.
fatal: just how do you expect me to merge 0 trees?
checkout failed: 256




the unrecognized path messages are coming from the call to split_path() 
located inside commit_all().

i'm using git 1.5.0-rc2 under suse 10.0 and opensuse 10.2 on x86_64.


thanks in advance
ray

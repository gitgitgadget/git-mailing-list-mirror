From: Gaspard Bucher <gaspard@teti.ch>
Subject: keep a subversion mirror in sync
Date: Wed, 17 Sep 2008 13:58:52 +0200
Message-ID: <B529992F-3C09-4708-A3F4-645DB23DF158@teti.ch>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 14:30:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfwBG-0000vV-P5
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 14:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbYIQM3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 08:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbYIQM3n
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 08:29:43 -0400
Received: from vserv96.swisslink.ch ([217.162.2.96]:36801 "EHLO teti.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750817AbYIQM3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 08:29:43 -0400
X-Greylist: delayed 1819 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Sep 2008 08:29:42 EDT
Received: from 20.89.3.213.cust.bluewin.ch ([213.3.89.20] helo=[10.0.0.13])
	by teti.ch with esmtpa (Exim 4.63)
	(envelope-from <gaspard@teti.ch>)
	id 1KfvaI-0005oy-Gw
	for git@vger.kernel.org; Wed, 17 Sep 2008 13:52:38 +0200
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96102>

Hi !

I have been trying different strategies to keep subversion repository  
in sync with a git repository (on github).

Some details with pictures can be found here: http://zenadmin.org/en/documentation/page439.html 
.

I have tried to use a single database to pull/push from github and  
dcommit to the old subversion repository but I get lots of conflicts  
and duplicates (see link above).

I have then tried to create a "pull" only clone to dcommit, but it  
looses the commit messages and replaces then with a merge message. At  
least this solution keeps the github repository clean.

What is the canonical way to do this ?

Many thanks for your help.

Gaspard

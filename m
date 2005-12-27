From: Jon Nelson <jnelson-git@jamponi.net>
Subject: cannot handle more than 29 refs
Date: Tue, 27 Dec 2005 08:43:07 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0512270840410.6812@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Dec 27 15:43:35 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErG2w-00022J-Im
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 15:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVL0OnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 09:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVL0OnR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 09:43:17 -0500
Received: from mxsf32.cluster1.charter.net ([209.225.28.156]:33510 "EHLO
	mxsf32.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932342AbVL0OnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 09:43:16 -0500
Received: from mxip10a.cluster1.charter.net (mxip10a.cluster1.charter.net [209.225.28.140])
	by mxsf32.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jBREhFxe020508
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 09:43:15 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip10a.cluster1.charter.net with ESMTP; 27 Dec 2005 09:43:15 -0500
X-IronPort-AV: i="3.99,296,1131339600"; 
   d="scan'208"; a="1958294240:sNHT30939924"
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 99BE2C09F; Tue, 27 Dec 2005 08:43:07 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id 81EE3C09E
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 08:43:07 -0600 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14077>


I get this message whenever I use --tags with git-pull with certain 
repositories. The git repository is one, and so is my local repository. 
I googled and got nothing. I grepped the git archive and got only 
show-branch.c.  Can this be safely ignored? Is it a known shortcoming, 
or something else entirely?

--
Jon Nelson <jnelson-git@jamponi.net>

From: Mircea Bardac <dev.list@mircea.bardac.net>
Subject: gitweb on shared hosting
Date: Sat, 2 Jun 2007 19:53:08 +0300
Message-ID: <200706021953.09942.dev.list@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 07:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuiWO-0008Tw-U5
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 07:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbXFCFUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 01:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbXFCFUn
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 01:20:43 -0400
Received: from bravo.securenet-server.net ([207.210.84.244]:45516 "EHLO
	bravo.securenet-server.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754549AbXFCFUm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2007 01:20:42 -0400
X-Greylist: delayed 44785 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jun 2007 01:20:42 EDT
Received: from [86.121.184.202] (helo=mircea.home.bardac.net)
	by bravo.securenet-server.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <dev.list@mircea.bardac.net>)
	id 1HuWre-0004qP-J6
	for git@vger.kernel.org; Sat, 02 Jun 2007 12:54:08 -0400
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-PopBeforeSMTPSenders: bmi@bardac.net
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bravo.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - mircea.bardac.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48974>

Hi everybody,

I don't know if this is possible or not, but I'm trying with no results.

Is it possible to install gitweb on a shared hosting system, with no root 
access. Reading the INSTALL document reveals only information for 
configuration on build-time/install as root.

I expected it to be installable just as any other web application:
* get gitweb.cgi and related files + place them on the webserver
* modify a config file (gitweb.cgi) to update the paths + gitweb options
* (eventually) adjust server configuration for CGI in the wanted dir
DONE.

Also, having configuration information spread across several files 
(README/INSTALL/gitweb.cgi) doesn't help much.

It is also very strange to have README/"How to configure gitweb for your local 
system" saying "You can specify the following configuration variables when 
buiding GIT". That means I have to rebuild GIT (actually, only 
gitweb/gitweb.cgi) to configure gitweb => I need to download the sources by 
hand instead of using the already installed gitweb on my system (the one 
which came with the git package).

Is there any strong reason to have configuration at build-time at all? It 
would be a lot easier IMO to have it *just* by config files. I'm saying this 
because most of the install process is manual anyway (copying/moving files).


Many thanks,
Mircea

-- 
http://mircea.bardac.net

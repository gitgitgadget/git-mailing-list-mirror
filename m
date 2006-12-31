From: "J.H." <warthog19@eaglescrag.net>
Subject: Gitweb - caching
Date: Sun, 31 Dec 2006 02:30:14 -0800
Message-ID: <45979136.3070901@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Dec 31 12:00:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0yQT-0005lx-NB
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 12:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933126AbWLaLAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 06:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbWLaLAR
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 06:00:17 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:56824 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933126AbWLaLAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 06:00:15 -0500
X-Greylist: delayed 1770 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 06:00:15 EST
Received: from [192.168.1.93] (c-67-188-75-114.hsd1.ca.comcast.net [67.188.75.114])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.13.8/8.13.7) with ESMTP id kBVAUjJN002817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 31 Dec 2006 02:30:45 -0800
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
X-Virus-Scanned: ClamAV 0.88.6/2314/Sun Dec 10 12:02:13 2006 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35692>

There has been some recent discussion concerning the amount of resources
that gitweb is chewing through, particularly on kernel.org.  I've just
pushed a small set of changes out to kernel.org that add in caching to
the gitweb thats running on it.  Changes are published at
git://git.kernel.org/pub/scm/git/warthog9/gitweb.git

Thoughts or comments are welcome.

- John 'Warthog9'

From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 23:56:56 +0200
Message-ID: <200707152356.58304.robin.rosenberg.lists@dewire.com>
References: <469A2B1D.2040107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:56:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAC4Y-0008V3-B2
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 23:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbXGOV4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 15 Jul 2007 17:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbXGOV4G
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 17:56:06 -0400
Received: from [83.140.172.130] ([83.140.172.130]:22556 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbXGOV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 17:56:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9821480266A;
	Sun, 15 Jul 2007 23:48:55 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14406-09; Sun, 15 Jul 2007 23:48:55 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 58C54800199;
	Sun, 15 Jul 2007 23:48:55 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <469A2B1D.2040107@alum.mit.edu>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52591>

s=F6ndag 15 juli 2007 skrev Michael Haggerty:
>    b. CVS tag/branch creation events do not even include a username.
> Any suggestions for what to use here?

The CVSROOT/history file contains the user name and timestamp of the ta=
g
creation. CVS can be told not to update the file. It is appended to by =
default.

-- robin

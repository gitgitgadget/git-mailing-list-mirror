From: Andriy Gapon <avg@icyb.net.ua>
Subject: git-svn and complex branch/tag layout
Date: Fri, 05 Sep 2008 16:53:47 +0300
Message-ID: <48C139EB.1000104@icyb.net.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 16:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbc7n-00085B-JS
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 16:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbYIEOQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 10:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbYIEOQR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 10:16:17 -0400
Received: from falcon.cybervisiontech.com ([217.20.163.9]:37563 "EHLO
	falcon.cybervisiontech.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753310AbYIEOQQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 10:16:16 -0400
X-Greylist: delayed 1343 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Sep 2008 10:16:16 EDT
Received: from localhost (localhost [127.0.0.1])
	by falcon.cybervisiontech.com (Postfix) with ESMTP id 7B64E744191
	for <git@vger.kernel.org>; Fri,  5 Sep 2008 16:53:49 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at falcon.cybervisiontech.com
Received: from falcon.cybervisiontech.com ([127.0.0.1])
	by localhost (falcon.cybervisiontech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wn5U8E+qzQHH for <git@vger.kernel.org>;
	Fri,  5 Sep 2008 16:53:49 +0300 (EEST)
Received: from [10.2.1.87] (gateway.cybervisiontech.com.ua [91.198.50.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by falcon.cybervisiontech.com (Postfix) with ESMTP id 2EA00744187
	for <git@vger.kernel.org>; Fri,  5 Sep 2008 16:53:48 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080805)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95016>


I am trying to use 'git svn' with FreeBSD base repository (which is now
in svn).
As can be seen here in "RELENG_* branches and general layout" section:
http://wiki.freebsd.org/SubversionPrimer

There are several subdirectories for branches and tags depending on the
status of a branch/tag in question. As I understand those subdirectories
do not introduce separate namespaces, i.e. a particular tag/branch name
is supposed to be unique across all subdirectories.

Does git-svn support repository layouts with multiple branch/tag
subdirectories? Or does it only support "standard layout" variations
that still have only one subdirectory for each?

Thank you in advance for any help/advice!

-- 
Andriy Gapon

From: Stephen Fisher <sfisher@SDF.ORG>
Subject: Git's configure script --mandir doesn't work
Date: Thu, 4 Dec 2014 16:25:32 -0700
Message-ID: <20141204232532.GB14036@SDF.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 00:59:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwgJO-0005vs-Ry
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbaLDX7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:59:51 -0500
Received: from mx.sdf.org ([192.94.73.24]:55456 "EHLO sdf.lonestar.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754730AbaLDX7u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:59:50 -0500
X-Greylist: delayed 2044 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Dec 2014 18:59:50 EST
Received: from sdf.org (IDENT:sfisher@otaku.freeshell.org [192.94.73.9])
	by sdf.lonestar.org (8.14.8/8.14.5) with ESMTP id sB4NPW4Q023035
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
	for <git@vger.kernel.org>; Thu, 4 Dec 2014 23:25:33 GMT
Received: (from sfisher@localhost)
	by sdf.org (8.14.8/8.12.8/Submit) id sB4NPW1t009781
	for git@vger.kernel.org; Thu, 4 Dec 2014 16:25:32 -0700 (MST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260846>

I'm installing Git 2.2.0 from source distribution on NetBSD 6.1.5 
(amd64) and when I specify --mandir=/usr/local/man, it still installs 
man pages in the default /usr/local/share/man directory.  Is there a fix 
available for this?

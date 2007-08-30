From: Paul Mackerras <paulus@samba.org>
Subject: gitk startup time improvement
Date: Thu, 30 Aug 2007 22:01:13 +1000
Message-ID: <18134.45449.527540.940620@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 14:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQiiB-0001m8-Mn
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbXH3MBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 08:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754798AbXH3MBS
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:01:18 -0400
Received: from ozlabs.org ([203.10.76.45]:57381 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbXH3MBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 08:01:18 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id ED169DDDF3; Thu, 30 Aug 2007 22:01:16 +1000 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57029>

In the 'dev' branch of the gitk.git repository at

git://git.kernel.org/pub/scm/gitk/gitk.git

there is now a version of gitk that is much faster at starting up than
the standard version.  Firstly, it doesn't lay out the whole graph,
only the parts that get displayed (plus a little bit either side), and
secondly, it caches the topology information that is used to determine
which tags a commit precedes and follows, and which branches it is on.

I'd like people to try it.  Comments, bug reports, patches etc. are
welcome, of course.

Paul.

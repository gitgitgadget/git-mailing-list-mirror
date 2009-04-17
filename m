From: Paul Mackerras <paulus@samba.org>
Subject: Re: .gitk should created hidden in windows
Date: Fri, 17 Apr 2009 20:49:27 +1000
Message-ID: <18920.24247.209397.732896@cargo.ozlabs.ibm.com>
References: <49BFA97A.1030203@lanwin.de>
	<18887.26239.115820.450313@cargo.ozlabs.ibm.com>
	<49C82377.40101@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Steve Wagner <lists@lanwin.de>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 12:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lulii-0002Qa-48
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 12:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbZDQKxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 06:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757436AbZDQKxO
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 06:53:14 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:49880 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756404AbZDQKxN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 06:53:13 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id D48DEB707B; Fri, 17 Apr 2009 20:53:12 +1000 (EST)
In-Reply-To: <49C82377.40101@users.sourceforge.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116731>

Pat Thoyts writes:

> An alternative that was discussed was to move it rather than hide it so
> that it ends up in the Application Data folder along with settings for
> other applications. The following patch does this but hits rather more
> lines of code and ends up needing to check the original location as well.

Sounds OK, but wouldn't we want to ignore ~/.gitk if there is a
gitk.settings in application data directory?

Paul.

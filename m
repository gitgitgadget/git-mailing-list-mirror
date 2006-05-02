From: Paul Mackerras <paulus@samba.org>
Subject: gitk highlight feature
Date: Wed, 3 May 2006 09:44:22 +1000
Message-ID: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed May 03 01:44:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4Xi-0004N5-J2
	for gcvg-git@gmane.org; Wed, 03 May 2006 01:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWEBXob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 19:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWEBXob
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 19:44:31 -0400
Received: from ozlabs.org ([203.10.76.45]:11975 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965040AbWEBXoa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 19:44:30 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8B66067BA3; Wed,  3 May 2006 09:44:29 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19443>

I just pushed out some changes to gitk which allow you to use one view
to highlight another (see the "Highlight" submenu under the "View"
menu), and which allow you to specify arbitrary git-rev-list arguments
for a view.  The arguments string uses shell quoting conventions.

I had been thinking of having fields in the view editor dialog where
you could put in refs that you did and didn't want included, date
specifiers, etc., all in separate fields with suitable labels.  Now
I'm thinking that it's probably just as convenient to put
"ORIG_HEAD.." into the git-rev-list arguments field as it is to put
"ORIG_HEAD" in the "Don't include commits reachable from this" field.
There may be an argument for having fields for "Exclude commits before
this date" and "Exclude commits after this date", because those things
often have spaces in them (e.g. "2 weeks ago") which would have to be
quoted in the git-rev-list arguments field.

Thoughts?

Paul.

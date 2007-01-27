From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: finding earliest tags descended from a given commit
Date: Fri, 26 Jan 2007 23:06:18 -0500
Message-ID: <20070127040618.GA14205@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 05:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAepf-0008PF-Rc
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 05:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbXA0EGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 23:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbXA0EGU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 23:06:20 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39035 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbXA0EGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 23:06:19 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HAepW-0004sA-SC
	for git@vger.kernel.org; Fri, 26 Jan 2007 23:06:18 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37915>

Just curious: every now and then somebody will ask me what kernel
version they need to upgrade to to get some given fix.  I can find the
commit with the given fix easily enough.  How do I then find the
earliest tagged version containing that fix?

More generally, given a commit, is there a quick way to find the set of
tags which tag commits descended from the given commit?  Or to get the
subset of such tags which are earliest (in the sense that they're not
descendants of any of the others)?

I usually just do

	git-describe <commit>

to make a guess, then

	git log <tag>..<commit>

to verify, but perhaps there's something more clever, or something that
would work better in a project where the tags aren't necessarily all in
a straight line.

--b.

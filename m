From: David Brown <git@davidb.org>
Subject: State of Perforce importing.
Date: Mon, 17 Sep 2007 12:30:28 -0700
Message-ID: <20070917193027.GA24282@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:08:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXMtg-000228-FD
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 22:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278AbXIQUIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 16:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756338AbXIQUIf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 16:08:35 -0400
Received: from mail.davidb.org ([66.93.32.219]:45985 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755790AbXIQUIe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 16:08:34 -0400
X-Greylist: delayed 2286 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2007 16:08:34 EDT
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IXMIe-0006eb-1g
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 12:30:28 -0700
Mail-Followup-To: Git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58478>

I'd like to track a lot of code living in a Perforce repository, so I've
been playing with 'git-p4.py'.  Is the one in the contrib/fast-import
directory the latest version, or is there a better place.

So far, it is having a couple of problems:

   - The commit comment is empty.  It doesn't seem to grab the Perforce
     description, and the user seems to be <a@b>.

   - Every revision seems to check every file out of Perforce.  This means
     that for the directory I want, every revision is going to take about 20
     minutes.

Before I start working on it, I'd like to make sure I'm working on the
latest code, though.

Thanks,
David

From: David Brown <git@davidb.org>
Subject: Referring a commit-id remote repo.
Date: Sun, 30 Sep 2007 21:16:35 -0700
Message-ID: <20071001041635.GA22102@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 06:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcCi5-0004tH-1n
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 06:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXJAEQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 00:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbXJAEQg
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 00:16:36 -0400
Received: from mail.davidb.org ([66.93.32.219]:54552 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbXJAEQf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 00:16:35 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IcChv-0006NW-CF
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 21:16:35 -0700
Mail-Followup-To: Git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59580>

Say someone has given me a url to a git-web view of a commit:

<http://www.linux-arm.org/git?p=linux-2.6.git;a=commitdiff_plain;h=c1a54638653ef81187309624940bfa1537aa0fab>

I managed to mangle this around to a repo name that I can clone from, so I
try:

   % git clone git://linux-arm.org/linux-2.6.git play

Now, from within my new directory, I try looking at this commit:

   % git show c1a54638653ef81187309624940bfa1537aa0fab
   fatal: bad object c1a54638653ef81187309624940bfa1537aa0fab

Ok, so they repo appears to have an object that none of their refs can
find, so I didn't pull it over with the clone.

Looking at the patch, I was able to find other commits with the same
content, so I suspect they were doing some rebasing on their repo, after
sending someone a commit ID via email.

The question I have: is there any way I can look at this particular commit
ID on the remote repo?  I couldn't come up with any way to get git fetch to
retrieve it.

Thanks,
David Brown

From: "Edward Ned Harvey" <git@nedharvey.com>
Subject: git performance
Date: Wed, 22 Oct 2008 16:17:16 -0400
Message-ID: <000801c93483$2fdad340$8f9079c0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 22:32:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskNh-0008NY-3d
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbYJVUbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165AbYJVUbF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:31:05 -0400
Received: from mail.itekmail.com ([208.86.156.243]:36534 "EHLO
	mail.itekmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523AbYJVUbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2008 16:31:00 -0400
X-Greylist: delayed 813 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Oct 2008 16:31:00 EDT
X-Spam-Status: No, hits=0.0 required=2.5
	tests=AWL: 0.454,BAYES_00: -1.665,TOTAL_SCORE: -1.211
X-Spam-Level: 
Received: from carmel ([98.110.160.127])
	(authenticated user rahvee@nedharvey.com)
	by mail.itekmail.com
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits))
	for git@vger.kernel.org;
	Wed, 22 Oct 2008 15:17:24 -0500
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Ack0gy0gRd+RMIOPTpmXR6mNf7WyiA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98903>

I see things all over the Internet saying git is fast.  I'm currently struggling with poor svn performance and poor attitude of svn developers, so I'd like to consider switching to git.  A quick question first.

The core of the performance problem I'm facing is the need to "walk the tree" for many thousand files.  Every time I do "svn update" or "svn status" the svn client must stat every file to check for local modifications (a coffee cup or a beer worth of stats).  In essence, this is unavoidable if there is no mechanism to constantly monitor filesystem activity during normal operations.  Analogous to filesystem journaling.

So - I didn't see anything out there saying "git is fast because it uses inotify" or anything like that.  Perhaps git would not help me at all?  Because git still needs to stat all the files in the tree?

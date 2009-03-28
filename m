From: jamespetts <jamespetts@yahoo.com>
Subject: Fork of abandoned SVN mirror - how to keep up to date with the SVN
Date: Sat, 28 Mar 2009 06:11:33 -0700 (PDT)
Message-ID: <22756729.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 14:13:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnYLT-0004Iy-KU
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 14:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbZC1NLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 09:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZC1NLg
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 09:11:36 -0400
Received: from kuber.nabble.com ([216.139.236.158]:47173 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbZC1NLf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 09:11:35 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LnYJx-00007j-GY
	for git@vger.kernel.org; Sat, 28 Mar 2009 06:11:33 -0700
X-Nabble-From: jamespetts@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114955>


For some months, I have been working on a 
http://github.com/jamespetts/simutrans-experimental/tree fork  of the
popular open source transport simulation game,  http://www.simutrans.com
Simutrans . Simutrans uses SVN as its official VCS, but I have been using
Git, by forking an  http://github.com/aburch/simutrans/tree/master
unofficial mirror  of the Simutrans SVN on Github. That has made it
extremely easy for me to merge in updates to the trunk code whilst
continuing to work on my branch. 

However, last week, the unofficial mirror on Github suddenly stopped
tracking the updates on the SVN. I have sent a message to the person who
administers it, but he has not been around for a long time, and I fear that
he probably will not reply - he did not reply to a message that I sent him
some time ago. I do not really know what to do now to keep my branch
synchronised. I have tried creating my own mirror of the SVN on Github, but
there are two problems: (1) I cannot for the life of me get the creation of
the mirror to work - it gets stuck permanently at "fetching authors"; and
(2) even if I did succeed in creating a mirror, it would no longer be the
same as the branch from which I forked, so Git would not be able to keep a
track of which parts of the code I intend to keep different from the trunk,
and which are the new updates to the trunk that I want to incorporate in my
branch. 

What is the best way of dealing with this mess to try to re-instate an easy
and reliable system of taking updates from the SVN and merging them into my
branched code?
-- 
View this message in context: http://www.nabble.com/Fork-of-abandoned-SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp22756729p22756729.html
Sent from the git mailing list archive at Nabble.com.

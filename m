From: thepurpleblob <howardsmiller@googlemail.com>
Subject: merge confusion
Date: Fri, 31 Jul 2009 05:35:54 -0700 (PDT)
Message-ID: <24755682.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 14:36:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWrL8-0003GE-03
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbZGaMfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZGaMfy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:35:54 -0400
Received: from kuber.nabble.com ([216.139.236.158]:49522 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZGaMfy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:35:54 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MWrL0-0008K0-GQ
	for git@vger.kernel.org; Fri, 31 Jul 2009 05:35:54 -0700
X-Nabble-From: howardsmiller@googlemail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124555>


I had some unexpected behaviour doing a merge today. I wonder if anybody can
tell me where I have gone wrong. This is the sequence...

* clone a remote repo
* created a local branch to track one of the remote branches
* did work on the local branch and then created another 'feature' branch
from that
* time elapsed and at some point(s) I pulled from the remote but did not
merge the original local branch
* finished feature, checkout local branch and merge in feature. 

What I didn't expect is that all the subsequent changes on the tracked
remote branch got merged in too. Which I didn't want.

So the question is - is that what's supposed to happen (ie. if you do any
merge the tracked branch 'fast forwards' the remote) and, if so, if I want a
branch that stays a branch (doesn't ever merge with the remote) how would I
do that?

Thanks!
-- 
View this message in context: http://www.nabble.com/merge-confusion-tp24755682p24755682.html
Sent from the git mailing list archive at Nabble.com.

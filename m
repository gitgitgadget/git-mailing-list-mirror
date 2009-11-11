From: rhlee <richard@webdezign.co.uk>
Subject: Working on merged branches whilst seeing current master
Date: Wed, 11 Nov 2009 09:16:46 -0800 (PST)
Message-ID: <1257959806206-3987667.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 18:16:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8GoQ-0005Vt-Q4
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 18:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757879AbZKKRQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 12:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757875AbZKKRQm
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 12:16:42 -0500
Received: from kuber.nabble.com ([216.139.236.158]:52549 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940AbZKKRQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 12:16:42 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N8GoI-0005BA-6p
	for git@vger.kernel.org; Wed, 11 Nov 2009 09:16:46 -0800
X-Nabble-From: rhlee <richard@webdezign.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132678>


Hi again gits,

I think my current query is somewhat related to my previous issue of
"Preserving branches after merging on ancestor" that you help me with last
time (many thanks).

I use branches for features. I have a branch and I merged it into my master
branch as I thought it was finished. But it turns out I wasn't and so I need
to work on it again.

I have made some more changes (branches and merges) on master. So what I
should do is checkout that branch, work on it committing along the way and
then merge it again onto my master branch.

However I though I am working on a feature branch I want to be also working
from the master branch as reference. Yes I know I probably should not be
working like this. My branches should be wholly independent. But I doing web
development not kernel development so there is much less modularity and
branches/features have a tendency to creep into one another. If you want to
get and idea of my workflow see my thread last week "Preserving branches
after merging on ancestor".

So how do I work again on a branch that has been preiously merged whilst
"seeing" the current changes on the master or another branch?

Is this a bad idea first of all. Should I change my workflow instead?

If I do try to do this I guess I got several ways.

I think I could pull(?) or merge the changes so far from the master branch
into the feature branch. But this seems like an uneccesary duplication.

Or should I just create a new branch? But if I do this there is no link
between the old and new branch.

Richard
-- 
View this message in context: http://n2.nabble.com/Working-on-merged-branches-whilst-seeing-current-master-tp3987667p3987667.html
Sent from the git mailing list archive at Nabble.com.

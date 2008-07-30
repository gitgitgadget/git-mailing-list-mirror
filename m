From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: git blame not respecting --find-copies-harder ?
Date: Wed, 30 Jul 2008 11:39:03 +0200
Message-ID: <20080730093903.GA14330@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 11:40:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO8AC-0001AX-CS
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 11:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbYG3JjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 05:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbYG3JjG
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 05:39:06 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:54195 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbYG3JjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 05:39:05 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id A5C9F5466; Wed, 30 Jul 2008 11:39:03 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90761>

git clone git://git.cuci.nl/pike

Both of this "git blame" commands return the same (erroneous) results
at the end of the files (the last lines are older, and are from the old
README file next to it).

git blame README-CVS
git blame --find-copies-harder README-CVS

However, when using git show with and without --find-copies-harder, we
see that git indeed finds the copy with a 76% similarity index.

git show 9eb55816
git show --find-copies-harder 9eb55816

Shouldn't it be expected that blame should also give the same difference
in result with and without that option?

On a related note, it doesn't seem possible to make --find-copies-harder
a default; is that intentional?
-- 
Sincerely,
           Stephen R. van den Berg.

How many weeks are there in a lightyear?

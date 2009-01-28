From: Zabre <427@free.fr>
Subject: (beginner) git rm
Date: Wed, 28 Jan 2009 02:11:38 -0800 (PST)
Message-ID: <1233137498146-2231416.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 11:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS7Ps-0007fM-13
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 11:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbZA1KLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 05:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbZA1KLj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 05:11:39 -0500
Received: from kuber.nabble.com ([216.139.236.158]:40876 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZA1KLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 05:11:38 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LS7OU-00066P-4t
	for git@vger.kernel.org; Wed, 28 Jan 2009 02:11:38 -0800
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107521>


Hi,

I am learning git and there is something I don't get : why a file deleted in
a branch gets also deleted in my master?
(For the moment I'm only working locally, no remote repository)

I have a master branch containing 4 text files called a.txt , b.txt , c.txt
, d.txt . (in HEAD)

I create a new branch from there (masters HEAD) and go to this new branch.
$ git branch new
$ git checkout new

I delete one file in the new branch
$ git rm d.txt
$ ls
a.txt b.txt c.txt

Then I go back to the master branch and list the files there
$ git checkout master
$ls
a.txt b.txt c.txt

I have not modified the master branch, why is d.txt deleted there also?

There must be something I did not understand in git behaviour (something to
do with the index?)
Thank you for your help.
-- 
View this message in context: http://n2.nabble.com/%28beginner%29-git-rm-tp2231416p2231416.html
Sent from the git mailing list archive at Nabble.com.

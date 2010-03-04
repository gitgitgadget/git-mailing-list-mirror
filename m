From: jateeq <jawad_atiq@hotmail.com>
Subject: How do I get the correct modification status after running git
 diff?
Date: Thu, 4 Mar 2010 07:40:00 -0800 (PST)
Message-ID: <27782430.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 16:40:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnD9n-0004iL-Je
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 16:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab0CDPkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 10:40:04 -0500
Received: from kuber.nabble.com ([216.139.236.158]:47470 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab0CDPkD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 10:40:03 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NnD9c-0003zl-C5
	for git@vger.kernel.org; Thu, 04 Mar 2010 07:40:00 -0800
X-Nabble-From: jawad_atiq@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141530>


Hello,

I have added a new file to a working repository, and would like to run a
diff between the last commit and whatever is int he working tree, along with
an identification of what kind of a modification it was. Currently, I am
adding all files to the index with the -N option, and then running a git
diff --name-status. This works well for existing files that have been
modified or deleted, but fails if a file is rename or is added. Does anyone
know of the right way to do this? The commands I am using to add and diff
newly added files are as follows in the sequence shown.

Commands:
echo "this is a new file" > file1.xml
git add -N .
git diff --name-status

The output is :
M   file1.xml

I want the status to show A for the newly added file (and R for renamed
files but I don't know if that's possible).

Thank You,
Jawad.
-- 
View this message in context: http://old.nabble.com/How-do-I-get-the-correct-modification-status-after-running-git-diff--tp27782430p27782430.html
Sent from the git mailing list archive at Nabble.com.

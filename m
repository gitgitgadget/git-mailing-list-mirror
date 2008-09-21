From: mwolfe38 <mwolfe38@gmail.com>
Subject: ignoring files/directories in git
Date: Sun, 21 Sep 2008 09:54:01 -0700 (PDT)
Message-ID: <19596152.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 18:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhSDw-0000Hc-SN
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbYIUQyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbYIUQyD
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:54:03 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40963 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbYIUQyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:54:03 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KhSC9-0007n2-Ht
	for git@vger.kernel.org; Sun, 21 Sep 2008 09:54:01 -0700
X-Nabble-From: mwolfe38@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96411>


I'm working on a project by myself and using git mostly just to learn about
it.
In my project I have several directories I do not want to have git ignore.
One of them being
cache/ and the other log/
I've added them to the .gitignore file which I have in the initial directory
of the repository
The contents of my gitignore are:

.settings
.cache
cache/
log/
.project

However, if I do 
git add .
It will add the files from cache and log anyways.
I know git add . will add anything that hasn't been added but shouldn't it
ignore files in .gitignore?
If not, what is the point, I would just ignore them manually anyways. 
The main reason i like doing git add .
is because i'm using symfony php framework which makes good use of scripts
which generates lots if initial files for you and thus adding one at a time
would be a pain.

Any idea what might be going on here?  I thought maybe I had added those
directories before putting them in .gitignore so i used git rm -r to remove
them but they still show back up with doing git add .

Thanks in advance
-- 
View this message in context: http://www.nabble.com/ignoring-files-directories-in-git-tp19596152p19596152.html
Sent from the git mailing list archive at Nabble.com.

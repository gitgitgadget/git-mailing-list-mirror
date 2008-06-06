From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] git diff dira dirb file ...
Date: Fri, 6 Jun 2008 18:27:23 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806061821320.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:28:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4kPy-0004vw-7r
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 00:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbYFFW1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 18:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbYFFW1Z
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 18:27:25 -0400
Received: from iabervon.org ([66.92.72.58]:50772 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613AbYFFW1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 18:27:24 -0400
Received: (qmail 28037 invoked by uid 1000); 6 Jun 2008 22:27:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jun 2008 22:27:23 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84125>

After a lot of trying, I finally found something that git diff doesn't 
handle. If you've got two trees of files with the same general structure, 
even if they aren't at all git-related, you can use:

$ git diff dira dirb

to get a nice diff between them. But then it would be intuitive and useful 
to be able to restrict by path the files within those directories that you 
want to compare (much like "git diff origin master file1 file2 ...") with:

$ git diff dira dirb file1 file2

That would, of course, compare dira/file1 with dirb/file1 and dira/file2 
with dirb/file2. Before I start looking into implementing this, is it 
incoherent for some reason I'm not seeing?

	-Daniel
*This .sig left intentionally blank*

From: "David Neu" <david@davidneu.com>
Subject: Converting from svn to git
Date: Sun, 10 Aug 2008 09:11:43 -0400
Message-ID: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 15:12:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSAj0-0004d8-BH
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 15:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbYHJNLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 09:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753829AbYHJNLo
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 09:11:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:44994 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbYHJNLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 09:11:44 -0400
Received: by wx-out-0506.google.com with SMTP id h29so965578wxd.4
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 06:11:43 -0700 (PDT)
Received: by 10.70.25.1 with SMTP id 1mr7303142wxy.75.1218373903232;
        Sun, 10 Aug 2008 06:11:43 -0700 (PDT)
Received: by 10.70.53.6 with HTTP; Sun, 10 Aug 2008 06:11:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91834>

Hi,

I'm trying to move an svn repo to git.  I'm not going to be committing
back to the svn repo, but will simply retire it and use git.

The issue I'm having is that the svn repo has sub directories that I'd
like to be separate git repos.

I can easily accomplish this for the sub directories like this:

git-svn clone svn-url/subdir1
git-svn clone svn-url/subdir2
etc.

but for the files in the base directory

git-svn clone svn-url

pulls the entire directory tree.

Is there a git-svn strategy similar to git-svnimport -P that would do the trick?
My git version 1.5.6.4 doesn't include git-svnimport, and I'm getting
the impression
it's be deprecated.

Many thanks for any help!

Cheers,
David

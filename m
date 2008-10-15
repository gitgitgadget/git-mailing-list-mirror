From: benhill <benhill@gmail.com>
Subject: Updating Submodules
Date: Tue, 14 Oct 2008 22:51:02 -0700 (PDT)
Message-ID: <19987153.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 07:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpzN7-0005Re-Cu
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 07:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYJOFvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 01:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYJOFvG
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 01:51:06 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35366 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbYJOFvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 01:51:06 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KpzHi-0008DV-Fb
	for git@vger.kernel.org; Tue, 14 Oct 2008 22:51:02 -0700
X-Nabble-From: benhill@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98233>


Heyah Folks.

So I have been playing with this for a few hours, and I must be missing
something.

I have created a submodule in my super project with the standard commands:

git submodule add <repo> <path>

No problem.  Repo Loads.  I push it to origin (github) and the little arrow
designating it as a sub is there.

Then one of my colleagues checks out the super and runs:

git submodule init
git submodule add

...no problems thus far...the repo loads as planned.

The she makes some changes to the submodule, checks them in, pushes them to
origin (also github).

Now, if she tried to check in changes to the super...it is no longer just
the submodule ref that she is checking in...but the whole tree....like it
adds all the files in the submodule to the super...if she were to push to
github, the little arrow would be gone..and the whole tree is there.  

What am I doing wrong here?  How do you make updates to supers to point to
the head revision of the sub?

Thanks for any help.

Ben
-- 
View this message in context: http://www.nabble.com/Updating-Submodules-tp19987153p19987153.html
Sent from the git mailing list archive at Nabble.com.

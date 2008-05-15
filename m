From: Peter Bengtson <peter@peterbengtson.com>
Subject: Submodule on Debian breaks
Date: Thu, 15 May 2008 14:29:54 +0200
Message-ID: <06D015DD-6F3B-4D2E-8305-BDD062F149E6@peterbengtson.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 14:30:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwcbe-0003R0-F3
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 14:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbYEOM34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 08:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbYEOM34
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 08:29:56 -0400
Received: from sphinx.naradek.org ([213.80.33.227]:63935 "EHLO
	sphinx.naradek.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbYEOM3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 08:29:55 -0400
Received: from [172.16.0.138] (static-213-115-7-202.sme.bredbandsbolaget.se [213.115.7.202])
	by sphinx.naradek.org (Postfix) with ESMTP id C61EDE70BEB
	for <git@vger.kernel.org>; Thu, 15 May 2008 14:29:54 +0200 (CEST)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82203>

We have problems cloning git repositories containing submodules on  
Debian. Cloning them locally, on Debian, or on Mac OS X, works without  
a hitch. Cloning them remotely from a Mac OS X repo server to a Mac OS  
X client computer also works as expected, as does cloning repos  
without submodules.

But as soon as a clone of a git repo containing a submodule on the  
Debian machine is attempted from another computer, this happens:

> error: git-upload-pack: git-pack-objects died with error.
> fatal: git-upload-pack: aborting due to possible repository  
> corruption on the remote side.
> remote: Generating pack...
> remote: Done counting 7 objects.
> remote: error: unable to find  
> 4d5436979e0afc1e9c03dceeeea3c2ddb9dbf211remote:
> remote: fatal: unable to get type of object  
> 4d5436979e0afc1e9c03dceeeea3c2ddb9dbf211
> remote: aborting due to possible repository corruption on the remote  
> side.
> fatal: early EOF
> fatal: index-pack failed

However, git fsck reports no errors.

The git version is the latest published one, 1.5.5.1, installed from  
source (not via apt-get), and configured only with ./configure -- 
prefix=/usr/local

Googling for info about git submodule and corrupted repos yields  
absolutely nothing.

Any ideas, anyone?

	/ Peter Bengtson

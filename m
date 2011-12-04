From: git815 <jianfu.pan@gmail.com>
Subject: Help with setting up git server
Date: Sun, 4 Dec 2011 05:22:49 -0800 (PST)
Message-ID: <1323004969273-7060154.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 14:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXC1w-0004bz-33
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 14:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab1LDNWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 08:22:50 -0500
Received: from sam.nabble.com ([216.139.236.26]:45664 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614Ab1LDNWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 08:22:50 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <jianfu.pan@gmail.com>)
	id 1RXC1p-00072y-A4
	for git@vger.kernel.org; Sun, 04 Dec 2011 05:22:49 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186265>

After what I thought I have set up a git server under http, I'm getting this
error on client site whenever I issue a git command: "fatal: Not a git
repository (or any of the parent directories): .git".

Here is what I did:
(1) In project directory, clone a git project:  "git clone --bare proj.git" 
( I noticed no .git subdirectory exists in the cloned directory).
(2) Move the cloned directory proj.git under web server path.
(3) On a separate client machine, clone a local copy of the project:  "git
clone http://git-server/proj.git" (This command runs and gives me the actual
source code files and nothing else.  The cloned proj.git directories
contains git files and directories).

I'm new and I must have missed something.  Can anyone help?  Thanks.


--
View this message in context: http://git.661346.n2.nabble.com/Help-with-setting-up-git-server-tp7060154p7060154.html
Sent from the git mailing list archive at Nabble.com.

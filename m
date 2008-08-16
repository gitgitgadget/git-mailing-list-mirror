From: Anthony Booker <tb@purple-people.org>
Subject: BUG simple "revert" fails
Date: Sat, 16 Aug 2008 16:21:57 -0700
Message-ID: <48A76115.9060909@purple-people.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 01:48:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUVVS-0008FL-0Z
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 01:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbYHPXrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 19:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYHPXrX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 19:47:23 -0400
Received: from purple-people.org ([64.62.231.173]:46565 "EHLO
	purple-people.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbYHPXrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 19:47:22 -0400
X-Greylist: delayed 1523 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Aug 2008 19:47:22 EDT
Received: from [192.168.2.2] (or-71-53-77-206.dhcp.embarqhsd.net [71.53.77.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by purple-people.org (Postfix) with ESMTP id 599F81C620
	for <git@vger.kernel.org>; Sat, 16 Aug 2008 19:21:58 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92561>


Attached is a tarball with a couple of repositories.  eg-sub is a 
submodule in eg.  In eg there's a commit, 
cd626e6baaa0888c6090e1f040f9f0ba8bfef218, which inappropriately changed 
a file in eg-sub.  It's a newby mistake with git and submodules.

The problem is that the problem can't be reverted.  It fails with 
unknown object It is a submodule.

To reproduce, unpack the tarball, cd to eg and:
git revert cd626e6baaa0888c6090e1f040f9f0ba8bfef218

Thanks for your time.

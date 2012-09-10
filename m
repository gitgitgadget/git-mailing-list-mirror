From: Rob Marshall <Rob.Marshall17@gmail.com>
Subject: Problems with repack during push
Date: Mon, 10 Sep 2012 12:16:22 -0400
Message-ID: <504E1256.4020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 18:23:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6lu-0003PN-15
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab2IJQXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:23:30 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:59828
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750805Ab2IJQX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 12:23:29 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Sep 2012 12:23:29 EDT
Received: from omta07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id xSCa1j0061GhbT851UGTrq; Mon, 10 Sep 2012 16:16:27 +0000
Received: from Rob-Marshalls-iMac.local ([76.23.194.37])
	by omta07.westchester.pa.mail.comcast.net with comcast
	id xUGl1j00J0oslp03TUGl7x; Mon, 10 Sep 2012 16:16:45 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:15.0) Gecko/20120824 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205137>

Hi,

Whenever I do a git push origin of a new branch I see:

Auto packing the repository for optimum performance.
/usr/local/libexec/git-core/git-sh-setup: line 241: uname: command not found
/usr/local/libexec/git-core/git-repack: line 56: rm: command not found
/usr/local/libexec/git-core/git-repack: line 85: mkdir: command not found
/usr/local/libexec/git-core/git-repack: line 85: rm: command not found
fatal: 'repack' appears to be a git command, but we were not
able to execute it. Maybe git-repack is broken?
error: failed to run repack

If I do a 'git repack' it works fine, so are these
messages coming from the remote server?

Thanks,

Rob

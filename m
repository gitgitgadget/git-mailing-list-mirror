From: Anthony <anthony@bnovc.com>
Subject: No argument is allowed
Date: Thu, 9 Sep 2010 21:43:39 +0000 (UTC)
Message-ID: <loom.20100909T233911-69@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 23:45:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otovi-0006Sn-E2
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 23:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab0IIVpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 17:45:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:33120 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208Ab0IIVpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 17:45:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OtovY-0006OM-5F
	for git@vger.kernel.org; Thu, 09 Sep 2010 23:45:06 +0200
Received: from mail.garmin.com ([63.76.48.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 23:45:04 +0200
Received: from anthony by mail.garmin.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 23:45:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.77.95.90 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.53 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155907>

When doing a "git clone 
ssh://platforms.companyname.com:40511/Support/Support/foobar.git", I get "fatal: 
No argument is allowed: /Support/Support/foobar.git".

The server is using JGit (0.8.4, with apache-sshd 0.3.0), but that error message 
isn't in the jgit source. I don't know where it originates from.

SSHing to that server gives "shell request failed on channel 0"

Someone in freenode/#git recommended I post here, although it may turn out the 
JGit mailing list is more appropriate.

Does anyone have any suggestions on how to resolve this or additional 
information?

Thanks

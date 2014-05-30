From: fuz@fuz.su
Subject: Bugreport: git push disobeys -c remote.xxx.url=...
Date: Fri, 30 May 2014 02:03:56 +0200
Message-ID: <20140530000356.GA8033@fuz.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 02:13:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqARk-0002ci-ND
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 02:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbaE3ANR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 20:13:17 -0400
Received: from fuz.su ([5.135.162.8]:36463 "EHLO fuz.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbaE3ANQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 20:13:16 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 May 2014 20:13:16 EDT
Received: by fuz.su (Postfix, from userid 1000)
	id E00FB20454; Fri, 30 May 2014 02:03:56 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250424>

Hello!

I've tried to changing the URL of a remote temporarily because of network
issues. I tried something like this:

    git -c remote.foo.url=http://gitserver.example/repo.git push foo bar

Tracing shows that git push does not use the provided URL for the remote foo
and instead uses the URL configured in the repository configuration as if the
-c option was not present at all. This looks like a bug to me.

My git identifies as version 1.8.1.2.

Yours sincerely,
Robert Clausecker

-- 
()  ascii ribbon campaign - for an 8-bit clean world 
/\  - against html email  - against proprietary attachments

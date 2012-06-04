From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Help: Found odd git bug
Date: Mon, 04 Jun 2012 12:37:07 -0400
Message-ID: <4FCCE433.7090007@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:37:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbaH2-0000fW-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 18:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760957Ab2FDQgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 12:36:52 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:44388 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760952Ab2FDQgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 12:36:52 -0400
X-Greylist: delayed 8261 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2012 12:36:52 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp27.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 616D82A80AA;
	Mon,  4 Jun 2012 12:36:51 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp27.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1BA322A8096;
	Mon,  4 Jun 2012 12:36:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199146>

Hi all,

A commit claims to add a line to a file.  Indeed, "git diff" shows the line
being added.

However, when I check out the commit, the file contains a *different* line,
with slightly modified contents.

What's more, "git show SHA:path/to/file" shows that the blob contains the
wrong line.

I found this using git 1.7.9, but 1.7.11.rc1 also shows the problem.

How can I narrow down what's causing this problem?

		M.

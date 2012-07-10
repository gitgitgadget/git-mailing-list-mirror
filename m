From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: "git commit --amend --only --" nevertheless commits staged changes
Date: Tue, 10 Jul 2012 12:41:13 +0200
Message-ID: <4FFC06C9.5050405@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 12:50:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoY1O-0000XX-BV
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 12:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab2GJKuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 06:50:14 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:43882 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab2GJKuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 06:50:10 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2012 06:50:10 EDT
Received: from [91.8.45.121] (helo=[192.168.92.202])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1SoXsX-0007hj-Mm
	for git@vger.kernel.org; Tue, 10 Jul 2012 12:41:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
X-Enigmail-Version: 1.4.2
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201259>

When using "git commit --amend --only --message <message> --", I'd
expect to have just the commit message of my last commit changed,
according to the man page:

"--only Make a commit only from the paths specified on the command line,
disregarding any contents that have been staged so far. [...] If this
option is specified together with --amend, then no paths need to be
specified, which can be used to amend the last commit without committing
changes that have already been staged."

However, all staged changes are committed as well. So looks like either
the man page or Git is wrong here!?

Tested with 1.7.10.msysgit.1.

-Marc

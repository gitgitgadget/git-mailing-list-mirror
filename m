From: "Christian C. Schouten" <info@zark3.net>
Subject: Beginner's question on how to use git for multiple parallel versions
Date: Mon, 4 Jan 2010 12:29:52 +0100
Message-ID: <F8CC469C9CCA415696101414EA997C0.MAI@sohosted19.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_Part_638CDCAF.3BFD42A7"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 12:49:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRlQj-0006Fn-LE
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 12:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab0ADLs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 06:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778Ab0ADLs5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 06:48:57 -0500
Received: from ns1.sohosted19.com ([195.8.208.62]:3777 "EHLO sohosted19.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab0ADLs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 06:48:57 -0500
X-Greylist: delayed 1131 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2010 06:48:57 EST
Received: from ([195.86.221.234]) by sohosted19.com with MailEnable WebMail; Mon, 4 Jan 2010 12:29:52 +0100
X-Mailer: MailEnable Web Mail 1.1
X-Read: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136109>

This is a multi-part message in MIME format.

----=_Part_638CDCAF.3BFD42A7
Content-type: text/plain; charset="US-ASCII"

Hello all,

I&#8217;ve got a project that I want to do version management on with git but being a beginner in
cvs/svn/dvcs etc. terminology I don&#8217;t know yet how to set it up.
My project needs to exist as several parallel copies, i.e. there is a &#8220;main version&#8221; in
which I do my development but it needs to end up being available as a couple of different
configurations.
For instance, say there is a file table.xml then this needs to contain different rows for versions
A and B. Likewise, a file process.bpel needs to be named identical for each version but contain
different content depending on whether it is distributed as version A or version B. Any changes
made in non-version specific files should be visible in all copies, but changes made to
version-specific files need to remain isolated to that particular version.

I read about branching, merging, rebasing and cherry-picking commits but I don&#8217;t get it yet.
Can anyone enlighten me on how I should approach this in a way that I can maintain easily
throughout future development for my situation?

Thanks in advance for any pointers,

Best,

Chris


----=_Part_638CDCAF.3BFD42A7--

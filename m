From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: gitk layout bug
Date: Sat, 19 Jan 2008 17:44:58 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 02:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGPFg-0005a2-6m
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 02:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbYATBpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 20:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYATBpE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 20:45:04 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57835 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751702AbYATBpC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 20:45:02 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K1iwKx014314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 17:45:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K1iwj4030290;
	Sat, 19 Jan 2008 17:44:58 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71149>


In the current git repository, try this:

	gitk origin/master..origin/pu

and it starts out looking ok.

But then scroll down a bit (say, press "PageDown" ten to twenty times), 
and scroll up again, and now that thing is totally unusable.

Is it just me?

		Linus

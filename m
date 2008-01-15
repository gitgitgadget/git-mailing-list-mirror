From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 21:14:58 +0100
Message-ID: <478D1442.2090301@gmx.ch>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 21:16:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsCZ-0004Jy-Sn
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbYAOUPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYAOUPE
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:15:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:56680 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752259AbYAOUPB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:15:01 -0500
Received: (qmail invoked by alias); 15 Jan 2008 20:14:59 -0000
Received: from 70-185.1-85.cust.bluewin.ch (EHLO [192.168.123.202]) [85.1.185.70]
  by mail.gmx.net (mp048) with SMTP; 15 Jan 2008 21:14:59 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19bPQ0hPq9bPUWfwgCh4tNPEZXIF845N6Dzll3mo5
	hrirHsipLpvWDo
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
In-Reply-To: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70549>

Chris Ortman wrote:
> Something that would really benefit the folks who use git to manage a
> subversion repository (such as myself) would be a special format-patch
> command for git-svn that creates a tortoise svn compatible diff file.

Isn't it that TortoiseSVN is simply being too strict about the
diff format it accepts?  Since even GNU patch reads and applies
them fine (I didn't test it thoroughly though), I would assume git
diffs follow some sort of standard (couldn't find it though) for
the unified diff format, or at least was designed to not break
patch.  So in the long term, I think this is rather or at least
also something to be addressed in TortoiseSVN.

jlh

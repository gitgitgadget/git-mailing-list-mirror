From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Sat, 3 Feb 2007 17:07:14 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnes9ga2.3l6.mdw@metalzone.distorted.org.uk>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <200702021302.10567.andyparkins@gmail.com> <Pine.LNX.4.64.0702020955540.3021@xanadu.home> <200702021611.06029.andyparkins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 18:07:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDOMK-0004wt-Is
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 18:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992431AbXBCRHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 12:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992434AbXBCRHS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 12:07:18 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:12140 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S2992431AbXBCRHR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Feb 2007 12:07:17 -0500
Received: (qmail 8097 invoked by uid 110); 3 Feb 2007 17:07:15 -0000
Received: (qmail 8081 invoked by uid 9); 3 Feb 2007 17:07:15 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1170522434 7991 172.29.199.2 (3 Feb 2007 17:07:14 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sat, 3 Feb 2007 17:07:14 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38577>

Andy Parkins <andyparkins@gmail.com> wrote:

> to do.  Asking for HEAD's reflog should be the same as asking for the 
> pointed-to-branch's reflog.

And what do you do when HEAD is detached?

I mean: I detach HEAD, and then ask about HEAD@{yesterday}.  It'd be
nonsensical for that to be an error, since HEAD surely did have a value
yesterday.  But it can't tell me where my current branch head was
yesterday, because there isn't a current branch to tell me about.

HEAD@{date} referring to the HEAD reflog is the only sane thing to do.

-- [mdw]

From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 09:15:42 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnerjhlu.7v0.mdw@metalzone.distorted.org.uk>
References: <45B8E61E.C9C5E6C6@eudaptics.com> <7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 10:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANBV-00037J-NS
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030823AbXAZJPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030845AbXAZJPq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:15:46 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:21788 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1030823AbXAZJPo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jan 2007 04:15:44 -0500
Received: (qmail 3598 invoked by uid 110); 26 Jan 2007 09:15:42 -0000
Received: (qmail 3582 invoked by uid 9); 26 Jan 2007 09:15:42 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1169802942 3580 172.29.199.2 (26 Jan 2007 09:15:42 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Fri, 26 Jan 2007 09:15:42 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37820>

Junio C Hamano <junkio@cox.net> wrote:

> grafts are local matter for archaeologist's convenience to glue
> two independent histories together, and not much more. 

I've found them useful for doing imports from CVS.  You run
git-cvsimport, and then manually find the places where merges happened
and record them as grafts.  gitk then correctly displays the history,
which is nice.

What you then do is run cg-admin-rewritehist, which magically transforms
the history into one with the grafts etched in.  All that remains is to
translate the refs, which you can do with a sed script you got
cg-admin-rewritehist to write for you.

-- [mdw]

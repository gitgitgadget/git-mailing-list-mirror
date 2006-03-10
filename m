From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] allow double click on current HEAD id after git-pull
Date: Fri, 10 Mar 2006 00:49:47 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne11j9b.fr9.mdw@metalzone.distorted.org.uk>
References: <20060211112630.GA12421@suse.de> <20060309210250.GY31278@pasky.or.cz> <7vy7zj2oom.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 10 01:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHVpk-0005iK-1G
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 01:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWCJAtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 19:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWCJAtu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 19:49:50 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:439 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932206AbWCJAts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 19:49:48 -0500
Received: (qmail 362 invoked by uid 110); 10 Mar 2006 00:49:47 -0000
To: git@vger.kernel.org
Received: (qmail 349 invoked by uid 9); 10 Mar 2006 00:49:47 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1141951787 32152 172.29.199.2 (10 Mar 2006 00:49:47 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Fri, 10 Mar 2006 00:49:47 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17443>

Junio C Hamano <junkio@cox.net> wrote:

> Well I kind of like ending a sentence with a full stop.  Isn't
> this something you can do by confuguiring your cut&paste?

Could do, but since . is a useful filename character it usually seems
like a good idea to include it in the set of characters considered a
`word' by the terminal double-click logic.  I've not used xterm for
ages, but a quick check shows that Eterm isn't smart enough to be told
that . followed by a word-constituent is good and should be included in
a word, whereas a trailing . is a different thing which it doesn't want
to include.

So I'm in favour of killing the full-stops.  Sorry. :-(

-- [mdw]

From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: Cloning from sites with 404 overridden
Date: Fri, 24 Mar 2006 17:29:14 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne28b3a.cp6.mdw@metalzone.distorted.org.uk>
References: <20060322025921.1722.qmail@science.horizon.com> <442152E0.4020604@op5.se>
X-From: git-owner@vger.kernel.org Fri Mar 24 18:29:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMq6D-0000C5-63
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 18:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWCXR3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 12:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWCXR3S
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 12:29:18 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:50498 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751280AbWCXR3S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 12:29:18 -0500
Received: (qmail 26947 invoked by uid 110); 24 Mar 2006 17:29:14 -0000
To: git@vger.kernel.org
Received: (qmail 26934 invoked by uid 9); 24 Mar 2006 17:29:14 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1143221354 24512 172.29.199.2 (24 Mar 2006 17:29:14 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Fri, 24 Mar 2006 17:29:14 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17929>

Andreas Ericsson <ae@op5.se> wrote:

>> I'm not sure what the best "object that's not supposed to be there" is.
>
> .git/objects/00/hoping-for-a-404-or-webadmin-should-fix

If .git/objects/00/00000000000000000000000000000000000000 exists, the
repository has big problems already.

(Aside: `C-u 38 0' doesn't work because Emacs hears `C-u 380' and waits
for a key.  `M-: (insert-char ?0 38) RET' does the right thing, but is
ugly.  Any better suggestions?)

-- [mdw]

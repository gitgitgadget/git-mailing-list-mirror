From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH 0/9] http-fetch fixes
Date: Wed, 1 Feb 2006 15:47:48 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndu1m14.2i8.mdw@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk> <20060201153052.GA16461@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Feb 01 16:48:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4KD9-0002ql-N8
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 16:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWBAPrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 10:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWBAPrw
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 10:47:52 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:24051 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1161100AbWBAPrw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 10:47:52 -0500
Received: (qmail 23115 invoked by uid 110); 1 Feb 2006 15:47:48 -0000
To: git@vger.kernel.org
Received: (qmail 23101 invoked by uid 9); 1 Feb 2006 15:47:48 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1138808868 23099 172.29.199.2 (1 Feb 2006 15:47:48 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Wed, 1 Feb 2006 15:47:48 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15421>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> wrote:

>> The series applies to commit 1506fc34f7585880aeeb12b5fdfe2de4800f9df5.
> after reverting c8568e139ed2149fbfb7ef9a8d819d5b6b7c554f it applies to
> 8233340ce6eb700eb2cd9c0fef4d1705997c499b (=current master), too.

Good-oh.  (I did pull the latest tip, and then panicked because Nick's
change had already made it out.)

> With these patches applied, I get now a Segfault, while cloning
> u-boot.

Oh. :-(  

> Actually now I cannot reproduce it anymore.  I added some debugging code
> s.t. I can give more details if it reoccurs.

Please do.  I've just tried, and I can't reproduce the problem either.

The watch-slots patch seems to uncover all manner of brokenness in
http-fetch.c -- or I've violated some unwritten assumptions of a very
deep nature, which is always possible.

Maybe the right thing to do is to go with Nick's separate-status-
structures patch as an actual mainline fix, with my patches for
http-fetch.c's other bugs as a belt-and-braces.

-- [mdw]

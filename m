From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH 0/9] http-fetch fixes
Date: Fri, 3 Feb 2006 20:20:01 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndu7enh.2i8.mdw@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk> <20060201153052.GA16461@informatik.uni-freiburg.de> <slrndu1m14.2i8.mdw@metalzone.distorted.org.uk> <7vzmlaxy2o.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:20:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57Po-0002lE-Pe
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945944AbWBCUUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945945AbWBCUUQ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:20:16 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:6452 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1945944AbWBCUUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:20:15 -0500
Received: (qmail 1566 invoked by uid 110); 3 Feb 2006 20:20:01 -0000
To: git@vger.kernel.org
Received: (qmail 1552 invoked by uid 9); 3 Feb 2006 20:20:01 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1138998001 664 172.29.199.2 (3 Feb 2006 20:20:01 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Fri, 3 Feb 2006 20:20:01 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15545>

Junio C Hamano <junkio@cox.net> wrote:

> I briefly looked at the series; the following may be ready to be
> applied:
>
> [PATCH 2/9] http-fetch: Fix object list corruption in fill_activ...
> [PATCH 5/9] http-fetch: Fix message reporting rename of object file
> [PATCH 6/9] http: Turn on verbose Curl messages if GIT_CURL_VERB...
> [PATCH 7/9] http-fetch: Tidy control flow in process_alternate_r...
>
> For now however I'll wait and see for a while, in case you can
> reproduce the breakage Uwe found and add fixes to your set.

I've not had any more trouble with this since, but I'm still worried
that the http fetcher is rather fragile. :-(

What was wrong with 3/9, by the way?  (It's the abort_active_slot patch
-- which does fix a real bug.)  Is it just that it doesn't apply cleanly
without the first one?  If so, I can send out a new patch easily enough.

-- [mdw]

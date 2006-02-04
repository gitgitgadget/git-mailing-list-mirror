From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH 2/3] daemon: Set SO_REUSEADDR on listening sockets.
Date: Sat, 4 Feb 2006 10:16:00 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndu8vn0.2i8.mdw@metalzone.distorted.org.uk>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk> <20060203202704.1895.18383.stgit@metalzone.distorted.org.uk> <7vfymz33v8.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 11:16:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5KSe-0004yS-3o
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 11:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946013AbWBDKQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 05:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946099AbWBDKQE
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 05:16:04 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:46891 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1946013AbWBDKQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 05:16:02 -0500
Received: (qmail 21840 invoked by uid 110); 4 Feb 2006 10:16:00 -0000
To: git@vger.kernel.org
Received: (qmail 21826 invoked by uid 9); 4 Feb 2006 10:16:00 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1139048160 21065 172.29.199.2 (4 Feb 2006 10:16:00 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sat, 4 Feb 2006 10:16:00 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15583>

Junio C Hamano <junkio@cox.net> wrote:

> But with that, you expose yourself to the confusion TIME_WAIT
> was designed to protect you from, so how about making it
> optional like this?

No objections there.

-- [mdw]

From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Teach git-checkout-index to use file suffixes.
Date: Wed, 1 Mar 2006 15:56:41 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne0bh1p.fr9.mdw@metalzone.distorted.org.uk>
References: <20060301044132.GF22894@spearce.org> <20060301150629.GB3456@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 16:57:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FETh9-0002Zl-GC
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 16:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWCAP4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 10:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWCAP4s
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 10:56:48 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:10086 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1030209AbWCAP4r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 10:56:47 -0500
Received: (qmail 4293 invoked by uid 110); 1 Mar 2006 15:56:41 -0000
To: git@vger.kernel.org
Received: (qmail 4279 invoked by uid 9); 1 Mar 2006 15:56:41 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1141228601 3562 172.29.199.2 (1 Mar 2006 15:56:41 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Wed, 1 Mar 2006 15:56:41 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16984>

Shawn Pearce <spearce@spearce.org> wrote:

> I thought about using instead:
>
>   --stage=all --suffix1=\#1 --suffix2\=#2 --suffix3=\#3

How about something like

  --suffixes=:#1:#2:#3

uses first character as a delimiter to separate the suffixes.  A single
--suffix option could plausibly provide the suffix if only one stage is
being checked out, and doesn't have the grim delimiter wart.

I suppose, though, that if this is going to be wrapped up in a script,
it doesn't really matter that much.

-- [mdw]

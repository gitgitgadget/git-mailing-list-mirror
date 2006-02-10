From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Fri, 10 Feb 2006 17:06:03 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnduphvr.2i8.mdw@metalzone.distorted.org.uk>
References: <87slqtcr2f.wl%cworth@cworth.org> <7vfymtl43b.fsf@assigned-by-dhcp.cox.net> <87bqxgxfl7.wl%cworth@cworth.org> <7vr76c5avd.fsf@assigned-by-dhcp.cox.net> <87fymst399.wl%cworth@cworth.org> <7vfyms0x4p.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 11 01:58:08 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7bio-0008GY-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 18:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWBJRGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 12:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWBJRGL
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 12:06:11 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:39029 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751324AbWBJRGK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 12:06:10 -0500
Received: (qmail 27721 invoked by uid 110); 10 Feb 2006 17:06:03 -0000
To: git@vger.kernel.org
Received: (qmail 27707 invoked by uid 9); 10 Feb 2006 17:06:03 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1139591163 26456 172.29.199.2 (10 Feb 2006 17:06:03 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Fri, 10 Feb 2006 17:06:03 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15909>

Junio C Hamano <junkio@cox.net> wrote:

> In order to rewrite this mess to be more manageable, I would
> first do "diff master topic", to extract the changes into a
> single patch, start picking pieces from it to get logically
> self-contained units, and start building on top of "master":

[etc.]

Oh, good.  It's not just me, then! ;-)

This is more or less exactly how I built the various patches I submitted
here.  The main difference is that I used StGIT because I'm less
competent than Junio and didn't always manage to get all my changes in
the right places to begin with.

(I really look forward to a StGIT which can withstand git-prune.)

-- [mdw]

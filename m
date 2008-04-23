From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 14:47:34 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0804231445550.18401@ds9.cixit.se>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
 <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness>
 <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
 <20080422023918.GA5402@sigill.intra.peff.net>
 <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
 <Pine.LNX.4.64.0804230806220.18401@ds9.cixit.se> <20080423081025.GB11935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 15:48:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JofKw-0001qT-F4
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 15:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYDWNrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 09:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYDWNrv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 09:47:51 -0400
Received: from ds9.cixit.se ([193.15.169.228]:56152 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbYDWNru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 09:47:50 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3NDlZBs029699
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Apr 2008 15:47:35 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3NDlY0g029693;
	Wed, 23 Apr 2008 15:47:35 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080423081025.GB11935@sigill.intra.peff.net>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Wed, 23 Apr 2008 15:47:35 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80218>

Jeff King:

> Sure, but that is quite slow on a larger tree, since it has to do a
> full checkout for each commit.

Indeed. That's why I would welcome a script such as the one you
mentioned :-) Fortunately, the repositories I worked on were small
enough to not suffer too much (even when using Git on Windows, which is
a bit slower than on Linux).

[Not seeing any unreachable objects]
> Did you remove refs/original/ ?

That, and cloned the repository to a new location after the conversion,
and removing the references to "origin" there. It does seem that the
objects are still there, but I can't see them with "gitk --all".

-- 
\\// Peter - http://www.softwolves.pp.se/

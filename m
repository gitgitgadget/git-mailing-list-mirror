From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 16:37:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801181631150.817@ds9.cixit.se>
References: <478E1FED.5010801@web.de> <200801180205.28742.robin.rosenberg.lists@dewire.com>
 <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org>
 <200801181042.37391.robin.rosenberg.lists@dewire.com>
 <20080118103036.GD14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pedro Melo <melo@simplicidade.org>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 16:38:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFtIP-0007S8-OE
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 16:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762731AbYARPhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 10:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762722AbYARPhp
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 10:37:45 -0500
Received: from ds9.cixit.se ([193.15.169.228]:36050 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762716AbYARPhn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 10:37:43 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0IFbIZZ031265
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Jan 2008 16:37:18 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0IFbHAE031256;
	Fri, 18 Jan 2008 16:37:18 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080118103036.GD14871@dpotapov.dyndns.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 18 Jan 2008 16:37:18 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71028>

Dmitry Potapov:

> because Microsoft C library does not work with encoding that requires
> more than two bytes per character.

Indeed. On Windows, you should avoid using UTF-8 and instead use UTF-16
everywhere. That usually works better, and if you run on an NT-based
system it will convert all the data to WinAPI to UTF-16 anyway.

-- 
\\// Peter - http://www.softwolves.pp.se/

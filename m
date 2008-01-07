From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 14:50:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801071447320.1864@ds9.cixit.se>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
 <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de> <flsu0r$m9p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Peter Klavins <klavins@netspace.net.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 14:51:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBsNw-0001sq-0m
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 14:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbYAGNuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 08:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbYAGNuw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 08:50:52 -0500
Received: from ds9.cixit.se ([193.15.169.228]:55997 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbYAGNuv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 08:50:51 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m07Do9ZZ014392
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 7 Jan 2008 14:50:09 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m07Do8cR014386;
	Mon, 7 Jan 2008 14:50:08 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <flsu0r$m9p$1@ger.gmane.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 07 Jan 2008 14:50:09 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69791>

Steffen Prohaska:

> Per default, CRLF conversion is disabled in msysgit.  Git should
> not convert a single file.  Does it really convert some?

I didn't verify, but it was only some files that had LFs, perhaps the
files that I added while on the Windows machine had CRLFs. That's bad.


Peter Klavins:

> Visual Studio in fact happily works with files that only have lf
> endings, _except_ *.sln and *.vcproj files, which it much prefers to
> have with cr/lf endings.

The project files were added to the repository on the Windows box
(obviously), so those are correct.


So apparently my repository is a bit broken at the moment with LF on
some files and CRLF on some. That's bad. I just assumed everything
worked, it used to "just work" for CVS (except for when you actually
tried to add binary files, of course).

-- 
\\// Peter - http://www.softwolves.pp.se/

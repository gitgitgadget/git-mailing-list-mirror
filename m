From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Git on Windows, CRLF issues
Date: Tue, 22 Apr 2008 07:52:34 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0804220749080.22731@ds9.cixit.se>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
 <m3bq42ri56.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:26:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoCtq-00085r-PT
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 09:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272AbYDVHZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 03:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757979AbYDVHZ6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 03:25:58 -0400
Received: from ds9.cixit.se ([193.15.169.228]:35427 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757091AbYDVHZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 03:25:57 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3M6qdBs024795
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 22 Apr 2008 08:52:40 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3M6qYpd024730;
	Tue, 22 Apr 2008 08:52:34 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <m3bq42ri56.fsf@localhost.localdomain>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 22 Apr 2008 08:52:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80074>

Jakub Narebski:

> I think you can, by unsetting `crlf` attribute, i.e. putting the
> following in .gitattributes:
> 
>    * -crlf

Yeah, that does indeed seem to work, no matter how core.autocrlf is
configured globally. I think this is the best way to go for the
repositories I am working on (as they are very much DOS/Windows-only).

Does anyone know how to hack an existing repository so that I can add
such a .gitattributes file to all commits? I've tried reading the
git-filter-branch manual page a few times, but I am still confused by
it.

I guess I need some combination of "git filter-branch --tree-filter"
and "git update-index --add".

It doesn't matter much that the all commits are re-written, as I am
still the only one to have cloned them.

-- 
\\// Peter - http://www.softwolves.pp.se/

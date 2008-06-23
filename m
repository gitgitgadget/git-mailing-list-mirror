From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Mon, 23 Jun 2008 15:46:11 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0806231543580.31319@ds9.cixit.se>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se>
 <20080620115102.GW29404@genesis.frugalware.org> <alpine.DEB.1.00.0806201323390.6439@racer>
 <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se> <alpine.DEB.1.00.0806201359320.6439@racer>
 <Pine.LNX.4.64.0806230732120.31319@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jun 23 16:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAnKB-00078Y-J3
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 16:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbYFWOqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 10:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbYFWOqW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 10:46:22 -0400
Received: from ds9.cixit.se ([193.15.169.228]:43949 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753890AbYFWOqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 10:46:21 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5NEkD5e014607
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Jun 2008 16:46:14 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5NEkBC3014602;
	Mon, 23 Jun 2008 16:46:12 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <Pine.LNX.4.64.0806230732120.31319@ds9.cixit.se>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 23 Jun 2008 16:46:14 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85867>

Peter Karlsson:

> That might work. My problem is the non-linearity of the data I want
> to import. But I might be able to massage the import-tars output
> before I feed it to git-fast-import to describe the history I need it
> to.

I ended up making a script that converted a description file that
described the hierarchy of versions and generated a fast-import file
from it. Good to have so that I could move stuff around a bit to make
up a version tree that looked somewhat reasonable (a lot of
cross-directory copying has been going on here, and no-one knows which
version is which).

I will try to make the script available.

-- 
\\// Peter - http://www.softwolves.pp.se/

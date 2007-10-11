From: Peter Karlsson <peter@softwolves.pp.se>
Subject: RCS keyword expansion
Date: Thu, 11 Oct 2007 15:47:29 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 16:47:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfzKA-0001Vr-Sz
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 16:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbXJKOrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 10:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbXJKOrd
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 10:47:33 -0400
Received: from ds9.cixit.se ([193.15.169.228]:55803 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbXJKOrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 10:47:32 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9BElTnQ024160
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Oct 2007 16:47:30 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9BElThf024155;
	Thu, 11 Oct 2007 16:47:29 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 11 Oct 2007 16:47:30 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60604>

Hi!

I've looked and looked, but cannot figure out how to do RCS/CVS style
keyword expansion with Git. The FAQ on the Wiki is quite cryptic on the
subject, and my googling skills fail short.

I mainly want to have $Date$ expand in RCS/CVS manner, i.e to when the
file was last changed. Possibly even have an $Id$ that gives me
something useful (name and commit hash, perhaps?). Is it possible to do
this? Can it be done through git-cvsserver?

I currently have my personal website in CVS and am using $Date$ to
include a datestamp on the pages. I am considering converting the
repository to Git, but only after I can get $Date$ expansion to work.
I am considering having the website host believe it still is a cvs
repository by using git-cvsserver, thus my question about expanding
$Date$ through it.

-- 
\\// Peter - http://www.softwolves.pp.se/

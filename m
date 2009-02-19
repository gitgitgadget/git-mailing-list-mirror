From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: First round of UGFWIINI results
Date: Thu, 19 Feb 2009 11:32:44 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0902191129010.4879@ds9.cixit.se>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:36:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6Fr-0001PK-QW
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbZBSKcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbZBSKcr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:32:47 -0500
Received: from ds9.cixit.se ([193.15.169.228]:44146 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbZBSKcr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:32:47 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n1JAWi0i004523
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Feb 2009 11:32:44 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n1JAWiTb004518;
	Thu, 19 Feb 2009 11:32:44 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 19 Feb 2009 11:32:44 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110670>

Johannes Schindelin:

> Number 10:
> Sergio Callegari describes how to manage opendocument (openoffice.org) files

Which is very nice, it saved me several megabytes of disk space :-)

> Git was clearly intended to track source code stored as small ASCII
> files; otherwise, 'git diff' would not be such an integral part of
> Git.

Still, I have "git diff" working fine for OpenOffice Writer documents
here, using "oodiff" that I found somewhere I cannot remember...

Now, if only OpenOffice could be told not to store the documents as zip
files, but rather as a directory, I wouldn't have to fool Git using the
rezipper. Or perhaps one should implement support in Git to store zip
files expanded (and just create the .zip on checkout)?

Then one could even merge conflicts between concurrent edits.

-- 
\\// Peter - http://www.softwolves.pp.se/

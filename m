From: "Art Haas" <ahaas@airmail.net>
Subject: Working with git-svn to export changes to Subversion
Date: Mon, 28 May 2007 15:27:12 -0500
Message-ID: <20070528202712.GA11207@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 22:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsloP-0002sI-2k
	for gcvg-git@gmane.org; Mon, 28 May 2007 22:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXE1U1V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 16:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbXE1U1V
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 16:27:21 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:63185 "EHLO
	ms-smtp-03.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXE1U1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 16:27:20 -0400
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-03.texas.rr.com (8.13.6/8.13.6) with ESMTP id l4SKRIRS008243
	for <git@vger.kernel.org>; Mon, 28 May 2007 15:27:18 -0500 (CDT)
Received: (qmail 31293 invoked by uid 1000); 28 May 2007 20:27:13 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48638>

Hi.

A few days ago I posted a message to this list regarding my attempts to
convert the PythonCAD Subversion repository into git. My first efforts
failed, but after several more attempts and some editing of the
git-svnimport code I've been able to convert the entire repo, tags and
all, seemingly successfully.

Having now converted my repo, I'm now tackling the second-half of my
task, which is to figure out how to use 'git-svn' to export my changes
to a Subversion repository. The documentation for 'git-svn' is set up
to guide someone using git to track a project kept in Subversion, where
in my case the code will be kept in git and exported out into
Subversion. I plan on pushing my changes solely to 'trunk', and when
I make a release I want to tag it and push the tag into the Subversion
repository as well.

I'm writing today to see if others using 'git-svn' are currently using
it in the form I'm trying to do, and if so could these people give me a
couple of pointers regarding any tips, tricks, and/or pitfalls that I
may encounter. Thanks in advance for any info you can send my direction.

My thanks also go to everyone that has contributed to the 'git-svnimport'
code, and git itself as well.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

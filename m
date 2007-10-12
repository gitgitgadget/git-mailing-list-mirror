From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Workflow: split repository?
Date: Fri, 12 Oct 2007 14:21:39 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710121421.39159.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 12 14:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgJcb-000876-Va
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 14:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326AbXJLM1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 08:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757369AbXJLM1j
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 08:27:39 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:4112 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029AbXJLM1i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 08:27:38 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9CCRavU095863
	for <git@vger.kernel.org>; Fri, 12 Oct 2007 14:27:36 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60685>

Hi,

I've got a big active project, until yesterday managed using CVS. As
with any distributed academic research project the repository has become
a nice mess where most files are in the wrong place and there are
several almost independent sub-projects living in directories.

The plan is/was to

	* Convert everything to GIT (done, through cvs2svn)
	* Everyone keeps hacking on their bits, while one is starting
	to reorganise the structure by moving files and directories
	and changing import headers, and other file references in
	a GIT branch.
	* Now we merge the continued work and the reorganisation to
	end up with a nice clean hierarchy :-)
	* Split the big project into multiple projects.  One of the
	reasons is that we want to make part of them public.  Others
	we cannot publish as they contain copyrighted data.  I understand
	we can reunite them using GIT sub modules.

Does this make sense?

While splitting we want to *loose* history information for some of the
projects.  That is easy: simply create a new repository from the current
files.  For some however we would like to *preserve* the history.  This
means we would like to pick a hierarchy with its history.  After quite
a bit of reading, I get the impression this cannot be done.  Am I right?

Is the only way to create a GIT repositiory right away from a subset of
the CVS for which we want to preserve the history?

	Thanks --- Jan

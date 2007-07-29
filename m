From: Ricardo SIGNES <rjbs@cpan.org>
Subject: conversion from svn with renames
Date: Sun, 29 Jul 2007 08:23:01 -0400
Message-ID: <20070729122301.GA17016@knight.manxome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 14:23:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF7oU-0005Z4-LQ
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 14:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761732AbXG2MXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 08:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759403AbXG2MXz
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 08:23:55 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:53142 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757219AbXG2MXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 08:23:54 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0AC412EF
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 08:24:16 -0400 (EDT)
Received: from knight.manxome.org (unknown [66.92.232.140])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CD809692CC
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 08:24:15 -0400 (EDT)
Received: by knight.manxome.org (Postfix, from userid 501)
	id 7D09089D487; Sun, 29 Jul 2007 08:23:01 -0400 (EDT)
Content-Disposition: inline
X-Message-Flag: Warning: This sender thinks he is better than you.
X-Planet: Planet of the Apes
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54112>


I'd like to convert svn.codesimply.com/projects' contents to git.

Right now, the content is like this:

  /projects/$PROJECTNAME/{trunk,tags,branches}

git-svnimport does well if I specify projects/$PROJECTNAME/trunk as the trunk
directory and that/tags as the tags directory.  (I am not interested in
bothering with branches.)  The problem is this:

For many of the projects, $PROJECTNAME was once "foo" and is now "bar."
git-svnimport only imports the history from the current name.

I tried to import foo, then bar, into one git repostiory, but the histories
didn't seem to get connected.  Sam V. suggested git-filter-branch, but I didn't
quite see how to make it do what I wanted.

I would greatly appreciate any advice or help on this conversion.

-- 
rjbs

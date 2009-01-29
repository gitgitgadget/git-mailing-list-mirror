From: Andrew Selder <aselder@mac.com>
Subject: Git SVN fetch failing on large commit
Date: Thu, 29 Jan 2009 01:24:00 +0000 (UTC)
Message-ID: <loom.20090129T011905-417@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 02:25:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSLf5-0005dk-U5
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 02:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbZA2BYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 20:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbZA2BYR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 20:24:17 -0500
Received: from main.gmane.org ([80.91.229.2]:43850 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbZA2BYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 20:24:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LSLdc-00009P-3J
	for git@vger.kernel.org; Thu, 29 Jan 2009 01:24:12 +0000
Received: from adsl-75-36-166-15.dsl.pltn13.sbcglobal.net ([75.36.166.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 01:24:12 +0000
Received: from aselder by adsl-75-36-166-15.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 01:24:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.36.166.15 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.5) Gecko/2008120121 Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107606>

Hi,

I'm trying to import an SVN repository and I'm running into trouble on a huge
SVN revision.

One of the revisions in SVN has a 1.25 GB file. When the git svn fetch process
gets to this revision, it crashed with the following message:

fatal: Out of memory, malloc failed
hash-object -w --stdin-paths: command returned error: 128

error closing pipe: Bad file descriptor at /usr/local/libexec/git-core//git-svn
line 0
error closing pipe: Bad file descriptor at /usr/local/libexec/git-core//git-svn
line 0

This is running on a machine with 3 GB of memory (2.5 GB free before starting
git svn), Git 1.6.1, Git-svn 1.6.1(svn 1.5.1)

Help would be greatly appreciated.

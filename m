From: Dennis Schridde <devurandom@gmx.net>
Subject: Odd number of elements in anonymous hash
Date: Tue, 8 Jan 2008 17:38:56 +0100
Message-ID: <200801081738.56624.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 17:40:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCHUl-0001G5-Jh
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 17:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761804AbYAHQjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 11:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761354AbYAHQji
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 11:39:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:59472 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755167AbYAHQjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 11:39:37 -0500
Received: (qmail invoked by alias); 08 Jan 2008 16:39:36 -0000
Received: from hnvr-4dbb9fd3.pool.einsundeins.de (EHLO ernie.local) [77.187.159.211]
  by mail.gmx.net (mp041) with SMTP; 08 Jan 2008 17:39:36 +0100
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX18aNGwbx00alLtJAbDBU2i+AIDFvVfl428LAXAtsO
	HbViENfu9qo9Iz
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69890>

Hello!

I am getting "Odd number of elements in anonymous hash at /usr/bin/git-svn 
line 1760." (normal output, no warning/error) during git-svn-clone.
I am using git version 1.5.4.rc2.

Line 1760 is this (with context, marked with '!!'):
    # see if we have it in our config, first:
    eval {
        my $section = "svn-remote.$self->{repo_id}";
!!        $svnsync = {
          url => tmp_config('--get', "$section.svnsync-url"),
          uuid => tmp_config('--get', "$section.svnsync-uuid"),
        }
    };

The commandline was "git svn 
clone --authors-file=/var/git/org.gna.warzone.git/authors --use-svnsync-props --stdlayout 
file:///var/svn/warzone2100/ org.gna.warzone.git/"

I assume this is some kind of bug?

--Dennis

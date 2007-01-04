From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: git-svn usability
Date: Thu, 04 Jan 2007 18:34:52 +0100
Message-ID: <87fyaqvgoz.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jan 04 18:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2WUh-00029k-Ln
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 18:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbXADRfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 4 Jan 2007 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbXADRfH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 12:35:07 -0500
Received: from main.gmane.org ([80.91.229.2]:49435 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965052AbXADRfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 12:35:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H2WUV-0007Co-E8
	for git@vger.kernel.org; Thu, 04 Jan 2007 18:34:59 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 18:34:59 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 18:34:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:R9HGB230PEcykKGmUVSpM39s2+w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35939>

I wanted to try out "git svn" and did a "git help svn" and got the man
page for git-svn.  That page starts out by describing that git-svn
only is useful for working with a single svn branch.  But then,
further down, it describes the commands "multi-init" and
"multi-fetch" anyway.  Confusing.  But I decided to give them a try.
But there isn't really any clear description on what the command line
should look like when you use multi-init (or any other git-svn command
for that matter).  So I boldly decided to try to run "git svn help
multi-init".  You never know, it might tell you something.  This is
what happened:

  morpheus% git svn help multi-init
  GIT_SVN_ID set to 'trunk' for help/trunk
  Initialized empty Git repository in /home/david/tmp/.git/
  W: --branches/-b not specified
  W: --tags/-t not specified

Not exactly what I wanted.  The command-line parser in git-svn is
broken since it picks the first argument that looks like a command
name.

--=20
David K=C3=A5gedal

From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Tue, 3 Jun 2008 18:56:10 +0200
Message-ID: <200806031856.11060.robin.rosenberg.lists@dewire.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 18:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ZrN-0006QD-0c
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 18:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbYFCQ6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 12:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbYFCQ6v
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 12:58:51 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:48884 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbYFCQ6u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 12:58:50 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id F3A3037F11; Tue,  3 Jun 2008 18:58:48 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id D9AD437EDC; Tue,  3 Jun 2008 18:58:48 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 3E5C837E46;
	Tue,  3 Jun 2008 18:58:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83680>

tisdagen den 3 juni 2008 16.42.33 skrev Imran M Yousuf:
> Hi,
> 
> I have successfully Mavenized JGit (at least partially :)) to make it
> independent of IDE to develop on. I will also add a code-file format
> checker soon. Please have a look at it and let me know what you think
> and how it can be improved. If its helpful I will surely send out a
> patch in this regard. The one thing that I did not configure is the
> external test (exttst), doing that and the code format checker is my
> next step.
> The 'jgit-mavenize' branch of my fork of egit contains it.
> (http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/jgit-mavenize).

An abvious problem is that JGit does not handle symbolic links and those do
not work well (if at all) under git on windows either. Cygwin will not do here,
unless you accompany it with a cygwin java build (if such a thing exists). Mingw
also does not support them.

-- robin

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Google Summer of Code 2007 progress report / summary
Date: Sun, 2 Sep 2007 23:42:01 -0400
Message-ID: <20070903034201.GP18160@spearce.org>
References: <200709030309.30996.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Luiz Fernando N. Capitulino" <lcapitulino@gmail.com>,
	Carlos Rica <jasampler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 05:42:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS2pl-0001Wc-JI
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 05:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbXICDmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 23:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbXICDmJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 23:42:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45506 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbXICDmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 23:42:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IS2ow-0008PP-Sp; Sun, 02 Sep 2007 23:41:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 97E0420FBAE; Sun,  2 Sep 2007 23:42:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709030309.30996.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57426>

Jakub Narebski <jnareb@gmail.com> wrote:
> How it goes with Google Summer of Code git projects:
> builtinification and libification? Which parts are
> done, which parts are worked on?

Heh.  You caught me literally as I was drafting the roundup.  ;-)

The 2007 version of Google Summer of Code[*1*] ended on August 20th.
For those who may be new to the list, Git participated this year
in Google Summer of Code with two successful student projects:

  Shell script to C builtin conversions
    Student: Carlos Rica
	Mentor:  Johannes Schindelin

  Libification
    Student: Luiz Capitulino
    Mentor:  Shawn Pearce

In addition to paying two students to work on Git for the entire
summer Google also donated $1000 USD to our community.  As Git has
no legal entity to receive or make use of these funds we directed
the full $1000 donation to the Free Software Foundation.

A good part of Carlos Rica's work is in Git 1.5.3 and brought us a
C based version of git-tag, as well as a comprehensive test suite
for git-tag and its various modes of operation.  Additionally Carlos
fixed a few bugs and improved some of the internal code to make a
C based version of git-commit easier to develop.  Carlos has more
recently been working on a C based version of git-reset, which will
hopefully be in the next version of Git (1.5.3.1? 1.5.4?).

Luiz Capitulino has found and submitted a few bug fixes to Git
1.5.3, but the majority of his work on creating an application
level library is still unmerged and can be found on repo.or.cz[*2*].
Luiz developed a C and Python log API and announced it on list[*3*]
near the end of July.  During August Luiz also worked with Marco
Costalba to modify qgit4 to use Luiz's log API.  This work is
currently stalled as Luiz has shifted his attention to expanding
and rebasing the work that Nico and I had done for pack v4 onto
current Git 1.5.3.  Luiz also tried to port StGIT to use this new
Python API but determined that StGIT needs more functions than the
API currently offers.  It may be interesting if someone picks up
this API work and continues it further.

I would like to thank our two students for their excellent work,
but also Brian Gernhardt, Johannes Schindelin, Martin Langhoff,
Martin Waitz, Petr Baudis, and Sam Vilain for helping us to review
student applications and for volunteering to mentor students.


*1* http://code.google.com/soc/2007/
*2* http://repo.or.cz/w/git/libgit-gsoc.git
*3* http://article.gmane.org/gmane.comp.version-control.git/53433

-- 
Shawn.

From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: Makefile: Another "make" command is used when going into SUBDIR
 perl
Date: Sat, 5 Apr 2014 23:10:41 +0000
Message-ID: <20140405231039.GA26578@rhi.hi.is>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 01:29:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWa1t-0003Um-2f
	for gcvg-git-2@plane.gmane.org; Sun, 06 Apr 2014 01:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbaDEX3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 19:29:38 -0400
Received: from fenja.rhi.hi.is ([130.208.165.103]:52204 "EHLO fenja.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604AbaDEX3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2014 19:29:36 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Apr 2014 19:29:36 EDT
Received: from smtp.hi.is (smtp.hi.is [130.208.165.149])
	by fenja.rhi.hi.is (8.13.8/8.13.8) with ESMTP id s35NNTOK027151
	for <git@vger.kernel.org>; Sat, 5 Apr 2014 23:23:30 GMT
Received: from katla.rhi.hi.is (katla.rhi.hi.is [130.208.165.1])
	by smtp.hi.is (8.14.4/8.14.4) with ESMTP id s35NNTgf026441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 5 Apr 2014 23:23:29 GMT
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s35NAfum026581
	for <git@vger.kernel.org>; Sat, 5 Apr 2014 23:10:41 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s35NAfLS026580
	for git@vger.kernel.org; Sat, 5 Apr 2014 23:10:41 GMT
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245787>

Package: git-1.9.0

  Another make command is used in the Makefile when it enters subdir
PERL.

  The used "make" command is a link in my home directory to
"/usr/sfw/bin/gmake".  Other make commands are "/usr/ccs/bin/make" and
"/usr/xpg4/bin/make".

My PATH variable has these directories in this order

$HOME, /usr/sfw/bin, /usr/xpg4/bin and /usr/ccs/bin

  The used variables for make are

CPPFLAGS=-I/usr/local/ssl/include
NO_GETTEXT=YesPlease
NO_TCLTK=YesPlease

  Last part of compilation:

    * new script parameters
    GEN git-am
    GEN git-bisect
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-pull
    GEN git-quiltimport
    GEN git-rebase
    GEN git-request-pull
    GEN git-stash
    GEN git-submodule
    GEN git-web--browse
    GEN perl/PM.stamp
    SUBDIR perl
make: Warning: Ignoring DistributedMake -o option
Usage : make [ -f makefile ][ -K statefile ]... [ -d ][ -dd ][ -D ][ -DD ]
             [ -e ][ -i ][ -k ][ -n ][ -p ][ -P ][ -q ][ -r ][ -s ][ -S ][ -t ]
             [ -u ][ -w ][ -V ][ target... ][ macro=value... ][ "macro +=value"... ]
make: Fatal error: Unknown option `-C'
make: *** [perl/perl.mak] Error 1

  The error comes from "/usr/ccs/bin/make" or "/usr/xpg4/bin/make".

From: Gerrit Pape <pape@smarden.org>
Subject: git-cvsimport cannot handle zsh CVS repo
Date: Thu, 7 Jun 2007 07:33:36 +0000
Message-ID: <20070607073336.26979.qmail@178148a41cee98.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 426617@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 09:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwCUl-0004nX-Ou
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 09:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbXFGHdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 03:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbXFGHdU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 03:33:20 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:34826 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754945AbXFGHdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 03:33:19 -0400
Received: (qmail 26980 invoked by uid 1000); 7 Jun 2007 07:33:36 -0000
Mail-Followup-To: git@vger.kernel.org, 426617@bugs.debian.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49361>

Hi, I'm stuck tracking down this issue, unfortunately reproducing it
seems to take ages.  Any help would be appreciated.

Please see http://bugs.debian.org/426617

---
Package: git-cvs
Version: 1:1.5.1.4-2
Severity: normal

After multiple invocations, I get the following.

% git-cvsimport -v -d :pserver:anonymous@zsh.cvs.sourceforge.net:/cvsroot/zsh zsh
fatal: Needed a single revision
Running cvsps...
WARNING: revision 1.1.1.7.2.1 of file Src/Zle/zle_refresh.c on unnamed branch
[...]
skip patchset 6963: 1180450228 before 1180474771
skip patchset 6964: 1180458067 before 1180474771
skip patchset 6965: 1180474771 before 1180474771
DONE.
fatal: Needed a single revision
Can merge only exactly one commit into empty head
Could not merge origin into the current branch.
---

Thanks, Gerrit.

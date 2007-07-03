From: David Kastrup <dak@gnu.org>
Subject: Re: being nice to patch(1)
Date: Tue, 03 Jul 2007 15:22:50 +0200
Message-ID: <86y7hxr591.fsf@lola.quinscape.zz>
References: <20070702125450.28228edd.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org> <20070702142557.eba61ccd.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org> <20070702145601.a0dcef0f.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org> <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org> <Pine.LNX.4.64.0707031303130.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: quilt-dev@nongnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 15:23:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5iM1-0007E2-JN
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 15:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbXGCNXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 09:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbXGCNXj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 09:23:39 -0400
Received: from main.gmane.org ([80.91.229.2]:44272 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbXGCNXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 09:23:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I5iLo-0003fm-RS
	for git@vger.kernel.org; Tue, 03 Jul 2007 15:23:29 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 15:23:28 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 15:23:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:3baxqenVMK1K247tvfK+6wUxcZQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51489>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But maybe they would be willing to install git to get that wonderful
> git-apply program, and that wonderful rename-and-mode-aware
> git-diff, and the git-merge-file program, all of which can operate
> outside of a git repository. (Take that, hg!)

As long as git-diff lists all added files in a second non-git dirtree
as "/dev/null" when doing
git-diff --name-status -B -M -C dir1 dir2
its usefulness is limited.

git-diff --name-status -B -M -C dir1 dir2
D	dir1/auctex-11.84/CHANGES
D	dir1/auctex-11.84/COPYING
D	dir1/auctex-11.84/ChangeLog

[...]

D	dir1/auctex-11.84/preview/preview-latex.spec
D	dir1/auctex-11.84/preview/prv-emacs.el
D	dir1/auctex-11.84/preview/prv-install.el
D	dir1/auctex-11.84/tex-site.el.in
D	dir1/auctex-11.84/tex-wizard.el
A	/dev/null
A	/dev/null
R100	dir1/auctex-11.84/images/amstex.xpm	dir2/etc/auctex/images/amstex.xpm
R100	dir1/auctex-11.84/images/bibtex.xpm	dir2/etc/auctex/images/bibtex.xpm
R100	dir1/auctex-11.84/images/dropdown.xpm	dir2/etc/auctex/images/dropdown.xpm

[...]

R100	dir1/auctex-11.84/images/viewdvi.xpm	dir2/etc/auctex/images/viewdvi.xpm
R100	dir1/auctex-11.84/images/viewpdf.xpm	dir2/etc/auctex/images/viewpdf.xpm
R100	dir1/auctex-11.84/images/viewps.xpm	dir2/etc/auctex/images/viewps.xpm
A	/dev/null
A	/dev/null
A	/dev/null
A	/dev/null
A	/dev/null
A	/dev/null

and so on.

git --version
git version 1.5.2.2.565.gde09

-- 
David Kastrup

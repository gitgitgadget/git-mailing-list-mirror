From: Wolfgang.Liebich@siemens-enterprise.com
Subject: What is the best way to convert a multi module CVS repository to
 git?
Date: Mon, 4 Jan 2010 16:53:22 +0100
Message-ID: <20100104155322.GC12195@atpcttvc.global-intra.net>
Reply-To: Wolfgang.Liebich@siemens-enterprise.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 15:26:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRnsf-0007vC-DS
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 15:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab0ADOZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 09:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282Ab0ADOZ5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 09:25:57 -0500
Received: from m0019.fra.mmp.de.bt.com ([62.180.227.30]:57418 "EHLO
	ms03.m0019.fra.mmp.de.bt.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752842Ab0ADOZ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 09:25:56 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2010 09:25:56 EST
Received: from senmx11-mx ([62.134.46.9] [62.134.46.9]) by ms03.m0020.fra.mmp.de.bt.com with ESMTP id BT-MMP-428135 for git@vger.kernel.org; Mon, 4 Jan 2010 15:10:54 +0100
Received: from atpcttvc.global-intra.net (unknown [172.26.8.53])
	by senmx11-mx (Server) with ESMTP id 3DE481EB8274
	for <git@vger.kernel.org>; Mon,  4 Jan 2010 15:10:54 +0100 (CET)
Received: by atpcttvc.global-intra.net (Postfix, from userid 20222)
	id 5ADFE605E; Mon,  4 Jan 2010 16:53:22 +0100 (CET)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136115>

Hi,
I have inherited a rather big, old, multi-module CVS repository which I
want to convert to GIT.
Most of the CVS modules do belong to one project now, i.e. the
separation into multiple modules is something of a historical accident
now. This means it does not make sense to put each CVS module into an
own GIT project and use submodules.
Furthermore the conversion will be one-way, i.e. afterwards the CVS repo
will be shutdown forever and moved to offline storage. Incremental
conversion is therefore not an issue.
If I need one day to convert everything (the repo is about 3GB), so be
it - the most important feature to me is correctness (I do NOT want to
have to run manual verifications for N days/weeks/months, just to verify
that everything was converted), and ideally even the possibility of
re-creating the history of files which were moved across directories
(this HAS happened sometimes - I did not fiddle around with the RCS
files, but used straight rm+add, and accepted the loss of history forced
on me by CVS).

What is the best (i.e. most trustworthy) method of conversion? For now
it seems to me that cvs2git (the ...2git companion to cvs2svn) is the
best choice (because it can handle multi-module projects in a sane way)
- but I'm open to suggestions!

Ciao,
Wolfgang Liebich

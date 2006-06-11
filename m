From: carbonated beverage <ramune@net-ronin.org>
Subject: cvs import error
Date: Sun, 11 Jun 2006 16:48:42 -0700
Message-ID: <20060611234842.GA12713@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 12 01:48:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpZfl-00006z-Nq
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 01:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWFKXso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 19:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFKXso
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 19:48:44 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:65499 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S1751176AbWFKXsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 19:48:43 -0400
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1FpZfe-0003KE-00
	for <git@vger.kernel.org>; Sun, 11 Jun 2006 16:48:42 -0700
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21676>

Hi all,

I'm currently trying to import a CVS archive into git and hitting
problems.  The repo was cloned with cvssuck, and the import was run
with cvsps 2.1 and git-1.4.0, getting this (abbreviated, slightly
sanitized) output:

$ git cvsimport  -v -d ':local:/home/ramune/git-import'  -C .  FOO
WARNING: revision 1.21.2.3 of file BAR/BAZ/QUX on unnamed branch
<<snip lots of the same types of warnings for different files, multiple
<<times for quite a few of them>>
WARNING: revision 1.6.2.2 of file BAR/BAZ/FROBOZ on unnamed branch
invalid cache revision line 'file:X/Y/Z/A/B/C D E.F; D G.F; pre_rev:INITIAL; pos
t_rev:1.1; dead:0; branch_point:0
'|' D G.F'
DONE; creating master branch
fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tr
ee.
Use '--' to separate paths from revisions
fatal: Not a valid object name HEAD
checkout failed: 256
$ exit

The import bombs out on the same place every time, with or without cvsps
being passed -x and/or --no-cvs-direct.

The source tree's proprietary, so I can't give snippets or examples,
unforutnately.  Has anyone come across this issue before and resovled it?

If so, how?

Thanks,

-- DN
Daniel

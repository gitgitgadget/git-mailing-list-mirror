From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Effectively tracing project contributions with git
Date: Sat, 12 Sep 2009 14:30:17 +0200
Message-ID: <4AAB9459.3070809@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 15:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmSD0-0000kB-M2
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 15:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbZILM5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 08:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZILM5l
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 08:57:41 -0400
Received: from up.nbi.dk ([130.225.212.6]:60808 "EHLO mail2.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbZILM5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 08:57:40 -0400
X-Greylist: delayed 1645 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Sep 2009 08:57:40 EDT
Received: from [192.168.0.4] (zux221-207-155.adsl.green.ch [81.221.207.155])
	by mail2.nbi.dk (Postfix) with ESMTP id 6751D3C941
	for <git@vger.kernel.org>; Sat, 12 Sep 2009 14:30:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128249>

Hello,

I've recently begun contributing to a FOSS project that has a problem --
although it has extensive git logs (some being CVS/SVN imports) dating
back over many years, there has not been maintenance of contribution
records on a file-by-file basis.

I'm trying to rectify this and track down who contributed what.
Unfortunately while I'm used to basic operations with git, I don't know
it well enough to be confident in how to go about tracing contributions
in this way.

'git annotate' of course is a nice starting point but of limited use
because every time someone tweaks a line (and there have been many such
tweaks in the history of the project) the responsibility of the original
contributor is replaced by that of the tweaker.

An alternative is to use gitk to trace the history of individual files
(or paths, as gitk has it).  The problem here is that files have been
renamed, content has been moved about between different files and so on.

Finally, there's the option to use gitk to trace contributors (someone
has prepared a .mailman file with a complete list of contributors by
name and email) and manually or otherwise tally their significant
contributions.  Again, I'm not sure to what extent this is made
difficult by copy/pasting and tweaking of file content.

I'm just hoping that the git community can offer some good advice on
this, to what extent the process of tracing contributions can be
automated, and so on.  I'm not expecting anyone to provide a solution
for me, but suggestions and pointers in the possible right directions
would be much appreciated.

Thanks & best wishes,

    -- Joe

From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Importing from CVS issues
Date: Tue, 16 Aug 2005 11:41:34 +0100
Message-ID: <1124188894.7444.9.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 16 12:43:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ytZ-0004y5-Lc
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 12:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVHPKmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 06:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbVHPKmE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 06:42:04 -0400
Received: from smarthost2.mail.uk.easynet.net ([212.135.6.12]:1295 "EHLO
	smarthost2.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S965197AbVHPKmD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 06:42:03 -0400
Received: from [217.207.128.220] (helo=mx.transitive.com)
	by smarthost2.mail.uk.easynet.net with esmtp (Exim 4.10)
	id 1E4ytL-00037R-00
	for git@vger.kernel.org; Tue, 16 Aug 2005 11:41:59 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.1 
X-TL-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

We've been having issues with CVS for some time and I thought I'd give
git a spin. To do some like-for-like tests I'm having a go at importing
our cvs repository into git so I can do some benchmarks on things like
branch creation as well as play around with the visualisation tools.

Obviously the CVS repo is non-trivial as we have many branches (one per
change developed). I've been trying to import script but it seems to
falling over. For starters cvsps is spitting out lots of messages along
the lines of:

WARNING: revision 1.3.2.1 of file scripts/xmltools/t/runtests.pl on
unnamed branch

Before the import script finally dies with:

WARNING: revision 1.3.2.1 of file
scripts/xmltools/t/data/gzip/DO-NOT-BACKUP on unnamed branch
DONE; creating master branch
cp: cannot stat `/export/test/cvstogit/.git/refs/heads/origin': No such
file or directory
usage: git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])

Is this a just a case of the cvsps not giving output the script can deal
with? Any suggestions on how I can proceed with diagnosing what went
wrong?

--
Alex, homepage: http://www.bennee.com/~alex/
Barometer, n.: An ingenious instrument which indicates what kind of
weather we are having. -- Ambrose Bierce, "The Devil's Dictionary"

From: Mike Hommey <mh@glandium.org>
Subject: git-filter-branch
Date: Thu, 9 Aug 2007 08:34:53 +0200
Organization: glandium.org
Message-ID: <20070809063453.GA12602@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 09:27:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ2QH-0004Uj-Rc
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 09:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764643AbXHIH1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 03:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764456AbXHIH1G
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 03:27:06 -0400
Received: from vawad.err.no ([85.19.200.177]:54308 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbXHIH1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 03:27:05 -0400
X-Greylist: delayed 3088 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2007 03:27:05 EDT
Received: from aputeaux-153-1-54-147.w82-124.abo.wanadoo.fr ([82.124.176.147] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IJ1cM-0001y0-J0
	for git@vger.kernel.org; Thu, 09 Aug 2007 08:35:36 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IJ1bh-0003Hx-Qs
	for git@vger.kernel.org; Thu, 09 Aug 2007 08:34:54 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55421>

Hi,

What is supposed to be the usage() of git-fetch-branch ?

git-filter-branch itself says:
git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]

while the documentation doesn't explicitely talk about DESTBRANCH,
expect in the form of an hypothetical /newbranch/, that you obviously
don't give to the command line.

And whereas git-filter-branch itself says there is such an argument,
it actually doesn't take it, and doesn't seem to be hardwired to create
a new branch instead of overwriting the current one.

So what is git-filter-branch supposed to be doing ?

As a side note, if it ever happens that git-filter-branch can create a
new branch, it might be nice to have each commit on the branch to have
the original commit as parent, as well as its branch parent, so that
they are seen as merges.

Cheers,

Mike

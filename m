From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig 0.8
Date: Tue, 19 Jun 2007 09:57:31 +0200
Message-ID: <20070619075731.GA12441@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 09:57:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Yat-0008EH-SV
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 09:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbXFSH5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 03:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbXFSH5e
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 03:57:34 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:50706 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbXFSH5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 03:57:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id F2801F0163
	for <git@vger.kernel.org>; Tue, 19 Jun 2007 09:57:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YVCYoeGQ0hkN for <git@vger.kernel.org>;
	Tue, 19 Jun 2007 09:57:31 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 833927A8002
	for <git@vger.kernel.org>; Tue, 19 Jun 2007 09:57:31 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 2974F6DF823
	for <git@vger.kernel.org>; Tue, 19 Jun 2007 09:55:00 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 690C062A5D; Tue, 19 Jun 2007 09:57:31 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50454>

Hello,

A new version of tig has been released. It mainly contains bugfixes,
most importantly for regressions in the pager mode.

Get the tarball at http://jonas.nitro.dk/tig/releases/
or pull it from git://repo.or.cz/tig.git

The shortlog for this release:

Jakub Narebski (3):
      Remove PDF version of manual from being build and installed
      Include documentation sources for rpmbuild with '--without docs'
      Refresh VERSION file when building distribution tarball in "make dist"

James Bowes (1):
      Allow CFLAGS to be overridden while preserving VERSION

Jeffrey C. Ollie (1):
      Supply explicit permission bits to 'install'

Jonas Fonseca (14):
      tig-0.7.git
      Fix typo the INSTALL file
      Make dist rule more robust using '&&'; create .tar.gz.md5 file
      Merge branch 'jn/rpm-updates'
      Fix string_copy macro to use sizeof(src) for the source buffer
      Fix use of the status view from subdirectories
      Fix wrong uses of string_copy() with pointer instead of buffer
      read_properties: use size_t instead of int for callback
      Grab path to the git directory; use it when listing untracked files
      Only emit one "Not a git repository" error message
      Add TODO about using non-blocking I/O for incremental view loading
      Fix (another) integer type mismatch on 64-bit systems
      Fix pager mode regressions
      tig-0.8

Steven Grimm (1):
      Fix integer type mismatch on 64-bit systems

-- 
Jonas Fonseca

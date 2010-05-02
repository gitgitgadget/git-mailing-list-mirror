From: Andreas Gruenbacher <agruen@suse.de>
Subject: Fwd: GNU patch: upcoming stable release; call for testing
Date: Sun, 2 May 2010 13:54:12 +0200
Organization: SUSE Labs
Message-ID: <201005021354.13119.agruen@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 13:55:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Xlb-0005kX-Si
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 13:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404Ab0EBLyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 07:54:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:48753 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756121Ab0EBLyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 07:54:15 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D59CC8FEA2
	for <git@vger.kernel.org>; Sun,  2 May 2010 13:54:13 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146165>

----------  Forwarded Message  ----------

Subject: GNU patch: upcoming stable release; call for testing
Date: Sunday 02 May 2010
From: Andreas Gruenbacher <agruen@suse.de>
To: info-gnu@gnu.org

I am pleased to announce that there is progress towards the next stable 
release of GNU patch.  This is a call for testing so that things will work as 
expected, on as many platforms as possible.

The upcoming release will include several new features:


* Support for most features of the "diff --git" format: renames and copies,
  permission changes, symlink diffs.  (Binary diffs are not supported yet;
  patch will complain and skip them.)

* Support for double-quoted filenames: when a filename in a context diff
  starts with a double quote, it is interpreted as a C string literal.  The
  escape sequences \\, \", \a, \b, \f, \n, \r, \t, \v, and \ooo (a three-digit
  octal number between 0 and 255) are recognized.

* Refuse to patch read-only files by default, or at least warn when patching
  such files with --force or --batch.

* Refuse to apply a normal patch to a symlink.  (Previous versions of patch
  were wrongly replacing the symlink with a regular file.)

* When a timestamp specifies a time zone, honor that instead of assuming the
  local time zone (--set-date) or Universal Coordinated Time (--set-utc).

* Support for nanosecond precision timestamps.


Behind the scenes, some infrastructure changes have happened as well: the 
project now uses GNU Automake, and the previous, static copy of the Gnulib 
library has been replaced by a git submodule.


The project home with the development repository, bug tracker, and bug-
patch@gnu.org mailing list archive is located at:

  http://savannah.gnu.org/projects/patch

Development snapshots will be made available on:

  ftp://alpha.gnu.org/gnu/patch/

Previous stable releases are available at:

  ftp://ftp.gnu.org/gnu/patch/

Please send bug reports or suggestions to <bug-patch@gnu.org>.

Thanks,
Andreas

-------------------------------------------------------

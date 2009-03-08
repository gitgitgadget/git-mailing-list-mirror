From: Marius Vollmer <marius.vollmer@gmail.com>
Subject: [ANNOUNCE] Magit 0.7
Date: Sun, 08 Mar 2009 19:12:00 +0200
Message-ID: <87y6vgos67.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: magit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 18:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgMwS-0008PQ-00
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 18:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbZCHRcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 13:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbZCHRcH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 13:32:07 -0400
Received: from smtp5.welho.com ([213.243.153.39]:49961 "EHLO smtp5.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbZCHRcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 13:32:06 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2009 13:32:06 EDT
Received: from zagadka.ping.de (cs178034.pp.htv.fi [213.243.178.34])
	by smtp5.welho.com (Postfix) with SMTP id 13DAE5BC163
	for <git@vger.kernel.org>; Sun,  8 Mar 2009 19:12:01 +0200 (EET)
Received: (qmail 13583 invoked by uid 1000); 8 Mar 2009 19:12:00 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112624>

It's time for the next release of Magit, the Emacs interface to Git!

    http://zagadka.vm.bytemark.co.uk/magit/

A lot of people have contributed to it.  Thanks a lot!

Please report bugs and general feedback to our little mailing list:

    http://groups.google.com/group/magit

or to me directly, of course.

What's new:

* Tagging, on 't' and 'T'.

* Stashing, on 'z' and 'Z'.

* Wazzup, on 'w'.  Wazzup gives you an overview over how other
  branches relate to the current one.

* There is more control over pushing.  'P' now takes a prefix argument
  and pushing a branch without a default remote will ask for one.

* Logs have changed a bit: 'l' shows the traditional brief log, and
  'L' shows a more verbose log.  Use the prefix arg to specify the
  range of the log.

* M-x magit-status doesn't prompt anymore for a directory when invoked
  from within a Git repository.  Use C-u to force a prompt.

* When you have nothing staged, 'c' will now explicitly ask whether to
  commit everything instead of just going ahead and do it.  This can
  be customized.

* The digit keys '1', '2', '3', and '4' now show sections on the
  respective level and hide everything below.  With Meta, they work on
  all sections; without, they work only on sections that are a parent
  or child of the current section.

* Typing '+' and '-' will change the size of hunks, via the "-U"
  option to git diff.  '0' resets hunks to their default size.

* Typing 'k' on the "Untracked files" section title will offer to
  delete all untracked files.

* Magit understands a bit of git-svn: the status buffer shows unpushed
  and unpulled commits, 'N r' runs git svn rebase, and 'N c' runs git
  svn dcommit.

* Magit now also works when the direcory is accessed via tramp.

* M-x magit-status can also create new repositories when given a
  directory that is not a Git repository.

* Magit works better with oldish Gits that don't understand "--graph",
  for example.

* The name of the Git program and common options for it can be
  customized.

Enjoy!

From: Bill Lear <rael@zopyra.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 11:07:03 -0600
Message-ID: <17875.16823.981920.183618@lisa.zopyra.com>
References: <17875.13564.622087.63653@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 18:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNb7-0003GR-FA
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbXBNRHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbXBNRHJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:07:09 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61413 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbXBNRHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:07:08 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EH78Z31804;
	Wed, 14 Feb 2007 11:07:08 -0600
In-Reply-To: <17875.13564.622087.63653@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39688>

On Wednesday, February 14, 2007 at 10:12:44 (-0600) Bill Lear writes:
>I have a 1.4.4.1 repository, non-bare, cloned from my public
>repository.  I just installed and am using the new 1.5.0 git.
>
>On my master branch, I cleaned out some cvs ids in our text files and
>did a git diff --- all was well.
>
>I then did a commit, and something went wrong:
>
>% git commit -a -m "Nuke CVS Id strings"
>error: Could not read ab66b31e390889e6bcbb2002111e2803c51f42b5
>error: unable to read tree object HEAD
># On branch master
>error: Could not read ab66b31e390889e6bcbb2002111e2803c51f42b5
>error: unable to read tree object HEAD
>...

I also notice this:

% git diff src/fus/testsuite/fus.design/prep4_5.s
fatal: failed to find delta-pack base object 1e742ba82e01f5bb39ed62e6863712fd3c9b0616
diff --git a/src/fus/testsuite/fus.design/prep4_5.s b/src/fus/tes[...]
index 106a233..4e6dbd5 100644

But running diff again seems to make the warning go away, but no
changes are listed...bad.


Bill

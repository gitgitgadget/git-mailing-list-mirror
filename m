From: "Richard Tibbitt" <gitlist@lazyprune.com>
Subject: Failure cloning from a separate-git-dir repository
Date: Sat, 20 Aug 2011 18:47:57 +0100
Message-ID: <6csv47te4qv41ni53q0kf1fne0a4e1grnm@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 20:03:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuptN-0006ol-9M
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 20:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab1HTSDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 14:03:20 -0400
Received: from mail.workflow24.co.uk ([78.136.40.51]:1126 "EHLO
	mail.workflow24.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab1HTSDU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 14:03:20 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Aug 2011 14:03:19 EDT
Received: from 82.152.159.100 [82.152.159.100] by mail.workflow24.co.uk with SMTP;
   Sat, 20 Aug 2011 18:48:07 +0100
X-Mailer: Forte Agent 4.2/32.1118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179767>

Hi

I've been struggling to find an answer to this for days.

Can anyone confirm whether I've got the syntax right for 'Git clone'
when attempting to clone FROM a repository that was initialized using
--separate-git-dir ?

If so, does this work on Linux systems ?

With Git on windows (git version 1.7.6.msysgit.0 installed from
GitExtensions224SetupComplete.msi) I get an error as below, that looks
as though 'Git clone' is expecting the repo to have a 'normal'
integral .git dir 


  F:\>mkdir repo2
  F:\>mkdir repo2git
  F:\>cd repo2
  F:\repo2>call git init --separate-git-dir="..\repo2git\.git"
  Initialized empty Git repository in F:/repo2git/.git/
  F:\repo2>echo abc >file1.txt
  F:\repo2>call git add . -A
  F:\repo2>call git commit -m "first"
  [master (root-commit) c7e4766] first
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 file1.txt
  F:\repo2>cd ..
  F:\>call git clone repo2 clone2
  Cloning into clone2...
  fatal: failed to open 'F:/repo2/objects': No such file or directory


Many thanks in advance for any insight into this.

Richard

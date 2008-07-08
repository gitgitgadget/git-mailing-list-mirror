From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: git submodules or, how do we share code between unrelated projects?
Date: Tue, 8 Jul 2008 23:11:32 +0200
Message-ID: <200807082311.32684.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 23:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGKUD-0000vF-Jw
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 23:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYGHVLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbYGHVLg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 17:11:36 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:3235 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbYGHVLf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 17:11:35 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id m68LBXCc056368
	for <git@vger.kernel.org>; Tue, 8 Jul 2008 23:11:33 +0200 (CEST)
	(envelope-from J.Wielemaker@uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87798>

Hi,

I'm looking at git-submodule, but I start to get the impression it is old
CVS jargon that brought me there.

We are two open source projects creating implementations of the Prolog
language.  One (SWI-Prolog) is under GIT, the other (YAP) is under CVS
but will move to git if this helps.

We want to start sharing some developments. I guess for each (unrelated)
library we wish to share we must create a git repo, right? Now we
generally need compatibility patches to make this shared code run
on both systems and we need some way to get this code into the main
repo of both systems, such that a clone of the repo of a system gets
you the shared library.

I guess GIT must be perfect for this, but I'm a bit unsure on the
proper setup of the workflow.  Is there a project that has something
similar established and has guidelines how to manage this?

	Cheers --- Jan

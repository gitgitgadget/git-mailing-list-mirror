From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Sep 2009, #03; Sun, 13)
Date: Sun, 13 Sep 2009 16:53:12 +0200
Message-ID: <200909131653.12743.johan@herland.net>
References: <7v63bnw3wy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 16:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmqS8-0006cV-UY
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 16:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbZIMOxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 10:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754507AbZIMOxL
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 10:53:11 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38955 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754504AbZIMOxL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 10:53:11 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPX00I0R00PTU60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 13 Sep 2009 16:53:13 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPX00CLA00PIL10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 13 Sep 2009 16:53:13 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.13.143922
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <7v63bnw3wy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128366>

On Sunday 13 September 2009, Junio C Hamano wrote:
> --------------------------------------------------
> [Stalled]
> 
> * jh/cvs-helper (2009-08-18) 8 commits
>  - More fixes to the git-remote-cvs installation procedure
>  - Fix the Makefile-generated path to the git_remote_cvs package in
>  git-remote-cvs - Add simple selftests of git-remote-cvs functionality
>  - git-remote-cvs: Remote helper program for CVS repositories
>  - 2/2: Add Python support library for CVS remote helper
>  - 1/2: Add Python support library for CVS remote helper
>  - Basic build infrastructure for Python scripts
>  - Allow helpers to request marks for fast-import
>  (this branch uses db/vcs-helper-rest.)
> 
> Builds on db/vcs-helper.  There is a re-roll planned.

The next iteration of this topic will use sr/gfi-options, however, I'm 
holding off on submitting the re-roll until Shawn's comments on sr/gfi-
options have been adressed by Sverre.

> --------------------------------------------------
> [Cooking]
> 
> * jh/notes (2009-09-12) 13 commits
>  - Selftests verifying semantics when loading notes trees with various
>  fanouts - Teach the notes lookup code to parse notes trees with various
>  fanout schemes - notes.[ch] fixup: avoid old-style declaration
>  - Teach notes code to free its internal data structures on request.
>  - Add '%N'-format for pretty-printing commit notes
>  - Add flags to get_commit_notes() to control the format of the note
>  string - t3302-notes-index-expensive: Speed up create_repo()
>  - fast-import: Add support for importing commit notes
>  - Teach "-m <msg>" and "-F <file>" to "git notes edit"
>  - Add an expensive test for git-notes
>  - Speed up git notes lookup
>  - Add a script to edit/inspect notes
>  - Introduce commit notes
>  (this branch uses sr/gfi-options.)

This topic does not use sr/gfi-options.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 1.6.5.0
Date: Fri, 25 Feb 2011 09:44:54 +0800
Message-ID: <AANLkTikCFnGWqhyMcEQe7D=U7rGzrBYk3FuzugEyHB4R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-announce@googlegroups.com,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 25 02:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psmjs-0003FS-H8
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 02:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab1BYBoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 20:44:55 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46453 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab1BYBoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 20:44:55 -0500
Received: by iwn34 with SMTP id 34so709540iwn.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 17:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=5Iuyh8UjTLDj+Xcp/sW0CwC6pe/9rJCWUXQaSpO56uA=;
        b=AF/RjAgTyji+LJ9rxoG+NSgBR+MgPLBj0+d2Yjr4e1XmAX03DKvZsjR2QAtvr7nzik
         uvVPkxmmNfmYyC0wBtk4sZANGSukr3nflNImAk0t2908uLOfLc11WkE+/NlNc2UVZ04D
         RYjISO9Jbuxyw3uNNtQTsQVEQ4aPpbiKgXs78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xD2mjWp+wOyqGfcLNsOonqKAyB7bFZ2sNc3Ri0+TZaG73CL1SkBaQygWvDLF3f86Xn
         8HfbMnlVHQi0dpIUsuo2/Gl0rK2x0ts2dBOuXEYdPA02WWMHqidLulPuLvsUJL2BqFRY
         smWa0pQ0Ne+cNQxLPhsFHLtfZPvF5Pm26jwHY=
Received: by 10.43.51.129 with SMTP id vi1mr79886icb.407.1298598294636; Thu,
 24 Feb 2011 17:44:54 -0800 (PST)
Received: by 10.231.208.83 with HTTP; Thu, 24 Feb 2011 17:44:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167871>

Download:

http://tortoisegit.googlecode.com/files/Tortoisegit-1.6.5.0-32bit.msi
http://tortoisegit.googlecode.com/files/Tortoisegit-1.6.5.0-64bit.msi

= Release 1.6.5.0 =
== Bug Fix ==
 * Fixed issue #715: Unable to show log when there are old version cache file
 * Fixed issue #611: Add "copy all information" to "Changed Files" dialog
 * Fixed new file miss when combine commits at log dialog
 * Fixed issue #720: Infinite loop at search in Show Log when there are notes

= Release 1.6.4.0 =
== Features ==
 * Significantly Improve Log fetch speed for big repository
 Fetch modified file list asynchronous.
 Time filter (From, to) use git built-in --max-age and --min-age.
 Text filter use git grep.
 Fixed issue #590: wasteful use of memory with very large repository
 Fixed issue #531: Git synchronization UI opened so slowly
 Fixed issue #541: show log is extremely slow
 Fixed issue #364: Log - hot key for "browse refs" dialog

 * Improve TortoisePLink 3x transfer perfomance
 Update TortoisePlink to plink 9078

 * Implemented issue #664: Warn when committing to detached HEAD
 * The context menu can be hidden completely for unversioned items (issue 674)
 * Only show DCommit type dialog if "svn.rmdir" is unset
 * Optionally remember DCommit type setting
 * enable git status column in TortoiseShell
 * Fixed issue #644: Dropped "Check repository" button on check for
modifications dialog
 * Allow to diff two revisions of a file by calling TortoiseProc
 * Fixed issue #480: Implement text copying opportunities in the dialogs
 * Allow to change EOL by pressing CTRL+Return in TortoiseMerge
 * Allow to replace (previously hardcoded) Notepad2 by any other editor
 * Optionally send/mail patches via MAPI, if a default mail client is set up
 * Fixed issue #248: Allow to reorder commits on rebase
 * Fixed issue #702: Added request-pull functionality

 * TortoiseGitBlame
 Clicking on a line automatically selects the log entry in the loglist
 Allow to diff to previous revision of a file
 Added new context menu
 Allow to toggle author column


== Bug Fix ==
 * Fixed issue #669: cannot open help from clean window
 * Fixed issue #671: Help not working when choose switch dialog and
dcommit dialog
 * Fixed issue #690: Superfluous line in displayed commit message
 * Do not allow to delete-ignore working copy root-directory
 * Starting TortoiseGitBlame might fail to start if folder contains spaces
 * Fixed window titles of log and statistics window
 * Fixed issue #697: /CloseOnEnd was not working, fixed for fetch&pull

 * Fixed issues with the send mail dialog
 If all three attempts failed, do not show success
 If all three attempts failed, do not go on sending more patches
 Correctly show retries
 Interpret user cancel as failure

 * TortoiseGitBlame
 Fixed issue #448: Disable personalized menu behaviour
 After blaming an older revision, TortoiseGitBlame was fixed to this.

 * Fixed issue #704: cannot open help from diff from previous, browse refs
 * Fixed issue #694: "Clean Up" executes on top level directory
 * Fixed issue #680: StatGraphDlg.cpp min-avg statistics are incorrect
 * Fixed issue #705: Fixed comparing added/deleted files on diffing
whole revisions
 * Improved "Combine commits" process (prevents possible loss of data)

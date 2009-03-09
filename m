From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 0.4.2.0 release
Date: Mon, 9 Mar 2009 09:38:33 +0800
Message-ID: <1976ea660903081838o77d9992ds5ddadd1c7fcd5952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com, git@vger.kernel.org,
	tortoisegit-announce@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Mar 09 02:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgUUQ-0008EQ-4l
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbZCIBig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbZCIBif
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:38:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:26392 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbZCIBif (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:38:35 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1404404rvb.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 18:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=+OzMnOTREVwFkeAaAZ2E6M8MvYVitbhOgVOC2IMTBEw=;
        b=MQOimKkinZHxiiywPzUNsnDIqvgr4VQV1JBWYTXzTmJZZnFh5KDJkNNCEEWudhQDs/
         879zbvVMNF6d7XOWDk7x8vwTZteE5VZzfxW3tOTa36HK6G/ZiP4JsEZihMU28Aut61eg
         qAd0P/l+wL5qGbD6zDSekxuR3r3V8a+7Rd7wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=EBN3le4nrkjwnCrj7p4IuhwcERagDKfARYnDbh+1utZ0QDnhcT3Tz8p28mpPrkF25K
         aBk4jZ0whzvnY/EdBOVlsaSSkAudUaArkz9pleU1bsikQWqU1EhxNQtlmHLsmGaAg70L
         xk68QCNMeeyABVdg1K7vG1jI0Nh8jmD1ni31E=
Received: by 10.141.26.19 with SMTP id d19mr2768290rvj.84.1236562713509; Sun, 
	08 Mar 2009 18:38:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112667>

TortoiseGit Shell can not appear at explore context menu because miss
install ATL library at v0.4.1.0.
I am sorry for such critial problem happen.

This release is for quick fix this issue.

Version 0.4.2.0 version(external)
	*Fix Shell menu disappear because ATL library have not installed.
	*Fix Commit Dialog and Log Dialog default column is wrong
	*Fix some dialog can't show after resize and close and open again
	*Fix ProgressDlg Sometime thread is dead blocked.

Version 0.4.1.0 version(external)
        *Fixed x64 build of TortoiseProc crashed due to received
unexpected messages
	*Fix tag to head when *force* check box checked
	*Add Git document to help

Version 0.4.0.0 version(internal)
Features:
	*Full Overlay Icon Support.
	 Show "Conflict, ignore file, untracked file, modified, Add, staged"
icon according to file status.

	*Rebase Support.
         Support "Pick" "Sqaush" "Edit" and "Skip" commit when rebase branch.
         Support abort.
 	
	*Combine Multi-commits to one commit.
	 Combine continous commits to one commit. The limition is the only
single line(no merge point) above combined commit.

	*Cherry Pick multi commits.
	 User can use multi commits at log dialog and then choose cherry pick
these. Cherry Pick dialog guide you finish whole work.
         Support "Pick" "Squash" "Edit" and "Skip" commits.
	
	*First x64 version.

	*Support version "browse" at switch, export, new branch/tag and merge dialogs.

	*Add context menu item "Revert" at Commit dialog File List.

	*Show bold font for HEAD at log dialog.
	
	*Add "Whole Project" checkbox at commit dialog

	*First Version Help Document.

Bug Fix:
	*Fix issue 36, Push not working if no remote branch is specified
	*Default UnCheck untrack file at commit dialog
	*Issue 40:  Commit from subfolder shows unversioned files in parent
	*Fix diff problem when filenames have embedded spaces
	*Fix Issue 24,45, Commit results not in window with scroll bars
	*Fix for win2k context menu icons
	*Fix Issue 46, The about window title still displays TortoiseSVN
	*Fix Issue 37, When the file name contains Chinese char, Diff doesn't work.
	*Fix Issue 28, "Add" status icon overlay is not correct.

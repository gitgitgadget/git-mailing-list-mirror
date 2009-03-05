From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 0.4.1.0 release
Date: Thu, 5 Mar 2009 23:10:08 +0800
Message-ID: <1976ea660903050710s7db3dcf6gf0955d789e2dd521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com, git@vger.kernel.org,
	tortoisegit-announce@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Mar 05 16:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfFEd-0001H1-6h
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 16:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbZCEPKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 10:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZCEPKM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 10:10:12 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:21720 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZCEPKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 10:10:11 -0500
Received: by rv-out-0506.google.com with SMTP id g37so3907546rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 07:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=HIHHXl5GhZYF1+VPQjCDjgVbMSbOYdHkWbr9eFaKdjQ=;
        b=RVFWQvSEw2a4XnmCM8uf+EInMfAub3AvOQu98+TsfPKIssk+Fmfow7f3aKZA2nGAov
         GetlPaEUjonOsqb02lSiP17MAIErDYrgGMX/zDYneqNZbQfjqC+vKFqeVRq3Hv10mXX8
         liw4DA3Dg40Bvjjs8HOSMn8AGaPQafUpgnBzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JEJNq1ExlyUt2jXm9bb4upl7sHNYWswhd59UMb++NPJPO1HsdYP1zTBMtsyC0pQTbW
         hd/J7rPvwV2vcAXAUWYvqWuirmOjqydiUEDkE3BAe9broKKX9ufl02NktN1RqDCw4d1H
         bnKd6woffsCAlV0vUPkrSTRwB/JgyFLJ+CYk0=
Received: by 10.141.176.6 with SMTP id d6mr690661rvp.143.1236265808907; Thu, 
	05 Mar 2009 07:10:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112309>

TortoiseGit 0.3.3 released.
http://code.google.com/p/tortoisegit/downloads/list

Features:
	*Full Overlay Icon Support.
	 Show "Conflict, ignore file, untracked file, modified, Add, staged"
icon according to file status.

	*Rebase Support.
                 Support "Pick" "Sqaush" "Edit" and "Skip" commit when
rebase branch.
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
                *Fixed x64 build of TortoiseProc crashed due to
received unexpected messages
	*Fix tag to head when *force* check box checked
	*Add Git document to help

Known Issue:
                *Git clone can't support git protocol. SSH need enable
TortoisePLink
                 as SSH client. User should use setting dialog network
page to setup
                 TortoisePLink as SSH client.

                *Git clone can't capture TortoisePLink output. So there are no
                 progress info during download from remote repository.

                *64bit setup package can not auto installed MFC 9.0
and ATL 9.0 Redistribute package.
                Work around: install MFC 9.0 and ATL 9.0 redistribute
package before install 64bit tortoisegit.

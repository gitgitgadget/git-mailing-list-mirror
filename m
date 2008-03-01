From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Summer of Code 2008
Date: Sun, 2 Mar 2008 00:53:08 +0100
Message-ID: <200803020053.09815.jnareb@gmail.com>
References: <200802262356.28971.jnareb@gmail.com> <alpine.LSU.1.00.0802281021070.22527@racer.site> <200802291304.16026.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 00:53:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVbWb-0002CD-JP
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 00:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbYCAXxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 18:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYCAXxQ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 18:53:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:45407 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbYCAXxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 18:53:15 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1124222ugc.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=4ZCd+Wq/EL5CCMMKuEXJsm0Nqunb/Xa3SySZ1RMSJYY=;
        b=Gwk+qifkbudRCuCcoMiCJepzDI8JubC65mavQ/gR3mKNuV2qoPyCm6XympgHHX1rzZwtxs/mBvVeHjw8QHCpEeRPAoQBAJKi8Sf2yNat8Ev9sKPcp74PuF2fRXYXozdiYJQf1C/5Rg/imsVMAkAYUqwo+9rc/ZC/XXBytVwUi0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Mzqt2CN+AXEkwu7fHmcWj6hFLrff98rHmZc/+E4EbMbokB5wn8C99E3MyD2qUGgtbxTjAMtE3AFRGjNdDapRy++z05RAuQsV6WvseOp5hO/JuW1BK2bBcuG7xyBVVsEfbReqjkVsxrkcYsj6+/nOVaEUzZpFTOKC/Mif9VpoXYk=
Received: by 10.67.115.17 with SMTP id s17mr3267727ugm.56.1204415593694;
        Sat, 01 Mar 2008 15:53:13 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.199.142])
        by mx.google.com with ESMTPS id j1sm4486414ugf.74.2008.03.01.15.53.08
        (version=SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 15:53:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200802291304.16026.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75709>

On Fri, 29 Feb 2008, Jakub Narebski wrote:

> I'd send other ideas (including new ones, like translating
> svn:externals into git submodules in git-svn; or making git mode
> for Emacs have all features of tig, git-gui and gitk; or improving
> shallow clone support) in a later post.

And here they are.

* GNU Emacs git GUI

  Make git mode for Emacs full featured git GUI, and not only commit
  tool, following ideas of PCL-CVS... and its limitation. I guess that
  DVC (http://download.gna.org/dvc) git mode is one thing to examine
  searching for features to implement, but from what I have read in
  documentation it is quite a but GNU Arch centric. Other git GUIs, like
  git-gui, gitk, qgit, tig could also be inspiration for features.

  Goal: Allow creating and switching branches, examining history,
  merging, fetching etc. from withing Emacs. Should include modes for
  git config file forma and format-patch patches.

  Language: Emacs Lisp
  Suggested mentors:
    Alexandre Julliard
    David Kagedal


* git-svn and submodules (and other improvements)

  Make git-svn translate svn:externals (full kind) submodules into git
  submodules. This might require improvements to submodule support in
  git. Other improvements include proper dealing with miscelaneus
  Subversion properties (translating them into .gitignore
  and .gitattributes entries).

  Goal: Succesfull two-way interaction with Subversion repository using
  svn: externals for submodules.

  Language: Perl
  Suggested mentors:
    Eric Wong (git-svn author)
    Shawn O. Pearce
    Johannes Schindelin


* Shallow clone improvements

  IIRC the interaction with shallow clone is a bit limited. Lift those
  limitations, allowing for example to push from shallow to full clone.

  Goal: Push from shallow clone to full clone, or other shallow clone.
  Language: C
  Suggested mentors: Johannes Schindelin


* blame Merge Strategy

  A new merge strategy "merge-blame". It should take advantage of code
  (fragment) movement and copying detection in git blame, correctly
  applying change to correct place if code was moved (e.g. reorganizing
  code) or moving fragment into another file.

  This strategy should probably be a function within merge-recursive
  that is activated only when merge-recursive is invoked as merge-blame
  (or some perhaps some better name). Further it probably should only be
  used when a file fails to be merged cleanly, as a "last resort before
  asking the developer to do it for me" sort of trick. Rationale here is
  the blame computation is non-trivial and will take some CPU time, so
  we want to avoid that in the common cases of non-moved code.

  Goal: Demonstrate a working merge-blame that can fairly accurately
  merge changes made to moved code segments.

  Language: probably C
  Suggested mentors: unknown

-- 
Jakub Narebski

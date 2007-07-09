From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [mingw port] Problem starting git subcommands
Date: Mon, 09 Jul 2007 10:49:15 +0200
Organization: eudaptics software gmbh
Message-ID: <4691F68B.832047D1@eudaptics.com>
References: <87eacd830707081126x69b2edb3o9fd89733ff2258f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 10:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ovS-0005Z4-G6
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 10:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbXGIIst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 04:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbXGIIst
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 04:48:49 -0400
Received: from main.gmane.org ([80.91.229.2]:34701 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbXGIIss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 04:48:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I7ovF-0006Gc-6E
	for git@vger.kernel.org; Mon, 09 Jul 2007 10:48:45 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 10:48:45 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 10:48:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51972>

Henning Rogge wrote:
> 
> I have experimented with GIT on my linux system successfully but one
> of my projects has to be done on Windows (neither VMware Workstation
> nor Wine can help at the moment) so I got a copy of the mingw port of
> GIT (http://lilypond.org/git/binaries/mingw/git-1.5.2.1-1.mingw.exe).
> 
> Installation succeeded without a single error but when I tried to run
> a few GIT commands I noticed a "bug":
> 
> the git.exe command does not recognize any scripted subcommand
> (git-clone in my case) !
> > C:\Programme\Git>git clone
> > git: 'clone' is not a git-command
> 
> Do I need another software package ? I tried to install the Mingw
> package itself, but it did not help at all.

Yes, you need a shell and some Posix tools. Install MSYS, e.g.

   MSYS-1.0.11-2004.04.30-1.exe

You will also want a ssh and perl, e.g. from

   msysDTK-1.0.1.exe

and MinGW's tcl/tk from

   tcltk-8.4.1-1.exe

Also, git-am seems to require bash 3.1, e.g. from

   bash-3.1-MSYS-1.0.11-snapshot.tar.bz2

-- Hannes

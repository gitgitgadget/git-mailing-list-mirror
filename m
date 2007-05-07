From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 07 May 2007 09:02:12 +0200
Organization: eudaptics software gmbh
Message-ID: <463ECEF4.625F3633@eudaptics.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500> <7vejlufmhd.fsf@assigned-by-dhcp.cox.net> <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 09:02:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkxEg-0006Ei-JG
	for gcvg-git@gmane.org; Mon, 07 May 2007 09:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbXEGHCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 03:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbXEGHCP
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 03:02:15 -0400
Received: from main.gmane.org ([80.91.229.2]:43118 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075AbXEGHCP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 03:02:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HkxEb-0004tb-8b
	for git@vger.kernel.org; Mon, 07 May 2007 09:02:13 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 May 2007 09:02:13 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 May 2007 09:02:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46420>

Aaron Gray wrote:
> What I want is to be able to work in Windows CMD and envoke .sh scripts by
> association (unfortunately you have to add the .sh on the command name
> though).

I run the mingw port exclusively from CMD without a .sh association. So
exclusively that I don't even know whether any other way of using the
tools even works. Of course, you have to get used to

  git status
  git fetch
  git commit
  git rebase

etc. instead of

  git-status
  git-fetch
  git-commit
  git-rebase

and I also use CMD's tab completion frequently, with leaves \ instead of
/ in the paths. I also quite often do

  git clone p:\public\repos\foo.git

and

  git clone p:/public/repos/foo.git

without a hitch.

Sure, you need a set of Posix tools (sed, grep, cat, wc, sort, ...)
including a Bourne shell that knows how to invoke other scripts by
parsing the interpreter from the first line (#!/bin/sh). (But the perl
scripts (git-remote) will probably work only with MinGW's perl.)

-- Hannes

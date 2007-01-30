From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 17:31:22 +0100
Organization: eudaptics software gmbh
Message-ID: <45BF72DA.B83017CF@eudaptics.com>
References: <200701292320.43888.johannes.sixt@telecom.at>
		 <20070129223513.GA31372@spearce.org>
		 <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com>
		 <20070129232425.GB31372@spearce.org>
		 <46d6db660701292359v7647306fla30c9a10e5989dcc@mail.gmail.com> <46d6db660701300007v573832b5pc7ac41059dc4490e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 17:31:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBvtE-00071D-V3
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 17:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXA3QbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 11:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbXA3QbW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 11:31:22 -0500
Received: from main.gmane.org ([80.91.229.2]:35127 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbXA3QbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 11:31:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HBvsa-00034E-As
	for git@vger.kernel.org; Tue, 30 Jan 2007 17:30:47 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 17:30:44 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 17:30:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38166>

Christian MICHON wrote:
> 
> On 1/30/07, Christian MICHON <christian.michon@gmail.com> wrote:
> > but call gitk from inside it fail :(
> >
> > "error in startup script"
> > ( git-peek-remote is not working from git-gui, could be path related.
> > It's hard to tell why yet)
> 
> just to be more clear: when using the .bat shortcut, calling gitk
> from within git-gui fails.

Calling gitk from git-gui works here, even if git-gui was invoked from
the .bat file. But maybe just because I have all git tools in my $PATH.
And I have this CMD script in my $PATH as well:

D:\>cat D:\MSYS\1.0\git\bin\gitk.cmd
@echo off
start wish84 D:/MSYS/1.0/git/bin/gitk %1 %2 %3 %4 %5 %6 %7 %8 %9

(and, btw, a similar script for git-gui).

-- Hannes

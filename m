From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Tue, 16 Jan 2007 01:51:39 +0100
Organization: At home
Message-ID: <eoh7ht$cc$1@sea.gmane.org>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx> <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com> <200701131815.27481.alan@chandlerfamily.org.uk> <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com> <20070113203456.GA17648@spearce.org> <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070114224204.GA10888@spearce.org> <7v4pqtf699.fsf@assigned-by-dhcp.cox.net> <20070115011217.GA11240@spearce.org> <Pine.LNX.4.64.0701151727310.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 16 01:51:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6cXz-0006DA-KC
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 01:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbXAPAv3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 19:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbXAPAv3
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 19:51:29 -0500
Received: from main.gmane.org ([80.91.229.2]:44396 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175AbXAPAv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 19:51:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H6cXn-0007Tg-LZ
	for git@vger.kernel.org; Tue, 16 Jan 2007 01:51:19 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 01:51:19 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 01:51:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36906>

Daniel Barkalow wrote:

> On Sun, 14 Jan 2007, Shawn O. Pearce wrote:
> 
>> I commit often directly from the command line.
>> 
>> But yes, you're right.  If I actually started my editor its right
>> there in the commit message template.  Easy enough to quit without
>> writing the file, add the new files, and restart the commit.
> 
> An config option to prohibit committing with untracked files should be 
> easy to add. If your workflow is such that incorrect commits are sometimes 
> generated given either policy, the system should ask you which you mean.

Not a config option. Pre-commit hook should be enough.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

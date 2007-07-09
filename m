From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Recent issues
Date: Mon, 09 Jul 2007 12:20:10 +0200
Organization: eudaptics software gmbh
Message-ID: <46920BDA.C1AC9F51@eudaptics.com>
References: <7v7ipcbrfd.fsf@assigned-by-dhcp.cox.net> <18065.65446.474822.436800@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 12:19:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7qLK-0004UH-L7
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 12:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbXGIKTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 06:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbXGIKTn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 06:19:43 -0400
Received: from main.gmane.org ([80.91.229.2]:42235 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbXGIKTm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 06:19:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I7qLA-000692-Ag
	for git@vger.kernel.org; Mon, 09 Jul 2007 12:19:36 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 12:19:36 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 12:19:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51978>

Paul Mackerras wrote:
> 
> Junio C Hamano writes:
> 
> > * gitk --left-right
> >
> >   From: Linus Torvalds <torvalds@linux-foundation.org>
> >   Message-ID: <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
> >   From: Junio C Hamano <junkio@cox.net>
> >   Message-ID: <7vabwifl23.fsf@assigned-by-dhcp.cox.net>
> >
> > Paulus?
> 
> Looks mostly OK; I assume there's no possible downside to using git
> log -v --pretty=raw rather than git rev-list?

In general, there is a big down-side, although I don't know if this
particular case is affected: --pretty=raw prints the parents noted in
the commit object, but not those from .git/info/grafts.

-- Hannes

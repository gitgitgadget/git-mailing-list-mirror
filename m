From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW problem
Date: Wed, 16 May 2007 10:02:55 +0200
Organization: eudaptics software gmbh
Message-ID: <464ABAAF.C6603C5@eudaptics.com>
References: <1e5001c794a0$aac23140$0200a8c0@AMD2500>
		 <033501c79710$a2eb0290$0200a8c0@AMD2500> <f329bf540705151251n10c05452s5a74e8eaa513bf90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 10:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoETE-0008F3-Mn
	for gcvg-git@gmane.org; Wed, 16 May 2007 10:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757036AbXEPICp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 04:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757041AbXEPICp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 04:02:45 -0400
Received: from main.gmane.org ([80.91.229.2]:47134 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756944AbXEPICn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 04:02:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HoET3-0007hU-4o
	for git@vger.kernel.org; Wed, 16 May 2007 10:02:41 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 May 2007 10:02:41 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 May 2007 10:02:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47428>

Han-Wen Nienhuys wrote:
> 
> I think it might be a bug. Patches are welcome.
> 
> I suppose git-clone has a hardcoded path. Paths under windows should
> be either taken from registry (yuck) or dynamically detected from
> $PATH and argv[0].
> 
> 2007/5/15, Aaron Gray <angray@beeb.net>:
> > Han-Wen,
> >
> > Dont know whether you got the message or not so I'll try you again.
> >
> > On doing a git-clone I get the message :-
> >
> >         warning: templates not found /usr/share/git-core/templates/
> >

This should have been fixed by 2d84ffaf (currently master~1 in
git://repo.or.cz/git/mingw.git) and its parent. Can you make sure that
your build picks up the new Makefile setting that these commits
introduce?

-- Hannes

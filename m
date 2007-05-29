From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 16:13:22 +0200
Organization: eudaptics software gmbh
Message-ID: <465C3502.BE134BC9@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
	 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
	 <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>
	 <Pine.LNX.4.64.0705291305540.4648@racer.site> <465C2516.7040607@trolltech.com> <Pine.LNX.4.64.0705291446170.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 29 16:12:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht2RN-0001as-Qn
	for gcvg-git@gmane.org; Tue, 29 May 2007 16:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbXE2OMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbXE2OMb
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 10:12:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:32962 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbXE2OMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 10:12:30 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1Ht2R1-0006Ca-AQ; Tue, 29 May 2007 16:12:27 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 22FC06EF; Tue, 29 May 2007 16:12:27 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.044
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48692>

Johannes Schindelin wrote:
> There are at least three different cmd.exe that _I_ encountered: NT4.0,
> 2000 and XP. All of them have different features. None of my scripts
> worked without _heavy_ workarounding on all of them.
> 
> But I think a .lnk file would be easier to create, and more portable,
> right?

If:

1. there is a .lnk file named gitk.lnk with target for example:

    D:\MSYS\1.0\mingw\bin\wish84.exe D:\MSYS\1.0\git\bin\gitk

2. you change PATHEXT to include '.LNK'.

then gitk can be invoked with varying arguments from CMD. I've tested
this only on W2k. Point 2 looks hackish and dangerous to me.

-- Hannes

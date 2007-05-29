From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 15:24:41 +0200
Organization: eudaptics software gmbh
Message-ID: <465C2999.677860A6@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com> <Pine.LNX.4.64.0705291305540.4648@racer.site> <465C2516.7040607@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue May 29 15:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht1g5-0005dx-SE
	for gcvg-git@gmane.org; Tue, 29 May 2007 15:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761904AbXE2NXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 09:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761866AbXE2NXt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 09:23:49 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43265 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761528AbXE2NXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 09:23:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1Ht1fu-0003L3-J4; Tue, 29 May 2007 15:23:46 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5CF026EF; Tue, 29 May 2007 15:23:46 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.045
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48690>

Marius Storm-Olsen wrote:
> 
> Johannes Schindelin said the following on 29.05.2007 14:11:
> >> Also, the /bin/gitk.bat file should rather be
> >> @"%~d0%~p0wish84.exe" "%~d0%~p0gitk" %* than the current
> >> hardcoded path. (Probably won't work with command.com, but who
> >> uses that for development nowadays anyways, right ;-)
> >
> > We're open source, so we _can_ do better than leaving people stuck
> > on older hardware behind.
> >
> > And I don't know what this garbage means. (I checked with GMane,
> > and it looks the same there.) I'd rather have something readable,
> > even if it is slightly slower or has to be adjusted when
> > installing.
> 
> %~d0 = expands %0 to a drive letter only
> %~p0 = expands %0 to a path only
> 
> so, for
>      C:\foo\bar\baz\gitk.bat
> %~d0%~p0gitk would expand to
>      C:\foo\bar\baz\gitk
> 
> Looking at the docs for cmd's call (run 'help call'), I see now that
> it can be written
>      %~dp0gitk
> as well..

But... the docs also say that this stuff is only available if command
extensions are turned on. Are they on by default?

(I cannot tell because I remember faintly that I fiddled with the
corresponding registry setting in the past, but don't know whether it
was on or off at the beginning.)

-- Hannes

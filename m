From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 23:16:01 -0300
Message-ID: <465CDE61.40103@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>		 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>		 <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>		 <Pine.LNX.4.64.0705291305540.4648@racer.site>		 <465C2516.7040607@trolltech.com>		 <Pine.LNX.4.64.0705291446170.4648@racer.site>		 <465C3502.BE134BC9@eudaptics.com> <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com> <465C4B0E.C34795B@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed May 30 04:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtDld-0001n5-C1
	for gcvg-git@gmane.org; Wed, 30 May 2007 04:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbXE3CSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 22:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbXE3CSX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 22:18:23 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:2894 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbXE3CSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 22:18:22 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4U2IDNt091821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2007 04:18:15 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <465C4B0E.C34795B@eudaptics.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48722>

Johannes Sixt escreveu:
>> I'd suggest create a small C wrapper to launch gitk. It would be much
>> easier that way IMHO.
> 
> Doh! You're right! It's even there already, right before our eyes:
> 
> pointy..clicky..pointy..clicky  (aka: cp gitk git-k)
> 
> $ git k
> 
> :)

how about 

  git tk 

that's more in line what actually happens. We can ship a gitk.bat
that runs git-tk.

BTW, I got one report that gitk doesn't work with the tcl/tk that I
ship.  Can I have other reports too? ie. 

  "It doesn't work for me, I use windows 92" 
  "It works for me, I use windows QZ" 

etc.?
-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

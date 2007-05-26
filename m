From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sat, 26 May 2007 16:42:28 -0300
Message-ID: <46588DA4.5020109@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <Pine.LNX.4.64.0705251113280.4648@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 26 21:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs2Bz-0005zs-Mz
	for gcvg-git@gmane.org; Sat, 26 May 2007 21:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373AbXEZToa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 15:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758769AbXEZToa
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 15:44:30 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4194 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758373AbXEZTo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 15:44:29 -0400
Received: from [192.168.1.102] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4QJiM9e025029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 May 2007 21:44:24 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0705251113280.4648@racer.site>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48488>

Johannes Schindelin escreveu:
> Hi,
> 
> On Fri, 25 May 2007, Johannes Sixt wrote:
> 
>> * I personally think that the files should go into
>>
>> 	$PROGRAMFILES/Git/{bin,share,lib}
>> instead of
>> 	$PROGRAMFILES/Git/usr/{bin,share,lib}
> 
> Agree. It is trivial, but it will help others. It might also be a good 
> idea to have a shortcut in "$PF/Git/Git Gui.lnk" to the git gui (once it 
> is working, that is).
> 
>> * git-gui and gitk don't work out of the box because they have the path
>> to wish hardcoded. They can't be started from CMD at all. I have written
>> wrappers gitk.cmd and git-gui.cmd with these 2 lines:
>>
>> @echo off
>> start wish84 D:/MSYS/1.0/git/bin/gitk %*
>>
>> But as you can see, the path is still hard-coded (but it is good enough
>> for me for the moment).
> 
> I'd also like to see bash, perl and wish bundled with the install (Windows 

Where is the info on the wish and bash port to Mingw?


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

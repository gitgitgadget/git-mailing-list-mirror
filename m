From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW port updated to 1.5.2
Date: Sun, 27 May 2007 03:26:37 -0300
Message-ID: <4659249D.8040106@xs4all.nl>
References: <46569DA5.4F0EBF9A@eudaptics.com>  <4658922B.1010807@xs4all.nl> <001d01c79fd7$3d7f5ad0$0200a8c0@AMD2500>  <4658A01E.5060209@xs4all.nl> <001201c79fdd$f1b7eca0$0200a8c0@AMD2500>  <4658B570.7000101@xs4all.nl> <004201c79fe7$f16b47b0$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aaron Gray <angray@beeb.net>
X-From: git-owner@vger.kernel.org Sun May 27 08:28:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsCFM-0005sO-VD
	for gcvg-git@gmane.org; Sun, 27 May 2007 08:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXE0G2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 02:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbXE0G2p
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 02:28:45 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:3778 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbXE0G2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 02:28:45 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4R6SYFn079778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 08:28:41 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <004201c79fe7$f16b47b0$0200a8c0@AMD2500>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48519>

Aaron Gray escreveu:
>> Aaron Gray escreveu:
>>>> Aaron Gray escreveu:
>>>>>>> GIT_EXTERNAL_DIFF works now.
>>>>>>
>>>>>> http://lilypond.org/git/binaries/mingw/
>>>>>>
>>>>>> uploading as I speak. Untested.
>>>>>
>>>>> This installs to "C:\Program Files\Git" and is not availiable on the
>>>>> path. What is going on here please ?
>>>>
>>>> this uses the same buildscripts as before, so if it worked, it should
>>>> still work. The path should point to $PF/Git/usr/bin/ ; you might
>>>> need to
>>>> log out and log in again for the path to visible.
>>>
>>> Still not working properly.
>>>
>>> From CMD.EXE, neither 'git clone' and 'git-clone' are accessable.

>> - what is the value of the PATH variable in CMD ?
> 
> Path=C:\Program
> Files\GreenBorder\;C:\windows\system32;C:\windows;C:\windows\Sys
> tem32\Wbem;C:\Program Files\ATI Technologies\ATI Control
> Panel;c:\Program Files\
> Microsoft SQL Server\90\Tools\binn\;C:\GnuWin32\bin;C:\Program
> Files\QuickTime\Q
> TSystem\;C:\Utils;C:\Program
> Files\MakeMsi\;c:\MinGW\bin;C:\MinGW\usr\bin;C:\Pro
> gram Files\Git\usr\bin;C:\Program Files\Git\usr\bin

Can you troubleshoot this for me?  As you can see, you have

C:\Program Files\Git\usr\bin

in the path. That AFAIK should be enough to have git.exe run 
inside CMD.  Maybe I'm missing something, but that is as far as my 
windows knowledge goes.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

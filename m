From: "Aaron Gray" <angray@beeb.net>
Subject: Re: MinGW port updated to 1.5.2
Date: Sun, 27 May 2007 14:38:48 +0100
Message-ID: <003701c7a064$60f32630$0200a8c0@AMD2500>
References: <46569DA5.4F0EBF9A@eudaptics.com>  <4658922B.1010807@xs4all.nl> <001d01c79fd7$3d7f5ad0$0200a8c0@AMD2500>  <4658A01E.5060209@xs4all.nl> <001201c79fdd$f1b7eca0$0200a8c0@AMD2500>  <4658B570.7000101@xs4all.nl> <004201c79fe7$f16b47b0$0200a8c0@AMD2500> <4659249D.8040106@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Han-Wen Nienhuys" <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun May 27 15:39:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsIy0-00023s-J9
	for gcvg-git@gmane.org; Sun, 27 May 2007 15:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbXE0NjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 09:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbXE0NjU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 09:39:20 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:28690 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019AbXE0NjU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2007 09:39:20 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FGK70688 (AUTH angray);
	Sun, 27 May 2007 14:39:18 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48539>

> Aaron Gray escreveu:
>>> Aaron Gray escreveu:
>>>>> Aaron Gray escreveu:
>>>>>>>> GIT_EXTERNAL_DIFF works now.
>>>>>>>
>>>>>>> http://lilypond.org/git/binaries/mingw/
>>>>>>>
>>>>>>> uploading as I speak. Untested.
>>>>>>
>>>>>> This installs to "C:\Program Files\Git" and is not availiable on the
>>>>>> path. What is going on here please ?
>>>>>
>>>>> this uses the same buildscripts as before, so if it worked, it should
>>>>> still work. The path should point to $PF/Git/usr/bin/ ; you might
>>>>> need to
>>>>> log out and log in again for the path to visible.
>>>>
>>>> Still not working properly.
>>>>
>>>> From CMD.EXE, neither 'git clone' and 'git-clone' are accessable.
>
>>> - what is the value of the PATH variable in CMD ?
>>
>> Path=C:\Program
>> Files\GreenBorder\;C:\windows\system32;C:\windows;C:\windows\Sys
>> tem32\Wbem;C:\Program Files\ATI Technologies\ATI Control
>> Panel;c:\Program Files\
>> Microsoft SQL Server\90\Tools\binn\;C:\GnuWin32\bin;C:\Program
>> Files\QuickTime\Q
>> TSystem\;C:\Utils;C:\Program
>> Files\MakeMsi\;c:\MinGW\bin;C:\MinGW\usr\bin;C:\Pro
>> gram Files\Git\usr\bin;C:\Program Files\Git\usr\bin
>
> Can you troubleshoot this for me?  As you can see, you have
>
> C:\Program Files\Git\usr\bin
>
> in the path. That AFAIK should be enough to have git.exe run
> inside CMD.  Maybe I'm missing something, but that is as far as my
> windows knowledge goes.

Git runs, 'git init' runs, but 'git clone' or 'git-clone' do not.

'git init' reports it cannot find '/usr/share/git-core/templates/'

I have no idea whats wrong and do not have the time to try to debug it at 
present.

Aaron

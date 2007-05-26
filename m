From: "Aaron Gray" <angray@beeb.net>
Subject: Re: MinGW port updated to 1.5.2
Date: Sat, 26 May 2007 22:36:38 +0100
Message-ID: <001201c79fdd$f1b7eca0$0200a8c0@AMD2500>
References: <46569DA5.4F0EBF9A@eudaptics.com>  <4658922B.1010807@xs4all.nl> <001d01c79fd7$3d7f5ad0$0200a8c0@AMD2500>  <4658A01E.5060209@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <hanwen@xs4all.nl>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 26 23:37:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs3wn-0005kI-1A
	for gcvg-git@gmane.org; Sat, 26 May 2007 23:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbXEZVhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 17:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758676AbXEZVhJ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 17:37:09 -0400
Received: from lon1-mail-2.visp.demon.net ([193.195.70.5]:2532 "ehlo
	lon1-mail-2.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758298AbXEZVhI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2007 17:37:08 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-2.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FBZ29167 (AUTH angray);
	Sat, 26 May 2007 22:37:03 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48495>

> Aaron Gray escreveu:
>>>> GIT_EXTERNAL_DIFF works now.
>>>
>>> http://lilypond.org/git/binaries/mingw/
>>>
>>> uploading as I speak. Untested.
>>
>> This installs to "C:\Program Files\Git" and is not availiable on the
>> path. What is going on here please ?
>
> this uses the same buildscripts as before, so if it worked, it should
> still work. The path should point to $PF/Git/usr/bin/ ; you might need to
> log out and log in again for the path to visible.

Still not working properly.

>From CMD.EXE, neither 'git clone' and 'git-clone' are accessable.

>From MSYS '/usr/share/git-core/templates/' is not accessable.

    $ git clone git://git.kernel.org/pub/scm/git/git.git
    Initialized empty Git repository in C:/MSYS/home/Aaron Gray/git/.git/
    warning: templates not found /usr/share/git-core/templates/

Another issue is git-clone is no atomic if it fails it leaves an open file 
that can only be deleted by logging off and on again.

Aaron

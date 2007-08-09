From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Thu, 9 Aug 2007 08:38:33 +0200
Message-ID: <872D90BF-CB37-496B-9E7D-3C9A19125EBA@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <f99nm6$9vi$1@sea.gmane.org>  <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org>  <20070807145825.GO21692@lavos.net>  <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>  <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>  <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>  <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de> <2F00D32E-8D0C-48D6-86E1-6F6E7611E364@zib.de> <7E22DF40-1E28-4B8A-B132-18B05136B5E9@zib.de> <46BAADC8.9020003@trolltech.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 08:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ1eu-0007zh-67
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 08:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764316AbXHIGh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 02:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760565AbXHIGh6
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 02:37:58 -0400
Received: from mailer.zib.de ([130.73.108.11]:54929 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936579AbXHIGhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 02:37:51 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l796bl9B007362;
	Thu, 9 Aug 2007 08:37:47 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.247.82])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l796bjUJ022265
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 9 Aug 2007 08:37:46 +0200 (MEST)
In-Reply-To: <46BAADC8.9020003@trolltech.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55413>


On Aug 9, 2007, at 8:01 AM, Marius Storm-Olsen wrote:

>>> I have two 'crashes' during installation. I attached snapshots of
>>> the requesters. I don't know how to copy text from the installer.
>>> Therefore I attached snapshots.
>> Hmm... how do I get started? I naively chose cygwin as my shell. I
>> set
>> export PATH=$PATH:/cygdrive/c/msysgit/bin
>> then I tried
>> $ git clone git://git.kernel.org/pub/scm/git/git.git c:/msysgit/ 
>> bin/git-clone: line 214: git-init: command not found
>> Maybe it's related to the errors during installation?
>> How can I build and install git manually, based on the result of
>> GitMe-3's basic setup?
>
> Ok, first, which system is this? Windows 2000/XP/Vista?
> (The Gitme installer doesn't work on old ones for now)

XP 32bit.

> Try running gitme from a terminal. Download gitme-3.exe into C: 
> \temp, open a native terminal (Start - Run - Type "cmd" <enter>);  
> then in the terminal, type:
>     C:\temp> set PATH=%WINDIR%\system32;%WINDIR%
>     C:\temp> gitme-3

> Does it work then? If so, the problem is likely to be that you have  
> Cygwin in the system path, which is not advisable/compatible with  
> MSys.

I had cygwin at the tail of my PATH. After removing it the
installation went through flawlessly.

A check in the installer would be a good idea.

Would you recommend running git only from the mingw shell prompt,
or can I start it also from a Cygwin shell prompt?

Thanks a lot,

	Steffen

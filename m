From: Abdelrazak Younes <younes.a@free.fr>
Subject: Re: [msysgit] how to detect git.exe directory?
Date: Sun, 23 Dec 2007 20:45:34 +0100
Message-ID: <476EBADE.6080805@free.fr>
References: <e5bfff550712230825o5e73bd3dm31057847106b8722@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 20:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Wlx-0000cB-KB
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 20:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbXLWTpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 14:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbXLWTpk
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 14:45:40 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:49290 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbXLWTpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 14:45:40 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6D8E21AB339;
	Sun, 23 Dec 2007 20:45:38 +0100 (CET)
Received: from [192.168.0.1] (gre92-5-82-237-199-162.fbx.proxad.net [82.237.199.162])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 251871AB304;
	Sun, 23 Dec 2007 20:45:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712230825o5e73bd3dm31057847106b8722@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69193>

Marco Costalba wrote:
> Hi all,
> 
>    I'm progressing on qgit installer for windows, I have switched to
> MSVC for compiling Qt4 and qgit sources and I have to say that first
> results are very good, qgit.exe now seems to work without problems or
> artifacts and the speed is much more similar to what we achieve under
> the Linux platform (read much higher).

Glad you manage to do it by yourself. Sorry for not going further with 
compilation as I promised but the git repository had only a MSVC2008 
solution file and I have only MSVC2005 here. I tried to adapt our CMake 
files to qgit but failed...

> 
> So it seems Qt+mingw is not the _best_ possible solution.

I told you that ;-)

> 
> Anyhow, under Vista you cannot simply copy qgit.exe in the git
> directory (OS barfs regarding some administrative rights, note that *I
> am* the administartor!), so to make qgit.exe work git.exe file must be
> in PATH.
> 
> To easy the user and allowing to call qgit.exe double clicking on a
> nice desktop icon I need a way to know where git.exe is installed *at
> runtime*.
> 
> So my question is: "What is the preferred way to detect git directory
> at runtime for msysgit files?"

If you use QProcess to launch git, maybe you could just use 
QProcess::workingDirectory()?

Abdel.

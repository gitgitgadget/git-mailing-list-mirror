From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port updated to GIT 1.5.0
Date: Thu, 15 Feb 2007 20:14:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702152012490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D44FD5.72299A3A@eudaptics.com> <7vire3co5s.fsf@assigned-by-dhcp.cox.net>
 <7v7iujckmv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 20:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHm3l-0008Lb-Sg
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 20:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030706AbXBOTOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030705AbXBOTOW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 14:14:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:46726 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030703AbXBOTOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 14:14:21 -0500
Received: (qmail invoked by alias); 15 Feb 2007 19:14:19 -0000
X-Provags-ID: V01U2FsdGVkX1/IPiYwpmjIKud+3X6idnYo0pFj/L3x2nmAPjGEdz
	W5/w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v7iujckmv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39844>

Hi,

On Thu, 15 Feb 2007, Junio C Hamano wrote:

> However, I am not so sure if we can do better to help Windows people.  
> They have what they call "ShortCut", which to me feels like what they 
> use for what symlinks are used for.  I do not know if it is possible (I 
> do not even know doing so would make life easier for Windows people) but 
> perhaps a symlink can be "checked out" as a ShortCut?

This is exactly what Cygwin does. They revers-engineered the format of 
.lnk files.

I am not so sure if it is worth the effort, though, since .lnk files are 
handled as files even from Windows. At some point we have to admit that 
Windows does not love symlinks, and we don't love Windows.

Ciao,
Dscho

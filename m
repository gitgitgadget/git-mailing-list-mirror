From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sun, 11 Sep 2005 12:07:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Ellson <ellson@research.att.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 12:09:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEOkp-0001Wf-6O
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 12:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVIKKIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 06:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVIKKIA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 06:08:00 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40610 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964854AbVIKKH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 06:07:59 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AAC23D9FD0; Sun, 11 Sep 2005 12:07:58 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8696058F8E; Sun, 11 Sep 2005 12:07:58 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 65D2B58F76; Sun, 11 Sep 2005 12:07:58 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0E3C3D9FD0; Sun, 11 Sep 2005 12:07:58 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8288>

Hi,

On Fri, 26 Aug 2005, Junio C Hamano wrote:

> Are Darwin folks on the list happy with the current codebase, or
> have you given up because it is too GNU/Linux specific?

While I'm not exactly Darwin folk, I use git on Mac OS X 10.2.8 (I'm 
sitting behind a scary firewall, so don't even think about hacking me).

I have three fixes in my personal tree without which git refuses to 
compile:

- daemon.c needs a define or typedef for socklen_t.

- mailinfo.c needs to have a simple strcasestr implementation, because 
  10.2.8 (at least in my setup) is lacking it!

- gitk gets very confused about the window layout. My preliminary tests on 
  cygwin showed that this seems to be rather a problem of Tk with rootless 
  Xwin. I worked around it by explicitely stating the dimensions of some 
  canvas windows which would not automatically resize with their contents 
  otherwise.

The only thing I did not "fix" is git-cvsimport not running because of a 
lacking File/Temp.pm. But then, I run git-cvsimport on a different machine 
anyway.

I regularly use git on OS X and it works great!

Ciao,
Dscho

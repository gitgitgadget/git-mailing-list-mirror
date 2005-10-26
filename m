From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 18:46:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261844020.29044@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de>
 <86mzkwfh54.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510261725150.8507@wbgn013.biozentrum.uni-wuerzburg.de>
 <86irvkfg80.fsf@blue.stonehenge.com> <20051026161552.GA11483@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 18:51:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUoTt-0001dy-29
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 18:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVJZQt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 12:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVJZQt3
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 12:49:29 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:160 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964830AbVJZQt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 12:49:27 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C485813F3BF; Wed, 26 Oct 2005 18:49:26 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9A588B353C; Wed, 26 Oct 2005 18:49:26 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6CFF5B4E80; Wed, 26 Oct 2005 18:46:55 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CC28D13F321; Wed, 26 Oct 2005 18:46:45 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20051026161552.GA11483@delft.aura.cs.cmu.edu>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10679>

Hi,

On Wed, 26 Oct 2005, Jan Harkes wrote:

> Checking the SuSv2 manpage for link(2), it doesn't mention either of
> these error codes. But does mention EPERM as a valid error when the
> filesystem doesn't support hardlinks.
>     http://www.opengroup.org/onlinepubs/007908799/xsh/link.html
> 
> My local manual page for link(2) agrees with that definition,
> 
> 	EPERM  oldpath is a directory.
> 
> 	EPERM  The  filesystem  containing oldpath and newpath does not support
> 	       the creation of hard links.

On my iBook, connecting a USB stick (FAT formatted), link() sets 
errno=ENOTSUP. I checked the man page, and erroneously thought that they 
got it right.

*turns his eyes helplessly to the sky*

Ciao,
Dscho

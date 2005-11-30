From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] SVN import: Use one log call
Date: Tue, 29 Nov 2005 22:54:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511292247591.3122@localhost.localdomain>
References: <pan.2005.11.29.07.13.02.145977@smurf.noris.de>
 <7vhd9vdx1o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 04:55:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhJ3Q-0003LM-ER
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 04:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVK3DyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 22:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVK3DyZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 22:54:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58531 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750834AbVK3DyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 22:54:24 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IQR00MLI1ILLFG0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 Nov 2005 22:54:21 -0500 (EST)
In-reply-to: <7vhd9vdx1o.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12984>

On Tue, 29 Nov 2005, Junio C Hamano wrote:

> BTW, I've never successfully managed to run svnimport from my
> private svn repository.

Same here, with the following public repo: svn://mielke.cc/main/brltty

> $ git svnimport -v -i -t photocat http://127.0.0.1/svn/private main/sources
> 1: Unrecognized path: /main/sources
> 1: Unrecognized path: /main/in-place
> 1: Unrecognized path: /main
> ...
> 1500: Unrecognized path: /main/sources/photocat/db/catalog.sql
> 1501: Unrecognized path: /main/sources/photocat/data/035-maribon-making.yaml
> DONE; creating master branch
> cp: cannot stat `/var/tmp/try0/.git/refs/heads/origin': No such file or directory
> fatal: master: not a valid SHA1
> $ 

And I only get similar results.

> If your answer is "your repository layout is too weird and
> nonstandard, you are screwed", that is perfectly fine.  I do not
> want you to bend over backwards to butcher the import script to
> support it, if it is too nonstandard.

Thing is the above repository is not _that_ weird.  And with the real 
svn it produces a proper source tree of course, without any special 
options.  So I would think git-svnimport should be able to do the same.  
No?


Nicolas

From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-repack: Outof memory
Date: Sun, 17 Sep 2006 17:09:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609171707430.2627@xanadu.home>
References: <450CA561.9030602@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 23:09:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP3sy-0003Jz-6d
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 23:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWIQVJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 17:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWIQVJF
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 17:09:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45614 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965102AbWIQVJE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 17:09:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5R00J6E9F3ZSD0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 17 Sep 2006 17:09:03 -0400 (EDT)
In-reply-to: <450CA561.9030602@gmail.com>
X-X-Sender: nico@xanadu.home
To: Dongsheng Song <dongsheng.song@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27203>

On Sun, 17 Sep 2006, Dongsheng Song wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi all:
> 
> 
> I'm import from subversion. The problem appears to be git-repack phase using too many memory:
> 
> $ git-repack -a -f -d --window=64 --depth=64

Try with that --window=64 argument removed.


Nicolas

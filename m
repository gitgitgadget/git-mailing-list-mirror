From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 10:36:16 +0200
Message-ID: <200509301036.16887.oliver@neukum.org>
References: <433BC9E9.6050907@pobox.com> <200509292138.26183.oliver@neukum.org> <7vslvn6m6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 10:39:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELGOh-0005XB-Su
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 10:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVI3Iga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 04:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVI3Iga
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 04:36:30 -0400
Received: from mail1.kontent.de ([81.88.34.36]:56527 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932572AbVI3Ig3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 04:36:29 -0400
Received: from p549A2192.dip0.t-ipconnect.de (p549A2192.dip0.t-ipconnect.de [84.154.33.146])
	by Mail1.KONTENT.De (Postfix) with ESMTP id 5282E100E50E;
	Fri, 30 Sep 2005 10:36:21 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vslvn6m6y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9549>

Am Freitag, 30. September 2005 09:37 schrieb Junio C Hamano:
> Oliver Neukum <oliver@neukum.org> writes:
> 
> > Am Donnerstag, 29. September 2005 21:34 schrieb Jon Loeliger:
> >> On Thu, 2005-09-29 at 14:08, Oliver Neukum wrote:
> >> 
> >> > Unfortunately, following the instructions to the letter produces this:
> >> > oliver@oenone:~/linux-2.6> git checkout
> >> > usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])
> >> 
> >> Yeah.  See if you still have a .git/HEADS that symlinks
> >> to a valid place or not...?
> >
> > oliver@oenone:~/linux-2.6> ls -la .git/
> > insgesamt 14
> > drwxrwxr-x    6 oliver users  224 2005-09-29 21:06 .
> > drwxr-xr-x    3 oliver users   72 2005-09-29 20:45 ..
> > -rw-rw-r--    1 oliver users   19 2005-05-02 01:02 description
> > lrwxrwxrwx    1 oliver users   17 2005-09-29 21:06 HEAD -> refs/heads/master
> > -rw-------    1 oliver users   32 2005-09-29 21:06 index
> 
> I wonder what that 32-byte small file called 'index' is doing
> there.  If this is the kernel tree, its index file should weigh
> about 1.7MB if I recall correctly.

I have no idea, but the instructions as stated didn't work for me.
Can you replicate that?

	Regards
		Oliver

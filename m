From: Johan Herland <johan@herland.net>
Subject: Re: Extra metadata in the commit?
Date: Sat, 25 Apr 2009 14:08:22 +0200
Message-ID: <200904251408.22410.johan@herland.net>
References: <d411cc4a0904241547p64c0af2bycae20cd4b26e43f6@mail.gmail.com>
 <alpine.DEB.1.00.0904250154080.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 14:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxgkl-0001Im-FD
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 14:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbZDYMLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 08:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZDYMLb
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 08:11:31 -0400
Received: from mx.getmail.no ([84.208.15.66]:44719 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752366AbZDYMLb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 08:11:31 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIN00GLQOJ51860@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 25 Apr 2009 14:11:29 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIN00C9POG4K8Z0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 25 Apr 2009 14:11:29 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.4.25.113425
User-Agent: KMail/1.11.2 (Linux/2.6.29-ARCH; KDE/4.2.2; x86_64; ; )
In-reply-to: <alpine.DEB.1.00.0904250154080.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117552>

On Saturday 25 April 2009, Johannes Schindelin wrote:
> On Fri, 24 Apr 2009, Scott Chacon wrote:
> > So, I can keep this data in the commit message, but I thought it
> > would be cleaner to keep it as extra fields in the commit object before
> > the "\n\n" separator.
>
> I'd suggest keeping it in the commit body, for better visibility and
> easier handling by tools.

Or even better: Keep it in separate commit notes (provided you can wait for 
the js/notes topic in pu to make it into a release). If you add the notes 
with GIT_NOTES_REF=refs/notes/hg_metadata, you will also keep them nicely 
out of the way of everybody else.

(I'm using this approach when building a bidirectional CVS <-> Git helper on 
top of Barkalow's foreign-scm topic).


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

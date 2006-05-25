From: Sean <seanlkml@sympatico.ca>
Subject: Re: Clean up sha1 file writing
Date: Wed, 24 May 2006 20:31:08 -0400
Message-ID: <BAYC1-PASMTP1121D710ADAA95C7B2D8E4AE990@CEZ.ICE>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org>
	<7vslmz5ewt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605241631340.5623@g5.osdl.org>
	<7virnv3qi6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 02:37:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj3qg-0006Qm-Ac
	for gcvg-git@gmane.org; Thu, 25 May 2006 02:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWEYAhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 20:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWEYAhG
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 20:37:06 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:55743 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S964796AbWEYAhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 20:37:05 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 24 May 2006 17:41:59 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 8E79D644C17;
	Wed, 24 May 2006 20:37:03 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060524203108.70b6c596.seanlkml@sympatico.ca>
In-Reply-To: <7virnv3qi6.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 May 2006 00:41:59.0828 (UTC) FILETIME=[08547D40:01C67F94]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 24 May 2006 17:19:29 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Wed, 24 May 2006, Junio C Hamano wrote:
> >>
> >> It was very pleasant to read the changes that way, especially around 
> >> write_sha1_to_fd() vs repack_object().  xxdiff is my new friend.
> >
> > I think "kompare" (the KDE diff tool) is nicer.
> 
> I'd love to give it a whirl, but aptitude says it will consume
> 73.5MB diskspace to install it, with download size 22.4MB, which
> makes me go ... hmmmm (my machines are currently KDE free so the
> above counts slurping in the kdelibs essentials).  
> 

"meld" works great too, and lets you do hunk-level merging etc; very
handy.  The bash <( ... )  feature is quite handy too, it will create
a temp file for you and clean it up afterward.

$ meld sha1_file.c <(git cat-file -p c2f493a4ae:sha1_file.c)

Sean

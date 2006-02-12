From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] binary-tree-based objects.
Date: Sat, 11 Feb 2006 23:05:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602112301170.3691@g5.osdl.org>
References: <87slqpg11q.fsf@wine.dyndns.org> <Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
 <7vslqpi9mg.fsf@assigned-by-dhcp.cox.net> <7vhd75fc6y.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602112045340.3691@g5.osdl.org> <Pine.LNX.4.64.0602112117560.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 08:05:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8BIP-0001rP-Am
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 08:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWBLHFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 02:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWBLHFM
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 02:05:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932297AbWBLHFL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 02:05:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1C757DZ008383
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 23:05:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1C756W5029473;
	Sat, 11 Feb 2006 23:05:06 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602112117560.3691@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15988>



On Sat, 11 Feb 2006, Linus Torvalds wrote:
> 
> Before:
> 	real    0m41.322s	user    0m40.612s	sys     0m0.492s
> After:
> 	real    0m22.542s	user    0m22.080s	sys     0m0.448s
Johannes:
	real    0m13.814s	user    0m13.492s	sys     0m0.296s

> And just so you wouldn't think that all my machines are slow..
> 
> Before:
> 	real    0m28.645s	user    0m28.366s	sys     0m0.280s
> After:
> 	real    0m16.566s	user    0m16.373s	sys     0m0.196s
Johannes:
	real    0m10.239s	user    0m10.029s	sys     0m0.208s

So the hashing thing is indeed the clear winner.

Make it so. 

		Linus

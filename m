From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 13:19:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRXN-0000Ct-C3
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbXBNVTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbXBNVTe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:19:34 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46293 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932621AbXBNVTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:19:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1ELJUhB016284
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 13:19:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1ELJTSP009447;
	Wed, 14 Feb 2007 13:19:30 -0800
In-Reply-To: <17875.30687.661794.512124@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.409 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39752>



On Wed, 14 Feb 2007, Bill Lear wrote:
>
> I forgot to mention that fsck in my original public repo looks fine:
> 
> % cd /repos/git/fus
> 
> [with 1.4.4.1]
> % GIT_DIR=. /usr/bin/git fsck-objects --full
> dangling commit 828c0a0649d2d6b43ed13853bba33f7764f034fa
> 
> [with 1.5.0]
> % GIT_DIR=. git fsck-objects --full
> dangling commit 828c0a0649d2d6b43ed13853bba33f7764f034fa

Ahh. So it's literally just the clone that fails?

What happens if you do *just*

	git clone /repos/git/fus new
	cd new
	git fsck --full

and nothing else?

		Linus

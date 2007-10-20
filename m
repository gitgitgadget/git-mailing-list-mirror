From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Allow gitk to start on Cygwin with native Win32 Tcl/Tk
Date: Sat, 20 Oct 2007 21:39:45 +1000
Message-ID: <18201.59649.800748.780690@cargo.ozlabs.ibm.com>
References: <20070922050446.GA28467@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <shawn.o.pearce@bankofamerica.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 13:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IjCly-0002YS-79
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 13:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbXJTLk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 07:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbXJTLk3
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:40:29 -0400
Received: from ozlabs.org ([203.10.76.45]:58981 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755397AbXJTLk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 07:40:29 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B5A67DDEAB; Sat, 20 Oct 2007 21:40:27 +1000 (EST)
In-Reply-To: <20070922050446.GA28467@spearce.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61824>

Shawn O. Pearce writes:

>  Yes, I admit this is an odd patch.  I can certainly carry it in
>  my own tree (I already carry some other patches) but I wonder if
>  we shouldn't include it as some users may actually try to do this,
>  just like I did.  Latest git-gui `master` already has changes to its
>  Makefile and shell startup boilerplate to handle this weird case.

Why do you need to change gitk itself?  If you're going to modify it
with sed, why can't you change the $0 on the 3rd line to the installed
path of the gitk script?

Paul.

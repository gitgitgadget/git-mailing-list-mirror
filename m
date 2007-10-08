From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 8 Oct 2007 11:27:04 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710081126340.4964@woody.linux-foundation.org>
References: <11917040461528-git-send-email-shawn.bohrer@gmail.com>
 <20071008020435.GA20050@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710071916510.23684@woody.linux-foundation.org>
 <20071008022205.GA21277@coredump.intra.peff.net>
 <4709D027.3090003@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Bohrer <shawn.bohrer@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:28:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IexL3-0007jf-O9
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 20:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbXJHS2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbXJHS2L
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 14:28:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33073 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755463AbXJHS2K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 14:28:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l98IR9MC027171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2007 11:27:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l98IR4FF012995;
	Mon, 8 Oct 2007 11:27:05 -0700
In-Reply-To: <4709D027.3090003@viscovery.net>
X-Spam-Status: No, hits=-4.739 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60330>



On Mon, 8 Oct 2007, Johannes Sixt wrote:

> Jeff King schrieb:
> > On Sun, Oct 07, 2007 at 07:17:50PM -0700, Linus Torvalds wrote:
> > 
> > > fchdir() is not portable.
> > 
> > I was using the "even Solaris has it!" test, but yes, it's not POSIX. I
> > don't know how common it actually is (for curiosity's sake, do you know
> > of a common platform that lacks it?).
> 
> Windows. ;)

Not just windows. Almost no "older" Unix has it. Including older versions 
of Linux.

		Linus

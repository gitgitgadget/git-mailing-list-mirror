From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [PATCH 31/49] PCI: PCI/Cardbus cards hidden, needs
 pci=assign-busses to fix
Date: Thu, 23 Mar 2006 17:51:26 -0800
Message-ID: <20060323175126.7ff71032.akpm@osdl.org>
References: <20060323161521.28a874e6.akpm@osdl.org>
	<20060324002930.GA21184@kroah.com>
	<20060323163844.5fda7589.akpm@osdl.org>
	<20060324004654.GA19763@kroah.com>
	<7vbqvw3a62.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: greg@kroah.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 02:49:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMbR0-00054e-87
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 02:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWCXBtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 20:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCXBtL
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 20:49:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751211AbWCXBtK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 20:49:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2O1n5DZ001872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Mar 2006 17:49:05 -0800
Received: from akpm.pao.digeo.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k2O1n46H018927;
	Thu, 23 Mar 2006 17:49:04 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqvw3a62.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17896>

Junio C Hamano <junkio@cox.net> wrote:
>
> The second best would be to add the duplicated From: to name the
> author (who is _not_ you) to the top of the body of the message.
> I do not particularly like that format myself, though.  Sender:
> header was invented to send an e-mail authored by somebody other
> than the sender of the message at the mail transport level, long
> before Documentation/SubmittingPatches were written and git was
> invented, and somehow I think that is a more kosher way to
> handle that than the "extra From: at the beginning of the
> message" clutch recommended in SubmittingPatches document.  

The email I received from Greg had no Sender: header at all.  I could find
no indication of who authored the patch in that email.

The convention of adding the From: to the top of the body of the changelog
is explicit and simple - I think it's a reasonable thing to do.

We wouldn't want to attempt to mix this concept up with email envelopes or
email headers or anything like that.  The authorship is an attribute of the
patch, and has nothing to do with how it was transported, stored or
anything like that.

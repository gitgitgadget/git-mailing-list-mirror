From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Wed, 12 Jul 2006 09:37:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607120931150.5623@g5.osdl.org>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
 <44B37893.5090501@innova-card.com> <7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
 <44B4A6CA.3020206@innova-card.com> <Pine.LNX.4.64.0607120834200.5623@g5.osdl.org>
 <7v1wsqzt8f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 12 18:38:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0hiw-0006dz-Ss
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 18:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWGLQhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGLQhv
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 12:37:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751331AbWGLQhu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 12:37:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6CGbhnW024009
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 09:37:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6CGbgcG014472;
	Wed, 12 Jul 2006 09:37:43 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wsqzt8f.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23791>



On Wed, 12 Jul 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> >
> > A number of people end up capitalizing the sign-off differently, so you 
> > have lines like "Signed-Off-By: Xy Zzy <xyzzy@example.org>".
> 
> Documentation/SubmittingPatches (the kernel one) does not show
> the ugly Camel-Case-With-Hyphen spelling, and I've been wondring
> why people do that.

Yeah, I actually try to edit it to the "proper" format when I notice it 
(which is not most of the time, but it's pretty rare to begin with).

More commonly, people mistype their own email addresses, and 
_occasionally_ just mis-type the whole Signed-off-by: line (we've got a 
few semi-colons instead of colons in the kernel, for example, and some 
lines that are missing the final '>' in the email etc.

So being somewhat forgiving might help, but I think another thing that 
migth help is a flag to "git-am" to _not_ apply a patch that lacks a 
previous sign-off.

I, for example, don't use the --signoff flag, partly because I want to 
make sure that I sign of only on patches that already have a sign-off from 
the previous person when it comes as email (or I add the sign-off only 
after looking at the patch closely). But if there was a 
"--error-on-no-signoff" flag, I could use it.

			Linus

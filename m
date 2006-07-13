From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Wed, 12 Jul 2006 21:40:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607122139090.5623@g5.osdl.org>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
 <44B37893.5090501@innova-card.com> <7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
 <44B4A6CA.3020206@innova-card.com> <Pine.LNX.4.64.0607120834200.5623@g5.osdl.org>
 <7v1wsqzt8f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607120931150.5623@g5.osdl.org>
 <7vac7exgvs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 06:41:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0t0k-0004Mo-Kd
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 06:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWGMEkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 00:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWGMEkv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 00:40:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932498AbWGMEkv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 00:40:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6D4eknW006798
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 21:40:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6D4ek8O010527;
	Wed, 12 Jul 2006 21:40:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac7exgvs.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23810>



On Wed, 12 Jul 2006, Junio C Hamano wrote:
> 
> How about having this in $GIT_DIR/hooks/applypatch-msg?
> 
> 	#!/bin/sh
> 	grep '^Signed-off-by: ' "$1" >/dev/null

Not good, because then I have no way to select a different behaviour with 
a flag. If I decide it was ok to apply (say, it's just a silly typo fix), 
I would want to say so.

		Linus

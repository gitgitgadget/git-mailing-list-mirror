From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Tue, 7 Aug 2007 20:07:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708072004150.23971@woody.linux-foundation.org>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
 <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site>
 <20070803053717.GA16379@midwinter.com> <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
 <7v4pjc9czm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 05:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIbtU-00007U-6a
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 05:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758287AbXHHDH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 23:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758048AbXHHDH3
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 23:07:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46302 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757339AbXHHDH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 23:07:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7837Hq8006120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Aug 2007 20:07:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l78378pu017858;
	Tue, 7 Aug 2007 20:07:09 -0700
In-Reply-To: <7v4pjc9czm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-4.722 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55294>


[ Slow at responding to email, sorry ]

On Mon, 6 Aug 2007, Junio C Hamano wrote:
> 
> That's essentially the patch I sent out in another thread allows
> you to do, and some of these people even Acked them, but there
> is one minor issue.  "git diff" output is paged, and that "not
> up to date" warning, if it is given to stderr, would not be
> usually seen.

I agree. I wouldn't send it to stderr, I'd literally make it part of the 
output.

Everybody who takes patches will accept crud afterwards, since the normal 
thing is to email them around, so there's no real downside to adding some 
status output at the end. It shouldn't screw anything up, but people will 
hopefully notice (sure, if you exit the pager without looking at it all 
you wouldn't notice, but that's _already_ true, so..)

		Linus

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 20:49:59 +0200
Message-ID: <20070520184959.GA25462@steel.home>
References: <20070520181447.GA10638@ferdyx.org> <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqTr-00067U-JO
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbXETSuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbXETSuE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:50:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:35966 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbXETSuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:50:03 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (fruni mo35) (RZmta 6.5)
	with ESMTP id E025cej4KEd3QR ; Sun, 20 May 2007 20:49:59 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B1C1B277BD;
	Sun, 20 May 2007 20:49:59 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6AE64D195; Sun, 20 May 2007 20:49:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47885>

Junio C Hamano, Sun, May 20, 2007 20:36:25 +0200:
> > +IMPORTANT: Maildir splitting relies upon filenames being sorted to output
> > +patches in the correct order.
> 
> I am sure there are many users who uses Maildir layout on this
> list.  Happy with this patch?  Please speak out.

I do use maildirs, but I have a suggestion: --maildir or something, to
create a non-existing maildir and split into it, so that the user does
not have to pre-create it.

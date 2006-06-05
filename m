From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Horrible re-packing?
Date: Mon, 5 Jun 2006 12:57:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606051256280.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org> <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
 <7vy7wb4cmy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 21:57:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnLCb-0001Fh-2Y
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 21:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWFET50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 15:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWFET50
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 15:57:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751345AbWFET50 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 15:57:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k55JvB2g006733
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 12:57:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k55JvAof022597;
	Mon, 5 Jun 2006 12:57:10 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7wb4cmy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21333>



On Mon, 5 Jun 2006, Junio C Hamano wrote:
> 
> IIRC, sometimes this function is called with path and name split
> and sometimes with full path in name

Yeah, I was pretty confused by the whole hashing thing. Are you sure that 
complexity is needed, it seems a bit overkill.

		Linus

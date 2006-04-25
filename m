From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 12:34:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251233340.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
 <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
 <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
 <BAYC1-PASMTP03E0B5376ACFF165B29ED1AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251155530.3701@g5.osdl.org>
 <7vslo1v4zw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 21:34:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYTIz-0007Pl-3E
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 21:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWDYTee (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 15:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWDYTed
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 15:34:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932123AbWDYTed (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 15:34:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PJYStH020734
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 12:34:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PJYPqF002211;
	Tue, 25 Apr 2006 12:34:27 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslo1v4zw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19173>



On Tue, 25 Apr 2006, Junio C Hamano wrote:
> 
> Then we should drop the author header and make it part of free
> form text.  The core does not give any meaning to it.

Sure it does. It's an integral part of logging: we not only verify the 
format, we also have multiple different ways of showing it. So it 
definitely changes the way we "act", very fundamentally.

		Linus

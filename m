From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Tue, 24 May 2005 01:31:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505240129420.2307@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
 <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
 <7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
 <Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
 <Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org> <7vbr71xjyt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505232314510.2307@ppc970.osdl.org> <7vll65vy10.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaUyC-0007M5-VO
	for gcvg-git@gmane.org; Tue, 24 May 2005 10:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVEXIlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 04:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVEXIaS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 04:30:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:59808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbVEXI3z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 04:29:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O8TmjA000932
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 01:29:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O8TlTE016478;
	Tue, 24 May 2005 01:29:48 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll65vy10.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Junio C Hamano wrote:
> 
> OK, so the short version is, diff-cache like optimization may be
> interesting to try out, but practically it would not be much
> useful anyway, so I should do it if I am really bored and have
> nothing else interesting to do ;-).

Yup. I think it's more important to get the rest calmed down again, and 
fix the things that got broken. Sadly, "git-whatchanged -s" was one such 
thing.

(I think that's just because the "silent" test used to depend on the 
magical behaviour of the "header" thing, and now that the header 
generation and suppression is sane, "silent" doesn't work any more)

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH Cogito] Fix cg-log -f behavior
Date: Thu, 26 May 2005 15:13:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505261512420.2307@ppc970.osdl.org>
References: <1117137826.12036.57.camel@pegasus> <7vk6llbv1j.fsf@assigned-by-dhcp.cox.net>
 <1117139740.12036.59.camel@pegasus> <7voeaxae0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marcel Holtmann <marcel@holtmann.org>, Petr Baudis <pasky@ucw.cz>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 00:10:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbQXu-00072r-OJ
	for gcvg-git@gmane.org; Fri, 27 May 2005 00:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVEZWLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 18:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVEZWLb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 18:11:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:49890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261829AbVEZWL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 18:11:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4QMBDjA008131
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 15:11:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4QMBCtY016975;
	Thu, 26 May 2005 15:11:12 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voeaxae0r.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Junio C Hamano wrote:
> 
> The suggestion I made this morning is to make ls-tree and
> ls-files use SP inside metadata and TAB before path.  If we
> can agree on that is the way to go, then the output from these
> commands would become:

Yes, let's make it so.

		Linus

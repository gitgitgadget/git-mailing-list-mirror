From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Add support for external programs for handling native
  fetches
Date: Sat, 25 Jul 2009 14:14:33 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907251414140.3960@localhost.localdomain>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>  <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain> <f488382f0907251408q383a7789l5342c7ec41b402a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 23:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoZq-0007FR-L8
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZGYVOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZGYVOj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:14:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54520 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752414AbZGYVOj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 17:14:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PLEXZI020126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Jul 2009 14:14:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PLEXxf026352;
	Sat, 25 Jul 2009 14:14:33 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <f488382f0907251408q383a7789l5342c7ec41b402a@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.959 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124075>



On Sat, 25 Jul 2009, Steven Noonan wrote:
> 
> But more importantly, how fast can your machine compile the kernel?
> (without ccache or any "cheats" like that, of course)

Without ccache? One minute. With ccache? 16 seconds.

		Linus

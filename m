From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log: add '--merges' flag to match '--no-merges'
Date: Mon, 29 Jun 2009 11:15:18 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906291112520.3605@localhost.localdomain>
References: <alpine.LFD.2.01.0906291015210.3605@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 29 20:16:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLLOV-0005V6-7q
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 20:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003AbZF2SPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 14:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbZF2SPm
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 14:15:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53140 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757892AbZF2SPl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 14:15:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5TIFJJJ007198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2009 11:15:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5TIFITZ022497;
	Mon, 29 Jun 2009 11:15:18 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0906291015210.3605@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122451>



On Mon, 29 Jun 2009, Linus Torvalds wrote:
> 
> So this just adds a '--merges' flag that _only_ shows merges.

Side note: if somebody wants to make this flag be called "--merges-only", 
and then adds a "--merges" flag that clears both the no_merges and 
merges_only flag, I wouldn't complain. That _might_ be useful to override 
default behaviour (say, if some alias/command were to default to not 
showing merges, then adding "--merges" would make it show all commits).

Dunno. I don't personally much care, but I thought I'd mention it as an 
alternative approach to this issue.

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Really fix git-merge-one-file-script this time.
Date: Sun, 1 May 2005 14:42:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505011441140.2296@ppc970.osdl.org>
References: <7vd5sbz436.fsf@assigned-by-dhcp.cox.net> <7vzmveu6zs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505011312080.2296@ppc970.osdl.org> <7vsm16sl0q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:37:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSM7x-00027W-Fe
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVEAVmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVEAVml
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:42:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:21702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262744AbVEAVk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 17:40:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41Leqs4032394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 14:40:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41LepKO031675;
	Sun, 1 May 2005 14:40:51 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm16sl0q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Junio C Hamano wrote:
> 
> Let me make sure I understand you correctly before I go
> further.  In the above sentence, do you mean a merge that is
> _successful_ by merges that:
> 
>     (1) "git-remove-tree -m" considers them trivial;
> 
> or
>     (2) in addition to (1), "git-merge-one-file-script"
>         considers them trivial.  That is, only one-side changes
>         or removes or adds it, or both sides adds it
>         identically, or merge/diff3 merges without conflict.

(2).

But in the more general case _any_ automated merge is the "uninteresting" 
case (except for the fact that we hope for them ;)

In other words, I want this case really designed for the situation where 
automation (_any_ kind) breaks down. 

			Linus

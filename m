From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Last mile for 1.0
Date: Sun, 5 Jun 2005 17:02:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 01:58:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df4zj-0002lO-RN
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 01:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFFAAs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 20:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVFFAAs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 20:00:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:39078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261158AbVFFAAm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 20:00:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5600bjA032350
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 17:00:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5600aml029921;
	Sun, 5 Jun 2005 17:00:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 5 Jun 2005, Junio C Hamano wrote:
> 
>  - Tutorials you have been working on.  I'd appreciate it if my
>    earlier "what about cvs annotate" example *3* finds its home
>    somewhere in that document ;-).

My main dislike about that was that I don't think -S is "better" than
annotate as you claim - I think it's different and can be better in many
circumstances, but I don't like the notion of telling a new user "you
don't want annotate, pickaxe is better".

Let's just be upfront about some things being missing, and suggest
alternatives. A lot of times, just "git-whatchanged -p filename" ends up
being sufficient, at other times -S might be.

Finally, please send it as a patch, that way the authorship etc stuff gets 
done right.

>  - "What happens when a merge goes wrong" helper script Jeff
>    wanted to have in *4*.

Does anybody have any suggestions? Preferably with a reasonable 
test-case, so that people can try it out.. Maybe just leaving the merge 
failures where they are?

		Linus

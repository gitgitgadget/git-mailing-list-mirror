From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log follow question
Date: Fri, 14 May 2010 08:29:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005140827250.3711@i5.linux-foundation.org>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au>  <20100514043704.GC6075@coredump.intra.peff.net> <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org> <AANLkTimfuINt0v_SETz9NsMGVXDL9d150B8En4TKqw3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Albert Krawczyk <albert@burgmann.anu.edu.au>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 17:31:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCwrb-0003qK-3x
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 17:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab0ENPbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 11:31:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33455 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140Ab0ENPbk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 11:31:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4EFVTg1028403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 May 2010 08:31:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4EFVSaR006882;
	Fri, 14 May 2010 08:31:29 -0700
In-Reply-To: <AANLkTimfuINt0v_SETz9NsMGVXDL9d150B8En4TKqw3b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.445 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147092>



On Fri, 14 May 2010, Martin Langhoff wrote:
> 
> The use case for this is: "Where the hell does this WTF-worthy
> function come from, in this WTF-esque old codebase I just inherited?"

Umm. And git does that better than anything else. 

"git log --follow" works fine. As does "git blame -C".

It's just that gitk does not, because it wants to show the graph.

Anyway, if you feel strongly about it, and really want "gitk --follow", 
you really need to do it yourself. I gave you some pointers. I personally 
don't think it's worth it.

		Linus

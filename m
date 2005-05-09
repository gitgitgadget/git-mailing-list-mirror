From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Prototype git commit viewer
Date: Mon, 09 May 2005 20:50:04 +0200
Message-ID: <m3fywwjktf.fsf@defiant.localdomain>
References: <17022.49021.344841.79940@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 20:55:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVDDi-0000Uq-QJ
	for gcvg-git@gmane.org; Mon, 09 May 2005 20:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVEISuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 14:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVEISuT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 14:50:19 -0400
Received: from khc.piap.pl ([195.187.100.11]:33540 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261487AbVEISuO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 14:50:14 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 67E1F107C0; Mon,  9 May 2005 20:50:05 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17022.49021.344841.79940@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Mon, 9 May 2005 11:40:13 +1000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Over the weekend I hacked up a prototype viewer for git commits in
> Tk.  It's called gitk and is at:
>
> 	http://ozlabs.org/~paulus/gitk

Nice. I wonder how well would it work with a longer history, say all
linux-2.[56] data. It takes gitk ~ 10 seconds to read ~ 1000 Linux
commits from cache now, on my system.

In fact I'm thinking about something working with WWW browser. I've
written a very simple experimental show-tree tool in C and it seems
reading current Linux tree (no HTTP output yet) takes 0.065s with it.

Now I'm thinking about output language. (X)HTML seems to be not
capable (I'm not HTML expert, please correct me if I'm wrong).

Any idea of what can I use?

(will post the source if there is interest)
-- 
Krzysztof Halasa

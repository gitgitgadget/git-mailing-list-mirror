From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Fix cygwin install issues
Date: Mon, 10 Oct 2005 11:03:42 +0200
Message-ID: <20051010090342.GB18009@diku.dk>
References: <20051010085259.GA18009@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 11:05:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOtZZ-0006tj-BI
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 11:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVJJJDu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 05:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVJJJDt
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 05:03:49 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:756 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750706AbVJJJDq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 05:03:46 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id CEC296E1000; Mon, 10 Oct 2005 11:03:31 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7BA6A6E0A5D; Mon, 10 Oct 2005 11:03:29 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2684360FBE; Mon, 10 Oct 2005 11:03:43 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20051010085259.GA18009@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9879>

Jonas Fonseca <fonseca@diku.dk> wrote Mon, Oct 10, 2005:
> Support installing to paths including spaces.
> Remove any old .exe files so ln will succeed.

I see that there are problems in the git porcelain commands that needs
to also be fixed so please ignore this for now.

Instead, is this something that should be supported? (It is quite
absurd, although it is required for 'make install' to work out of the
box on some systems).

-- 
Jonas Fonseca

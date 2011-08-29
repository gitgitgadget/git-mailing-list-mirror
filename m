From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Mon, 29 Aug 2011 15:32:32 +0200
Message-ID: <1314624752.2816.32.camel@twins>
References: <4E56CE8F.8080501@panasas.com>
	 <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>
	 <4E580830.4010305@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 15:32:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy1xI-0006iK-Ca
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 15:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab1H2Ncn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 09:32:43 -0400
Received: from casper.infradead.org ([85.118.1.10]:35488 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1H2Ncl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 09:32:41 -0400
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1Qy1x3-0001ML-0h; Mon, 29 Aug 2011 13:32:33 +0000
Received: by twins (Postfix, from userid 1000)
	id 38B2481B0D2C; Mon, 29 Aug 2011 15:32:32 +0200 (CEST)
In-Reply-To: <4E580830.4010305@panasas.com>
X-Mailer: Evolution 3.0.2- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180310>

On Fri, 2011-08-26 at 13:55 -0700, Boaz Harrosh wrote:

> But this patch is for all the people and distributions that are going
> to use the old git versions for a while, (Years).
> 
> It is important for the Linux mailing-list review, because you get
> patches with:
> 
> @@@ lable out:
> -	change foo
> +	to bazz
> 
> And how the hell are you suppose to know where in the file it is.
> This is such a trivial addition, that can help unify everyone's
> usage. I don't see the down sides.

Ah, I'm using:

# cat ~/.gitconfig 
[diff "default"]
                xfuncname = "^[[:alpha:]$_].*[^:]$"


For this.

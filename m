From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Git-commits mailing list feed.
Date: Thu, 21 Apr 2005 22:23:55 +1000
Message-ID: <1114086237.29135.24.camel@localhost.localdomain>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
	 <1114079347.6277.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu Apr 21 14:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOafL-00062c-GG
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 14:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVDUMYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 08:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVDUMYl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 08:24:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2479 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261151AbVDUMYi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 08:24:38 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DOajU-0005cw-Hw; Thu, 21 Apr 2005 13:24:37 +0100
To: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1114079347.6277.29.camel@laptopd505.fenrus.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-21 at 12:29 +0200, Arjan van de Ven wrote:
> with BK this was not possible, but could we please have -p added to the
> diff parameters with git ? It makes diffs a LOT more reasable!

With BK this was not possible, but could you please provide your
criticism in 'diff -up' form?

I've done 'perl -pi -e s/-u/-up/ gitdiff-do' as a quick hack to provide
what you want, but a saner fix to make gitdiff-do obey the same
GIT_DIFF_CMD and GIT_DIFF_OPTS environment variables as show-diff.c
would be a more useful answer.

-- 
dwmw2


From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 12:13:13 +0100
Message-ID: <1114859594.24014.60.camel@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	 <42730061.5010106@zytor.com>
	 <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	 <20050430125333.2bd81b18.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 13:09:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRpqs-0004By-VB
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 13:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVD3LPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 07:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVD3LPT
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 07:15:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35248 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261198AbVD3LPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 07:15:13 -0400
Received: from shinybook.infradead.org ([81.187.226.99])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRpw0-0006Ve-6H; Sat, 30 Apr 2005 12:14:57 +0100
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20050430125333.2bd81b18.froese@gmx.de>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-30 at 12:53 +0200, Edgar Toernig wrote:
> +       tm = localtime(&now); /* get timezone and tm_isdst */
> +       offset = -timezone / 60;
> +       if (tm->tm_isdst > 0)
> +               offset += 60;

Some locales have DST offsets which aren't 60 minutes, don't they?

-- 
dwmw2


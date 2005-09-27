From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 1/3] Support for SSL client cert
Date: Mon, 26 Sep 2005 17:15:42 -0700
Message-ID: <20050927001542.GC15615@reactrix.com>
References: <20050926175156.GB9410@reactrix.com> <20050926182341.GA26340@pasky.or.cz> <7v3bnrh85g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 02:17:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK38r-0004NQ-EP
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 02:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVI0AQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 20:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVI0AQA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 20:16:00 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:4743 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964775AbVI0AP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 20:15:59 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8R0FhSv017385;
	Mon, 26 Sep 2005 17:15:43 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8R0FgZB017383;
	Mon, 26 Sep 2005 17:15:42 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bnrh85g.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9357>

On Mon, Sep 26, 2005 at 01:43:39PM -0700, Junio C Hamano wrote:

> That is a valid concern.
> 
> Anoter possibility is to read them from the environment, since
> we already do SSL_NO_VERIFY from there.

Good point - use of environment variables is more consistent.  Use of
command-line arguments is a bit more convenient in my case since I'm
driving the transfer from a perl script, but I suppose consistency is
more important...

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.

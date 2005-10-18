From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb.cgi
Date: Tue, 18 Oct 2005 13:07:25 +0200
Message-ID: <20051018110725.GB6929@vrfy.org>
References: <43546492.3020401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 13:08:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERpJs-00024a-Rs
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 13:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbVJRLH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 07:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVJRLH3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 07:07:29 -0400
Received: from soundwarez.org ([217.160.171.123]:29092 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750834AbVJRLH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 07:07:28 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id DCA6662E64; Tue, 18 Oct 2005 13:07:25 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43546492.3020401@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10211>

On Mon, Oct 17, 2005 at 07:57:22PM -0700, H. Peter Anvin wrote:
> It is increasingly clear that gitweb.cgi is producing an unacceptable 
> load on the kernel.org servers.

Sure, sorry, was on 3 conferences in a row the last weeks.

> Most of the hits we get are either the 
> gitweb front page or the gitweb rss feeds, and it's eating I/O bandwidth 
> like crazy.

I tested some stuff on these boxes and 30 stat() calls alone take app. 2 seconds
on these boxes cause of I/O load ... :)

> This has become particularly painful during the current one-server outage.
> 
> Kay, gitweb really needs to be able to do caching, or be run behind a 
> caching proxy.  Otherwise I will have to turn it off until we can come 
> up with a dedicated piece of server hardware for it.

How about Apache's mod_cache? Worked nicely for me several times in other
setups.

Kay

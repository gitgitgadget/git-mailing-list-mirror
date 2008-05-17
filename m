From: Nikolaus Schulz <microschulz@web.de>
Subject: Re: partial globbing in fetch refspecs broken in v1.5.5
Date: Sat, 17 May 2008 14:23:05 +0200
Message-ID: <20080517122304.GA3745@penelope.zusammrottung.local>
References: <20080516212833.GA5366@penelope.zusammrottung.local> <20080517052212.GC18876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 14:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxLSD-0004Y0-4V
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 14:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbYEQMXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbYEQMXK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 08:23:10 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:37629 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbYEQMXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 08:23:09 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 105FEDF60463
	for <git@vger.kernel.org>; Sat, 17 May 2008 14:23:08 +0200 (CEST)
Received: from [83.125.40.75] (helo=tunichtgut.zusammrottung.local)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1JxLRL-0000XV-00
	for git@vger.kernel.org; Sat, 17 May 2008 14:23:08 +0200
Received: from penelope.zusammrottung.local ([192.168.178.202])
	by tunichtgut.zusammrottung.local with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1JxLRK-0005gq-AS
	for git@vger.kernel.org; Sat, 17 May 2008 14:23:06 +0200
Received: from nikolaus by penelope.zusammrottung.local with local (Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1JxLRJ-00017r-10
	for git@vger.kernel.org; Sat, 17 May 2008 14:23:05 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080517052212.GC18876@sigill.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Sender: microschulz@web.de
X-Provags-ID: V01U2FsdGVkX190C2CVBRCxKTyHk3wjy+YfcB6y9j32QzY5K3Mt
	Z1V7Gu6klcV64NpDVtdpjv23eO9srVphdxN7hZpTWOdbpX3vX6
	rg8USGNP0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82346>

On Sat, May 17, 2008 at 01:22:12AM -0400, Jeff King wrote:
> On Fri, May 16, 2008 at 11:28:34PM +0200, Nikolaus Schulz wrote:
> 
> > the new refspec parser in v1.5.5 has also broken fetch uses like
> > 
> >     git fetch <url> +refs/heads/<foo>*:refs/remotes/<bar>*. 
> 
> This was intentionally changed in ef00d150 (Tighten refspec processing).
> There is some associated discussion in this thread:
> 
>   http://mid.gmane.org/7vwso2ieuu.fsf@gitster.siamese.dyndns.org

Ah.  I had found that commit, but not this discussion, thanks. 
I don't understand what the problem with packing the OP ran into with
his setup, though (see [1]).

> But I don't see any particular reason why this syntax should not be
> allowed (besides, "it was never meant to be supported, so it was causing
> other breakage").

Which breakage?

Nikolaus

[1] http://article.gmane.org/gmane.comp.version-control.git/77381

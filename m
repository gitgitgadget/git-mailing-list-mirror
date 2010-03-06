From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Documentation: reset: describe new "--keep" option
Date: Sat, 6 Mar 2010 09:10:34 +0100
Message-ID: <20100306081034.GA4827@m62s10.vlinux.de>
References: <20100305202537.25469.73470.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Mar 06 09:11:16 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nnp6D-0003vt-1L
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 09:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab0CFIKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 03:10:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:53736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751727Ab0CFIKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 03:10:44 -0500
Received: (qmail invoked by alias); 06 Mar 2010 08:10:40 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp015) with SMTP; 06 Mar 2010 09:10:40 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+QvUwX3w2QLcmJnbg7gfjKd5uNYxi2igcRJOZoQA
	c/Mdtc4o5MRF7g
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 8F540D4003; Sat,  6 Mar 2010 09:10:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100305202537.25469.73470.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141610>

On Fri, Mar 05, 2010 at 09:25:36PM +0100, Christian Couder wrote:
> and give an example to show how it can be used.
> 
> +--keep::
> +	Resets the index to match the tree recorded by the named commit,
> +	but keep changes in the working tree. Aborts if the reset would
> +	change files that are already modified in the working tree.
> +
 
Huh? Keep changes (by not touching the worktree) and then aborting if we
touch the worktree. Seems like a contradiction to me.

--
Peter

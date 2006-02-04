From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [PATCH] Use adler32() from zlib instead of defining our own.
Date: Sun, 5 Feb 2006 00:20:23 +0100
Message-ID: <20060204232023.GA25081@ebar091.ebar.dtu.dk>
References: <20060204225401.GA24725@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 05 00:28:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Wpk-00021i-Fx
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 00:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWBDX2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 18:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWBDX2o
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 18:28:44 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:27299 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S964868AbWBDX2o
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 18:28:44 -0500
Received: (qmail 25246 invoked by uid 5842); 4 Feb 2006 23:20:24 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060204225401.GA24725@ebar091.ebar.dtu.dk>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15610>

On Sat, Feb 04, 2006 at 11:54:01PM +0100, Peter Eriksen wrote:
> 
> Since we already depend on zlib, we don't need to define our
> own adler32().  Spotted by oprofile.

Sorry for the bad formatting, I don't use git-format-patch often enough
to be comfortable with it yet.

The patch shows no regression on my machine and at least doesn't slow
down the 2.6.15 merge with 2.6.12+change, but I don't know, if it's
correct.  It just seemed like an easy cleanup.

It was only spotted indirectly, while I was playing with OProfile
(thanks Linus), trying to find the bottlenecks in the afore mentioned 
merge.

Regards,

Peter

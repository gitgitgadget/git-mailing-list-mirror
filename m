From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] apply --index-info: fall back to current index for
	mode changes
Date: Sun, 16 Sep 2007 20:46:23 -0400
Message-ID: <20070917004623.GA3826@pe.Belkin>
References: <Pine.LNX.4.64.0709170119270.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 02:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX4kv-0001pS-L6
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 02:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbXIQAqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 20:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbXIQAqZ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 20:46:25 -0400
Received: from eastrmmtao104.cox.net ([68.230.240.46]:48467 "EHLO
	eastrmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbXIQAqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 20:46:24 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917004624.LIPX21140.eastrmmtao104.cox.net@eastrmimpo02.cox.net>;
          Sun, 16 Sep 2007 20:46:24 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id pCmP1X0030epFYL0000000; Sun, 16 Sep 2007 20:46:23 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1IX4kp-000101-Bo; Sun, 16 Sep 2007 20:46:23 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709170119270.28586@racer.site>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58371>

On Mon, Sep 17, 2007 at 01:24:57AM +0100, Johannes Schindelin wrote:
> 
> "git diff" does not record index lines for pure mode changes (i.e. no
> lines changed).  Therefore, apply --index-info would call out a bogus
> error.
> 
> Instead, fall back to reading the info from the current index.
> 
> Incidentally, this fixes an error where git-rebase would not rebase a 
> commit including a pure mode change, and changes requiring a threeway 
> merge.
> 
> Noticed by Chris Shoemaker.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Works for me.  Thanks.

Acked-by: Chris Shoemaker <chris.shoemaker@cox.net>

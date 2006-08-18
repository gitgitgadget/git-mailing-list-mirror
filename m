From: Jeff King <peff@peff.net>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 01:10:13 -0400
Message-ID: <20060818051013.GA10900@sigio.intra.peff.net>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 07:10:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDwcj-0003SN-E1
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 07:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWHRFKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 01:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWHRFKR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 01:10:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:43193 "HELO
	peff.net") by vger.kernel.org with SMTP id S932392AbWHRFKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 01:10:16 -0400
Received: (qmail 14992 invoked from network); 18 Aug 2006 01:09:44 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 18 Aug 2006 01:09:44 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2006 01:10:13 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25628>

On Thu, Aug 17, 2006 at 09:09:03PM -0700, Junio C Hamano wrote:

> * Jeff King sent a patch to color git-status output
[...]
>   Hoping to see the C implementation of run_status but I am in
>   no rush myself.

I am working on this but got side-tracked by "real" work. The current
state is that I have a simplistic working C run_status, but I'm still
hoping to hack the diff code to simultaneously do the tree<->index and
index<->files diffs. I will try to send out something next week.

>   I vaguely recall there was a companion patch to add vim
>   colorizer for the current git-status output, meant for
>   contrib/vim, but I lost it.  If somebody cares deeply enough
>   please send it over.

It's in <20060805032135.GA11244@coredump.intra.peff.net>. However, if I
can get the multi-diff support working, then the status format will
change. I will wait until that is resolved before submitting a patch to
put vim highlighting into contrib/.

-Peff

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Thu, 21 Jun 2007 20:58:41 -0700
Message-ID: <7v4pl0bpxq.fsf@assigned-by-dhcp.pobox.com>
References: <20070621045903.GA14047@spearce.org>
	<7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
	<20070621061045.GG8477@spearce.org>
	<7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
	<7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com>
	<7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com>
	<alpine.LFD.0.99.0706211137020.20596@xanadu.home>
	<7v7ipxw1bq.fsf@assigned-by-dhcp.pobox.com>
	<20070622032502.GA17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 05:58:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1aIH-0007VO-9O
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 05:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbXFVD6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 23:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbXFVD6n
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 23:58:43 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57341 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbXFVD6n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 23:58:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070622035843.EKIL17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Jun 2007 23:58:43 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ETyi1X0091kojtg0000000; Thu, 21 Jun 2007 23:58:42 -0400
In-Reply-To: <20070622032502.GA17393@spearce.org> (Shawn O. Pearce's message
	of "Thu, 21 Jun 2007 23:25:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50671>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Here's the problem though: `git-blame -w` will be supported
> in Git 1.5.3 and later, we all know this.  But Git doesn't.
> Ask git-describe what version `master` and `next` are; its
> v1.5.2.2-249 and v1.5.2.2-1050.
>
> So tell me, how can git-gui know that Git 1.5.2.2.249 is OK, and
> 1.5.3 is OK, but 1.5.2.3 isn't?

You don't.  Although 1.5.2.2.249 may have it, you do not enable
it for that version.

That is what "1.5.3 or later" implies.  And in 6 weeks that
little distinction does not matter.

Pretty simple.

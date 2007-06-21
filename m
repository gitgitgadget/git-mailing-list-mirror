From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Thu, 21 Jun 2007 12:32:25 -0700
Message-ID: <7v7ipxw1bq.fsf@assigned-by-dhcp.pobox.com>
References: <20070621045903.GA14047@spearce.org>
	<7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
	<20070621061045.GG8477@spearce.org>
	<7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
	<7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com>
	<7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com>
	<alpine.LFD.0.99.0706211137020.20596@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 21:32:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1SOK-0004x7-On
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 21:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbXFUTc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 15:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbXFUTc1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 15:32:27 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54821 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbXFUTc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 15:32:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621193225.DRKG1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 15:32:25 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EKYR1X00R1kojtg0000000; Thu, 21 Jun 2007 15:32:26 -0400
In-Reply-To: <alpine.LFD.0.99.0706211137020.20596@xanadu.home> (Nicolas
	Pitre's message of "Thu, 21 Jun 2007 11:55:46 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50652>

Nicolas Pitre <nico@cam.org> writes:

> Well, just in case my opinion matters...

Well, you already do ;-)

> I don't like this feature list idea at all.

... and thanks for bringing a bit of sanity to this thread.

> When you need git behavior X and you know that it appeared in version Y 
> then you only need to test for git_version >= Y.  Determining that 
> particular Y is much easier after the facts using the commit log than 
> trying to anticipate what item should be added to a feature list for 
> future usage.  In fact the same argument as for not explicitly recording 
> renames in commit objects should apply here.

Very well put; that is exactly what I wanted to say in two
messages ago.

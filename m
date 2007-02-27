From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Make 'cvs ci' lockless in git-cvsserver by using git-update-ref
Date: Tue, 27 Feb 2007 15:44:24 -0800
Message-ID: <7v1wkbb1yf.fsf@assigned-by-dhcp.cox.net>
References: <200702210908.59579.andyparkins@gmail.com>
	<200702271248.59652.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBzi-0006il-5w
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbXB0Xo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXB0Xo0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:44:26 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37196 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbXB0XoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:44:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227234425.TLMI6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 18:44:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UnkQ1W0151kojtg0000000; Tue, 27 Feb 2007 18:44:25 -0500
In-Reply-To: <200702271248.59652.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 27 Feb 2007 04:48:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40849>

Andy Parkins <andyparkins@gmail.com> writes:

> This patch is actually yours (with one extra removal of lock file reference
> that you'd missed, and a change of shortlog), but I don't know how to send
> an email that comes from me but attributes authorship to you.

The extra one was introduced by a later patch to honor the
update hook since I wrote the original patch you forward ported.

Thanks.  Will apply.

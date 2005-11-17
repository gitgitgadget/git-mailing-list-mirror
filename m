From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 18:10:14 -0800
Message-ID: <20051117021014.GC3968@reactrix.com>
References: <437B6997.8010903@mc.com> <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net> <437B8CEC.8040002@mc.com> <20051116203334.GA3968@reactrix.com> <Pine.LNX.4.63.0511170023040.9284@wbgn013.biozentrum.uni-wuerzburg.de> <20051117004621.GB3968@reactrix.com> <7vd5l03whv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 03:11:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcZEK-0004u7-Qk
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 03:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbVKQCKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 21:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbVKQCKY
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 21:10:24 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:44392 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030585AbVKQCKX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 21:10:23 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAH2AFom030558;
	Wed, 16 Nov 2005 18:10:15 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAH2AEh2030555;
	Wed, 16 Nov 2005 18:10:14 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5l03whv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12083>

On Wed, Nov 16, 2005 at 05:15:40PM -0800, Junio C Hamano wrote:

> > Is it worth trying to figure this out in the Makefile instead, using eg.
> > curl-config --vernum?
> 
> If we can do that reliably, that would be very nice for the
> users.  Might be worth a try.

Well, it looks as though the --vernum option was added prior to 7.8.1,
so if it doesn't work it's safe to assume that curl is too old - more
than ~4.5 years old in this case.

Assuming --vernum does work, is there a reasonable/portable way to
compare two hex values like 070801?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.

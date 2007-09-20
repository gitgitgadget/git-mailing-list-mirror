From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] new test from the submodule chapter of the user manual
Date: Thu, 20 Sep 2007 15:56:46 -0700
Message-ID: <20070920225646.GB3490@tasint.org>
References: <20070920003413.GJ16235@genesis.frugalware.org> <7v1wcum0ox.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709201133590.28395@racer.site> <20070920170831.GQ16235@genesis.frugalware.org> <20070920175952.GC30391@tasint.org> <Pine.LNX.4.64.0709201946410.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 00:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYUxw-0000o1-Jx
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 00:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbXITW5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 18:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbXITW5n
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 18:57:43 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:30971 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbXITW5m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 18:57:42 -0400
Received: from rgmgw1.us.oracle.com (rgmgw1.us.oracle.com [138.1.186.110])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id l8KMvLMm014722;
	Thu, 20 Sep 2007 17:57:21 -0500
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmgw1.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id l8KMvKYH031214;
	Thu, 20 Sep 2007 16:57:20 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.63)
	(envelope-from <joel.becker@oracle.com>)
	id 1IYUxU-0004GD-7w; Thu, 20 Sep 2007 15:57:20 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709201946410.28395@racer.site>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58816>

On Thu, Sep 20, 2007 at 07:47:32PM +0100, Johannes Schindelin wrote:
> > 	Silly question: why use the '&&' when you can 'set -e'?  As it
> > currently stands, a failure will still go back around the loop...
> 
> A "set -e" will make the script exit AFAIR.  That's not what we want.  A 
> simple "|| break" after the "cd .." will work, though.

	Oh, drat.  It's run in eval, not a subshell.

Joel

-- 

Life's Little Instruction Book #94

	"Make it a habit to do nice things for people who 
	 will never find out."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

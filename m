From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 10 Dec 2007 11:50:52 -0500
Message-ID: <20071210165052.GA22327@pe.Belkin>
References: <200712101357.49325.jnareb@gmail.com> <87ve76mwos.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1lwl-0005lu-6L
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbXLJQ5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbXLJQ5K
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:57:10 -0500
Received: from eastrmmtai110.cox.net ([68.230.240.29]:50969 "EHLO
	eastrmmtai110.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbXLJQ5J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:57:09 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2007 11:57:09 EST
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071210165054.UJJX21667.eastrmmtao106.cox.net@eastrmimpo02.cox.net>;
          Mon, 10 Dec 2007 11:50:54 -0500
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id P4qY1Y00F0epFYL0000000; Mon, 10 Dec 2007 11:50:33 -0500
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1J1lqG-0005ru-5M; Mon, 10 Dec 2007 11:50:52 -0500
Content-Disposition: inline
In-Reply-To: <87ve76mwos.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67737>

On Mon, Dec 10, 2007 at 03:49:39PM +0100, Florian Weimer wrote:
> * Jakub Narebski:
> 
> > +                <s id="git">
> > +                    Yes (or no depending on interpretation). Git
> 
> This should be "No." (same for copies below).

ISTM that people are stuck using less than helpful criteria for
judging whether renames are supported.  Namely, in effect, they ask:
"Does the user get to do extra work in order to get rename-detection?"

Let me humbly suggest an alternate, two-fold, very practical criteria
that I actually care about as a user:

1) If I edit file A, while another developer renames file A to B, and
I merge my work with his, do I have to clean things up myself, or does
everything Just Work?

2) If I'm browsing the history of some code in a renamed file, does
the history continue through the rename?

By these criteria, git certainly does support renames.

-chris

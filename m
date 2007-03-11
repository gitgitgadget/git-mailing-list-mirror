From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge and merge message
Date: Sun, 11 Mar 2007 22:41:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703112241040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
 <20070311160424.GA629@fieldses.org> <200703111815.l2BIFHbq010315@localhost.localdomain>
 <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
 <45F46713.6030702@qumranet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Xavier Maillard <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:42:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVnv-000576-59
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbXCKVly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbXCKVlx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:41:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:38597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932768AbXCKVlw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:41:52 -0400
Received: (qmail invoked by alias); 11 Mar 2007 21:41:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 11 Mar 2007 22:41:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Y0TYYSn9YjeKKOV+Ned3bqHgWGXWs9PcFo3tG7x
	2EQRiH/gHm8NIS
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45F46713.6030702@qumranet.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41989>

Hi,

On Sun, 11 Mar 2007, Avi Kivity wrote:

> Linus Torvalds wrote:
> > Comments? Do people think it would be a good idea to do
> > 
> > 	git merge --no-fast-forward -m "Merge feature Xyz" xyz-branch
> > 
> > as an option?
> > 
> >   
> 
> Actually there's at least one tree where this should be activated -- 
> yours. If you perform a fast-forward merge, there's no record of the 
> merge, no record of which tree was pulled, and no sign-off from you.  
> The commits just appear there.  It partially defeats the sign-off 
> system.
> 
> This feature would be good for top-level trees and for major subsystem 
> trees IMO.

What? You should sign-off on stuff you did not review? Or do you review 
the stuff _before_ merging? I don't.

Ciao,
Dscho

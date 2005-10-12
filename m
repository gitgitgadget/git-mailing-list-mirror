From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] gitk: Add "Refs" menu
Date: Wed, 12 Oct 2005 10:34:52 -0400
Message-ID: <1129127692.31997.10.camel@dv>
References: <1128559088.32103.8.camel@dv>
	 <17227.44393.412591.267878@cargo.ozlabs.ibm.com>
	 <1129080380.2427.21.camel@dv>
	 <20051012073139.GV8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 12 16:36:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPhhP-0006oF-8P
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 16:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVJLOfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 10:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVJLOfA
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 10:35:00 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:7367 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964795AbVJLOe7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 10:34:59 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EPhh4-0004uj-LL
	for git@vger.kernel.org; Wed, 12 Oct 2005 10:34:58 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EPhgy-0008Q8-BK; Wed, 12 Oct 2005 10:34:52 -0400
To: skimo@liacs.nl
In-Reply-To: <20051012073139.GV8383MdfPADPa@greensroom.kotnet.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10031>

On Wed, 2005-10-12 at 09:31 +0200, Sven Verdoolaege wrote:
> On Tue, Oct 11, 2005 at 09:26:20PM -0400, Pavel Roskin wrote:
> > Browsing trees and opening files for a given commit would be great and
> > helpful from developers migrating from CVS.
> 
> Something like this ?
> 
>     From: Ingo Bormuth <ibormuth@efil.de>
>     To: git@vger.kernel.org
>     Cc: paulus@samba.org
>     Subject: [PATCH] Gitk tree view (correction)
>     Message-ID: <20050824223550.GA23693@kruemel>

That's pretty good, thank you.  Although I think "Tree" and "Commit"
should be links on top of the view pane rather than a button.  "Commit"
button is especially confusing - one could think that it would commit
something.

Also, it would be really great to put line numbers in a separate widget
so that they are never selected with the text.  When done correctly,
most users will never want to turn the line numbers off.

-- 
Regards,
Pavel Roskin

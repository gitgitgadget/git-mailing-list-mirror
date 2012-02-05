From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: (unknown)
Date: Sun,  5 Feb 2012 17:32:20 -0500
Message-ID: <1328481141-21037-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <7vr4y9ggij.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 05 23:34:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuAev-0002eq-St
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab2BEWd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:33:59 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:32974 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab2BEWd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 17:33:58 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:51389 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RuAej-0007mc-Gu; Sun, 05 Feb 2012 17:33:57 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RuAej-0005Zk-Fy; Sun, 05 Feb 2012 17:33:57 -0500
Subject: 
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <7vr4y9ggij.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189979>

Hi Junio,

> > diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
> > index 60b5a1d..f1bf81c 100644
> > --- a/compat/inet_ntop.c
> > +++ b/compat/inet_ntop.c
> > @@ -15,11 +15,9 @@
> >   * SOFTWARE.
> >   */
> >
> > +#include "../git-compat-util.h"
> >  #include <errno.h>
> >  #include <sys/types.h>
> > -
> > -#include "../git-compat-util.h"
> > -
> >  #include <stdio.h>
> >  #include <string.h>
> 
> I actually have to wonder if any of these four inclusion of the
> system headers are warranted. Wouldn't they be included as part of
> git-compat-util.h anyway?

Yes, you're correct.  Dropping the system includes is correct as
opposed to rearranging the order.  Updated patch to follow.

Thanks
-Ben

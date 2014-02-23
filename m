From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and
 arguments
Date: Sun, 23 Feb 2014 11:44:38 +0100 (CET)
Message-ID: <20140223.114438.2222295831383883854.chriscool@tuxfamily.org>
References: <xmqqtxc1fdsk.fsf@gitster.dls.corp.google.com>
	<xmqqppmpfcx1.fsf@gitster.dls.corp.google.com>
	<xmqq8ut55n6x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, dan.carpenter@oracle.com, greg@kroah.com,
	peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 23 11:45:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHWYg-0000fn-45
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 11:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbaBWKon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 05:44:43 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:41546 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbaBWKom (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 05:44:42 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 8EE5953;
	Sun, 23 Feb 2014 11:44:38 +0100 (CET)
In-Reply-To: <xmqq8ut55n6x.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242540>

From: Junio C Hamano <gitster@pobox.com>
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> Having said all that, it appears that nobody seems to be able to
> come up with a saner arrangement that would not paint us into a
> tough corner that we would not be able to later escape from without
> being backward incompatible---I certainly didn't.
> 
> So... let's take this from your earlier message:
> 
>>> If we limit it to "if_exists" and "if_missing", the user can remember
>>> that without things becoming too complex.
> 
> and go with the semantics the posted patches (I believe I have the
> latest from you on 'pu') attempt to implement, at least for now.
> 
> IOW, when re-rolling, let's not try changing the arrangement to use
> if-exists/if-missing (configuration variable names) for keys'
> existence and include chosen set of conditions on values as
> modifiers to the action (i.e. X in "do_Y_in_X").

Ok, will re-roll soon.

Thanks,
Christian.

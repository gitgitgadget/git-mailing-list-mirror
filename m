From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: [PATCH] Documentation: Clarify which paths git-clean will
	affect
Date: Wed, 6 May 2009 18:31:45 +0200
Message-ID: <20090506163145.GF4452@frsk.net>
References: <20090505091302.GB27900@frsk.net> <200905051426.18814.trast@student.ethz.ch> <7vk54v1py6.fsf@alter.siamese.dyndns.org> <200905061524.52186.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 18:32:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1k2Y-0002mb-00
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 18:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbZEFQcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 12:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbZEFQcE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 12:32:04 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:45741 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbZEFQcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 12:32:03 -0400
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1M1k25-0003w4-O7; Wed, 06 May 2009 18:31:53 +0200
Received: from fredrik by asterix.frsk.net with local (Exim 4.69)
	(envelope-from <fredrik@frsk.net>)
	id 1M1k25-0001mO-EI; Wed, 06 May 2009 18:31:45 +0200
Content-Disposition: inline
In-Reply-To: <200905061524.52186.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118354>

On Wed, May 06, 2009 at 03:24:47PM +0200, Thomas Rast wrote:

> > I'd suggest not touching this paragraph at all, but instead say something
> > like this at the beginning:
> > 
> > > -This allows cleaning the working tree by removing files that are not
> > 
> >     Cleans the working tree by recursively removing files that are not
> >     under version control, starting from the current directory.
> 
> Indeed, yours is better.

And I agree, it does looks better. Junio, would you like me to produce a
patch v2, or would you like do the honor? (After all, you came up with the
final suggestion)

-- 
Fredrik Skolmli

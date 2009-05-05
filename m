From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: [PATCH] Documentation: Clarify which paths git-clean will
	affect
Date: Tue, 5 May 2009 12:05:07 +0200
Message-ID: <20090505100506.GF27900@frsk.net>
References: <20090505091302.GB27900@frsk.net> <200905051155.28985.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 05 12:05:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1HWg-0005I5-3k
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 12:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbZEEKFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 06:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbZEEKFM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 06:05:12 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:58880 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbZEEKFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 06:05:11 -0400
Received: from asterix.samfundet.no ([2001:700:300:1800::f] helo=asterix.frsk.net)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1M1HWN-0002p7-A8; Tue, 05 May 2009 12:05:07 +0200
Received: from fredrik by asterix.frsk.net with local (Exim 4.69)
	(envelope-from <fredrik@frsk.net>)
	id 1M1HWN-0000is-2c; Tue, 05 May 2009 12:05:07 +0200
Content-Disposition: inline
In-Reply-To: <200905051155.28985.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118286>

On Tue, May 05, 2009 at 11:55:17AM +0200, Thomas Rast wrote:
> Fredrik Skolmli wrote:
> > --- a/Documentation/git-clean.txt
> > +++ b/Documentation/git-clean.txt
> > @@ -23,6 +23,9 @@ example, be useful to remove all build products.
> >  If any optional `<path>...` arguments are given, only those paths
> >  are affected.
> >  
> > +If no arguments are given, the cleaning is recursive, starting at the current
> > +path.
> 
> That makes it sound as if the <path> case was not recursive, but it
> is!

Auch, good point. Any suggestions on how to formulate it?

-- 
Fredrik Skolmli

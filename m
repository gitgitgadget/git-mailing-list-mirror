From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 1/3] strbuf: make stripspace() part of strbuf
Date: Fri, 16 Oct 2015 09:14:07 +0200
Message-ID: <20151016071406.GK11304@distanz.ch>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
 <1444911524-14504-2-git-send-email-tklauser@distanz.ch>
 <vpqio6813tc.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 16 09:14:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmzDT-0005EQ-HS
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 09:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbbJPHOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 03:14:11 -0400
Received: from sym2.noone.org ([178.63.92.236]:56970 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370AbbJPHOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 03:14:10 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ncdy84xpqzQWbs; Fri, 16 Oct 2015 09:14:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqio6813tc.fsf@grenoble-inp.fr>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279733>

On 2015-10-15 at 18:42:23 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > Also switch all current users of stripspace() to the new function name
> > and  keep a temporary wrapper inline function for topic branches still
> > using stripspace().
> 
> Since you have this temporary wrapper, it would have made sense to split
> the patch into 1) move and rename the function, and 2) change the
> callsites to strbuf_stripspace. This way 2) would be absolutely trivial
> to review.
> 
> OTOH, this patch is already easy to review, so you may consider it's OK
> like this.

Ok, in this case will keep the patch as is for v2, but with the adjusted
commit message as indicated in your and Junio's review.

> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Will add it to v2, thanks!

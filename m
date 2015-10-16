From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Fri, 16 Oct 2015 09:54:13 +0200
Message-ID: <20151016075413.GN11304@distanz.ch>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
 <1444911524-14504-3-git-send-email-tklauser@distanz.ch>
 <vpq4mhsx7hq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 16 09:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmzqP-0004NL-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 09:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbbJPHyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 03:54:19 -0400
Received: from sym2.noone.org ([178.63.92.236]:60741 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbbJPHyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 03:54:16 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ncfrR2yblzQWbs; Fri, 16 Oct 2015 09:54:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpq4mhsx7hq.fsf@grenoble-inp.fr>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279737>

On 2015-10-15 at 21:21:53 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > + * comments are considered contents to be removed or not. Returns the
> > + * number of lines in the resulting buffer.
> 
> We write comments at imperative tone, hence "Return", not "Returns".

The other comments in strbuf.h used "Returns", so I went for it for
consistency reasons. But the comment will be obsolete anyhow, as
strbuf_stripspace() will not be changed and the functionality
implemented in cmd_stripspace() as Junio suggested.

> Other than that, I agree with Junio:
> 
> * A preparatory patch introducing parse-options would make the actual
>   patch much easier to review.

Will do.

> 
> * Just running strbuf_stripspace and counting the number of lines in the
>   result is much simpler. We use stripspace only on user-provided input
>   which are never really big so maintainability is more important than
>   performance.

Ditto.

Thanks

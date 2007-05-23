From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/3] Added generic string handling code.
Date: Wed, 23 May 2007 15:24:29 +0200
Message-ID: <20070523132429.GM4489@pasky.or.cz>
References: <1179627869.32181.1284.camel@hurina> <20070522134007.GK4489@pasky.or.cz> <1179917386.32181.1643.camel@hurina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Wed May 23 15:24:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqqph-0004L7-5v
	for gcvg-git@gmane.org; Wed, 23 May 2007 15:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbXEWNYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 09:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764630AbXEWNYc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 09:24:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46809 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755780AbXEWNYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 09:24:31 -0400
Received: (qmail 24935 invoked by uid 2001); 23 May 2007 15:24:29 +0200
Content-Disposition: inline
In-Reply-To: <1179917386.32181.1643.camel@hurina>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48154>

On Wed, May 23, 2007 at 12:49:46PM CEST, Timo Sirainen wrote:
> On Tue, 2007-05-22 at 15:40 +0200, Petr Baudis wrote:
> > On Sun, May 20, 2007 at 04:24:29AM CEST, Timo Sirainen wrote:
> > > diff --git a/str.c b/str.c
> > > new file mode 100644
> > > index 0000000..d46e7f4
> > > --- /dev/null
> > > +++ b/str.c
> > > @@ -0,0 +1,40 @@
> > > +#include "str.h"
> > > +
> > > +void _str_append(struct string *str, const char *cstr)
> > 
> > _ is reserved namespace.
> 
> I remember __ is, but was _ too? A lot of programs are using that. :)

C99 7.1.3 says that

   -- All identifiers that begin with an underscore are always reserved
for use as identifiers with file scope in both the ordinary and tag name
spaces.

Hmm, this _is_ file scope, right?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett

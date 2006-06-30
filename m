From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC/PATCH 14] autoconf: Added --with/--without for openssl,
	curl, expat to ./configure
Date: Fri, 30 Jun 2006 17:57:06 -0400
Message-ID: <1151704626.12008.5.camel@dv>
References: <200606290301.51657.jnareb@gmail.com>
	 <200606301708.19521.jnareb@gmail.com> <200606301711.39635.jnareb@gmail.com>
	 <200606302345.17045.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 23:57:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwQzC-0002bB-Q8
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 23:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWF3V5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 17:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWF3V5K
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 17:57:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:12470 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751217AbWF3V5J
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 17:57:09 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FwQz6-0004nl-NM
	for git@vger.kernel.org; Fri, 30 Jun 2006 17:57:08 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FwQz4-00039z-Gl; Fri, 30 Jun 2006 17:57:06 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200606302345.17045.jnareb@gmail.com>
X-Mailer: Evolution 2.7.3 (2.7.3-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23020>

Hi Jakub,

On Fri, 2006-06-30 at 23:45 +0200, Jakub Narebski wrote:
> I'm not autoconf/m4 expert: could anyone tell me how to uppercase
> PACKAGE name, so one could write MY_PARSE_WITH(openssl)?

I don't quite understand what you want, but you could check m4_toupper.

> How to add [=PATH] to --with-PACKAGE option description in a way
> which does not screw up AS_HELP_WITH calculations. I could use
> @<:@=PATH@:>@ which transforms to [=PATH], but AS_HELP_WITH counts
> number of characters in source I think.

Try another pair of square brackets as quotes for literal contents.  In
this case, use [[=PATH]]

> +# MY_PARSE_WITH(PACKAGE)

By the way, it's better to use a prefix other than MY.  I thing
GIT_PARSE_WITH would be great.

-- 
Regards,
Pavel Roskin

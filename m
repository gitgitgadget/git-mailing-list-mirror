From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: mailmap distinguishing names
Date: Thu, 16 Jul 2009 12:55:32 +0400
Organization: St.Petersburg State University
Message-ID: <20090716085532.GA8843@landau.phys.spbu.ru>
References: <85b5c3130907151522x1009a796tced7726d9be4ca7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Thu Jul 16 11:21:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRN9v-0001LQ-EO
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 11:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbZGPJVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 05:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbZGPJVj
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 05:21:39 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:1145 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbZGPJVj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 05:21:39 -0400
X-Greylist: delayed 1565 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2009 05:21:39 EDT
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id DF24C17B668; Thu, 16 Jul 2009 12:55:32 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <85b5c3130907151522x1009a796tced7726d9be4ca7d@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123392>

On Wed, Jul 15, 2009 at 04:22:08PM -0600, Ondrej Certik wrote:
> Hi,
> 
> I know how to use mailmap to map names to email addresses, however,
> what if we have some old commits that look like:
> 
> commit 1815ccf8ea8a7d99736d9b15c10d2ddf41162faf
> Author: ondrej.certik <devnull@localhost>
> Date:   Sat Oct 6 01:57:03 2007 +0000
> 
>     test for a series bug 364 added, but XFAILed, because sometimes it works, so
> 
> commit ef95d618e1fda2dc6b50a0edf343a7b321467527
> Author: kirill.smelkov <devnull@localhost>
> Date:   Fri Oct 5 20:10:04 2007 +0000
> 
>     pprint: add support for multile indexes in unicode mode
> 
> commit 7e74ebdf2701f0ab213a6e5ba47b7860fcf90cff
> Author: fredrik.johansson <devnull@localhost>
> Date:   Fri Oct 5 16:41:04 2007 +0000
> 
>     add abc module
> 
> 
> 
> E.g. for some reason the addresses are <devnull@localhost>, but the
> names are correct (svn names). Then "git shortlog -ns" shows things
> like:
> 
>    654  Ondrej Certik
>    322  Kirill Smelkov
>    268  ondrej.certik
>    208  Mateusz Paprocki
>     74  fredrik.johansson
> 
> is there some way to join "ondrej.certik" with "Ondrej Certik"? If the

You just do

    Ondrej Certik <...@...>   ondrej.certik  <devnull@localhost>


in .mailmap

See Documentation/mailmap.txt for details

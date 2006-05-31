From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] Update documentation for git-format-patch
Date: Wed, 31 May 2006 19:24:41 +0200
Message-ID: <20060531172441.G2b322ff2@leonov.stosberg.net>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com> <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com> <20060531112803.GB3877@spinlock.ch> <20060531141408.G366d89c7@leonov.stosberg.net> <e5kcfi$124$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 31 19:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlURe-00050A-BO
	for gcvg-git@gmane.org; Wed, 31 May 2006 19:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWEaRZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 13:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWEaRZS
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 13:25:18 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:34751 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751748AbWEaRZQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 13:25:16 -0400
Received: from leonov.stosberg.net (p213.54.78.240.tisdip.tiscali.de [213.54.78.240])
	by ncs.stosberg.net (Postfix) with ESMTP id 6DD1EAEBA00A
	for <git@vger.kernel.org>; Wed, 31 May 2006 19:24:41 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id D4333105CC3; Wed, 31 May 2006 19:24:41 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e5kcfi$124$1@sea.gmane.org>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21072>

Jakub Narebski wrote:

> Dennis Stosberg wrote:
> 
> > -        Display suspicious lines in the patch.  The definition
> > -        of 'suspicious lines' is currently the lines that has
> > -        trailing whitespaces, and the lines whose indentation
> > -        has a SP character immediately followed by a TAB
> > -        character.
> 
> So is this option also lost in built-in git-format-patch?

Johannes Schindelin made that one a diff option, so it can be used in
other ways, too.  I think it should be documented in diff-options.txt.

> > -CONFIGURATION
> > -You can specify extra mail header lines to be added to each
> > -message in the repository configuration as follows:
> > -
> > -[format]
> > -        headers = "Organization: git-foo\n"
> 
> So is this configuration option also lost in built-in git-format-patch?

Grep'ing the sources, I couldn't find any trace of it.

Regards,
Dennis

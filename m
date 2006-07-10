From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Tue, 11 Jul 2006 01:51:22 +0200
Message-ID: <20060710235122.GB26528@dspnet.fr.eu.org>
References: <20060710065751.22902.43316.stgit@dv.roinet.com> <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net> <20060710094653.GA52962@dspnet.fr.eu.org> <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060710114117.GA62514@dspnet.fr.eu.org> <44B2A709.8020500@serice.net> <20060710202412.GA8189@dspnet.fr.eu.org> <Pine.LNX.4.63.0607110049470.29667@wbgn013.biozentrum.uni-wuerzburg.de> <f36b08ee0607101625y6eaec83ck22dd20b4f27a1846@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 11 01:51:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G05XE-00041I-Ov
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 01:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWGJXvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 19:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWGJXvY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 19:51:24 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:40454 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S965067AbWGJXvX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 19:51:23 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 9182AA4169; Tue, 11 Jul 2006 01:51:22 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <f36b08ee0607101625y6eaec83ck22dd20b4f27a1846@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23670>

On Tue, Jul 11, 2006 at 02:25:44AM +0300, Yakov Lerner wrote:
> I am writing in order to ask, whether there maybe
> some c99-to-c89 source convertor that can be
> automatically applied to the .c before compiling with
> pre-c99 compiler ?

Comments are easy.  Moving declarations without breaking initializers
is harder.  Rewriting the struct initializers is pretty much
impossible without the tool turning into a full-blown C parser.

Maybe git can be perfectly happy with c89.  I don't know.  I know the
linux kernel requires c99, mostly for the struct initializers.  My
point was that staying at the c89 level has a maintainance cost, and a
cost/benefit analysis should be done to decide whether it is a good
idea.  Answering "get a C compiler", as is being done for some years
now for people not wanting prototypes, is an option not to neglect.

  OG.

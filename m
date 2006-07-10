From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Mon, 10 Jul 2006 13:41:18 +0200
Message-ID: <20060710114117.GA62514@dspnet.fr.eu.org>
References: <20060710065751.22902.43316.stgit@dv.roinet.com> <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net> <20060710094653.GA52962@dspnet.fr.eu.org> <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 13:41:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzu8h-00026v-BB
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 13:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWGJLlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 07:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWGJLlT
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 07:41:19 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:35855 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964789AbWGJLlT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 07:41:19 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 1093BA360A; Mon, 10 Jul 2006 13:41:18 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23610>

On Mon, Jul 10, 2006 at 01:06:44PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 10 Jul 2006, Olivier Galibert wrote:
> 
> > On Mon, Jul 10, 2006 at 12:46:28AM -0700, Junio C Hamano wrote:
> > > It is sad that some people stay behind and we need to
> > > cater to them, though.
> > 
> > Do you, really?
> 
> Well, I guess as long as things do not break for _you_, we do not need to.

Supporting old, not-standard-anymore compilers has a cost in
maintainability, by precluding the use of better constructs (//
comments, declarations near initialisation, struct initializers...).
Additionally, it gets harder and harder to have people test for them.
Given than you can find gcc on pretty much everything that has a
filesystem cache decent enough to handle git correctly, is this cost
worth it?  _That_ was the question.

  OG.

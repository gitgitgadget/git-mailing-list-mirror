From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [WIP PATCH 0/3] implement merge strategy for submodule
	links
Date: Sat, 19 Jun 2010 11:43:02 +0200
Message-ID: <20100619094301.GA2667@book.hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006170239.01951.johan@herland.net> <4C1A8FDC.7010309@web.de> <201006181140.16652.johan@herland.net> <4C1B7ABE.8080905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 19 11:43:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPua7-0007bY-PT
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 11:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab0FSJnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jun 2010 05:43:06 -0400
Received: from darksea.de ([83.133.111.250]:51450 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755191Ab0FSJnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 05:43:04 -0400
Received: (qmail 12685 invoked from network); 19 Jun 2010 11:43:00 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 19 Jun 2010 11:43:00 +0200
Content-Disposition: inline
In-Reply-To: <4C1B7ABE.8080905@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149376>

On Fri, Jun 18, 2010 at 03:55:10PM +0200, Jens Lehmann wrote:
> Am 18.06.2010 11:40, schrieb Johan Herland:
> > On Thursday 17 June 2010, Jens Lehmann wrote:
> >> But I think this approach will solve a lot of the problems we - and maybe
> >> others - have with submodule merges without doing any harm to other
> >> workflows.
> > 
> > For the fast-forward case, I fully agree.
> > 
> > For the non-fast-forward case, I would suggest to search for submodule 
> > merges that contain both submodule commits (as described in [1]), and then:
> > 
> > - If there are no merges, do nothing (leave a conflict).
> > 
> > - If there is exactly one merge, then check it out (but do not record it as 
> > resolved in the index).
> > 
> > - If there are more merge alternatives, present them as equal alternatives, 
> > but do nothing (leave a conflict).
> 
> Nice summary. Heiko, would you please post a new patch implementing this
> approach?

Yes sure. I agree with the proposed scheme.

As Jens is working on the automatically checkout submodules extension I
will base the merge patch on your branch. Is the checkout_submodule()
function already stable enough to be used?

cheers Heiko

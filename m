From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Fri, 23 Oct 2009 20:49:18 -0400
Message-ID: <20091024004917.GA8012@sigio.peff.net>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <alpine.LNX.2.00.0910202044150.14365@iabervon.org> <20091021031528.GB18997@atjola.homenet> <200910211005.29053.trast@student.ethz.ch> <20091023025434.GA29908@sigio.peff.net> <alpine.LNX.2.00.0910222334040.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 02:45:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1UlS-0007Wq-IY
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 02:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbZJXAph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 20:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZJXAph
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 20:45:37 -0400
Received: from peff.net ([208.65.91.99]:51770 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243AbZJXAph (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 20:45:37 -0400
Received: (qmail 8024 invoked by uid 1000); 24 Oct 2009 00:49:18 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910222334040.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131139>

On Thu, Oct 22, 2009 at 11:43:05PM -0400, Daniel Barkalow wrote:

> > But probably that is an artifact of the workflow. The scenario I am
> > describing above implies a somewhat centralized workflow, where the
> > shorthand contains all of the interesting information. In a totally
> > distributed, we-don't-share-anything-except-the-url-namespace setup of
> > an open source repo, the full URL makes more sense.
> > 
> > So maybe it is something that should be optional.
> 
> Surely you ought to be able to get the short form with "pull", though, if 
> you happen to like short forms. So it would make sense to decide how to 
> format the merge message based entirely on an option, not at all on 
> whether you use pull or fetch+merge.

Yeah, I think you are right. It _should_ be variable, but right now it
varies on something totally unrelated to what you want (how you invoked,
and not what type of repo setup you are using). So I agree a patch to
make it more consistent across fetch+merge versus pull would be good,
and then we can make a configuration option to choose one or the other.

-Peff

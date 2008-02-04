From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin,
 submodules
Date: Mon, 4 Feb 2008 14:55:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041449300.7372@racer.site>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802032237320.7372@racer.site> <A3A63507-41CA-4FE0-BE77-BF6987E87AD2@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 15:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2kV-0006kY-TF
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 15:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbYBDO4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 09:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbYBDO4H
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 09:56:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:45110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751156AbYBDO4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 09:56:04 -0500
Received: (qmail invoked by alias); 04 Feb 2008 14:56:02 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp022) with SMTP; 04 Feb 2008 15:56:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wzxUMyY6wW4VUv7WIOEmqHaJ6B+Ul5j73+8yew0
	il9m9/DNccjKYW
X-X-Sender: gene099@racer.site
In-Reply-To: <A3A63507-41CA-4FE0-BE77-BF6987E87AD2@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72511>

Hi,

On Mon, 4 Feb 2008, Steffen Prohaska wrote:

> On Feb 3, 2008, at 11:43 PM, Johannes Schindelin wrote:
> 
> > If your issue is with git-submodule, then fix _that_, and do not "fix" 
> > _anything_ else.
> 
> If I understood Mark correctly, this would not solve his problem
> because he wants to *avoid* origin;

So he should *avoid* origin.  Not redefine it.

For example, if you want to update your submodules from their respective 
"bollywog" remotes, it is perfectly fine with me to introduce a notion

	$ git submodule update --from bollywog

If you do not want to fetch from here one time, and from there the next, 
then there is _simply_ _no_ _point_ in pointing to another remote _name_.

You cannot put multiple urls into .gitmodules _anyway_, so they _have_ to 
be modified locally, and then the people can look up their remote urls.

Putting in another layer of indirection, which can very well be 
unsynchronised is what I am strongly in "unfavour" of.

Frankly, I am puzzled how long this discussion drags on.  If I would not 
be concerned about the loss of simplicity of git's core _and concepts_, I 
would not even bother to respond.

Ciao,
Dscho

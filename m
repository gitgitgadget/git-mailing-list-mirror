From: Jeff King <peff@peff.net>
Subject: Re: 'typechange' in the git-status output
Date: Mon, 14 Mar 2011 15:27:23 -0400
Message-ID: <20110314192723.GA22434@sigill.intra.peff.net>
References: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
 <AANLkTikkHWFrjmrPMP_poxrkCwE34jqaFDbU1Roouw--@mail.gmail.com>
 <1300129161.13980.4.camel@drew-northup.unet.maine.edu>
 <20110314192238.GA30378@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Drew Northup <drew.northup@maine.edu>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:27:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDQQ-0003p4-Ef
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab1CNT1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 15:27:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35940
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701Ab1CNT1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:27:25 -0400
Received: (qmail 12503 invoked by uid 107); 14 Mar 2011 19:27:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Mar 2011 15:27:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Mar 2011 15:27:23 -0400
Content-Disposition: inline
In-Reply-To: <20110314192238.GA30378@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169010>

On Mon, Mar 14, 2011 at 02:22:38PM -0500, Jonathan Nieder wrote:

> Hi,
> 
> Drew Northup wrote:
> 
> > As has been said more than a few times (and is probably somewhere in the
> > docs), if you really want to duplicate a git repo you should probably be
> > using git to do it.
> 
> FWIW I don't agree with this advice.  "cp -a" works perfectly well and
> I think that's a valuable thing.

Agreed. Note that "cp -a" really _duplicates_ a repo: refs, config,
unreferenced objects, current packed state, etc. Using git to copy makes
a clone, which is subtly different. So I don't think there is any reason
to dissuade people from "cp -a" (cp without "-a", on the other hand, can
be problematic as shown here).

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: how to recover a repository
Date: Fri, 17 Dec 2010 16:22:02 -0500
Message-ID: <20101217212201.GC11511@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1012162024020.22269@asgard.lang.hm>
 <20101217044530.GA8590@burratino>
 <alpine.DEB.2.00.1012171218450.18272@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Dec 17 22:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PThkh-00012V-Ch
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 22:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab0LQVWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 16:22:07 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37394 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755671Ab0LQVWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 16:22:04 -0500
Received: (qmail 10557 invoked by uid 111); 17 Dec 2010 21:22:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 17 Dec 2010 21:22:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Dec 2010 16:22:02 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012171218450.18272@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163893>

On Fri, Dec 17, 2010 at 12:20:56PM -0800, david@lang.hm wrote:

> >3. git update-ref HEAD refs/heads/(branch you were on)
> 
> I was on the default branch but if I do 'git update-ref HEAD
> refs/heads/master' I get an error 'not a valid SHA1'

That should be "git symbolic-ref HEAD refs/heads/master".

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] trace: refactor to support multiple env variables
Date: Thu, 24 Feb 2011 14:48:28 -0500
Message-ID: <20110224194828.GA5616@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142841.GD15477@sigill.intra.peff.net>
 <7vsjvd1e9r.fsf@alter.siamese.dyndns.org>
 <20110224190258.GA4318@sigill.intra.peff.net>
 <7vbp211alu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 20:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PshAz-0001OE-J9
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446Ab1BXTsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 14:48:31 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46649 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687Ab1BXTsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 14:48:30 -0500
Received: (qmail 27367 invoked by uid 111); 24 Feb 2011 19:48:29 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 19:48:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 14:48:28 -0500
Content-Disposition: inline
In-Reply-To: <7vbp211alu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167855>

On Thu, Feb 24, 2011 at 11:44:13AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Feb 24, 2011 at 10:25:04AM -0800, Junio C Hamano wrote:
> > ...
> > So I guess I'm not sure what your complaint is.
> 
> There was no complaint. I wanted to see the reasoning behind the choices
> you made spelled out (and later copied into developer docs).

Oh. :) I'll write something up to go into Documentation/technical for my
re-roll. And something should clearly go in Documentation/git.txt for
users, too.

> > I think I covered that pretty well above, but you lose the flexibility
> > of pushing different trace types to different places if you want to.
> 
> That statement illustrates the inflexibility that all packet traces going
> to a same place rather clearly, doesn't it, though?  That "two-tier" thing
> was my primary concern.

Sorry, I don't quite understand what you're saying here.

-Peff

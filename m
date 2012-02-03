From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Fri, 3 Feb 2012 16:53:07 -0500
Message-ID: <20120203215307.GA3472@sigill.intra.peff.net>
References: <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
 <20120202215913.GA26727@sigill.intra.peff.net>
 <7vzkd0u4ik.fsf@alter.siamese.dyndns.org>
 <20120203120215.GA31441@sigill.intra.peff.net>
 <7v8vkjstq2.fsf@alter.siamese.dyndns.org>
 <20120203212906.GB1890@sigill.intra.peff.net>
 <7vmx8zmvq2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:53:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtR4F-0004kT-RC
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab2BCVxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 16:53:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56037
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779Ab2BCVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:53:09 -0500
Received: (qmail 2582 invoked by uid 107); 3 Feb 2012 22:00:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 17:00:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 16:53:07 -0500
Content-Disposition: inline
In-Reply-To: <7vmx8zmvq2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189811>

On Fri, Feb 03, 2012 at 01:51:33PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> No, thanks for working on this.
> >
> > What do you want to do with it, then? Take my patch and ignore the
> > gitfile issue, or have me refactor it more heavily? I could go either
> > way.
> 
> How about queuing it as is in next and see if anybody screams loudly
> enough so that we can fix-up if necessary in-tree?

Sounds good to me. Jonathan might be interested in building on top of
it, too.

-Peff

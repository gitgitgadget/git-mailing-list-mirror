From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 2/2] git-patch-id: do not trip over "no newline" markers
Date: Fri, 18 Feb 2011 05:47:41 -0500
Message-ID: <20110218104741.GA11888@sigill.intra.peff.net>
References: <26bc8a07f1b965a3022c3a1542f95422a8462e42.1298023827.git.git@drmicha.warpmail.net>
 <c0ee81b29d902e773dc851aaf86b99c9337079c9.1298023827.git.git@drmicha.warpmail.net>
 <20110218104151.GB7262@sigill.intra.peff.net>
 <4D5E4D44.6000203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 11:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqNsL-0001kh-5z
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 11:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab1BRKrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 05:47:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47937 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab1BRKro (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 05:47:44 -0500
Received: (qmail 31106 invoked by uid 111); 18 Feb 2011 10:47:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 10:47:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Feb 2011 05:47:41 -0500
Content-Disposition: inline
In-Reply-To: <4D5E4D44.6000203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167197>

On Fri, Feb 18, 2011 at 11:43:16AM +0100, Michael J Gruber wrote:

> >> +		else if (!memcmp(line, "\\ ", 2) && strlen(line)>=12)
> >> +			continue;
> > 
> > Whitespace around relational operators.
> 
> You think
> 
> +		else if (!memcmp(line, "\\ ", 2)&&strlen(line)>=12)
> 
> is that much better?

Yeah, it's starting to look like perl. :)

-Peff

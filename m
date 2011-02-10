From: Jeff King <peff@peff.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Wed, 9 Feb 2011 21:31:32 -0500
Message-ID: <20110210023132.GB5073@sigill.intra.peff.net>
References: <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <20110207195035.GA13461@sigill.intra.peff.net>
 <20110208100518.GA9505@neumann>
 <20110209210312.GB2083@sigill.intra.peff.net>
 <7vipwsomq8.fsf@alter.siamese.dyndns.org>
 <20110209234621.GA12575@sigill.intra.peff.net>
 <AANLkTi=dmqRQqBD2HZfv2x-kxaqrxvSx3r62d09KMP1k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 03:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnMJo-0001Qq-36
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 03:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab1BJCbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 21:31:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44494 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab1BJCbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 21:31:35 -0500
Received: (qmail 14528 invoked by uid 111); 10 Feb 2011 02:31:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 10 Feb 2011 02:31:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Feb 2011 21:31:32 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=dmqRQqBD2HZfv2x-kxaqrxvSx3r62d09KMP1k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166467>

On Thu, Feb 10, 2011 at 09:24:55AM +0700, Nguyen Thai Ngoc Duy wrote:

> > I don't think it's worth moving ls-files/ls-tree. They're plumbing that
> > people don't use frequently. So the cost of moving them is high (because
> > we are breaking something meant to be scriptable) and the benefit is low
> > (because users don't type them a lot).
> 
> No we should not, but we should add --full-tree to
> ls-files/ls-tree/archive. I'd love "ls-files --full-tree
> '*somefile*'".

ls-tree already has --full-tree (and --full-name, which just gives full
pathnames but still restricts output to files in the current directory).
ls-files. ls-files has --full-name, but AFAIK needs a matching
--full-tree.

-Peff
